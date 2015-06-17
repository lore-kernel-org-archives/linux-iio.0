Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v2 3/7] iio:light:cm3323: pass up error value
Date: Thu, 18 Jun 2015 00:32:01 +0200
Message-Id: <729e23b785dfa67011e8d2cfde7f5bac84d6f147.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

cm3323_get_it_bits() returns a valid error code, so pass it up in
cm3323_read_raw().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/light/cm3323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index a1d4905..feb4dbc 100644
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
