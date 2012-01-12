Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:46924 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab2ALUK0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2012 15:10:26 -0500
Message-ID: <4F0F3DFD.6010106@metafoo.de>
Date: Thu, 12 Jan 2012 21:09:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Palande, Ameya" <ameya.palande@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: drv2665 driver placement query
References: <CAHFNHeW=XM0=c-PiOtttzgL68jrAwPyeM-iZMQffVx2yq3BN-g@mail.gmail.com>
In-Reply-To: <CAHFNHeW=XM0=c-PiOtttzgL68jrAwPyeM-iZMQffVx2yq3BN-g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 01/12/2012 08:39 PM, Palande, Ameya wrote:
> Hi,
> 
> I submitted a driver for Texas Instruments DRV2665 chip for placing it
> under "drivers/misc".
> But I guess it is more appropriate to put it under "drivers/staging/iio"
> Reference: https://lkml.org/lkml/2012/1/10/31

> 
> Here is the description of the chip:
> 
> DRV2665 IC drives piezo actuator which enables a wide variety of
> high-resolution haptic effects, including feedback localized to
> specific areas of the device, as well as vibrations and pulses that
> change in frequency based on how the user is interacting with the
> device.
> 
> Can you tell me where should I put it under "staging/iio" ?
> 


I had a short look at your driver and it looks to me as if all it does is
expose the raw registers as sysfs attributes. So I think one thing you first
have to do is to figure out a generic interface for the device class. How does
a application usually use these kinds of devices, how can the interface be
abstracted, so it applies to a wider range of devices of this class and not
only to this one specific device.

- Lars

