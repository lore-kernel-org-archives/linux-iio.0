Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUjV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:39:21 -0500
Subject: Re: [RFC PATCH 4/9] iio: imu: inv_mpu6050: Remove unnecessary
 parentheses
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-5-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com,
	mwelling@ieee.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA2077.50103@kernel.org>
Date: Sun, 21 Feb 2016 20:39:19 +0000
MIME-Version: 1.0
In-Reply-To: <1455810794-3188-5-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/16 15:53, Daniel Baluta wrote:
> Fixes the following checkpatch warning:
> CHECK: Unnecessary parentheses around cpm->package.elements[i]
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied (though I find it hard to care about this one!)

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 231a7af..2771106 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -66,11 +66,11 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  		union acpi_object *elem;
>  		int j;
>  
> -		elem = &(cpm->package.elements[i]);
> +		elem = &cpm->package.elements[i];
>  		for (j = 0; j < elem->package.count; ++j) {
>  			union acpi_object *sub_elem;
>  
> -			sub_elem = &(elem->package.elements[j]);
> +			sub_elem = &elem->package.elements[j];
>  			if (sub_elem->type == ACPI_TYPE_STRING)
>  				strlcpy(info->type, sub_elem->string.pointer,
>  					sizeof(info->type));
> 

