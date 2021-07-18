t = [1, 4, 1, 6, 3, 5, 2, 6]
x = 0
z = [0.5, :elec_triangle, 1, 1]


def music(bpf = false)
  if bpf == false then
    fx_1 = :bitcrusher
  else
    fx_1 = :bpf
  end
  
  use_synth :fm
  with_fx :compressor do
    with_fx fx_1 do
      with_fx :bitcrusher do
        3.times do
          play :Fs6, amp: 0.25
          sleep 0.5
          play :Bb6, amp: 0.25
          sleep 0.25
          play :Cs5, amp: 0.375
          sleep 0.25
        end
        
        play :Fs5, amp: 0.5
        sleep 0.5
        play :Cs5, amp: 0.5
        sleep 0.25
        play :Db4, amp: 0.75
        sleep 0.25
        
        3.times do
          play :D6, amp: 0.25
          sleep 0.5
          play :Eb6, amp: 0.25
          sleep 0.25
          play :Es6, amp: 0.25
          sleep 0.25
        end
        play :D5, amp: 0.5
        sleep 0.5
        play :Eb5, amp: 0.5
        sleep 0.25
        play :Es4, amp: 0.75
        sleep 0.25
      end
    end
  end
end



sample :ambi_haunted_hum
sleep 4
sample :ambi_lunar_land
sleep 2

live_loop:a do
  x = 0 if x == 8
  sample z[1], amp: z[2] , rate:t[x] * z[3], beat_stretch:t[x+(x-1)]
  x+=1
  sleep z[0]
end

sleep 4

elec = [3,2,4,7, 1,4,5,3, 2,5,4,6, 3,1,7,2]
live_loop:c do
  sample :tabla_tun1, rate:elec[x], compress: 1, amp: 0.5 * z[0]
  sleep 0.5
end

sleep 2
tk = 0
live_loop:d do
  tk += 1
  tk = 0 if tk == 40
  sample :bd_boom, amp: 15, rate: 5
  sleep 0.5
  sample :elec_soft_kick, amp: 10, rate: 5
  sleep 0.5
  if tk % 4 == 0 then
    2.times do
      sample :elec_soft_kick, amp: 10
      sleep 0.25
    end
    sample :bd_boom, amp: 15, rate: 5
    sleep 0.25
    2.times do
      sample :elec_soft_kick, amp: 10
      sleep 0.125
    end
  else
    4.times do
      sample :elec_soft_kick, amp: 10
      sleep 0.0625
    end
    sample :bd_boom, amp: 15, rate: 5
    sleep 0.5
    sample :elec_soft_kick, amp: 10
    sleep 0.25
  end
end

sleep 4

z[0] = 0.75
sleep 6
z[0] = 0.25
z[3] = -1

sleep 4
##| sample :ambi_lunar_land
##| sleep 2
x = 0
z[1] = :bass_voxy_hit_c
z[2] = 0.5
z[3] = 1

music(true)

10.times do
  music()
end

music(true)
z[1] = :tick