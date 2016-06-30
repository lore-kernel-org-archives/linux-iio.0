Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36052 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcF3HnW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 03:43:22 -0400
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v3 0/2] iio: adc: max1363: Add device tree support
Date: Thu, 30 Jun 2016 09:43:04 +0200
Message-Id: <1467272586-28761-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This series introduces the necessary device tree binding to
perform DT boot.

Tested with MAX11644 (DT boot).

Best regards,
Florian

---
Since v2:
- Use a macro to declare compatibles, as suggested by Peter Rosin
  for a similar patch on the mcp4531

Since v1:
- First patch applied by Jonathan
- Added DT maintainer's Ack
- Fixed handling of data pointer in struct of_device_id

Florian Vaussard (2):
  iio: adc: max1363: Add device tree binding documentation
  iio: adc: max1363: Add device tree binding

 .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
 drivers/iio/adc/max1363.c                          | 61 ++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt

-- 
2.5.5

