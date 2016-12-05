Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbcLEJN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 04:13:26 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/3] Add ChromeOS EC Activity Sensors driver
Date: Mon,  5 Dec 2016 10:13:15 +0100
Message-Id: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This patchset adds support for an activity sensors driver handling
activity/gesture recognition coming from the EC. Only significant motion
is currently supported. Moreover it is an incomplete driver: activity can
be set and ring buffer must be used to receive interruption.

This patchset depends on [1] to apply (which is merged into linux-next).

[1] https://lkml.org/lkml/2016/8/1/141

Regards,
 Thierry

Gwendal Grignou (3):
  mfd: cros_ec: update MOTIONSENSE definitions and commands
  iio: core: Add double tap as possible gesture
  iio: cros_ec_activity: add ChromeOS EC Activity Sensors

 drivers/iio/common/cros_ec_sensors/Kconfig         |  10 +
 drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
 .../iio/common/cros_ec_sensors/cros_ec_activity.c  | 300 +++++++++++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  24 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  |   1 +
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/mfd/cros_ec_commands.h               |  35 +++
 include/uapi/linux/iio/types.h                     |   1 +
 8 files changed, 373 insertions(+)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c

-- 
2.7.4

