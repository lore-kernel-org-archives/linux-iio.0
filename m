Return-Path: <vladimir.barinov@cogentembedded.com>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: hi-843x: Add Holt HI-8435/8436/8437 descrete ADC
Date: Mon,  1 Jun 2015 15:17:53 +0300
Message-Id: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This adds the folowing:
- Holt descrete ADC driver for HI-8435/8436/8437 chips
- Add vendor prefix
- Document DT bindings

Vladimir Barinov (3):
[1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete ADC
[2/3] dt: Add vendor prefix 'holt'
[3/3] dt: Document Holt descrete ADC bindings

---
This patchset is against the 'kernel/git/torvalds/linux.git' repo.

 Documentation/devicetree/bindings/iio/adc/hi-843x.txt |   27 
 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 
 drivers/iio/adc/Kconfig                               |   12 
 drivers/iio/adc/Makefile                              |    1 
 drivers/iio/adc/hi-843x.c                             |  777 ++++++++++++++++++
 5 files changed, 818 insertions(+)
