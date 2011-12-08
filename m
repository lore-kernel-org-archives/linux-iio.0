Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <4EE09AB6.1000501@free-electrons.com>
Date: Thu, 08 Dec 2011 12:08:38 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: Buffer chrdev API and test
References: <4ED62FD2.4040500@free-electrons.com> <298089ef-0d1e-497a-9f45-32daf37bf2eb@email.android.com>
In-Reply-To: <298089ef-0d1e-497a-9f45-32daf37bf2eb@email.android.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

Just an update to that, in case anyone fall into the same sort of thing.
I actually lacked the fix you sent for the fscanf on the output of
bytes_per_datum in the iioutils_get_type function.

Maxime

On 30/11/2011 15:34, Jonathan Cameron wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
>> Hi list,
>>
>> I'm currently trying to test the buffer output, using the chrdev
>> present
>> at /dev/iio:deviceN.
>>
>> So I looked into the generic_buffer.c file which seems to do exactly
>> that.
>>
>> By looking into the source code, my understanding is that samples are
>> stored with this frame format :
>>
>> +--bpe--+--...--+--bpe--+--64 bits--+
>> | Ch 0  | ..... | Ch N  | timestamp |
>> +-------+-------+-------+-----------+
>>
>> the overall "frame" size being stored in
>> /sys/..../buffer/bytes_per_datum.
>>
>> Now, when I execute generic-buffer, it sets up correctly the driver by
>> enabling the channels, the buffer, setting the trigger, etc, but
>> outputs
>> nothing at all. After some number of trigger firing, it finally exits,
>> having displayed nothing but
>>
>> # /root/generic-buffer -n at91_adc -t at91_adc-dev0-external
>> iio device number being used is 0
>> iio trigger number being used is 3
>> /sys/bus/iio/devices/iio:device0 at91_adc-dev0-external
>> #
>>
>> which seems pretty odd to me.
>>
>> But when I do a cat directly on /dev/iio:device0, I get some binary
>> data, which indicates that the buffer is filled anyway.
>>
>> So, is generic_buffer supposed to print something ? If so, what kind of
>> output should I expect ?
>> Or is it just a poor driver configuration/data storing from me ?
> 
> Probably something about the data format that it doesn't understand.  It is pretty dumb so I would guess you are hitting something it doesn't know about yet.
>>
>> Thanks,
>> Maxime
>>
>> -- 
>> Maxime Ripard, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
