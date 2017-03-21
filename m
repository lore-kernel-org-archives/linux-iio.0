Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36390 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757389AbdCUSEC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 14:04:02 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3 0/2] Replace mlock with private lock and delete whitespaces
Date: Tue, 21 Mar 2017 23:33:54 +0530
Message-Id: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch series replaces mlock with a private lock for driver ad9834 and
Fix coding style issues related to white spaces.

v3:
  -Using new private "lock" instead of using "buf_lock"
   as it can cause deadlock.
  -Sending it as a series of two patches.

v2:
  -Using the existing buf_lock instead of lock.
   

simran singhal (2):
  staging: iio: ade7753: Remove trailing whitespaces
  staging: iio: ade7753: Replace mlock with driver private lock

 drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.7.4

