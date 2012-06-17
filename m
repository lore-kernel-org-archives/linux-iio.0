Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: fix typos in tsl*: register
Date: Sun, 17 Jun 2012 19:03:15 +0200
Message-Id: <1339952599-22105-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 drivers/staging/iio/light/tsl2583.c      |    2 +-
 drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5e23ad5..6d2f4c6 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -410,7 +410,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	/* determine als integration regster */
+	/* determine als integration register */
 	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
 	if (als_count == 0)
 		als_count = 1; /* ensure at least one cycle */
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 040da4a..fdf75e4 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -736,7 +736,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	/* determine als integration regster */
+	/* determine als integration register */
 	als_count = (chip->tsl2x7x_settings.als_time * 100 + 135) / 270;
 	if (als_count == 0)
 		als_count = 1; /* ensure at least one cycle */
-- 
1.7.9.5
