Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34761 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdCEQeN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 11:34:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id u132so2185187wmg.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 08:34:12 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 0/2] staging: iio: accel: Group similar macros into enums
Date: Sun,  5 Mar 2017 18:26:03 +0200
Message-Id: <cover.1488730643.git.narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Group related macros into enums, for clarity.

Narcisa Ana Maria Vasile (2):
  staging: iio: adis16209: Group similar macros into enums
  staging: iio: adis16240: Group similar macros into enums

 drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
 drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
 2 files changed, 18 insertions(+), 14 deletions(-)

-- 
1.9.1

