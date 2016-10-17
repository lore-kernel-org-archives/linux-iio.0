Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: 
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Ico Doornekamp <ico@pruts.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ioana Ciornei <ciorneiioana@gmail.com>,
	Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 14/28] iio: accel: sca3000_core: avoid potentially uninitialized variable
Date: Tue, 18 Oct 2016 00:13:35 +0200
Message-Id: <20161017221355.1861551-2-arnd@arndb.de>
In-Reply-To: <20161017220342.1627073-1-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

The newly added __sca3000_get_base_freq function handles all valid
modes of the SCA3000_REG_ADDR_MODE register, but gcc notices
that any other value (i.e. 0x00) causes the base_freq variable to
not get initialized:

drivers/staging/iio/accel/sca3000_core.c: In function 'sca3000_write_raw':
drivers/staging/iio/accel/sca3000_core.c:527:23: error: 'base_freq' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This adds explicit error handling for unexpected register values,
to ensure this cannot happen.

Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ico Doornekamp <ico@pruts.nl>
Cc: Jonathan Cameron <jic23@kernel.org>
---
I submitted this on Sept 22, and Jonathan said he applied it to his
'togreg' tree, but it hasn't appeared in linux-next yet, presumably
since this was not considered material for v4.9.

If we enable the warning again by default, we may want to have the
fix merged for v4.9 after all.

 drivers/staging/iio/accel/sca3000_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index d626125..564b36d 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -468,6 +468,8 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 	case SCA3000_MEAS_MODE_OP_2:
 		*base_freq = info->option_mode_2_freq;
 		break;
+	default:
+		ret = -EINVAL;
 	}
 error_ret:
 	return ret;
-- 
2.9.0
