Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46864 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbcLDCUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 00/19] staging: iio: isl29028: staging cleanups
Date: Sat,  3 Dec 2016 21:19:24 -0500
Message-Id: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is my first round of cleanups to the isl29028 light driver in
preparation for moving the driver out of staging. The main feature
introduced by this patch set is support for power management. The
rest of the patches are minor improvements, mostly style.

I have one of these devices from
https://www.digikey.com/product-detail/en/intersil/ISL29028AIROZ-T7/ISL29028AIROZ-T7CT-ND/2639604
mounted on a breakout board hooked up to a Raspberry Pi 2. The IR and
light sensor are functioning, however I can't get the proximity sensor
to work. I hooked an oscilloscope up to the IRDR pin and +3V to verify
that the pin state begins pulsing when proximity mode is enabled on the
chip. According to page 9 of the datasheet
http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf,
the chip has a noise reduction feature where it will take an IR reading
with the IR LED off to get the baseline, drive the IR LED for 0.1ms, take
another IR reading, and subtract the two readings. My hunch about the
cause of my issue is the 5mm IR LED that I am using is still emitting IR
light during the brief time that the IRDR has no power. The LED is huge
size wise compared to the size of the chip. Replacing the IR LED with a
visible light LED causes the visible light LED to become illuminated
dimly when the IRDR pin begins pulsing.

Any suggestions are welcome. Ideally, I'd like to verify that the
proximity sensing works before submitting a patch moving the driver out
of staging. Looking through the data sheet, and the git commits since
the driver was first introduced into staging, everything in the driver
looks correct so I think this is operator error on my part.

Brian Masney (19):
  staging: iio: isl29028: remove nested if statements
  staging: iio: isl29028: remove enable flag from
    isl29028_enable_proximity()
  staging: iio: isl29028: remove chip test and defaults from
    isl29028_chip_init()
  staging: iio: isl29028: add power management support
  staging: iio: isl29028: made alignment of #defines consistent
  staging: iio: isl29028: made alignment of variables in struct
    isl29028_chip consistent
  staging: iio: isl29028: fix alignment of function arguments
  staging: iio: isl29028: combine isl29028_proxim_get() and
    isl29028_read_proxim()
  staging: iio: isl29028: change newlines to improve readability
  staging: iio: isl29028: remove unused define ISL29028_DEV_ATTR
  staging: iio: isl29028: made column alignment in isl29028_channels
    consistent
  staging: iio: isl29028: fix comparison between signed and unsigned
    integers
  staging: iio: isl29028: move failure logging into
    isl29028_set_proxim_sampling()
  staging: iio: isl29028: move failure logging into
    isl29028_set_als_scale()
  staging: iio: isl29028: made error messages consistent
  staging: iio: isl29028: remove unnecessary error logging in
    isl29028_chip_init_and_power_on()
  staging: iio: isl29028: remove out of memory log message
  staging: iio: isl29028: remove unnecessary parenthesis
  staging: iio: isl29028: remove legacy device tree binding

 drivers/staging/iio/light/isl29028.c | 358 +++++++++++++++++++++--------------
 1 file changed, 215 insertions(+), 143 deletions(-)

-- 
2.7.4

