Return-Path: <SRS0=75sL=NL=gmail.com=nishadkamdar@kernel.org>
Date: Wed, 31 Oct 2018 21:30:36 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Slawomir Stepien <sst@poczta.fm>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541000375.git.nishadkamdar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index d3e7d5aad2c8..7c50def91a2b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -701,6 +701,12 @@ static int ad2s1210_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad2s1210_of_match[] = {
+	{ .compatible = "adi,ad2s1210", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
+
 static const struct spi_device_id ad2s1210_id[] = {
 	{ "ad2s1210" },
 	{}
@@ -710,6 +716,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
-- 
2.17.1
