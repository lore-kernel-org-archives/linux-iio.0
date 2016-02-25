Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57491 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646AbcBYTzP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 14:55:15 -0500
Subject: Re: [PATCH 3/5] iio: imu: mpu6050: add missing docstring for
 int_pin_cfg
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
 <1456177151-15881-4-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CF5C21.3010804@kernel.org>
Date: Thu, 25 Feb 2016 19:55:13 +0000
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-4-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 21:39, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Applied.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 243324dd78de..a6c45ce459ee 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -39,6 +39,7 @@
>   *  @int_enable:	Interrupt enable register.
>   *  @pwr_mgmt_1:	Controls chip's power state and clock source.
>   *  @pwr_mgmt_2:	Controls power state of individual sensors.
> + *  @int_pin_cfg;	Controls interrupt pin configuration.
>   */
>  struct inv_mpu6050_reg_map {
>  	u8 sample_rate_div;
> 

