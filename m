Return-Path: <SRS0=vAg0=F2=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v3 0/4] adis16209 driver cleanup
Date: Sun,  4 Mar 2018 18:04:26 +0530
Message-Id: <cover.1520164945.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.

Changes in v3
  -Combine some patches into one from the previous series
and add some more comments in patch *[1/4].
Introduce a new patch *[2/3] for more cleanup.
Also split the last patch of the previous series into two
patches.

Changes in v2
  -Split patches and redo the series.

Shreeya Patel (4):
  Staging: iio: adis16209: Remove and add some comments and group the
    definitions
  Staging: iio: adis16209: Change some macro names
  Staging: iio: adis16209: Adjust a switch statement
  Staging: iio: adis16209: Use sign_extend32 function

 drivers/staging/iio/accel/adis16209.c | 183 +++++++++++++---------------------
 1 file changed, 67 insertions(+), 116 deletions(-)

-- 
2.7.4
