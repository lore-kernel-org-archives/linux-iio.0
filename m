Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTTbw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:31:52 -0400
Date: Fri, 20 Apr 2018 21:31:48 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 12/13] staging: iio: ad2s1200: Add scaling factor for
 angle channel
Message-ID: <9352ade3afee830795315b5931dfb316853dc094.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A fractional scaling factor of approximately 2 * Pi / (2^12 -1) is added,
to scale the 12-bits angular position to radians.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v2:
  - This patch replaces the patch that changed the
    the channel for angular position to inclination
    channel.

 drivers/staging/iio/resolver/ad2s1200.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 6c56257be3b1..4f5dd28b174a 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -71,6 +71,17 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_ANGL:
+			/*
+			 * 2 * Pi / (2^12 - 1) ~= 2 * 103993 / (33102 * 0xFFF)
+			 *
+			 * Since there only fit 3 whole radians in 360 degrees,
+			 * usage of iio_convert_raw_to_processed for this
+			 * channel will be highly inaccurate.
+			 */
+			*val = 103993;
+			*val2 = 16551 * 0xFFF;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_ANGL_VEL:
 			/*
 			 * 2 * Pi ~= 2 * 103993 / 33102
@@ -133,6 +144,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
-- 
2.16.2

