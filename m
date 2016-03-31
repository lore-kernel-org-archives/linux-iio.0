Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35148 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757525AbcCaRbm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 31 Mar 2016 13:31:42 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 0/2] Add support for adc101c* and adc121c* 
Date: Thu, 31 Mar 2016 20:20:34 +0300
Message-Id: <cover.1459444547.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for adc101c* and adc121c* using the ti-adc081c driver.

I send just the first patch earlier but got no response. The first patch now no
longer sets .data in of_device_id because that was not actually used.

The second patch adds buffer support based on external trigger.

Crestez Dan Leonard (2):
  ti-adc081c: Add support for adc101c* and adc121c*
  ti-adc081c: Initial triggered buffer support

 drivers/iio/adc/Kconfig      |   6 +--
 drivers/iio/adc/ti-adc081c.c | 116 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 106 insertions(+), 16 deletions(-)

-- 
2.8.0.rc3

