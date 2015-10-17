Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58772 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbJQQt4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Oct 2015 12:49:56 -0400
In-Reply-To: <CAF8px57ji+ooS5i7gCohUihMq-JXuy2jVa8+Q7Q-_s0yi1UFsQ@mail.gmail.com>
References: <CAF8px55G9aLXWcRKvhfAb7W=GUSbGn9TKdr_wnPyYiiTg-qG6w@mail.gmail.com> <CAF8px55=zHk-1v51fpHJAwKJUsa1-eaQvCd2chmeONsobeeBRg@mail.gmail.com> <CAF8px57ji+ooS5i7gCohUihMq-JXuy2jVa8+Q7Q-_s0yi1UFsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio: inv_mpu6050: client: Erratic data.
From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 17 Oct 2015 17:49:49 +0100
To: Mike Mestnik <cheako@mikemestnik.net>,
	linux-iio <linux-iio@vger.kernel.org>
Message-ID: <07632D7F-33D3-4301-89AF-22FFDFEB8D80@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 17 October 2015 17:18:32 BST, Mike Mestnik <cheako@mikemestnik.net> wrote:
>I think I've found the problem.  Looks like an *endianness problem.
>Is that the driver or userspace?
>
>* a is stable, b fluctuates.  on x86 b is most significant, so changes
>there represent large movements.
Driver looks to be out putting big endian (at least Fifo counts are definitely big
 endian would be odd if the channels were not)
It's marked as a big endian channel to userspace so looks superficially fine from
 kernel side to me...

