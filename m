Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:16704 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbJPMxt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2015 08:53:49 -0400
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/3] Add Palmas iio gpadc
Date: Fri, 16 Oct 2015 14:53:37 +0200
Message-Id: <cover.1445000017.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

H. Nikolaus Schaller (2):
  iio:adc: add iio driver for Palmas (twl6035/7) gpadc
  ARM: dts: omap5-uevm: enable iio gpadc for Palmas

Marek Belisko (1):
  iio:adc:palmas: add DT support

 .../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  48 ++
 arch/arm/boot/dts/omap5-uevm.dts                   |  10 +
 drivers/iio/adc/Kconfig                            |   8 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/palmas_gpadc.c                     | 859 +++++++++++++++++++++
 include/linux/mfd/palmas.h                         |  75 +-
 6 files changed, 977 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
 create mode 100644 drivers/iio/adc/palmas_gpadc.c

-- 
2.5.1

