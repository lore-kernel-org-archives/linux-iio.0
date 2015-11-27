Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: Add mcp3421 support
Date: Fri, 27 Nov 2015 14:52:50 +0100
Message-Id: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

This adds support for the mcp3421 adc as part of the mcp342x driver.
Not much needs to be done, only add the compatible entry and add the
array with the correct number of channels.

----------------------------------------------------------------
Sascha Hauer (2):
      iio: adc: mcp3422: Add mcp3421 support
      dt-bindings: iio: adc: Update mcp342x binding for the mcp3421

 Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 3 ++-
 drivers/iio/adc/mcp3422.c                             | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
