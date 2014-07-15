Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22449 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbaGOSkg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 15 Jul 2014 14:40:36 -0400
Message-ID: <53C576F6.2070604@linux.intel.com>
Date: Tue, 15 Jul 2014 11:46:14 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 2/3] iio:kxcjk-1013: Fix endianness in scan_type
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net> <1405370318-19699-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405370318-19699-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/2014 01:38 PM, Peter Meerwald wrote:
> driver uses i2c_smbus_read_word_data() to the data in the trigger handler and hence
> already does endianness conversion; the I2C chip has data in little endian, but the
> value is provides in CPU endianness
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a11588c..ea96170 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -466,7 +466,7 @@ static const struct attribute_group kxcjk1013_attrs_group = {
>   		.realbits = 12,						\
>   		.storagebits = 16,					\
>   		.shift = 4,						\
> -		.endianness = IIO_LE,					\
> +		.endianness = IIO_CPU,					\
>   	},								\
>   }
>
>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
