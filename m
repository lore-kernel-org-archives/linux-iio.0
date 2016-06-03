Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43870 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbcFCHRg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 03:17:36 -0400
To: linux-iio@vger.kernel.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Interface between IIO driver and an input driver
Message-ID: <57512F0D.3050009@free-electrons.com>
Date: Fri, 3 Jun 2016 09:17:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. We currently have a driver for the two
latter functions in drivers/input/touchscreen/sun4i-ts.c, but we don't
have access to the ADC feature at all.

Hence, I've been working on an IIO driver for that IP, with the hope
that we could use iio-hwmon for the thermal sensor, and a
yet-to-be-developped driver for the touchscreen part.

The thermal sensor using iio_hwmon to communicate with the IIO driver is
working fine.

However, the touchscreen needs all the channels of the ADC to be able
to get the coordinates. Moreover, you need to poke a few bits in some
registers to switch the ADC mode and activate a few interrupts (pen-up
and pen-down) to be able to operate as a touchscreen controller.
Therefore, I need a way to ask the IIO driver to poke these bits from
the input driver. For now, I am calling a function defined in my IIO
driver from my input driver to ask to switch between modes. Is it how it
is supposed to be done?

Now that I switched to touchscreen mode, I need to get data from the IIO
driver. I already get hardware interrupts in the IIO driver when
something occurs with the touchscreen but now I need to notify the input
driver that I received an interrupt for the touchscreen and make  the
associated data available to the input driver. For now, I am using a
callback I set when probing the input driver and call this callback when
the correct interrupt is detected in the IIO driver's interrupt handler.
I pass the data through a parameter of this callback. However, I don't
think it is a good idea since the IIO driver has no idea on what the
callback is doing and it might just take too long to execute or even
freeze, which is definitely not what we want in an interrupt handler.
I've seen iio_channel_get_all_cb
(http://lxr.free-electrons.com/source/include/linux/iio/consumer.h#L79)
but I don't understand what it is doing or how to use it since there is
not a single driver using this function. Can someone explain what it is
supposed to do?
If that callback mechanism isn't really supposed to address my use-case,
do you have a suggestion on how to implement such a thing?

Thanks,

Quentin
