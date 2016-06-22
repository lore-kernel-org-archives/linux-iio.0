Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34043 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcFVGLh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 02:11:37 -0400
Received: by mail-pa0-f49.google.com with SMTP id bz2so13691690pad.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2016 23:11:37 -0700 (PDT)
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v3 0/3] Add Broadcom iproc-static-adc controller driver
Date: Wed, 22 Jun 2016 11:41:50 +0530
Message-Id: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset contains initial driver for Broadcom's
iproc static adc controller. The patchset is based on v4.7-rc1
tag and its tested on Broadcom Cygnus SoC.

The patches can be fetched from iproc-adc-v3 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v2:
 - Addressed various comments given by Jonathan Cameron and
   Peter Meerwald-Stadler on driver source code related to linux
   coding style and clean-up of code. Lot of source code change
   happened especially due to redefining the #defines.
 - Added code to support IIO_CHAN_INFO_SCALE mask to return
   scale value in iproc_adc_read_raw().
 - Removed #address-cells, #size-cells properties in DT binding
   document and dts file as adc will not have any child nodes as
   noticed by Rob Herring.

Changes since v1:
 - Modified Kconfig file to add more informative information
   in Broadcom Adc driver configuration menu.
 - Added Broadcom Adc driver menu config in the alphabetical
   order in Kconfig
 - Addressed various comments given by Peter Meerwald-Stadler
   on driver source code, Including issues related to linux
   coding style and race conditions.

Raveendra Padasalagi (3):
  Documentation: DT: Add iproc-static-adc binding
  iio: Add driver for Broadcom iproc-static-adc
  ARM:dts-Add dt node for Broadcom iproc-static-adc

 .../bindings/iio/adc/brcm,iproc-static-adc.txt     |  38 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  11 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/bcm_iproc_adc.c                    | 648 +++++++++++++++++++++
 5 files changed, 710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
 create mode 100644 drivers/iio/adc/bcm_iproc_adc.c

-- 
1.9.1

