Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 2/3] iio: frequency: Remove unnecessary braces around single statement block
Date: Tue, 16 Dec 2014 11:11:46 +0200
Message-Id: <1418721107-5429-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl warning:
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/frequency/adf4350.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 2b301eb..10a0dfc 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -611,9 +611,8 @@ static int adf4350_remove(struct spi_device *spi)
 	if (st->clk)
 		clk_disable_unprepare(st->clk);
 
-	if (!IS_ERR(reg)) {
+	if (!IS_ERR(reg))
 		regulator_disable(reg);
-	}
 
 	return 0;
 }
-- 
1.9.1
