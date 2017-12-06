Return-Path: <SRS0=m7Dp=DC=melexis.com=cmo@kernel.org>
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 0/3] iio: temperataure: MLX90632
Date: Wed,  6 Dec 2017 10:54:30 +0100
Message-Id: <20171206095430.8041-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

Hi everybody,

With the sensor now available to broad public, it is time to also
share the driver with the community. MLX90632 is just 3x3mm in size,
but with factory calibration offers instant usage in every project.

Driver currently provides basic functionality, but I might add
some more fancy features after a while.

v2 includes comments from Rob Herring (dt-bindings) and Jonathan
Cameron (iio), as well as proposal to split out int_sqrt64 function
into the linux/kernel.h

v3 comments were added to some parts of mlx90632.c and TENTO defines
replaced by values. Fixes were done to emissivity read/write and
changed to INT_PLUS_MICRO instead. Empty line in int_sqrt.c was
removed as it generated a warning when applying.

Crt Mori (3):
  iio: temperature: Adding support for MLX90632
  dt-bindings: iio: temperature: add MLX90632 device bindings
  lib: Add strongly typed 64bit int_sqrt

 .../bindings/iio/temperature/mlx90632.txt          |  28 +
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  12 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/mlx90632.c                 | 787 +++++++++++++++++++++
 include/linux/kernel.h                             |   1 +
 lib/int_sqrt.c                                     |  26 +
 7 files changed, 862 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 drivers/iio/temperature/mlx90632.c

-- 
2.15.0
