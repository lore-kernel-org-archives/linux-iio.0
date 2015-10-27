Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36508 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbJ0DSI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2015 23:18:08 -0400
Received: by pacfv9 with SMTP id fv9so216761079pac.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2015 20:18:07 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] iio: lidar: return -EINVAL on invalid signal
Date: Mon, 26 Oct 2015 20:18:22 -0700
Message-Id: <1445915903-23418-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v1:

* Changed EIO to EINVAL
* Don't display error message on invalid signal since will fill up the
  kernel log messages.

Matt Ranostay (1):
  iio: lidar: return -EINVAL on invalid signal

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

