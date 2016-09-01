Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/15 v2] iio: accel: kxsd9: split out a common remove() function
Date: Thu,  1 Sep 2016 11:44:37 +0200
Message-Id: <1472723089-25113-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This makes it possible to later split the transport mechanism
using a generic probe() and a generic remove().

Use dev_set_drvdata() and dev_get_drvdata() as a paired
accessor to operate on the abstract struct device * regardless
of the transport mechanism in use.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch replacing "iio: accel: kxsd: use devm_iio_device_register"
  which didn't work out in practice: also later patches anyways
  reintroduced the common remove() function so we may just as well
  keep it around.
---
 drivers/iio/accel/kxsd9.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index df8a31e84c7d..1f9e9a867f34 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -220,8 +220,7 @@ static const struct iio_info kxsd9_info = {
 
 static int kxsd9_common_probe(struct device *parent,
 			      struct kxsd9_transport *transport,
-			      const char *name,
-			      struct iio_dev **retdev)
+			      const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
@@ -248,7 +247,17 @@ static int kxsd9_common_probe(struct device *parent,
 	if (ret)
 		return ret;
 
-	*retdev = indio_dev;
+	dev_set_drvdata(parent, indio_dev);
+
+	return 0;
+}
+
+static int kxsd9_common_remove(struct device *parent)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(parent);
+
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
@@ -295,7 +304,6 @@ static int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
 static int kxsd9_spi_probe(struct spi_device *spi)
 {
 	struct kxsd9_transport *transport;
-	struct iio_dev *indio_dev;
 	int ret;
 
 	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
@@ -311,20 +319,16 @@ static int kxsd9_spi_probe(struct spi_device *spi)
 
 	ret = kxsd9_common_probe(&spi->dev,
 				 transport,
-				 spi_get_device_id(spi)->name,
-				 &indio_dev);
+				 spi_get_device_id(spi)->name);
 	if (ret)
 		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
 	return 0;
 }
 
 static int kxsd9_spi_remove(struct spi_device *spi)
 {
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
+	return kxsd9_common_remove(&spi->dev);
 }
 
 static const struct spi_device_id kxsd9_spi_id[] = {
-- 
2.7.4
