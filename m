Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34188 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdC0Jol (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 05:44:41 -0400
Received: by mail-wr0-f178.google.com with SMTP id l43so47589769wre.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2017 02:44:30 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, vilhelm.gray@gmail.com, mwelling@ieee.org
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/2] iio: stm32 trigger: Add quadrature device and counter 
Date: Mon, 27 Mar 2017 11:43:22 +0200
Message-Id: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A first encoder IIO driver (104-quad-8) with a count channel already exist.
STM32 driver have the same type of feature but with different counting modes.
Some parts, like counting direction (up/down) could be generalized so move the
corresponding documentation from driver file to sysfs-bus-iio.

version 3:
- fix typo in documentation
- change some functions names

version 2:
- since iio: Generalize counting direction modes commit of version has being
  pushed in iio.git testing branch I have remove it from this serie.
- split the original attribute in 2: one for quadrature modes and one for
  enable modes.
- add scale info
- change modes to more generic names to be able to merge them with 104-quad-8
  in the futur.

Benjamin Gaignard (2):
  iio: stm32 trigger: Add quadrature encoder device
  iio: stm32 trigger: Add counter enable modes

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  55 ++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 314 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |   2 +
 3 files changed, 365 insertions(+), 6 deletions(-)

-- 
1.9.1

