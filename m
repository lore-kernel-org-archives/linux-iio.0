Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33060 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbaDIX3H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 19:29:07 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so3213225iec.32
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 16:29:06 -0700 (PDT)
From: Michael Welling <mwelling@ieee.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 0/3] tsl2583 checkpatch fixes
Date: Wed,  9 Apr 2014 18:28:46 -0500
Message-Id: <1397086129-12112-1-git-send-email-mwelling@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removes all checkpatch warnings.

Michael Welling (3):
  Removes unwanted space before semicolon
  Remove quoted string split across lines warnings
  Switch from msleep to usleep range per timers-howto.txt

 drivers/staging/iio/light/tsl2583.c |   38 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

-- 
1.7.9.5

