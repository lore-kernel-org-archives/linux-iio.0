Return-Path: <SRS0=B/yk=4G=axis.com=marten.lindahl@kernel.org>
From: =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	devicetree@vger.kernel.org,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH v2 0/2] add driver for the ti-adc084s021 chip
Date: Sun, 30 Apr 2017 14:53:40 +0200
Message-Id: <1493556822-2601-1-git-send-email-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

From: Mårten Lindahl <martenli@axis.com>

This adds support for the Texas Instruments ADC084S021 ADC chip.

---
Changes in v2:
- Split dt-bindings and iio/adc into separate patches
- Updated dt-bindings after Robs comments
- Removed most #defines to inlines
- Corrected channel macro
- Removed configuration array with only one item
- Updated func adc084s021_adc_conversion to use be16_to_cpu
- Added IIO_CHAN_INFO_SCALE to func adc084s021_read_raw
- Use iio_device_claim_direct_mode in func adc084s021_read_raw
- Removed documentation for standard driver functions
- Changed retval to ret everywhere
- Removed dynamic alloc for data buffer in trigger handler
- Keeping mutex for all iterations in trigger handler
- Removed usage of events in this driver
- Removed info log in probe
- Use spi_message_init_with_transfers for spi message structs
- Use preenable and postdisable functions for regulator
- Inserted blank line before last return in all functions

Mårten Lindahl (2):
  dt-bindings: iio: adc: add driver for the ti-adc084s021 chip
  iio: adc: add driver for the ti-adc084s021 chip

 .../devicetree/bindings/iio/adc/ti-adc084s021.txt  |  19 ++
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-adc084s021.c                    | 294 +++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
 create mode 100644 drivers/iio/adc/ti-adc084s021.c

-- 
2.1.4
