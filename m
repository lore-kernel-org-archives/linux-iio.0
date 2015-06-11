Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30919 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbbFKPrd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Jun 2015 11:47:33 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net, vlad.dogaru@intel.com,
	tiberiu.a.breana@intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/2] Clarify proximity output value interpretation
Date: Thu, 11 Jun 2015 18:49:32 +0300
Message-Id: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Proximity sensors indicate high values for closer objects and vice-versa.
This patchset clarifies the ABI and fixes the SX9500 sensor.

We have 5 proximity sensors that got this right (gp2ap020a00f, jsa1212,
vcnl4000, cm36651, ltr501) and 2 that got it wrong (stk3310 and
sx9500).

For SX9500 the fix was trivial and it is included here, for stk3310 there
are more things to do and will try to fix in the near future.

Daniel Baluta (2):
  iio: ABI: Clarify proximity output value
  iio: proximity: sx9500: Fix proximity value

 Documentation/ABI/testing/sysfs-bus-iio | 6 ++----
 drivers/iio/proximity/sx9500.c          | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
1.9.1

