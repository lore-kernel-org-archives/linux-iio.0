Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34627 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbLBFFU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 00:05:20 -0500
Received: by padhx2 with SMTP id hx2so28708603pad.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2015 21:05:19 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: proximity: lidar: optimize i2c transactions
Date: Tue,  1 Dec 2015 21:05:21 -0800
Message-Id: <1449032722-25646-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* change incorrect i2c_transfer function return check from message length
  to messages executed

Matt Ranostay (1):
  iio: proximity: lidar: optimize i2c transactions

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 95 +++++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

-- 
1.9.1

