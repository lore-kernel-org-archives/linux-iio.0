Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:35125 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751808AbdLUSbw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Dec 2017 13:31:52 -0500
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2 2/7] iio: adc: ina2xx: Clarify size requirement for data buffer
Date: Thu, 21 Dec 2017 19:31:33 +0100
In-Reply-To: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <177afe81-4299-4ba7-8fbf-4e0f08e3942a@rwthex-w2-a.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The timestamp is inserted into the buffer after the sample data by
iio_push_to_buffers_with_timestamp, document the space requirement for
the timestamp.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

Changes in v2: None

 drivers/iio/adc/ina2xx-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 3195f8754c3b..8c8120406f52 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -700,7 +700,8 @@ static const struct iio_chan_spec ina219_channels[] = {
 static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 {
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
-	unsigned short data[8];
+	/* data buffer needs space for channel data and timestap */
+	unsigned short data[4 + sizeof(s64)/sizeof(short)];
 	int bit, ret, i = 0;
 	s64 time_a, time_b;
 	unsigned int alert;
-- 
2.15.1

