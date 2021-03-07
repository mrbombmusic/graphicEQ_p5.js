# You will need to use your own samples in place of these
hats = "/Users/admin/Music/SAmples/808_drum_kit/hihats/"
kicks = "/Users/admin/Music/SAmples/808_drum_kit/kicks/"
snares = "/Users/admin/Music/SAmples/808_drum_kit/snares"

t = 1.0
live_loop :metro do
  sleep 1
end

sync :metro
live_loop :trapHats do
  sample hats, 9
  sleep (knit, t/4, 4, t/6, 6, t/8, 8, t/16, 8, t/4, 2).tick
end

live_loop :kick do
  sample kicks, 7
  sleep (ring, 2, 0.25, 1.5, 0.25, 2, 0.125, 1.25, 0.125, 0.25, 0.25).tick
end

live_loop :snare do
  sleep 1
  sample snares, 7
  sleep 1
end

live_loop :bass do
  with_fx :lpf, cutoff: 80 do
    use_synth :chipbass
    use_random_seed (knit, 469, 4, 32214, 4).tick
    sleep t/2
    7.times do
      play scale(:d1, :dorian).choose, release: 0.8
      sleep t/2
    end
  end
end

live_loop :melody do
  use_synth :hollow
  use_random_seed 879
  with_fx :reverb, room: 0.7 do
    3.times do
      7.times do
        play scale(:g3, :mixolydian, num_octaves: 2).choose, amp: 1.3, release: (knit, 2, 1, t, 6).tick
        sleep (knit, 2, 1, t/4, 4, t/2, 2).look
      end
    end
    2.times do
      play scale(:g3, :mixolydian, num_octaves: 2).choose, amp: 1.3, release: 2
      sleep 2
    end
  end
end

live_loop :chords do
  use_synth_defaults env_curve: 6
  use_synth  :blade
  with_fx :slicer, phase: t/6, probability: 0.84 do
    play chord(:g3,  '7'), attack: 3, release: 4, amp: 0.6
    sleep 8
  end
end
