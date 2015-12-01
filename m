Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35559 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbLACQt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2015 21:16:49 -0500
Received: by pacej9 with SMTP id ej9so204296916pac.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2015 18:16:49 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: proximity: lidar: optimize i2c transactions
Date: Mon, 30 Nov 2015 18:16:48 -0800
Message-Id: <1448936209-31656-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
* allow smbus method as fallback if i2c mode isn't possible

Matt Ranostay (1):
  iio: proximity: lidar: optimize i2c transactions

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 95 +++++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

-- 
1.9.1

