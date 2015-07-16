Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53205 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840AbbGPJSw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:18:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx08-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id t6G9ITsH020690
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:18:51 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx08-00178001.pphosted.com with ESMTP id 1vnt5wushd-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:18:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A67C31
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:18:49 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1700E53F9
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:18:49 +0000 (GMT)
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH 0/5] Added ST LSM303AGR sensor
Date: Thu, 16 Jul 2015 11:17:39 +0200
Message-ID: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set add support for STMicroelectronics LSM303AGR device,
which embeds an accelerometer and a magnetometer sensors.
These patches have been rebased on iio repo testing branch and tested on Panda
board.

Giuseppe Barba (5):
  iio: st-sensors: add configuration for WhoAmI address
  iio: st-sensors: add full scale counter field
  iio: st_magn: Add irq trigger handling
  iio: st-accel: add support for lsm303agr accelerometer
  iio: st-magn: add support for lsm303agr magnetometer

 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |   9 ++
 drivers/iio/accel/st_accel_i2c.c                   |   5 ++
 drivers/iio/accel/st_accel_spi.c                   |   1 +
 drivers/iio/common/st_sensors/st_sensors_core.c    |  54 ++++++-----
 drivers/iio/gyro/st_gyro_core.c                    |   6 ++
 drivers/iio/magnetometer/st_magn.h                 |   3 +
 drivers/iio/magnetometer/st_magn_buffer.c          |   7 ++
 drivers/iio/magnetometer/st_magn_core.c            | 100 ++++++++++++++++++++-
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 ++
 drivers/iio/magnetometer/st_magn_spi.c             |   1 +
 include/linux/iio/common/st_sensors.h              |   3 +
 13 files changed, 173 insertions(+), 24 deletions(-)

--
1.9.1

