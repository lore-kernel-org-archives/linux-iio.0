Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34459 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbbKHCud (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Nov 2015 21:50:33 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	k.kozlowski@samsung.com, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sat,  7 Nov 2015 18:50:23 -0800
Message-Id: <1446951024-7621-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
* add mutex lock in measurement reading function
* add missing pm_runtime_mark_last_busy() call
* use pm_runtime_get_sync() function instead of async version

Matt Ranostay (1):
  iio: pulsedlight-lidar-lite: add runtime PM

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 63 ++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

-- 
1.9.1

