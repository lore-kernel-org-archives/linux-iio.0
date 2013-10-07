Return-Path: <bigeasy@linutronix.de>
Message-ID: <5252B696.7010607@linutronix.de>
Date: Mon, 07 Oct 2013 15:26:46 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: "Zubair Lutfullah: zubair.lutfullah"@gmail.com, jic23@cam.ac.uk,
 dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Felipe Balbi <balbi@ti.com>
Subject: Re: Testing ti_am335x_adc continuous mode (WAS: Re: [PATCH 2/2]
References: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com> <1379503383-17086-3-git-send-email-zubair.lutfullah@gmail.com> <20131007115317.GA6135@linutronix.de> <20131007125025.GA4655@gmail.com> <5252B02C.2080707@linutronix.de> <20131007131854.GB4655@gmail.com>
In-Reply-To: <20131007131854.GB4655@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/07/2013 03:18 PM, Zubair Lutfullah : wrote:
> On Mon, Oct 07, 2013 at 02:59:24PM +0200, Sebastian Andrzej Siewior wrote:
>>
>>> Also, I used generic_buffer.c after removing the trigger checks.
>>
>> Do you mind posting it?
>>
> Don't have the file handy as its inside the beaglebone black.
> And I'm 'technically' on vacation for my wedding :)

Ah, okay then. Congratulations to you and your future spouse :)

> If I remember correctly, i simply hacked generic_buffer.c
> by commenting trigger related goto error statements.
> 
> Hope that helps.

yup, should be enough. Thanks.

> ZubairLK

Sebastian
