Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rdunlap@xenotime.net,
        linux@arm.linux.org.uk, jic23@cam.ac.uk, gregkh@linuxfoundation.org,
        broonie@opensource.wolfsonmicro.com, swarren@nvidia.com,
        cbouatmailru@gmail.com, olof@lixom.net, linus.walleij@linaro.org,
        lars@metafoo.de, bfreed@chromium.org, grundler@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/3] staging: iio: light: of: Fix vendor prefix of isl29018
Date: Tue, 17 Apr 2012 12:15:54 +0530
Message-Id: <1334645155-13799-3-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

ISL29018 is from Intersil Corporation and the vendor prefix
for this part should be "isl", at least not "invn" for OF
compatibility.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/staging/iio/light/isl29018.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 38ec52b..ee220ae 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -593,7 +593,7 @@ static const struct i2c_device_id isl29018_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29018_id);
 
 static const struct of_device_id isl29018_of_match[] = {
-	{ .compatible = "invn,isl29018", },
+	{ .compatible = "isl,isl29018", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29018_of_match);
-- 
1.7.1.1
