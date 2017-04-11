Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36318 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdDKKFc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2017 06:05:32 -0400
Received: by mail-wm0-f45.google.com with SMTP id o81so59049677wmb.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2017 03:05:31 -0700 (PDT)
Date: Tue, 11 Apr 2017 11:05:28 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        icenowy@aosc.xyz, liam@networkimprov.net,
        thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [GIT PULL] Immutable branch between MFD and IIO due for the v4.12
 merge window
Message-ID: <20170411100528.2zif3fyi7uoyw33n@dell>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.12

for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59:

  iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017-04-11 11:02:33 +0100)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v4.12 merge window

----------------------------------------------------------------
Quentin Schulz (1):
      iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 drivers/iio/adc/axp20x_adc.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
