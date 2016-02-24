Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51127 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcBXVIa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2016 16:08:30 -0500
Subject: Re: [PATCH 0/5] mpu6050: code clean and calibration support
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com, Ge Gao <ggao@invensense.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CE1BCB.40807@kernel.org>
Date: Wed, 24 Feb 2016 21:08:27 +0000
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 21:39, Matt Ranostay wrote:
> The patchset series cleans up several documentation, return
> code issues, incorrect timing delays, and adds accl/gyro offset
> support.
> 
> Matt Ranostay (5):
>   iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
>   iio: imu: mpu6050: fix INV_MPU6050_REG_UP_TIME delay
>   iio: imu: mpu6050: add missing docstring for int_pin_cfg
>   iio: imu: mpu6050: add calibration offset support
>   iio: imu: mpu6050: add mpu6500 register settings
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 88 +++++++++++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 ++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 +-
>  4 files changed, 105 insertions(+), 12 deletions(-)
> 
Whole series looks good to me (the typo fix can follow if you like :)

Ideally I'd like Ge to take a look as well (+ anyone else who fancies
doing so!) so will leave it on list for a few days more.

Jonathan




