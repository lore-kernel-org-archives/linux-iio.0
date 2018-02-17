Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41113 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeBQQOM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Feb 2018 11:14:12 -0500
Received: by mail-pf0-f194.google.com with SMTP id 68so515595pfj.8
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2018 08:14:12 -0800 (PST)
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 0/3] adis16209 driver cleanup
Date: Sat, 17 Feb 2018 21:32:41 +0530
Message-Id: <cover.1518883035.git.shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.

Shreeya Patel (3):
  Staging: iio: adis16209: Use SPDX identifier
  Staging: iio: adis16209: Remove unnecessary comments and add suitable
    suffix
  Staging: iio: adis16209: Use sign_extend32 and adjust a switch
    statement

 drivers/staging/iio/accel/adis16209.c | 231 ++++++++++++----------------------
 1 file changed, 82 insertions(+), 149 deletions(-)

-- 
2.7.4

