Return-Path: <SRS0=Zfd2=GE=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Wed, 14 Mar 2018 15:12:18 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging:iio:ade7854: Add proper error handling condition
Message-ID: <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

There is some improper error handling for IRQ and device register.  This
patch adds a proper verification. The IRQ correction was extracted from
John Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 09fd8c067738..49cbe365e43d 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -436,7 +436,7 @@ static int ade7854_initial_setup(struct iio_dev *indio_dev)
 
 	/* Disable IRQ */
 	ret = ade7854_set_irq(dev, false);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
@@ -544,7 +544,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* Get the device into a sane initial state */
-- 
2.16.2
