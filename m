Return-Path: <SRS0=qS1a=FK=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Feb 2018 11:38:41 -0200
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: apply coding-style into ms5611_probe function
Message-ID: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warning and error:

iio/pressure/ms5611.h:66: ERROR: code indent should use tabs where possible
iio/pressure/ms5611.h:66: WARNING: please, no spaces at the start of a line
iio/pressure/ms5611.h:66: ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/pressure/ms5611.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index ccda63c5b3c3..ead9e9f85894 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -63,7 +63,7 @@ struct ms5611_state {
 };
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
-                 const char* name, int type);
+		 const char *name, int type);
 int ms5611_remove(struct iio_dev *indio_dev);
 
 #endif /* _MS5611_H */
-- 
2.16.1
