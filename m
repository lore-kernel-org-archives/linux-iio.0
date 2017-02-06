Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36576 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdBFOWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2017 09:22:02 -0500
Received: by mail-wm0-f54.google.com with SMTP id c85so122458812wmi.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2017 06:22:01 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 0/2] iio: Add parent_trigger attribute to triggers
Date: Mon,  6 Feb 2017 15:21:50 +0100
Message-Id: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thoses patches add parent_trigger attribute to IIO triggers.
The goal is to allow triggers to use triggers like is this done for iio
devices.
With this patch it will be possible to chain triggers, for example
stm32 triggers could be used as clock of an other triggers:
echo "tim1_trgo" > trigger0/parent_trigger.

Similary to what already exist to validate a device, a new (optional) 
validate_trigger function is added in iio_trigger structure and should be
filled by drivers.

Benjamin Gaignard (2):
  iio: Allow triggers to be used as parent of others triggers
  iio: stm32 trigger: Implement validate_trigger function

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  26 ++++++
 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |   8 ++
 drivers/iio/industrialio-trigger.c                 |  68 ++++++++++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 104 +++++++++++++++++++++
 include/linux/iio/trigger.h                        |   6 +-
 5 files changed, 211 insertions(+), 1 deletion(-)

-- 
1.9.1

