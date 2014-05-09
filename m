Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10888 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbaEIQz6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 9 May 2014 12:55:58 -0400
Message-ID: <536D089C.9040307@linux.intel.com>
Date: Fri, 09 May 2014 09:55:56 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: hid-sensors: typo leads to potential forever loop
References: <20140509115617.GC32027@mwanda>
In-Reply-To: <20140509115617.GC32027@mwanda>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

OOPs. Good catch.

Thanks,
Srinivas

On 05/09/2014 04:56 AM, Dan Carpenter wrote:
> The "i < " was missing in this condition.
>
> Fixes: 5d02edfc3957 ('iio: hid-sensors: Convert units and exponent')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 3729646..3052eb1 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -327,7 +327,7 @@ int hid_sensor_format_scale(u32 usage_id,
>   	*val0 = 1;
>   	*val1 = 0;
>   
> -	for (i = 0; ARRAY_SIZE(unit_conversion); ++i) {
> +	for (i = 0; i < ARRAY_SIZE(unit_conversion); ++i) {
>   		if (unit_conversion[i].usage_id == usage_id &&
>   			unit_conversion[i].unit == attr_info->units) {
>   			exp  = hid_sensor_convert_exponent(
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

