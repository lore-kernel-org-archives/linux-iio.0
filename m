Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47564 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1I0OBK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2011 10:01:10 -0400
Received: from [192.168.0.42] (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id C95D6136
	for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2011 16:01:00 +0200 (CEST)
Message-ID: <4E81D71C.3050805@free-electrons.com>
Date: Tue, 27 Sep 2011 16:01:00 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Questions about IIO drivers
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I'm currently writing a driver for the ADCs present in Atmel AT91 SoC
using iio. I will of course submit it once it is ready.

For now, I have the basic integration into iio, and I am beginning to
integrate the hardware logic in it. However, this integration raises few
questions, and I didn't found any answers to it. (The dummy driver is of
great help btw)

  - While the registers are all the same on the AT91 platform for the
ADCs, the number of channels available is not the same from one board to
another. For now, I'm declaring the number of channels available through
the board definition and platform_data, and I'm declaring the channels
to iio using :

	idev->channels = kzalloc(sizeof(struct iio_chan_spec) * nb_chan,
				 GFP_KERNEL);
	for(i = 0; i < nb_chan; i++) {
		struct iio_chan_spec *chan = idev->channels + i;
		chan->type = IIO_IN;
		chan->indexed = 1;
		chan->channel = i;
	}

While it seems to work nicely, it generates a warning, as iio_dev's
channels field is declared const. Is there a better solution ?

  - For now, I don't really want to rely on hardware triggers, but
instead use only software triggers. I've taken a look to sysfs triggers,
and while the module for sysfs trigger is compiled and loaded, and added
to the platform_devices of the board, the file trigger_now is nowhere to
be found. I guess that I need to declare triggers in my driver, but I
have found no clue on how to do that. How can we achieve it ?

Thanks,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
