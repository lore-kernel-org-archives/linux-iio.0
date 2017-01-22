Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34351 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAVKa4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 05:30:56 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 0/2] iio: imu: st_lsm6dsx: add capability to select interrupt pin
Date: Sun, 22 Jan 2017 11:30:50 +0100
Message-Id: <20170122103052.8769-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add possibility to select drdy pin
  Documentation: dt: iio: imu: st_lsm6dsx: add st,drdy-int-pin property

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 66 ++++++++++++++++++++--
 2 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.9.3

