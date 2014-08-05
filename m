Return-Path: <mopsfelder@gmail.com>
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH v2 0/8] staging: iio: accel: Multiple coding style fixes
Date: Mon,  4 Aug 2014 22:46:55 -0300
Message-Id: <1407203223-9700-1-git-send-email-mopsfelder@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The following patches fix almost all warnings reported by
checkpatch.pl.

Changes from v1:
- Updated commit messages to better reflect changes.

Murilo Opsfelder Araujo (8):
  staging: iio: accel: adis16203_core.c: Add blank lines between
    declarations and code
  staging: iio: accel: adis16201_core.c: Add blank line between
    declarations and code
  staging: iio: accel: adis16204_core.c: Add blank line between
    declarations and code
  staging: iio: accel: adis16209_core.c: Add blank line between
    declarations and code
  staging: iio: accel: adis16240_core.c: Add blank line between
    declarations and code
  staging: iio: accel: lis3l02dq_core.c: Add blank lines between
    declarations and code
  staging: iio: accel: lis3l02dq_ring.c: Add blank line between
    declarations and code
  staging: iio: accel: sca3000_core.c: Add blank line between
    declarations and code

 drivers/staging/iio/accel/adis16201_core.c | 5 +++--
 drivers/staging/iio/accel/adis16203_core.c | 2 ++
 drivers/staging/iio/accel/adis16204_core.c | 1 +
 drivers/staging/iio/accel/adis16209_core.c | 1 +
 drivers/staging/iio/accel/adis16240_core.c | 1 +
 drivers/staging/iio/accel/lis3l02dq_core.c | 4 ++++
 drivers/staging/iio/accel/lis3l02dq_ring.c | 1 +
 drivers/staging/iio/accel/sca3000_core.c   | 4 +++-
 8 files changed, 16 insertions(+), 3 deletions(-)

--
2.1.0.rc1.204.gae8bc8d
