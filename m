Return-Path: <SRS0=alez=YZ=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: ak8974: remove redundant zero timeout check
Date: Wed, 11 Jan 2017 17:49:33 +0000
Message-Id: <20170111174933.22523-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

At the end of the delay loop timeout will always be zero
and hence the check for !timeout will always be true. Remove
the redundant check and the redundant return 0 at the end of
the function.

Fixes CoverityScan CID#1357168 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/magnetometer/ak8974.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ce09d77..6dd8cbd 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -278,13 +278,9 @@ static int ak8974_await_drdy(struct ak8974 *ak8974)
 		if (val & AK8974_STATUS_DRDY)
 			return 0;
 	} while (--timeout);
-	if (!timeout) {
-		dev_err(&ak8974->i2c->dev,
-			"timeout waiting for DRDY\n");
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	dev_err(&ak8974->i2c->dev, "timeout waiting for DRDY\n");
+	return -ETIMEDOUT;
 }
 
 static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
-- 
2.10.2
