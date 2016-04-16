Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48184 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbcDPMn3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:43:29 -0400
Subject: Re: [PATCH 1/5] iio:adis: Add support for manual self-test flag clear
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1460732382-6840-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5712336F.4000107@kernel.org>
Date: Sat, 16 Apr 2016 13:43:27 +0100
MIME-Version: 1.0
In-Reply-To: <1460732382-6840-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 15:59, Lars-Peter Clausen wrote:
> Some variants of the devices from the ADIS family don't auto-clear the
> self-test bit after the self-test has completed. Instead we have to
> manually clear. Add support for this to the ADIS library.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I think we can get away without applying this to stable since the drivers
> have been broken since forever and so this is more of a new feature rather
> than a regression fix.
OK, though then I'm going to route them the slow way rather than as fixes
so applied to the togreg branch of iio.git.

We can always backport if anyone cares.

Jonathan
> ---
>  drivers/iio/imu/adis.c       | 7 ++++++-
>  include/linux/iio/imu/adis.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 911255d..ad6f91d 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -324,7 +324,12 @@ static int adis_self_test(struct adis *adis)
>  
>  	msleep(adis->data->startup_delay);
>  
> -	return adis_check_status(adis);
> +	ret = adis_check_status(adis);
> +
> +	if (adis->data->self_test_no_autoclear)
> +		adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
> +
> +	return ret;
>  }
>  
>  /**
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index fa2d01e..360da7d 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -41,6 +41,7 @@ struct adis_data {
>  	unsigned int diag_stat_reg;
>  
>  	unsigned int self_test_mask;
> +	bool self_test_no_autoclear;
>  	unsigned int startup_delay;
>  
>  	const char * const *status_error_msgs;
> 

