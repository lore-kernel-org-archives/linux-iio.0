Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58532 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbaKRPtU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Nov 2014 10:49:20 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so4180593igb.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2014 07:49:19 -0800 (PST)
Date: Tue, 18 Nov 2014 15:49:12 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	IIO <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Carlo Caione <carlo@caione.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [GIT PULL] Immutable branch between MFD and IIO (second tag)
Message-ID: <20141118154912.GB13959@x1>
References: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1415734210-5657-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9:

  Linux 3.17 (2014-10-05 12:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-iio-v3.19-1

for you to fetch changes up to 8019f6962708985782b65bd97be88046a55e1e4d:

  iio/axp288_adc: remove THIS_MODULE owner (2014-11-18 15:34:22 +0000)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for v3.19.

This is the second tag, as more patches have been applied.

----------------------------------------------------------------
Aaron Lu (1):
      iio: adc: Add module device table for autoloading

Jacob Pan (4):
      mfd: axp20x: Extend axp20x to support axp288 pmic
      iio: adc: Add support for axp288 adc
      mfd/axp20x: avoid irq numbering collision
      iio/axp288_adc: remove THIS_MODULE owner

 drivers/iio/adc/Kconfig      |   8 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/axp288_adc.c | 261 +++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig          |   3 +-
 drivers/mfd/axp20x.c         | 361 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mfd/axp20x.h   |  59 +++++++
 6 files changed, 637 insertions(+), 56 deletions(-)
 create mode 100644 drivers/iio/adc/axp288_adc.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
