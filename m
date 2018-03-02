Return-Path: <SRS0=gG0f=FY=gmail.com=shreeya.patel23498@kernel.org>
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
Subject: [PATCH 0/6] adis16209 driver cleanup
Date: Fri,  2 Mar 2018 18:46:29 +0530
Message-Id: <cover.1519995673.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.

Shreeya Patel (6):
  Staging: iio: adis16209: Arrange headers in alphabetical order
  Staging: iio: adis16209: Change the definition name
  Staging: iio: adis16209: Add _REG postfix for registers
  Staging: iio: adis16209: Remove unnecessary comments and group the
    definitions
  Staging: iio: adis16209: Add some informatic comments
  Staging: iio: adis16209: Use sign_extend32 and adjust a switch
    statement

 drivers/staging/iio/accel/adis16209.c | 245 +++++++++++++---------------------
 1 file changed, 94 insertions(+), 151 deletions(-)

-- 
2.7.4
