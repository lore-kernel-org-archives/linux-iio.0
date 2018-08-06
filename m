Return-Path: <SRS0=2+VP=KV=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <broonie@kernel.org>
CC: Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
	<mark.rutland@arm.com>, <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] iio: accel: Add adxl372 driver
Date: Mon, 6 Aug 2018 15:04:41 +0300
Message-ID: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Changes in v4:
Patch 1:
	- used a lookup table in adxl372_set_activity_threshold() instead
	  of a switch(case).
Patch 2: 
	- removed the interrupt-parent from the bindings.
Patch 3:
	- renamed regmap_pipe_read() stub to regmap_noinc_read().
Patch 4:
	- removed the adxl372_read_fifo() wrapper and directly called
	  regmap_noinc_read().
	- called iio_triggered_buffer_predisable() before doing the local
	  changes.
Patch 5:
	- nothing changed.
Patch 6:
	- nothing changed.

Changes in v3:
Patch 1, 2:
	- nothing changed
Patch 3:
	- changed the name from regmap_pipe_read() to regmap_noinc_read()
	- added a check for readable registers
Patch 4:
	- dropped the fifo peak mode
	- corrected the patch based on feedback from Peter Meerwald-Stadler.
Patch 5 and 6:
	- nothing changed

Changes in v2:
Patch 1:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().
Patch 2:
	- introduced all the DT bindings in a single patch.
Patch 3:
	- backported the patch based on this discussion: 
          https://lkml.org/lkml/2016/6/16/548.
	- this patch is required as the regmap_pipe_read() API will be used 
	  to read the data from the FIFO.
Patch 4:
	- removed DT bindings changes from this patch.
	- removed the linux/gpio/consumer.h header.
	- used regmap_pipe_read() instead of regmap_bulk_read() when
	  reading data from the FIFO.
	- used multiple regmap_write() calls instead of a single
	  regmap_bulk_write() if there is no fast path.
	- used be32_to_cpu() inside the adxl372_get_status() function.
	- added a new in_accel_x&y&z_peak scan element which allows the
	  user to set the FIFO into XYZ peak mode.
	- used a adxl372_axis_lookup_table() to determine the fifo format
	  from the active_scan_mask.
	- made IRQ optional.
Patch 5 and 6:
	- nothing changed

Crestez Dan Leonard (1):
  regmap: Add regmap_noinc_read API

Stefan Popa (5):
  iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
  dt-bindings: iio: accel: Add docs for ADXL372
  iio:adxl372: Add FIFO and interrupts support
  iio:adxl372: Add sampling frequency support
  iio:adxl372: Add filter bandwidth support

 .../devicetree/bindings/iio/accel/adxl372.txt      |  22 +
 MAINTAINERS                                        |   7 +
 drivers/base/regmap/regmap.c                       |  65 +-
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl372.c                        | 977 +++++++++++++++++++++
 include/linux/regmap.h                             |   9 +
 7 files changed, 1091 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 drivers/iio/accel/adxl372.c

-- 
2.7.4
