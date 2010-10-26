Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org
Subject: [PATCH 03/36] staging: iio: add ADI info to TODO
Date: Tue, 26 Oct 2010 14:17:13 -0400
Message-Id: <1288117066-18055-4-git-send-email-vapier@gentoo.org>
In-Reply-To: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/TODO |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 898cba1..d1ad35e 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -61,6 +61,10 @@ necessitate a header that is also visible from arch board
 files. (avoided at the moment to keep the driver set
 contained in staging).
 
+ADI Drivers:
+CC the device-drivers-devel@blackfin.uclinux.org mailing list when
+e-mailing the normal IIO list (see below).
+
 Documentation
 1) Lots of cleanup and expansion.
 2) Some device require indvidual docs.
-- 
1.7.3.2
