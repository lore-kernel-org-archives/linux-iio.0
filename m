Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50026 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbbFCIcS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Jun 2015 04:32:18 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, pmeerw@pmeerw.net, knaack.h@gmx.de,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 5/6] iio: magnetometer: mmc35240: Fix sensitivity on z-axis
Date: Wed,  3 Jun 2015 11:33:57 +0300
Message-Id: <1433320438-23870-6-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433320438-23870-1-git-send-email-daniel.baluta@intel.com>
References: <1433320438-23870-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Datasheet says (Page 2) that typical value for sensitivity
for 16 bits mode on Z-axis is 770. Anyhow, looking at the
input driver provided by Memsic the value for MMC35240 is
1024.

Also, testing shows that using 1024 for Z-axis senzitivity
offers better results.

Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 35eb6fd..88be660 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -77,7 +77,7 @@ static const struct {
 } mmc35240_props_table[] = {
 	/* 16 bits, 100Hz ODR */
 	{
-		{1024, 1024, 770},
+		{1024, 1024, 1024},
 		32768,
 	},
 	/* 16 bits, 200Hz ODR */
-- 
1.9.1

