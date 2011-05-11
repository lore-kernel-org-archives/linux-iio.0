Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 1/2] IIO-work: iio.h: add missing address in IIO_CHAN
Date: Wed, 11 May 2011 13:58:38 +0200
Message-ID: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

add missing address in IIO_CHAN

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 92609ee..d9f2692 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -136,6 +136,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	  .extend_name = _name,						\
 	  .channel = _chan,						\
 	  .channel2 = _chan2,						\
+	  .address = _address,						\
 	  .info_mask = _inf_mask,					\
 	  .scan_index = _si,						\
 	  .scan_type = _stype,						\
-- 
1.6.0.2
