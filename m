Return-Path: <bigeasy@linutronix.de>
Message-ID: <5252B02C.2080707@linutronix.de>
Date: Mon, 07 Oct 2013 14:59:24 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 Felipe Balbi <balbi@ti.com>
Subject: Re: Testing ti_am335x_adc continuous mode (WAS: Re: [PATCH 2/2]
References: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com> <1379503383-17086-3-git-send-email-zubair.lutfullah@gmail.com> <20131007115317.GA6135@linutronix.de> <20131007125025.GA4655@gmail.com>
In-Reply-To: <20131007125025.GA4655@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/07/2013 02:50 PM, Zubair Lutfullah : wrote:
>> and the output is:
>> |00000000  37 02 92 02 1f 07 0a 06  20 06 31 06 2f 07 2a 07
>> |00000010  2b 07 2d 07 2c 07 28 07  2c 07 2b 07 2b 07 0c 06
>> |00000020  21 06 32 06 2e 07 2c 07  2a 07 2a 07 2c 07 2b 07
>> |00000030  29 07 27 07 28 07 29 07  2a 07 0d 06 21 06 35 06
>>
>> The first entry is in the range that I would expect. The second is
>> slitghly higher. The third and following entries are out of range. Have
>> you observed something like that? Is my testing close to what you have
>> done or did I make an mistake here?
> 
> I can't read the hex dump easily..

The first one "37 02" => 0x0237 => 567. The next 658 and the following
have mostly a 7 in the upper 8 bit which means the result is 1792+

> Keep in mind that the driver now uses 16 bit storage. 

Yes, I do.

> Also, I used generic_buffer.c after removing the trigger checks.

Do you mind posting it?

> 
> The driver would report stable values for 1.8V on one channel and gnd
> on another channel.

Okay. That sounds good.

> 
> Hope this helps
> ZubairLK


Sebastian
