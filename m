Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:17655 "EHLO
	DVREDG02.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485Ab3JHDue (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 23:50:34 -0400
From: Josh Wu <josh.wu@atmel.com>
To: <jic23@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<maxime.ripard@free-electrons.com>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v4 0/3] Add touch screen support in at91 adc
Date: Tue, 8 Oct 2013 11:48:53 +0800
Message-ID: <1381204136-32322-1-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series introduce multiple compatible string for different ip.
So remove some adc dt parameters as it already included in driver code.

It also touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

v3 --> v4:
  Seperate these 3 patches since the others are already in mainline.

Josh Wu (3):
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: move the num_channels from DT to driver itself
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |    8 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
 drivers/iio/adc/at91_adc.c                         |  453 ++++++++++++++++++--
 3 files changed, 456 insertions(+), 39 deletions(-)

-- 
1.7.9.5

