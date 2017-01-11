Return-Path: <SRS0=etR0=YZ=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ti,ads7950 device tree bindings
Date: Wed, 11 Jan 2017 11:52:48 -0600
Message-Id: <1484157171-15571-1-git-send-email-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This series adds device tree bindings for the TI ADS7950 family of A/DC chips.
The series includes the bindings documentation and some fixes to the iio driver
to make it work with the device tree bindings.

FYI, the ads7950 driver has not made it into mainline yet, so no worries about
breaking anyone with these changes.

David Lechner (3):
  DT/bindings: Add bindings for TI ADS7950 A/DC chips
  iio: adc: ti-ads7950: Drop "ti-" prefix from module name
  iio: adc: ti-ads7950: Change regulator matching string to "vref"

 .../devicetree/bindings/iio/adc/ti-ads7950.txt     | 23 ++++++++++++++++
 drivers/iio/adc/ti-ads7950.c                       | 32 +++++++++++-----------
 2 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt

-- 
2.7.4
