Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:25715 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaKEV6k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 16:58:40 -0500
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Phani Movva <phani.movva@imgtec.com>
CC: <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>,
	<knaack.h@gmx.de>, <devicetree@vger.kernel.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2 0/3] iio: Add Cosmic Circuits ADC support
Date: Wed, 5 Nov 2014 18:56:48 -0300
Message-ID: <1415224611-22096-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks everyone for the good feedback. I've tried to address all your comments
on this round but if you spot anything worth of mention (or I forgot
something), please speak out.

Regarding the invalid sample handling, I tried to keep things simple. This
should happen only in the event of hardware failure, so the driver spits a
warning and errors out, as suggested by Jonathan.

The CC10001 ADC IP block will be present on the Pistachio SoC. Upstream
support for this SoC is on the way and will be submitted soon.

As I mentioned in the commit log for the binding, the ADC channels are shared
between the Pistachio SoC and another processor (RPU). To specify which
channels are available to Linux, the binding includes a property
"cosmic,adc-available-channels".

Each CPU gets its own view of the ADC register set, but both act on the
same hardware block. Concurrency is handled by the hardware and is completely
transparent to the OS. This means that if both CPUs make a request
simultaneously, the conversion time would be twice the expected time.
 
The series is based on v3.18-rc2.

Changes from v1:

  * Removed unneeded header includes.

  * Changed all the names and macros prefix: s/CC_10001_/CC10001_.

  * Used .update_scan_mode callback to preallocate the buffer.

  * Used indio_dev for the struct iio_dev.

  * Only read the regulator voltage when needed.

  * Fixed probe() error handling.

  * Used for_each_set_bit() instead of open-coding it.

  * Name the power-down register as _POWER_UP, to make the code
    less silly.

  * Error out when no valid sample can be read (i.e. when end-of-conversion
    poll times out).

  * ... plus some assorted code cleaning based on the feedback.

Ezequiel Garcia (1):
  DT: Add a vendor prefix for Cosmic Circuits

Phani Movva (2):
  iio: adc: Cosmic Circuits 10001 ADC driver
  DT: iio: adc: Add CC_10001 binding documentation

 .../devicetree/bindings/iio/adc/cc_10001_adc.txt   |  19 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/cc_10001_adc.c                     | 425 +++++++++++++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
 create mode 100644 drivers/iio/adc/cc_10001_adc.c

-- 
2.1.0

