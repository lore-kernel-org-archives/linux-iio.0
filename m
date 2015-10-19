Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1148 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753715AbbJSJn4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 05:43:56 -0400
Message-ID: <5624BB59.20003@metafoo.de>
Date: Mon, 19 Oct 2015 11:43:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matthias Meier <matthias.j.meier@gmx.net>,
	linux-iio@vger.kernel.org
Subject: Re: iio_interrupt_trigger
References: <5623962F.6040105@gmx.net>
In-Reply-To: <5623962F.6040105@gmx.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2015 02:53 PM, Matthias Meier wrote:
> Hi
> 
> I'm trying to set on a IMX6 SoC (wandboard) a PWM to use as a
> 'iio_interrupt_trigger' source.
> I can't figure out how to assign the pwm to the 'iio_interrupt_trigger'
> module in the device tree source.
> (The pwm an the iio adc device when sysfs triggered is working fine)
> 
> Any suggestions?

The problem is that you can't really instantiate the iio-interrupt-trigger
from the devicetree. IIO is a software concept, there is no hardware
associated with it that you could describe in the devicetree.

There have been discussions in the past about implementing a pwm trigger,
similar to the existing iio-trig-bfin-timer.c trigger driver. But instead of
directly accessing the PWM/Timer hardware registers use the PWM API. This
requires some extensions to the PWM API though, so we can export the IRQ
associated with the PWM device.


So far nobody has stepped up to implement this, but sounds like a fun
project, doesn't it? ;)

- Lars

