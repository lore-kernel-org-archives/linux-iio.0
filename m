Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbcHQMOO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Aug 2016 08:14:14 -0400
From: Vignesh R <vigneshr@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
	"Andrew F . Davis" <afd@ti.com>, <linux-iio@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ti_am335x_adc: Fix bugs related to oneshot read
Date: Wed, 17 Aug 2016 17:42:59 +0530
Message-ID: <20160817121301.21785-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series fixes a couple of bugs related to simultaneous read of
multiple ADC channels in oneshot mode. Since, all channels share FIFO1,
it has to be protected using a mutex, implemented by patch 1. Patch 2
increases the timeout waiting for a ADC sample.

Vignesh R (2):
  iio: adc: ti_am335x_adc: Protect FIFO1 from concurrent access
  iio: adc: ti_am335x_adc: Increase timeout value waiting for ADC sample

 drivers/iio/adc/ti_am335x_adc.c      | 16 ++++++++++++----
 include/linux/mfd/ti_am335x_tscadc.h |  8 ++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.9.2

