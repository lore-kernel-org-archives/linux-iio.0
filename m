Return-Path: <zubair.lutfullah@gmail.com>
Date: Mon, 7 Oct 2013 18:18:56 +0500
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Zubair Lutfullah:  zubair.lutfullah@gmail.com, jic23@cam.ac.uk,
	dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, Felipe Balbi <balbi@ti.com>
Subject: Re: Testing ti_am335x_adc continuous mode (WAS: Re: [PATCH 2/2]
Message-ID: <20131007131854.GB4655@gmail.com>
References: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379503383-17086-3-git-send-email-zubair.lutfullah@gmail.com>
 <20131007115317.GA6135@linutronix.de>
 <20131007125025.GA4655@gmail.com>
 <5252B02C.2080707@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5252B02C.2080707@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 07, 2013 at 02:59:24PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > Also, I used generic_buffer.c after removing the trigger checks.
> 
> Do you mind posting it?
>
Don't have the file handy as its inside the beaglebone black.
And I'm 'technically' on vacation for my wedding :)

If I remember correctly, i simply hacked generic_buffer.c
by commenting trigger related goto error statements.

Hope that helps.
ZubairLK
