Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35219 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbcKIPKI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Nov 2016 10:10:08 -0500
Received: by mail-lf0-f51.google.com with SMTP id b14so166475756lfg.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Nov 2016 07:10:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] ST Sensors: inline sensor data
Date: Wed,  9 Nov 2016 16:09:56 +0100
Message-Id: <1478704200-19046-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Based on a comment from Jonathan that he would not do this kludgy
define-then-use for all the sensor properties today, refactor all
the ST sensors by inlining the per-sensor data.

Linus Walleij (4):
  iio: accel: st_accel: inline per-sensor data
  iio: gyro: st_gyro: inline per-sensor data
  iio: magn: st_magn: inline per-sensor data
  iio: pressure: st_pressure: inline per-sensor data

 drivers/iio/accel/st_accel_core.c       | 538 +++++++++++---------------------
 drivers/iio/gyro/st_gyro_core.c         | 205 ++++--------
 drivers/iio/magnetometer/st_magn_core.c | 376 ++++++++--------------
 drivers/iio/pressure/st_pressure_core.c | 257 ++++++---------
 4 files changed, 460 insertions(+), 916 deletions(-)

-- 
2.7.4

