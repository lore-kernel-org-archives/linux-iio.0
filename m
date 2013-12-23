Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de,
	Marek Vasut <marex@denx.de>,
	harald@ccbib.org,
	hector.palacios@digi.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv5 RESEND 0/4] iio: mxs-lradc: add support to optional divider_by_two
Date: Mon, 23 Dec 2013 18:48:00 +0100
Message-Id: <1387820884-28140-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This is v5 of the patchset that adds support to the optional divider_by_two
of LRADC channels.

Changes since v4:
 - moved enum mxs_lradc_divbytwo to the third patch
 - added a fourth patch to convert is_divided to a bitmap. I did that in a
   separated patch for review and copyright attribution purposes.

This was tested on a custom i.MX28 platform.

Alexandre Belloni (1):
  iio: mxs-lradc: convert is_divided to a bitmap

Hector Palacios (3):
  iio: mxs-lradc: add scale attribute to channels
  iio: mxs-lradc: add scale_available file to channels
  iio: mxs-lradc: add write_raw function to modify scale

 drivers/staging/iio/adc/mxs-lradc.c | 222 +++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 3 deletions(-)

-- 
1.8.3.2
