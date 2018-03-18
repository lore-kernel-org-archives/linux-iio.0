Return-Path: <SRS0=e4jg=GI=gmail.com=davidjulianveenstra@kernel.org>
Date: Sun, 18 Mar 2018 14:33:52 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 00/11] staging: iio: ad2s1200: Driver clean up
Message-ID: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Please forget the previous 3 emails, I forgot the message-id and
reply-to business.

This patch series is meant to move the ad2s1200 driver to mainline. In short
the following is done:

1. Clean up of minor code style issues
2. Fix minor bugs
3. Replace legacy GPIO ABI with modern ABI
4. Change the channel definitions of angular position and angular
   velocity to match the sysfs IIO ABI.

The channel for angular position had to be changed to another type
as there is no definition for IIO_ANGL in sysfs IIO ABI. There are other
types that model some kind of rotation, the candidates are:
- in_rot_from_north_*
- in_rot_quaternion
- in_incli

The in_rot_from_north_*_raw family is a rotation relevative to the
geographical north, or the magnetic north. These semantics are not a
good fit for the angular position of a resolver. The
in_rot_quaternion_raw als does not seem like a good choice, as it is
overkill for a rotation over a single and fixed axis. This is also
likely to be a cubersome format for users of the ABI interface. Finally,
there is in_incli which seems to be meant for any kind of inclination,
given in degrees. In my opinion in_incli is the best choice, as
it has a conveniant format and has semantics similar to that of angular
position.

David Veenstra (11):
  staging: iio: ad2s1200: Sort includes alphabetically
  staging: iio: ad2s1200: Reverse Christmas tree order
  staging: iio: ad2s1200: Add blank lines
  staging: iio: ad2s1200: Add kernel docs to driver state
  staging: iio: ad2s1200: Introduce variable for repeated value
  staging: iio: ad2s1200: Improve readability with be16_to_cpup
  staging: iio: ad2s1200: Ensure udelay(1) in all necessary code paths
  staging: iio: ad2s1200: Replace legacy gpio ABI with modern ABI
  staging: iio: ad2s1200: Add scaling factor for IIO_ANGL_VEL channel
  staging: iio: ad2s1200: Replace angle channel with inclination channel
  Move resolver ad2c1200 driver out of staging to mainline iio

 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/resolver/Kconfig                  |  17 +++
 drivers/iio/resolver/Makefile                 |   5 +
 drivers/{staging => }/iio/resolver/ad2s1200.c | 177 ++++++++++++++++++--------
 drivers/staging/iio/resolver/Kconfig          |  12 --
 drivers/staging/iio/resolver/Makefile         |   1 -
 7 files changed, 151 insertions(+), 63 deletions(-)
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 rename drivers/{staging => }/iio/resolver/ad2s1200.c (50%)

-- 
2.16.2
