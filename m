Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48288 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756237AbdESDk4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 May 2017 23:40:56 -0400
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/3] Few non-critical cpcap ADC fixes
Date: Thu, 18 May 2017 20:40:32 -0700
Message-Id: <20170519034035.16795-1-tony@atomide.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Here are few fixes for cpcap ADC mostly to get temperature readings
produce sane values. AFAIK no need for urgency with these and they
can all wait for v4.13 merge window.

Regards,

Tony

Tony Lindgren (3):
  iio: adc: cpcap: Fix default register values and battery temperature
  iio: adc: cpcap: Fix die temperature
  iio: adc: cpcap: Remove hung interrupt quirk

 drivers/iio/adc/cpcap-adc.c | 101 ++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 28 deletions(-)

-- 
2.13.0
