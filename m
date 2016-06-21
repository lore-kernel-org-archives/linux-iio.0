Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH 0/3] iio: adc: max1363: Fix missing parts and add device tree
Date: Tue, 21 Jun 2016 09:09:26 +0200
Message-Id: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This series first fix missing i2c_device_id for several MAX1164x parts.
It then introduces the necessary device tree binding to perform DT boot.

Tested with MAX11644 (DT boot).

Best regards,
Florian

Florian Vaussard (3):
  iio: adc: max1363: Fix missing i2c_device_id for MAX1164x parts
  iio: adc: max1363: Add device tree binding documentation
  iio: adc: max1363: Add device tree binding

 .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
 drivers/iio/adc/max1363.c                          | 62 ++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt

-- 
2.5.0
