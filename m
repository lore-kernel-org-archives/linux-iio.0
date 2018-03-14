Return-Path: <SRS0=Zfd2=GE=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Wed, 14 Mar 2018 15:10:00 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging:iio:ade7854: Cleanup on I2C/SPI code
Message-ID: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patchset reworks the I2C/SPI code from meter module. The set of
patches try to reduce the code duplication and make the communication
reliable. The current version of the module had many code duplications,
which make the code more error-prone and hard to read. Jonh Syne
identified some wrong error handling and fixed it in his patches; in
this series of patches I analyzed Jonh's fixes, and use it in the new
code.

It is important to highlight that meter module is under observation, due
to the lack of hardware and the old design of the chip. However, John
has the hardware for testing and interest to help to update the code
[1]. As a result, this patchset represents the first work effort to
update the meter module in the staging.

1 - https://marc.info/?l=linux-iio&m=152046885922153&w=2 

Rodrigo Siqueira (7):
  staging:iio:ade7854: Rework I2C write function
  staging:iio:ade7854: Rework SPI write function
  staging:iio:ade7854: Replace many functions for one function
  staging:iio:ade7854: Rework I2C read function
  staging:iio:ade7854: Rework SPI read function
  staging:iio:ade7854: Remove read_reg_* duplications
  staging:iio:ade7854: Add proper error handling condition.

 drivers/staging/iio/meter/ade7854-i2c.c | 236 ++++++++--------------------
 drivers/staging/iio/meter/ade7854-spi.c | 268 +++++++-------------------------
 drivers/staging/iio/meter/ade7854.c     |  44 +++---
 drivers/staging/iio/meter/ade7854.h     |  23 +--
 4 files changed, 160 insertions(+), 411 deletions(-)

-- 
2.16.2
