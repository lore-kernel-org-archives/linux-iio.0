Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:44185 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754697Ab3GEIbP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 04:31:15 -0400
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-iio@vger.kernel.org>
CC: <alexandre.belloni@free-electrons.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <marex@denx.de>, <fabio.estevam@freescale.com>,
	<hector.palacios@digi.com>
Subject: [PATCH 0/4] iio: mxs-lradc: add support to optional divider_by_two
Date: Fri, 5 Jul 2013 10:30:35 +0200
Message-ID: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Greetings,

This patchset adds support to the optional divider_by_two of
LRADC channels. The first patch changes the realbits to 12. The 
following add the scale read operation, scale_available read 
operation, and scale write operation.

This was tested on a custom i.MX28 platform.
Could someone please test on an i.MX23?

Thanks to Lars-Peter Clausen and Alexandre Belloni for helping me out 
through the IIO driver framework.
Man, it resulted a large amount of code for just enabling a flag.

Hector Palacios (4):
  iio: mxs-lradc: change the realbits to 12
  iio: mxs-lradc: add scale attribute to channels
  iio: mxs-lradc: add scale_available file to channels
  iio: mxs-lradc: add write_raw function to modify scale

 drivers/staging/iio/adc/mxs-lradc.c | 292 ++++++++++++++++++++++++++++++++----
 1 file changed, 261 insertions(+), 31 deletions(-)

