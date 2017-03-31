Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32792 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbdCaQqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 12:46:50 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: health: Clean up
Date: Fri, 31 Mar 2017 22:16:41 +0530
Message-Id: <1490978804-25549-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch-series removes commented code in afe440x.h and 
removes unused functions in afe4404.c and afe4403.c.

simran singhal (3):
  iio: health: afe440x: Remove code in comments
  iio: health: afe4404: Remove all unused functions
  iio: health: afe4403: Remove all unused functions

 drivers/iio/health/afe4403.c | 51 --------------------------------------
 drivers/iio/health/afe4404.c | 51 --------------------------------------
 drivers/iio/health/afe440x.h | 58 --------------------------------------------
 3 files changed, 160 deletions(-)

-- 
2.7.4

