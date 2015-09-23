Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:26028 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbbIWMy6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 08:54:58 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: [PATCH 0/3] Add Palmas iio gpadc
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
Date: Wed, 23 Sep 2015 14:48:44 +0200
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-iio@vger.kernel.org,
	notaz@openpandora.org
Message-Id: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
References: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Nikolaus Schaller <hns@goldelico.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk,
	jic23@jic23.retrosnub.co.uk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add iio driver for the TI Palmas (twl6035, 6037) including device tree bindings.
It enables the gpadc for the OMAP5 uevm.

This patch series is based on original code taken from Android Tegra kernels:
(https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc)

Tegra code was developed by:
Pradeep Goudagunta <pgoudagunta@nvidia.com>
Laxman Dewangan <ldewangan@nvidia.com>

Edited and extended for mainline by:
H. Nikolaus Schaller <hns@goldelico.com>
Marek Belisko <marek@goldelico.com>



H. Nikolaus Schaller (2):
 iio:adc: add iio driver for Palmas (twl6035/7) gpadc
 ARM: dts: omap5-uevm: enable iio gpadc for Palmas

Marek Belisko (1):
 iio:adc:palmas: add DT support

.../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  67 ++
arch/arm/boot/dts/omap5-uevm.dts                   |  22 +
drivers/iio/adc/Kconfig                            |   9 +
drivers/iio/adc/Makefile                           |   1 +
drivers/iio/adc/palmas_gpadc.c                     | 883 +++++++++++++++++++++
include/linux/mfd/palmas.h                         |  59 +-
6 files changed, 1037 insertions(+), 4 deletions(-)
create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
create mode 100644 drivers/iio/adc/palmas_gpadc.c

-- 
2.5.1

