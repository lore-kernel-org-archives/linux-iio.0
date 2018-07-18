Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:11350
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbeGRLyI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Jul 2018 07:54:08 -0400
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 0/4] iio: adc: xilinx: XADC driver enhancements and bug fixes
Date: Wed, 18 Jul 2018 16:42:07 +0530
Message-ID: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series resolves code style problems as reported by code analysis
tools.

Manish Narani (4):
  iio: adc: xilinx: Rename 'channels' variable name to
    'iio_xadc_channels'
  iio: adc: xilinx: Remove dead code from xadc_zynq_setup
  iio: adc: xilinx: Check for return values in clk related functions
  iio: adc: xilinx: Use devm_ functions while requesting irq

 drivers/iio/adc/xilinx-xadc-core.c | 60 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.1.1

