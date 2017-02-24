Return-Path: <SRS0=QEF/=2F=linaro.org=benjamin.gaignard@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: fabrice.gasnier@st.com,
	linaro-kernel@lists.linaro.org,
	benjamin.gaignard@linaro.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/2] Add parent_trigger attribute to triggers
Date: Fri, 24 Feb 2017 15:48:13 +0100
Message-Id: <1487947695-9305-1-git-send-email-benjamin.gaignard@st.com>
List-ID: <linux-iio@vger.kernel.org>

version 3:
- try to provide better description of parent_trigger usages
- add one channel to get counter raw value

version 2:
- Do not automatically set parent_trigger attribute on all triggers.
  Let driver decide to use it.
- Improve documentation of parent_trigger
- Improve slave modes documentation

Thoses patches add parent_trigger attribute to IIO triggers.
Parent trigger edges or levels could be used to control current
trigger. For example current trigger could be started on parent
rising edges or be enabled only when parent trigger level is high.

Since there is many ways to use parent edges and levels to
control current trigger behavoir an additional custom sysfs
attribute may be needed to describe those control modes.

Similary to what already exist to validate a device, a new (optional) 
validate_trigger function is added in iio_trigger structure and should be
filled by drivers.

For STM32 triggers parent trigger edges or levels could used in various ways.
To be able to select them "in_count0_count_mode" attribute is added to STM32
triggers.

When setting a parent trigger on STM32 trigger "trigger_rising_edges" mode
is automatically set so current trigger is clock by the rising edges of it
parent.

Benjamin Gaignard (2):
  iio: Allow triggers to be used as parent of others triggers
  iio: stm32 trigger: Implement parent trigger feature

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  63 +++++
 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |  15 ++
 drivers/iio/industrialio-trigger.c                 |  69 ++++++
 drivers/iio/trigger/stm32-timer-trigger.c          | 256 ++++++++++++++++++++-
 include/linux/iio/trigger.h                        |   7 +-
 include/linux/mfd/stm32-timers.h                   |   2 +
 6 files changed, 405 insertions(+), 7 deletions(-)

-- 
1.9.1
