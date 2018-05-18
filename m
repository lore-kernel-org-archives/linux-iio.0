Return-Path: <SRS0=iAnx=IF=gmail.com=davidjulianveenstra@kernel.org>
Date: Fri, 18 May 2018 20:20:52 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 00/12] iio: ad2s1200: Driver clean up
Message-ID: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

For v1 see [1], for v2 see [2], for v3 see [3].

A summary of this patch:
1. Clean up of minor code style issues.
2. Replace legacy GPIO ABI with modern ABI and remove usage of.
   platform data.
4. Add scaling factor for angular position and angular velocity to
   match the sysfs IIO ABI.
5. Add documentation for device tree binding
6. Move driver to main line.

Changes in v4:
- Some new minor code style fix ups.
- Move spi setup to before iio device registration.
- Add vendor prefix to gpios function name, and dt docs.
- Add device tree table
- Add copyright.

Best regards,
David Veenstra

[1] https://marc.info/?l=linux-iio&m=152137920426820&w=2
[2] https://marc.info/?l=linux-iio&m=152425250915148&w=2
[3] https://marc.info/?l=linux-iio&m=152443456824272&w=2

David Veenstra (12):
  staging: iio: ad2s1200: Remove unneeded newline in license
  staging: iio: ad2s1200: Remove unneeded initializations
  staging: iio: ad2s1200: Add kernel docs to driver state
  staging: iio: ad2s1200: Setup spi before iio device register
  staging: iio: ad2s1200: Replace legacy gpio API with modern API
  staging: iio: ad2s1200: Replace platform data with dt bindings
  staging: iio: ad2s1200: Add dt table
  dt-bindings: iio: resolver: Document AD2S1200 bindings
  staging: iio: ad2s1200: Add scaling factor for angular velocity
    channel
  staging: iio: ad2s1200: Add scaling factor for angle channel
  staging: iio: ad2s1200: Add copyright
  staging: iio: ad2s1200: Move driver out of staging

 .../bindings/iio/resolver/ad2s1200.txt        |  16 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/resolver/Kconfig                  |  17 ++
 drivers/iio/resolver/Makefile                 |   5 +
 drivers/iio/resolver/ad2s1200.c               | 210 ++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig          |  12 -
 drivers/staging/iio/resolver/Makefile         |   1 -
 drivers/staging/iio/resolver/ad2s1200.c       | 168 --------------
 9 files changed, 250 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 create mode 100644 drivers/iio/resolver/ad2s1200.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s1200.c

-- 
2.17.0
