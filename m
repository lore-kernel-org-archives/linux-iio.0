Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35637 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938098AbdD0N32 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 09:29:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id w64so16887170wma.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Apr 2017 06:29:27 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, vilhelm.gray@gmail.com, mwelling@ieee.org
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/2]
Date: Thu, 27 Apr 2017 15:29:14 +0200
Message-Id: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Those patches aim to complete stm32 timer features support.
The last missing part is to be able to chain to timer blocks
which mean that one of timerX's trigger could be used as clock for timerY.

Since this operating is neither event or buffer triggered mode I would
like to introduce a hardware triggered mode in IIO core.

Benjamin Gaignard (2):
  iio: add hardware triggered operating mode
  iio: make stm32 trigger driver use INDIO_HARDWARE_TRIGGERED mode

 .../ABI/testing/sysfs-bus-iio-timer-stm32          | 15 ++++++
 drivers/iio/industrialio-core.c                    |  4 +-
 drivers/iio/trigger/stm32-timer-trigger.c          | 61 ++++++++++++++++++++++
 include/linux/iio/iio.h                            |  6 +++
 4 files changed, 84 insertions(+), 2 deletions(-)

-- 
1.9.1

