Return-Path: <SRS0=/TkE=ZV=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/2] Documentation: iio: Fix KernelVersion lines in counter sysfs ABI documentation
Date: Wed,  8 Feb 2017 09:01:27 -0500
Message-Id: <cover.1486562053.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The IIO counter driver support did not appear in the 4.9 version of the
Linux kernel. The sysfs ABI documentation merged had incorrectly
anticipated a version 4.9 release. However, the relevant patches ended
up in the 4.10 merge instead. This patchset fixes the KernelVersion
lines of the relevant IIO counter and 104-QUAD-8 IIO driver sysfs ABI
documentation.

William Breathitt Gray (2):
  Documentation: iio: Fix KernelVersion in counter sysfs ABI
    documentation
  Documentation: iio: 104-quad-8: Fix KernelVersion in sysfs ABI
    documentation

 Documentation/ABI/testing/sysfs-bus-iio                |  4 ++--
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8       | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.11.1
