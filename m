Return-Path: <SRS0=vqMg=2N=gmail.com=narcisaanamaria12@kernel.org>
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com,
	linux-iio@vger.kernel.org,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v2] staging: iio: accel: Rename source files and update Makefile
Date: Sat,  4 Mar 2017 21:43:12 +0200
Message-Id: <1488656592-15251-1-git-send-email-narcisaanamaria12@gmail.com>
In-Reply-To: <1488651002-18415-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488651002-18415-1-git-send-email-narcisaanamaria12@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Rename adis162xx_core.c files to adis162xx.c because
these are the only source files for these drivers.

Update Makefile to correspond to the new file names.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

 rename drivers/staging/iio/accel/{adis16201_core.c => adis16201.c} (100%)
 rename drivers/staging/iio/accel/{adis16203_core.c => adis16203.c} (100%)
 rename drivers/staging/iio/accel/{adis16209_core.c => adis16209.c} (100%)
 rename drivers/staging/iio/accel/{adis16240_core.c => adis16240.c} (100%)

diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index febb137..5d8ad21 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -2,14 +2,7 @@
 # Makefile for industrial I/O accelerometer drivers
 #
 
-adis16201-y             := adis16201_core.o
 obj-$(CONFIG_ADIS16201) += adis16201.o
-
-adis16203-y             := adis16203_core.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
-
-adis16209-y             := adis16209_core.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
-
-adis16240-y             := adis16240_core.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16201_core.c
rename to drivers/staging/iio/accel/adis16201.c
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16203_core.c
rename to drivers/staging/iio/accel/adis16203.c
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16209_core.c
rename to drivers/staging/iio/accel/adis16209.c
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16240_core.c
rename to drivers/staging/iio/accel/adis16240.c
-- 
1.9.1
