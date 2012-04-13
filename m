Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37387 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758345Ab2DMKEg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/13] staging:iio:resolver Add IIO_CHAN_INFO_RAW entries to all drivers.
Date: Fri, 13 Apr 2012 11:04:27 +0100
Message-Id: <1334311471-23054-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
No processed values in resolvers at the moment.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/resolver/ad2s1200.c |    2 ++
 drivers/staging/iio/resolver/ad2s1210.c |    2 ++
 drivers/staging/iio/resolver/ad2s90.c   |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index d8ce854..0465e5d 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -85,10 +85,12 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c439fcf..c6ced16 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -580,10 +580,12 @@ static struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 2a86f58..20ca529 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -55,6 +55,7 @@ static const struct iio_chan_spec ad2s90_chan = {
 	.type = IIO_ANGL,
 	.indexed = 1,
 	.channel = 0,
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 };
 
 static int __devinit ad2s90_probe(struct spi_device *spi)
-- 
1.7.0.4

