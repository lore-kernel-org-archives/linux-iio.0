Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56187 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbcGYWH4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 18:07:56 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: atlas-ph-sensor: fix typo in val assignment
Date: Mon, 25 Jul 2016 23:06:56 +0100
Message-Id: <1469484416-17305-1-git-send-email-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix an incorrect assignment due to a typo on a variable name. The
variable val2 should be assigned 100000 and not val.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index ae038a5..407f141 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -434,7 +434,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_ELECTRICALCONDUCTIVITY:
 			*val = 1; /* 0.00001 */
-			*val = 100000;
+			*val2 = 100000;
 			break;
 		case IIO_CONCENTRATION:
 			*val = 0; /* 0.000000001 */
-- 
2.8.1

