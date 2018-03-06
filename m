Return-Path: <SRS0=GhrB=F4=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 6 Mar 2018 09:25:50 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging:iio:meter: Remove unused macro
 IIO_DEV_ATTR_CH_OFF
Message-ID: <d22093b4c22f6df9c6efc2e7f711417726719fee.1520338980.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch removes the macro IIO_DEV_ATTR_CH_OFF. The macro
IIO_DEV_ATTR_CH_OFF is not required, due to the replace of it by the
direct use of IIO_DEVICE_ATTR in files staging/iio/meter/ade7759.c and
staging/iio/meter/ade7753.c.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/meter.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
index edf26302fa57..5ed59bf30a25 100644
--- a/drivers/staging/iio/meter/meter.h
+++ b/drivers/staging/iio/meter/meter.h
@@ -348,9 +348,6 @@
 #define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
-
 /* active energy register, AENERGY, is more than half full */
 #define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)
-- 
2.16.2
