Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30858 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbcCBLJ5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Mar 2016 06:09:57 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 3/6] iio:magnetometer:ak8975: use explicit endianness
Date: Wed, 2 Mar 2016 12:10:25 +0100
Message-ID: <397338e080c043cdaa7848a875a1f54a280e34ac.1456916271.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1456916271.git.gregor.boirie@parrot.com>
References: <cover.1456916271.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ak8963, ak8975, ak09911 and ak09912 all store measurements in 2's
complement and little endian.
This enforces le16 to CPU endianness conversion of raw measurements
fetched from I2C bus.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/ak8975.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 896b13e3..46c6bd7 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -655,7 +655,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	mutex_unlock(&data->lock);
 
 	/* Clamp to valid range. */
-	*val = clamp_t(s16, ret, -data->def->range, data->def->range);
+	*val = clamp_t(s16, le16_to_cpu((s16)ret), -data->def->range,
+		       data->def->range);
 	return IIO_VAL_INT;
 
 exit:
-- 
2.1.4

