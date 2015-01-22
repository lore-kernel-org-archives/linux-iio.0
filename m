Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56434 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbAVDnA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 22:43:00 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so20743442pdj.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2015 19:42:59 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH iio v2 0/3] cleanup for InvenSense MPU6050
Date: Thu, 22 Jan 2015 09:08:01 +0530
Message-Id: <1421897884-32663-1-git-send-email-varkab@cdac.in>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

changes since v1:
 - reorder patch-1 and patch-2

Varka Bhadram (3):
  imu: inv_mpu6050: use devm_iio_trigger_alloc
  imu: inv_mpu6050: use devm_request_irq
  imu: inv_mpu6050: cleanup on error check

 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   39 +++++++++++--------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
1.7.9.5

