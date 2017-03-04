Return-Path: <SRS0=vqMg=2N=gmail.com=narcisaanamaria12@kernel.org>
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com,
	linux-iio@vger.kernel.org,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 0/4] staging: iio: adis162xx: Clean-up headers
Date: Sat,  4 Mar 2017 15:46:16 +0200
Message-Id: <cover.1488634510.git.narcisaanamaria12@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Move contents from adis16201.h, adis16203.h, adis16209.h, adis16240.h
into the corresponding source files, because, for each one of these 
headers, there is one single source file that uses it.

Narcisa Ana Maria Vasile (4):
  staging: iio: adis16201: Move contents of the header to the source
    file
  staging: iio: adis16203: Move contents of the header to the source
    file
  staging: iio: adis16209: Move contents of the header to the source
    file
  staging: iio: adis16240: Move contents of the header to the source
    file

 drivers/staging/iio/accel/adis16201.h      | 144 -----------------------
 drivers/staging/iio/accel/adis16201_core.c | 140 +++++++++++++++++++++-
 drivers/staging/iio/accel/adis16203.h      | 125 --------------------
 drivers/staging/iio/accel/adis16203_core.c | 123 +++++++++++++++++++-
 drivers/staging/iio/accel/adis16209.h      | 144 -----------------------
 drivers/staging/iio/accel/adis16209_core.c | 140 +++++++++++++++++++++-
 drivers/staging/iio/accel/adis16240.h      | 179 -----------------------------
 drivers/staging/iio/accel/adis16240_core.c | 175 +++++++++++++++++++++++++++-
 8 files changed, 573 insertions(+), 597 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/adis16201.h
 delete mode 100644 drivers/staging/iio/accel/adis16203.h
 delete mode 100644 drivers/staging/iio/accel/adis16209.h
 delete mode 100644 drivers/staging/iio/accel/adis16240.h

-- 
1.9.1
