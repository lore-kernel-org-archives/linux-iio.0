Return-Path: <SRS0=1vzh=3A=linaro.org=lee.jones@kernel.org>
Date: Thu, 23 Mar 2017 12:32:37 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com,
	fabio.estevam@freescale.com
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v4.12 merge window
Message-ID: <20170323123237.cztjm5gzyhtwyqfg@dell>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Enjoy!

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v4.12

for you to fetch changes up to b2d476404601806c5a94a5f9bfc441d3898a5541:

  dt-bindings: mfd: Move mxs-lradc binding document from IIO to MFD (2017-03-23 12:29:29 +0000)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v4.12 merge window

----------------------------------------------------------------
Ksenija Stanojevic (5):
      mfd: mxs-lradc: Add support for mxs-lradc
      iio: adc: mxs-lradc: Add support for ADC driver
      input: touchscreen: mxs-lradc: Add support for touchscreen
      iio: adc: mxs-lradc: Remove driver
      dt-bindings: mfd: Move mxs-lradc binding document from IIO to MFD

 .../bindings/{iio/adc => mfd}/mxs-lradc.txt        |    0
 drivers/iio/adc/Kconfig                            |   27 +-
 drivers/iio/adc/Makefile                           |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |  843 ++++++++++
 drivers/iio/adc/mxs-lradc.c                        | 1750 --------------------
 drivers/input/touchscreen/Kconfig                  |   10 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/mxs-lradc-ts.c           |  714 ++++++++
 drivers/mfd/Kconfig                                |   17 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/mxs-lradc.c                            |  267 +++
 include/linux/mfd/mxs-lradc.h                      |  187 +++
 12 files changed, 2054 insertions(+), 1765 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 delete mode 100644 drivers/iio/adc/mxs-lradc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
