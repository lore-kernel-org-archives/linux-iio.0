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
Subject: [PATCH v2 0/2] iio: adc: max1363: Add device tree support
Date: Sun, 26 Jun 2016 22:04:02 +0200
Message-Id: <1466971444-5333-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This series introduces the necessary device tree binding to
perform DT boot.

Tested with MAX11644 (DT boot).

Best regards,
Florian

---
Since v1:
- First patch applied by Jonathan
- Added DT maintainer's Ack
- Fixed handling of data pointer in struct of_device_id

Florian Vaussard (2):
  iio: adc: max1363: Add device tree binding documentation
  iio: adc: max1363: Add device tree binding

 .../devicetree/bindings/iio/adc/max1363.txt        |  63 ++++++++
 drivers/iio/adc/max1363.c                          | 169 ++++++++++++++++++++-
 2 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt

-- 
2.5.5
