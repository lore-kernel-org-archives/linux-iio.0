Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48128 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753525Ab2ALTjp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2012 14:39:45 -0500
Received: by mail-tul01m020-f182.google.com with SMTP id ta17so2006382obb.27
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2012 11:39:45 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 12 Jan 2012 11:39:43 -0800
Message-ID: <CAHFNHeW=XM0=c-PiOtttzgL68jrAwPyeM-iZMQffVx2yq3BN-g@mail.gmail.com>
Subject: drv2665 driver placement query
From: "Palande, Ameya" <ameya.palande@ti.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I submitted a driver for Texas Instruments DRV2665 chip for placing it
under "drivers/misc".
But I guess it is more appropriate to put it under "drivers/staging/iio"
Reference: https://lkml.org/lkml/2012/1/10/31

Here is the description of the chip:

DRV2665 IC drives piezo actuator which enables a wide variety of
high-resolution haptic effects, including feedback localized to
specific areas of the device, as well as vibrations and pulses that
change in frequency based on how the user is interacting with the
device.

Can you tell me where should I put it under "staging/iio" ?

Thank you!

Cheers,
Ameya.
