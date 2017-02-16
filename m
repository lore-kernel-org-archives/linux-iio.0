Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35857 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbdBPOXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 09:23:15 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so67654783wmi.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2017 06:23:14 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/2] iio: Add parent_trigger attribute to triggers
Date: Thu, 16 Feb 2017 15:23:01 +0100
Message-Id: <1487254984-20122-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

version 2:
- Do not automatically set parent_trigger attribute on all triggers.
  Let driver decide to use it.
- Improve documentation of parent_trigger
- Improve slave modes documentation

Thoses patches add parent_trigger attribute to IIO triggers.
Parent trigger edges or levels could be used to control current
trigger for example to start, stop or reset it.

Similary to what already exist to validate a device, a new (optional) 
validate_trigger function is added in iio_trigger structure and should be
filled by drivers.

For STM32 triggers parent trigger edges or levels could used in various ways.
To be able to select them "slave_mode" attribute is added to STM32 triggers.
For example the combinaison of parent_trigger and slave_mode allows to start
a trigger only when parent trigger level is high or to reset it on parent
trigger rising edge.

Benjamin Gaignard (2):
  iio: Allow triggers to be used as parent of others triggers
  iio: stm32 trigger: Implement parent trigger feature

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  43 +++++++++
 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |  10 ++
 drivers/iio/industrialio-trigger.c                 |  68 +++++++++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 105 +++++++++++++++++++++
 include/linux/iio/trigger.h                        |   7 +-
 5 files changed, 232 insertions(+), 1 deletion(-)

-- 
1.9.1

