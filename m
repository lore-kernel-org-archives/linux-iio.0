Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37017 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHSSrr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Aug 2017 14:47:47 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/3] constify iio i2c_device_id
Date: Sun, 20 Aug 2017 00:17:35 +0530
Message-Id: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Arvind Yadav (3):
  [PATCH 1/3] iio: accel: bma180: constify i2c_device_id
  [PATCH 2/3] iio: light: apds9300: constify i2c_device_id
  [PATCH 3/3] iio: light: tsl2583: constify i2c_device_id

 drivers/iio/accel/bma180.c   | 2 +-
 drivers/iio/light/apds9300.c | 2 +-
 drivers/iio/light/tsl2583.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