>
>On Fri, Oct 16, 2015 at 11:36 PM, Mike Mestnik <cheako@mikemestnik.net>
>wrote:
>> On Wed, Oct 14, 2015 at 3:13 PM, Mike Mestnik
><cheako@mikemestnik.net> wrote:
>>> This was taken with the tablet as still as I could without resorting
>>> to using a vice and clamps.
>>>
>>> How to know if this is kernel or app?
>>
>> Testing shows these are the values coming from the kernel, there can
>> be no mistake.  Are the values relative instead of absolute
>>
>>
>https://github.com/cheako/iio-sensor-proxy/blob/structeddata/src/drv-iio-buffer-accel.c#L76
>> (gdb) run
>> Starting program: /usr/sbin/iio-sensor-proxy
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library
>> "/lib/i386-linux-gnu/i686/cmov/libthread_db.so.1".
>> [New Thread 0xf795bb40 (LWP 17038)]
>> [New Thread 0xf6fffb40 (LWP 17039)]
>> [New Thread 0xf65ffb40 (LWP 17040)]
>> ** (process:17037): DEBUG: Found accel_3d at
>> /sys/devices/pci0000:00/INT3432:00/i2c-5/i2c-INVN6500:00/iio:device0
>> ** (process:17037): DEBUG: Found device
>> /sys/devices/pci0000:00/INT3432:00/i2c-5/i2c-INVN6500:00/iio:device0
>> of type accelerometer at IIO Buffer accelerometer
>> ** (process:17037): DEBUG: Found associated trigger at
>> /sys/devices/pci0000:00/INT3432:00/i2c-5/i2c-INVN6500:00/trigger0
>> ** (process:17037): DEBUG: Got type for in_anglvel_x: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_anglvel_y: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_anglvel_z: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_accel_x: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_accel_y: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_accel_z: is signed: 1,
>> bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Got type for in_timestamp: is signed: 1,
>> bytes: 8, bits_used: 64, shift: 0, mask: 0x18446744073709551615, be:
>0
>> ** (process:17037): DEBUG: Built channel array for in_anglvel_x: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_anglvel_y: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_anglvel_z: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_accel_x: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_accel_y: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_accel_z: is
>> signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>> ** (process:17037): DEBUG: Built channel array for in_timestamp: is
>> signed: 1, bytes: 8, bits_used: 64, shift: 0,
>> mask:0x18446744073709551615, be: 0
>> ** (process:17037): DEBUG: Handling driver refcounting method
>> 'ClaimLight' for ambient light sensor device
>> ** (process:17037): DEBUG: Handling driver refcounting method
>> 'ClaimLight' for ambient light sensor device
>> ** (process:17037): DEBUG: Handling driver refcounting method
>> 'ClaimAccelerometer' for accelerometer device
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *(*mydata)
>> Structure has no component named operator*.
>> (gdb) print *mydata
>> $1 = {in_anglvel_x = {a = {a = -62 '\302', b = -44 '\324'}, value =
>> -11070}, in_anglvel_y = {a = {a = -5 '\373', b = -32 '\340'}, value =
>> -7941}, in_anglvel_z = {a = {a = 11 '\v', b = 116 't'}, value =
>> 29707}, in_accel_x = {a = {a = 0 '\000', b = 2 '\002'}, value = 512},
>> in_accel_y = {a = {a = -1 '\377', b = -2 '\376'}, value = -257},
>> in_accel_z = {a = {a = -1 '\377', b = -2 '\376'}, value = -257}, a =
>0
>> '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp =
>> {a = {a = -102 '\232', b = 124 '|', c = 29 '\035', d = -104 '\230', e
>> = -32 '\340', f = -42 '\326', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047315568884890}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 512, -257, -257
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): 0,
>0, 0
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $2 = {in_anglvel_x = {a = {a = -60 '\304', b = 40 '('}, value =
>> 10436}, in_anglvel_y = {a = {a = -3 '\375', b = -120 '\210'}, value =
>> -30467}, in_anglvel_z = {a = {a = 14 '\016', b = -124 '\204'}, value
>=
>> -31730}, in_accel_x = {a = {a = 0 '\000', b = 11 '\v'}, value =2816},
>> in_accel_y = {a = {a = 0 '\000', b = 15 '\017'}, value = 3840},
>> in_accel_z = {a = {a = -1 '\377', b = -2 '\376'}, value = -257}, a =
>0
>> '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp =
>> {a = {a = -126 '\202', b = -35 '\335', c = -79'\261', d = -104
>'\230',
>> e = -1 '\377', f = -42 '\326', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047448722595202}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 2816, 3840, -257
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): -1,
>-2, 0
>> ** (process:17037): DEBUG: Emitted orientation changed: from
>undefined
>> to bottom-up
>> ** (process:17037): DEBUG: Handling driver refcounting method
>> 'ClaimAccelerometer' for accelerometer device
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $3 = {in_anglvel_x = {a = {a = -60 '\304', b = 52 '4'}, value =
>> 13508}, in_anglvel_y = {a = {a = -3 '\375', b = -120 '\210'}, value =
>> -30467}, in_anglvel_z = {a = {a = 14 '\016', b = -80 '\260'}, value =
>> -20466}, in_accel_x = {a = {a = 0 '\000', b = 10 '\n'}, value =2560},
>> in_accel_y = {a = {a = -1 '\377', b = -1 '\377'}, value = -1},
>> in_accel_z = {a = {a = -1 '\377', b = -6 '\372'}, value = -1281}, a =
>> 0 '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp
>> = {a = {a = -11 '\365', b = -20 '\354', c = -120'\210', d = 106 'j',
>e
>> = 4 '\004', f = -41 '\327', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047469422996725}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 2560, -1, -1281
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): -1,
>0, 0
>> ** (process:17037): DEBUG: Emitted orientation changed: from
>bottom-up
>> to left-up
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $4 = {in_anglvel_x = {a = {a = -61 '\303', b = -4 '\374'}, value =
>> -829}, in_anglvel_y = {a = {a = -3 '\375', b = 108 'l'}, value
>> =27901}, in_anglvel_z = {a = {a = 14 '\016', b = -4 '\374'}, value =
>> -1010}, in_accel_x = {a = {a = 0 '\000', b = 8 '\b'}, value =2048},
>> in_accel_y = {a = {a = -1 '\377', b = -1 '\377'}, value = -1},
>> in_accel_z = {a = {a = -1 '\377', b = -6 '\372'}, value = -1281}, a =
>> 0 '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp
>> = {a = {a = 17 '\021', b = -81 '\257', c = -99'\235', d = 50 '2', e =
>> 5 '\005', f = -41 '\327', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047472779800337}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 2048, -1, -1281
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): -1,
>0, 0
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $5 = {in_anglvel_x = {a = {a = -61 '\303', b = -64 '\300'}, value =
>> -16189}, in_anglvel_y = {a = {a = -3 '\375', b = -124 '\204'}, value
>=
>> -31491}, in_anglvel_z = {a = {a = 13 '\r', b = 16 '\020'}, value =
>> 4109}, in_accel_x = {a = {a = 0 '\000', b = 11 '\v'}, value = 2816},
>> in_accel_y = {a = {a = -1 '\377', b = -24 '\350'}, value = -5889},
>> in_accel_z = {a = {a = 0 '\000', b = 2 '\002'}, value =512}, a = 0
>> '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp =
>> {a = {a = -49 '\317', b = -27 '\345', c = 111 'o', d = 36 '$', e = 7
>> '\a', f = -41 '\327', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047481131853263}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 2816, -5889, 512
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): -1,
>3, 0
>> ** (process:17037): DEBUG: Emitted orientation changed: from left-up
>to normal
>> [Thread 0xf6fffb40 (LWP 17039) exited]
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $6 = {in_anglvel_x = {a = {a = -60 '\304', b = 48 '0'}, value =
>> 12484}, in_anglvel_y = {a = {a = -3 '\375', b = -68 '\274'}, value =
>> -17155}, in_anglvel_z = {a = {a = 13 '\r', b = 108 'l'}, value =
>> 27661}, in_accel_x = {a = {a = 0 '\000', b = 11 '\v'}, value = 2816},
>> in_accel_y = {a = {a = -1 '\377', b = -6 '\372'}, value = -1281},
>> in_accel_z = {a = {a = 0 '\000', b = 5 '\005'}, value = 1280}, a =
>> 0'\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp
>=
>> {a = {a = -31 '\341', b = -122 '\206', c = -62 '\302', d = 106'j', e
>=
>> 8 '\b', f = -41 '\327', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047486606640865}}
>> (gdb) cont
>> Continuing.
>> ** (process:17037): DEBUG: Read from IIO: 2816, -1281, 1280
>> ** (process:17037): DEBUG: Accel sent by driver (quirk applied): -1,
>0, 0
>> ** (process:17037): DEBUG: Emitted orientation changed: from normal
>to left-up
>>
>> Breakpoint 1, read_orientation (channel=0x5656fb28,
>condition=G_IO_IN,
>> user_data=0x565715f8) at drv-iio-buffer-accel.c:164
>> (gdb) print *mydata
>> $7 = {in_anglvel_x = {a = {a = -61 '\303', b = -80 '\260'}, value =
>> -20285}, in_anglvel_y = {a = {a = -3 '\375', b = -112 '\220'}, value
>=
>> -28419}, in_anglvel_z = {a = {a = 13 '\r', b = -40 '\330'}, value =
>> -10227}, in_accel_x = {a = {a = 0 '\000', b = 11 '\v'}, value =
>2816},
>> in_accel_y = {a = {a = -1 '\377', b = -29 '\343'}, value = -7169},
>> in_accel_z = {a = {a = -1 '\377', b = -3 '\375'}, value = -513}, a =
>0
>> '\000', b = -120 '\210', c = -1 '\377', d = -1 '\377', in_timestamp =
>> {a = {a = 11 '\v', b = 127 '\177', c = 119'w', d = 73 'I', e = 9
>'\t',
>> f = -41 '\327', g = 13 '\r', h = 20 '\024'}, value =
>> 1445047490343042827}}
>>
>>
>> (gdb) print *(or_data->buffer_data->channels[0])
>> $1 = {name = 0x565727a0 "in_anglvel_x", generic_name = 0x56574090
>> "in_anglvel", scale = 0.00106472406, offset = 0, index = 3, bytes =2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 0}
>> (gdb) print *(or_data->buffer_data->channels[1])
>> $2 = {name = 0x56586878 "in_anglvel_y", generic_name = 0x5656f9d0
>> "in_anglvel", scale = 0.00106472406, offset = 0, index = 4, bytes =2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 2}
>> (gdb) print *(or_data->buffer_data->channels[2])
>> $3 = {name = 0x56574070 "in_anglvel_z", generic_name = 0x5656f9f0
>> "in_anglvel", scale = 0.00106472406, offset = 0, index = 5, bytes =2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 4}
>> (gdb) print *(or_data->buffer_data->channels[3])
>> $4 = {name = 0x5656f9e0 "in_accel_x", generic_name = 0x5656fa50
>> "in_accel", scale = 0.000598000013, offset = 0, index = 0, bytes = 2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 6}
>> (gdb) print *(or_data->buffer_data->channels[4])
>> $5 = {name = 0x5656fa40 "in_accel_y", generic_name = 0x5656fab0
>> "in_accel", scale = 0.000598000013, offset = 0, index = 1, bytes = 2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 8}
>> (gdb) print *(or_data->buffer_data->channels[5])
>> $6 = {name = 0x5656faa0 "in_accel_z", generic_name = 0x5656fb10
>> "in_accel", scale = 0.000598000013, offset = 0, index = 2, bytes = 2,
>> bits_used = 16, shift = 0, mask = 65535, be = 1, is_signed = 1,
>> enabled = 0, location = 10}
>> (gdb) print *(or_data->buffer_data->channels[6])
>> $7 = {name = 0x56574190 "in_timestamp", generic_name = 0x5656f9c0
>> "in", scale = 1, offset = 0, index = 6, bytes = 8, bits_used = 64,
>> shift = 0, mask = 18446744073709551615, be = 0, is_signed = 1,
>enabled
>> = 0, location = 16}
>> (gdb) print *(or_data->buffer_data->channels[7])
>> Cannot access memory at address 0x3a323334
>> (gdb) kill
>>
>>
>>>
>>> root@debian:~# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy | awk
>>> '{ print strftime("%M:%S"), $0; fflush(); }'
>>> 00:21 ** (process:22742): DEBUG: Found accel_3d at
>>> /sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/iio:device0
>>> 00:21 ** (process:22742): DEBUG: Found device
>>> /sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/iio:device0
>>> of type accelerometer at IIO Buffer accelerometer
>>> 00:21 ** (process:22742): DEBUG: Found associated trigger at
>>> /sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/trigger0
>>> 00:21 ** (process:22742): DEBUG: Got type for in_anglvel_x: is
>signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_anglvel_y: is
>signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_anglvel_z: is
>signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_accel_x: is signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_accel_y: is signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_accel_z: is signed:
>>> 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
>>> 00:21 ** (process:22742): DEBUG: Got type for in_timestamp: is
>signed:
>>> 1, bytes: 8, bits_used: 64, shift: 0, mask: 0x18446744073709551615,
>>> be: 0
>>> 00:21 ** (process:22742): DEBUG: Built channel array for
>in_anglvel_x:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for
>in_anglvel_y:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for
>in_anglvel_z:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for in_accel_x:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for in_accel_y:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for in_accel_z:
>>> is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be:
>1
>>> 00:21 ** (process:22742): DEBUG: Built channel array for
>in_timestamp:
>>> is signed: 1, bytes: 8, bits_used: 64, shift: 0, mask:
>>> 0x18446744073709551615, be: 0
>>> 00:27 ** (process:22742): DEBUG: Handling driver refcounting method
>>> 'ClaimAccelerometer' for accelerometer device
>>> 00:27 ** (process:22742): DEBUG: Handling driver refcounting method
>>> 'ClaimLight' for ambient light sensor device
>>> 00:28 ** (process:22742): DEBUG: Read from IIO: 2304, -1, 1280
>>> 00:28 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): -1, 0, 0
>>> 00:28 ** (process:22742): DEBUG: Emitted orientation changed: from
>>> undefined to left-up
>>> 00:29 ** (process:22742): DEBUG: Read from IIO: 3840, 2304, 2816
>>> 00:29 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): -2, -1, 1
>>> 00:29 ** (process:22742): DEBUG: Read from IIO: 1024, 512, -1281
>>> 00:29 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:30 ** (process:22742): DEBUG: Read from IIO: 1536, -513, -2049
>>> 00:30 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, -1
>>> 00:31 ** (process:22742): DEBUG: Read from IIO: 1024, -1025, -1281
>>> 00:31 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:31 ** (process:22742): DEBUG: Read from IIO: 1280, -1537, -1537
>>> 00:31 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:32 ** (process:22742): DEBUG: Read from IIO: 1536, -1537, -1281
>>> 00:32 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:33 ** (process:22742): DEBUG: Read from IIO: 768, 512, -2561
>>> 00:33 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, -1
>>> 00:34 ** (process:22742): DEBUG: Read from IIO: 2048, -513, -2049
>>> 00:34 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): -1, 0, -1
>>> 00:34 ** (process:22742): DEBUG: Read from IIO: 1280, -5121, -769
>>> 00:34 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 3, 0
>>> 00:34 ** (process:22742): DEBUG: Emitted orientation changed: from
>>> left-up to normal
>>> 00:35 ** (process:22742): DEBUG: Read from IIO: 768, -513, -1025
>>> 00:35 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:36 ** (process:22742): DEBUG: Read from IIO: 768, 2816, -513
>>> 00:36 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, -1, 0
>>> 00:36 ** (process:22742): DEBUG: Emitted orientation changed: from
>>> normal to bottom-up
>>> 00:36 ** (process:22742): DEBUG: Read from IIO: 1024, 1280, -513
>>> 00:36 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:37 ** (process:22742): DEBUG: Read from IIO: 1280, -4865, -2049
>>> 00:37 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 2, -1
>>> 00:37 ** (process:22742): DEBUG: Emitted orientation changed: from
>>> bottom-up to normal
>>> 00:38 ** (process:22742): DEBUG: Read from IIO: 1536, 256, -769
>>> 00:38 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, 0, 0
>>> 00:38 ** (process:22742): DEBUG: Read from IIO: 2304, 7936, 1280
>>> 00:38 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): -1, -4, 0
>>> 00:38 ** (process:22742): DEBUG: Emitted orientation changed: from
>>> normal to bottom-up
>>> 00:39 ** (process:22742): DEBUG: Read from IIO: 0, 4864, -5377
>>> 00:39 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): 0, -2, -3
>>> 00:40 ** (process:22742): DEBUG: Read from IIO: 2304, 10496, 0
>>> 00:40 ** (process:22742): DEBUG: Accel sent by driver (quirk
>applied): -1, -6, 0
>>>
>>> The client reported the motion ?!correctly!?:
>>> ** Message: Accelerometer orientation changed: left-up
>>> ** Message: Accelerometer orientation changed: normal
>>> ** Message: Accelerometer orientation changed: bottom-up
>>> ** Message: Accelerometer orientation changed: normal
>>> ** Message: Accelerometer orientation changed: bottom-up
>>>
>>>
>>> Patches applied, there are a few!
>>> get them from here:
>>> http://j.mp/1VSEEnK
>>>
>>> Project link:
>>> http://j.mp/1VST95v
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
