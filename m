Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 3/7] iio:light:cm3323: pass up error value
Date: Wed, 17 Jun 2015 00:17:02 +0200
Message-Id: <bd2cf6c9af8c7b741cf0f544d273952976e6e07c.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

cm3323_get_it_bits() returns a valid error code, so pass it up in
cm3323_read_raw().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/cm3323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 1e6092a..f88a0ed 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -175,7 +175,7 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
 		i = cm3323_get_it_bits(data);
 		if (i < 0) {
 			mutex_unlock(&data->mutex);
-			return -EINVAL;
+			return i;
 		}
 
 		*val = cm3323_int_time[i].val;
-- 
2.3.6
