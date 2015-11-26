Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35266 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbKZRLO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Nov 2015 12:11:14 -0500
Received: by pacej9 with SMTP id ej9so90858317pac.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2015 09:11:14 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: chemical: vz89x: rework i2c transfer reading
Date: Thu, 26 Nov 2015 09:11:13 -0800
Message-Id: <1448557874-3812-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:
* allow smbus method as fallback if i2c mode isn't possible

Matt Ranostay (1):
  iio: chemical: vz89x: rework i2c transfer reading

 drivers/iio/chemical/vz89x.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

-- 
1.9.1

