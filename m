Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3F2Jkg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 05:40:36 -0400
Message-ID: <51CEAB8D.8030201@kernel.org>
Date: Sat, 29 Jun 2013 10:40:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Um9iaW4gTcO8bGxlci1CYWR5?= <mueller-bady@linux.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Start writing new IIO drivers
References: <CACRdhnBWk8Vi1fD6+6LknnLoPb8dLBEq3wrMXLofVrqQEEuaFA@mail.gmail.com>
In-Reply-To: <CACRdhnBWk8Vi1fD6+6LknnLoPb8dLBEq3wrMXLofVrqQEEuaFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/28/2013 10:28 AM, Robin Müller-Bady wrote:
> Hi,
> 
> I'm currently writing userspace software in python and c for using
> (mainly I2C) sensors, e.g. MPL115A2 barometric pressure, on a
> raspberry pi.
Excellent!

> I now want to port them to the IIO subsystem but I still require some help.
> * Is there any good documentation on writing those drivers ? I'm
> currently working through examples in the current git kernel version
> with assistance of the IIO Introductory slides from Maxime Ripard
> "IIO, a new kernel subsystem" but these examples are, in my opinion,
> rather difficult.

Saddly the nature of kernel driver development is that it is hard to put
together simple examples (or perhaps I'm just no good at doing so).
I'd personally start by taking a basic driver, (perhaps accel/kxsd9)
and making sure you understand what each step is doing.

Note this won't be a trivial exercise as you will want to drill down
through a lot of the function calls to really get the hang of it.
Another option is to first of all play with the dummy driver without the
events or buffer enabled.  That is there to in a sense act as documentation
of how to do basic stuff.

> * As raspbian (raspberry pi specific debian version) comes with a
> precompiled kernel 3.6.9, several features of IIO seem to be not yet
> included. Compiling a kernel natively on the raspi is no fun (700MHz
> ARM), so I don't want to make any mistake with the configs.
Silly question but has no one provided an appropriate cross compiler?
I certainly don't do my arm builds on an arm processor - have a nice
fast intel one for building stuff.  Obviously my appologies if all you
have to hand is a raspberry pi, in which case I hope you also have a
good book to read.

If I were you I would spend some time working out how to do a full cross compile
from scratch of a more recent kernel.  I see from a quick google that
lots of people are saying 'but it is so much easier to build directly on the
pi'.  All I can say is they have clearly never built anything of any size with
an frequency.  Also doing kernel development on anything more than a few
months old just leads to a world of pain and makes it much harder to get
help as it's not what everyone else is working with.

> Which
> kernel options of the current stable kernel do I require for IIO/I2C
> Sensor communication ?
Should just need relevant i2c bus support (if you can enable the actual
i2c bus driver then you'll have all the dependencies), core IIO and the
driver you want to use. Again if you enable the driver you should be fine
and it should not be available unless i2c support is present.

> 
> Thank you very much in advance!
Good luck,

Feel free to post any questions you have about specific aspects as you
get going.
> 
> Regards,
> 
> Robin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
