Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35646 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbKHGKU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 01:10:20 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	k.kozlowski@samsung.com, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sat,  7 Nov 2015 22:10:14 -0800
Message-Id: <1446963015-17828-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* Remove un-needed mutex
* Move usleep_range to resume callback

Matt Ranostay (1):
  iio: pulsedlight-lidar-lite: add runtime PM

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

-- 
1.9.1

