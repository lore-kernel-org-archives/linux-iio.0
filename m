Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34478 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbKHU1C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 15:27:02 -0500
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	k.kozlowski@samsung.com, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sun,  8 Nov 2015 12:26:57 -0800
Message-Id: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v3:
* readd pm_runtime_mark_last_busy() that got dropped accidently

Matt Ranostay (1):
  iio: pulsedlight-lidar-lite: add runtime PM

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

-- 
1.9.1

