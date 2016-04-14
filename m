Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 09/10] iio: magnetometer: ak8975: put else and brace at the same line
Date: Thu, 14 Apr 2016 21:36:41 +0200
Message-Id: <1460662602-2951-10-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: else should follow close brace '}'

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/magnetometer/ak8975.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 48d127a..6bc855f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -810,8 +810,7 @@ static int ak8975_probe(struct i2c_client *client,
 		name = ak8975_match_acpi_device(&client->dev, &chipset);
 		if (!name)
 			return -ENODEV;
-	}
-	else
+	} else
 		return -ENOSYS;
 
 	if (chipset >= AK_MAX_TYPE) {
-- 
2.8.0
