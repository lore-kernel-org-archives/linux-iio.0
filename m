Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36461 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbLBFrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 00:47:25 -0500
Received: by pacdm15 with SMTP id dm15so29697035pac.3
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2015 21:47:24 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] iio: chemical: vz89x: rework i2c transfer reading
Date: Tue,  1 Dec 2015 21:47:19 -0800
Message-Id: <1449035240-31044-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v2:
* change incorrect i2c_transfer function return check from message length
  to messages executed

Matt Ranostay (1):
  iio: chemical: vz89x: rework i2c transfer reading

 drivers/iio/chemical/vz89x.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

-- 
1.9.1

