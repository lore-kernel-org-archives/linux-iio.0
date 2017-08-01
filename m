Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:54314 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdHAIZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Aug 2017 04:25:24 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993302AbdHAIZWmMay6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Aug 2017 10:25:22 +0200
Date: Tue, 1 Aug 2017 10:25:21 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Matt Ranostay <matt.ranostay@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] iio: adc: ti-ads1015: fix channel crosstalk
Message-ID: <20170801082521.namcrs4wyufwqyuh@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

first patch of this serie fixes reading diffrent channel value than device
is currently processing, while second one is purely optional, making
drivers generate attributes from values it is actually working with.

Ladislav Michl (2):
  iio: adc: ti-ads1015: fix conversion time
  iio: adc: ti-ads1015: use dynamically generated attributes

 drivers/iio/adc/ti-ads1015.c | 107 ++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 46 deletions(-)
