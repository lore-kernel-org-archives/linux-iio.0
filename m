Return-Path: <amsfield22@gmail.com>
Date: Fri, 20 May 2016 10:06:41 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc100x: correct humidity integration time
 mask
Message-ID: <20160520170633.GA2629@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Apply the correct mask to enable all available humidity integration
times.  Currently, the driver defaults to 6500 and all is okay with that.
However, if 3850 is selected we get a stuck bit and can't change back
to 6500 or select 2500.  (Verified with HDC1008)

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index fa47676..59aa1cb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -55,7 +55,7 @@ static const struct {
 	},
 	{ /* IIO_HUMIDITYRELATIVE channel */
 		.shift = 8,
-		.mask = 2,
+		.mask = 3,
 	},
 };
 
-- 
2.1.4
