Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35872 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbKPBUG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 20:20:06 -0500
Received: by pacdm15 with SMTP id dm15so156857701pac.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2015 17:20:06 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sun, 15 Nov 2015 17:20:04 -0800
Message-Id: <1447636805-1451-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v4:
* error out of lidar_probe() if pm_runtime_set_active() fails

Matt Ranostay (1):
  iio: pulsedlight-lidar-lite: add runtime PM

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 56 ++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

-- 
1.9.1

