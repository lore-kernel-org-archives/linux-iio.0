Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbaG1LTU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:19:20 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH 0/5] staging: iio: minor fixes for sparse warnings
Date: Mon, 28 Jul 2014 14:18:28 +0300
Message-Id: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix sparse warnings mostly regarding casting or incorrect argument type for iio drivers in staging.

Teodora Baluta (5):
  staging: iio: ad7816: fix sparse warning cast to restricted __be16
  staging: iio: ad5933: fix sparse warning cast to restricted __be16
  staging: iio: hmc5843_core: fix sparse warnings
  staging: iio: isl29018: fix sparse warning regarding incorrect type   
     (different signedness)
  staging: iio: adis16240: fix sparse warnings regarding incorrect    
    argument type

 drivers/staging/iio/adc/ad7816.c                | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 drivers/staging/iio/light/isl29018.c            | 2 +-
 drivers/staging/iio/magnetometer/hmc5843_core.c | 6 +++---
 drivers/staging/iio/resolver/ad2s1210.c         | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.1

