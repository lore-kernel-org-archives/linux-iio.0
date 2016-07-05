Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41636 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbcGELzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:49 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 8/9] staging: iio: isl29028: Expose scale and sample frequency available without comma
Date: Tue,  5 Jul 2016 13:55:43 +0200
Message-Id: <1467719744-19450-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29028.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index a73b632..7358c3b 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -383,8 +383,8 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
-				"1, 3, 5, 10, 13, 20, 83, 100");
-static IIO_CONST_ATTR(in_illuminance_scale_available, "125, 2000");
+				"1 3 5 10 13 20 83 100");
+static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
 
 #define ISL29028_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
-- 
1.7.10.4

