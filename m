Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62871 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbaDJC1F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 22:27:05 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so3212017iec.23
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 19:27:04 -0700 (PDT)
From: Michael Welling <mwelling@ieee.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 0/3] Staging: iio: tsl2583 checkpatch fixes
Date: Wed,  9 Apr 2014 21:26:42 -0500
Message-Id: <1397096805-25168-1-git-send-email-mwelling@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Updated patch series with appropriate subject and sign off.
Replaces '[PATCH 0/3] tsl2583 checkpatch fixes' patch series.

Michael Welling (3):
  Removes unwanted space before semicolon
  Remove quoted string split across lines warnings
  Switch from msleep to usleep range per timers-howto.txt

 drivers/staging/iio/light/tsl2583.c |   38 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

-- 
1.7.9.5

