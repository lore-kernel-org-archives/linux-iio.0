Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36996 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdCAOpg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 09:45:36 -0500
Received: by mail-wm0-f48.google.com with SMTP id n11so1033602wma.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Mar 2017 06:45:16 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 0/2] iio: stm32 trigger: Add counter device
Date: Wed,  1 Mar 2017 15:45:04 +0100
Message-Id: <1488379506-23969-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A first encoder IIO driver (104-quad-8) with a count channel already exist.
STM32 driver have the same type of feature but with different counting modes.
Some parts, like counting direction (up/down) could be generalized so move the
corresponding documentation from driver file to sysfs-bus-iio.


Benjamin Gaignard (2):
  iio: Generalize counting direction modes
  iio: stm32 trigger: Add counter device

 Documentation/ABI/testing/sysfs-bus-iio            |  14 ++
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |   8 -
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  40 ++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 231 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |   2 +
 5 files changed, 281 insertions(+), 14 deletions(-)

-- 
1.9.1

