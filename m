Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 29 Jan 2013 10:51:45 +0100
Subject: Re: STMicroelectronics IIO driver
Message-ID: <135947692.Y65oJdCdPt@elitebook-8460p>
References: <1359157488-15969-1-git-send-email-denis.ciocca@st.com>
 <51068BAE.9090801@metafoo.de> <5106DC2F.60501@kernel.org>
In-Reply-To: <5106DC2F.60501@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Applied to togreg branch of iio.git.  Note there was some fuzz on patches
> 2 and 3  + need to do a merge on patch 2 due to makefile changes.  Denis,
> could you verify I didn't mess it up (as I am occasionally known to do ;)

I tested the driver and I didn't find any problems, there is only one littl=
e=20
wrong label in Kconfig of iio/st_sensors/Kconfig:

---
 drivers/iio/common/st_sensors/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/Kconfig=20
b/drivers/iio/common/st_sensors/Kconfig
index 84b2dca..865f1ca 100644
--- a/drivers/iio/common/st_sensors/Kconfig
+++ b/drivers/iio/common/st_sensors/Kconfig
@@ -1,5 +1,5 @@
 #
-# Hid Sensor common modules
+# STMicroelectronics sensors common library
 #
=20
 config IIO_ST_SENSORS_I2C
--=20
1.7.9.5


> This won't go to Greg until next weekend anyway now.
Ok thanks!
