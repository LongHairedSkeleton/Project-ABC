extends Node

var _reset_timer: Timer

func _ready() -> void:
	# Setup a timer to turn off "always on top" after speech finishes
	_reset_timer = Timer.new()
	_reset_timer.one_shot = true
	_reset_timer.connect("timeout", self, "_on_tts_finished")
	add_child(_reset_timer)

func _on_tts_finished() -> void:
	yield(get_tree().create_timer(3),"timeout")
	if OS.get_name() == "Windows":
		OS.set_window_always_on_top(false)

# --- Windows Execution ---
func _speak_windows(text: String, pitch: float, rate: float) -> void:
	var processed_text = text.replace("-", " menos ").replace("+", " mais ")
	var sanitized_text = processed_text.replace('"', '""')
	var sapi_rate = int(clamp((rate - 1.0) * 10, -10, 10))
	
	var vbs_code = "javascript:var v=new ActiveXObject('SAPI.SpVoice');v.Rate=%d;v.Speak('%s');close();" % [sapi_rate, sanitized_text]
	OS.execute("mshta", [vbs_code], false)

func speak(text: String, pitch: float = 1.0, rate: float = 0.8) -> void:
	# Replace common symbols with Portuguese words before sending to TTS
	var formatted_text = text \
		.replace("-", " menos ") \
		.replace("+", " mais ") \
		.replace("x", " vezes ") \
		.replace(":", " dividido por ")
	if OS.get_name() == "Windows":
		OS.set_window_always_on_top(true)
		_speak_windows(text, pitch, rate)
		
		# Estimate speech duration based on text length and speech rate
		# Average speed is roughly 15 characters per second
		var estimated_seconds = max((text.length() / (15.0 * rate)), 1.5)
		_reset_timer.start(estimated_seconds)
		
	elif OS.get_name() == "HTML5":
		_speak_html5(text, pitch, rate)

func stop() -> void:
	match OS.get_name():
		"HTML5":
			JavaScript.eval("if ('speechSynthesis' in window) { window.speechSynthesis.cancel(); }")
		"Windows":
			# Kills any active PowerShell SAPI processes running in the background
			OS.execute("powershell", ["-Command", "Stop-Process -Name powershell -ErrorAction SilentlyContinue"], false)

# --- HTML5 Execution (Instant Local Voice) ---
func _speak_html5(text: String, pitch: float, rate: float) -> void:
	var processed_text = text.replace("-", " menos ").replace("+", " mais ")
	var sanitized_text = processed_text.replace("\\", "\\\\").replace("'", "\\'")
	
	# JavaScript forced to use local system voice instantly
	var js_code = """
		if ('speechSynthesis' in window) {
			window.speechSynthesis.cancel();
			
			var utterance = new SpeechSynthesisUtterance('%s');
			utterance.pitch = %f;
			utterance.rate = %f;
			utterance.lang = 'pt-BR'; // Match Portuguese
			
			var voices = window.speechSynthesis.getVoices();
			
			// Find a local Portuguese voice first to avoid cloud network delay
			var localVoice = voices.find(function(v) {
				return v.lang.includes('pt') && v.localService === true;
			}) || voices.find(function(v) {
				return v.lang.includes('pt');
			});
			
			if (localVoice) {
				utterance.voice = localVoice;
			}
			
			window.speechSynthesis.speak(utterance);
		}
	""" % [sanitized_text, pitch, rate]
	
	JavaScript.eval(js_code)
