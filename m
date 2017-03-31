Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36002 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbdCaPJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 11:09:01 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: iio: Remove useless type conversion
Date: Fri, 31 Mar 2017 20:38:47 +0530
Message-Id: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch-series removes some type conversions like casting a pointer to a pointer of same type,
casting to the original type using addressof(&) operator etc.

simran singhal (3):
  staging: iio: accel: Remove useless type conversion
  staging: iio: frequency: Remove useless type conversion
  staging: iio: light: Remove useless type conversion

 drivers/staging/iio/accel/adis16201.c    | 2 +-
 drivers/staging/iio/accel/adis16203.c    | 2 +-
 drivers/staging/iio/accel/adis16209.c    | 2 +-
 drivers/staging/iio/accel/adis16240.c    | 6 +++---
 drivers/staging/iio/frequency/ad9832.c   | 2 +-
 drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4

