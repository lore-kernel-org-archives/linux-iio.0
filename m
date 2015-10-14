Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53002 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbbJNMyy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 14 Oct 2015 08:54:54 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Andrea Galbusera <gizero@gmail.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@rosetechnology.dk>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 0/2] iio: adc: mcp320x: Add compatible with vendor prefix and deprecate old ones
Date: Wed, 14 Oct 2015 14:54:37 +0200
Message-Id: <1444827279-23163-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

When the patch "iio: adc: mcp320x: Set struct spi_driver .of_match_table" [0]
was posted, there was a discussion on how to solve the fact that the driver's
compatible strings don't have a vendor prefix and are already documented in
the DT binding doc.

Rob Herring suggested [1] to add new compatible strings with a vendor prefix
and mark the old ones as deprecated. This patch series take care of that.

[0]: https://lkml.org/lkml/2015/8/20/95
[1]: https://lkml.org/lkml/2015/8/23/120

Best regards,
Javier


Javier Martinez Canillas (2):
  iio: adc: mcp320x: Deprecated compatible strings with no vendor prefix
  iio: adc: mcp320x: Add compatible with vendor prefix to OF table

 .../devicetree/bindings/iio/adc/mcp320x.txt        | 30 +++++++++++++++-------
 drivers/iio/adc/mcp320x.c                          | 28 ++++++++++++++++++++
 2 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.4.3

