Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34899 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545AbbIYRXk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2015 13:23:40 -0400
Received: by pacfv12 with SMTP id fv12so113188626pac.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 10:23:40 -0700 (PDT)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 0/2] Staging: iio: cdc: Use BIT macro and remove dev_info
Date: Fri, 25 Sep 2015 22:53:00 +0530
Message-Id: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches use the BIT macro and remove dev_info

Shraddha Barke (2):
  Staging: iio: cdc: Prefer using the BIT macro
  Staging: iio: cdc: Remove unnecessary dev_info

 drivers/staging/iio/cdc/ad7746.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.1.4

