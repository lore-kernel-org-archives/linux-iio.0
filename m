Return-Path: <SRS0=Jd6c=NI=gmail.com=nishadkamdar@kernel.org>
Date: Sun, 28 Oct 2018 13:22:31 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <6b324781850b7543f8bbe67a6a48c9469d8a707b.1540712249.git.nishadkamdar@gmail.com>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1540712249.git.nishadkamdar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 93c3c70ce62e..0234869e9d74 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -724,6 +724,12 @@ static int ad2s1210_remove(struct spi_device *spi)
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
@@ -733,6 +739,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
-- 
2.17.1
