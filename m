Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25576 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbcDKOYo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 10:24:44 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v3 0/2] iio: Add support for adc101 and adc121c to ti-adc081c
Date: Mon, 11 Apr 2016 17:24:25 +0300
Message-Id: <cover.1460384543.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Version 3 fixes review comments:
* Avoid using VLAs in trigger_handler.
* Add an array of model types and make driver_data an index in the table.

Crestez Dan Leonard (2):
  ti-adc081c: Add support for adc101c and adc121c
  ti-adc081c: Initial triggered buffer support

 drivers/iio/adc/Kconfig      |   6 +--
 drivers/iio/adc/ti-adc081c.c | 118 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 15 deletions(-)

-- 
2.5.5

