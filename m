Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11935 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaLQVIY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Dec 2014 16:08:24 -0500
Date: Wed, 17 Dec 2014 13:07:33 -0800
From: Todd E Brandt <todd.e.brandt@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, jacob.jun.pan@linux.intel.com
Subject: [PATCH 0/2] axp20x fuel gauge support
Message-ID: <20141217210732.GA10978@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add fuel gauge support to the axp20x driver

axp20x.c (1/2): change the battery cell name to fuel_gauge
axp20x.h (2/2): add the register defs and platform struct for fuel gauge

 drivers/mfd/axp20x.c       | 10 +++++-----
 include/linux/mfd/axp20x.h | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 7 deletions(-)

