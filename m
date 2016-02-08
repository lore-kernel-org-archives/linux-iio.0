Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35918 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbcBHGtO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 01:49:14 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: lars@metafoo.de, gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] Staging:iio:adc:Prefer using BIT macro
Date: Mon,  8 Feb 2016 12:18:55 +0530
Message-Id: <cover.1454913458.git.bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset replaces bit shifting on 1 with the BIT(x) macro.
This was done with coccinelle:
@@ int g; @@ 
-(1 << g) 
+BIT(g)

Bhumika Goyal (2):
  Staging:iio:Prefer using BIT macro
  Staging: iio: adc: Prefer using the BIT macro

 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 drivers/staging/iio/adc/ad7816.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

