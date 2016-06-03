Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34966 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcFCINA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 04:13:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id a136so264065482wme.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2016 01:12:59 -0700 (PDT)
Subject: Re: Interface between IIO driver and an input driver
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org
References: <57512F0D.3050009@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <57513C09.2060802@baylibre.com>
Date: Fri, 3 Jun 2016 10:12:57 +0200
MIME-Version: 1.0
In-Reply-To: <57512F0D.3050009@free-electrons.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi All,


(sorry Quentin, I here just share a related thought, not actually 
helping you much).

a nice feature would be to have some sort of "mixer" interface, similar 
to the one common with audio APIs. An IIO driver can already use a 
separate trigger device as an interrupt source and I believe there is 
some wip to allow for software trigger sources instantiated with 
configfs. Similarly, being able to link standard interfaces from 'input' 
or 'gpio' as an event source for (an) iio driver(s) would be great. 
Another benefit would be to use libiio and iiod as the unique connector 
to enumerate and control those interfaces, for instance with a product 
that can record some voltage (plain iio streaming) and switch on/off 
that power source using a standard gpio.

BR,
Mar.


On 03/06/2016 09:17, Quentin Schulz wrote:
> Hi all,
>
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. We currently have a driver for the two
> latter functions in drivers/input/touchscreen/sun4i-ts.c, but we don't
> have access to the ADC feature at all.
>
> Hence, I've been working on an IIO driver for that IP, with the hope
> that we could use iio-hwmon for the thermal sensor, and a
> yet-to-be-developped driver for the touchscreen part.
>
> The thermal sensor using iio_hwmon to communicate with the IIO driver is
> working fine.
>
> However, the touchscreen needs all the channels of the ADC to be able
> to get the coordinates. Moreover, you need to poke a few bits in some
> registers to switch the ADC mode and activate a few interrupts (pen-up
> and pen-down) to be able to operate as a touchscreen controller.
> Therefore, I need a way to ask the IIO driver to poke these bits from
> the input driver. For now, I am calling a function defined in my IIO
> driver from my input driver to ask to switch between modes. Is it how it
> is supposed to be done?
>
> Now that I switched to touchscreen mode, I need to get data from the IIO
> driver. I already get hardware interrupts in the IIO driver when
> something occurs with the touchscreen but now I need to notify the input
> driver that I received an interrupt for the touchscreen and make  the
> associated data available to the input driver. For now, I am using a
> callback I set when probing the input driver and call this callback when
> the correct interrupt is detected in the IIO driver's interrupt handler.
> I pass the data through a parameter of this callback. However, I don't
> think it is a good idea since the IIO driver has no idea on what the
> callback is doing and it might just take too long to execute or even
> freeze, which is definitely not what we want in an interrupt handler.
> I've seen iio_channel_get_all_cb
> (http://lxr.free-electrons.com/source/include/linux/iio/consumer.h#L79)
> but I don't understand what it is doing or how to use it since there is
> not a single driver using this function. Can someone explain what it is
> supposed to do?
> If that callback mechanism isn't really supposed to address my use-case,
> do you have a suggestion on how to implement such a thing?
>
> Thanks,
>
> Quentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
