Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34748 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbbKJQHw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2015 11:07:52 -0500
Received: by wmvv187 with SMTP id v187so15515254wmv.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2015 08:07:50 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com, Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 0/4] IIO: add support for INA2xx power monitor
Date: Tue, 10 Nov 2015 17:07:29 +0100
Message-Id: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This chip has fair support in the hwmon stack already, this work is more
as a pathfinder for me, hence I post it as RFC to digg some more into 'does
and donts' with IIO.

Nevertheless, it provides a working streaming scheme for capturing
power/voltage/current with this chip. It works in local and remote
mode with iio_readdev and I did some sniffing tests with iio-oscilloscope
with promising results inspite of timeout issues for long temporal buffers
presumably due to the slow rates for this chip compared to expected high-speed
CoDecs (and maybe the lack of a proper plugin?).

The kthread I'm using does an active waiting to allow for sampling periods
shorter than a tick. I have not experienced performance issues with it on
the board (BeagleBoneBlack), IIOD could always schedule on time as far as I
could see, maybe with other i2c backends a schedule() could be mandatory ?

Many thanks,

Marc Titinger (4):
  iio: ina2xx: add direct IO support for TI INA2xx Power Monitors
  iio: ina2xx: add SAMP_FREQ attribute.
  iio: ina2xx: add debugfs reg access
  iio: ina2xx: add SOFTWARE buffer mode using an iio kfifo.

 drivers/iio/adc/Kconfig      |  11 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ina2xx-iio.c | 579 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 591 insertions(+)
 create mode 100644 drivers/iio/adc/ina2xx-iio.c

-- 
1.9.1

