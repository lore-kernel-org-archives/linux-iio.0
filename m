Return-Path: <amsfield22@gmail.com>
Date: Tue, 5 Apr 2016 22:18:44 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, kgene@kernel.org,
	k.kozlowski@samsung.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 5/9] iio: accel: mma7455: use regmap to retrieve struct device
Message-ID: <acaeee6c3c1f99900614baf99ab31e6e5b515970.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Driver includes struct regmap and struct device in its global data.
Remove the struct device and use regmap API to retrieve device info.

Patch created using Coccinelle plus manual edits.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/accel/mma7455_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index c633cc2..c902f54 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -55,11 +55,11 @@
 
 struct mma7455_data {
 	struct regmap *regmap;
-	struct device *dev;
 };
 
 static int mma7455_drdy(struct mma7455_data *mma7455)
 {
+	struct device *dev = regmap_get_device(mma7455->regmap);
 	unsigned int reg;
 	int tries = 3;
 	int ret;
@@ -75,7 +75,7 @@ static int mma7455_drdy(struct mma7455_data *mma7455)
 		msleep(20);
 	}
 
-	dev_warn(mma7455->dev, "data not ready\n");
+	dev_warn(dev, "data not ready\n");
 
 	return -EIO;
 }
@@ -260,7 +260,6 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 	dev_set_drvdata(dev, indio_dev);
 	mma7455 = iio_priv(indio_dev);
 	mma7455->regmap = regmap;
-	mma7455->dev = dev;
 
 	indio_dev->info = &mma7455_info;
 	indio_dev->name = name;
-- 
2.1.4
