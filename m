Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbHHLyf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:54:35 -0400
Subject: Re: [PATCH 5/9] iio: adis16400: Add ADIS16305 support
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-6-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EDFA.9060404@kernel.org>
Date: Sat, 8 Aug 2015 12:54:34 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> The ADIS16305 is fully register map compatible to the ADIS16300.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.  Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis16400_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 7d612ab..e4cc2ec 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -927,6 +927,7 @@ static int adis16400_remove(struct spi_device *spi)
>  
>  static const struct spi_device_id adis16400_id[] = {
>  	{"adis16300", ADIS16300},
> +	{"adis16305", ADIS16300},
>  	{"adis16334", ADIS16334},
>  	{"adis16350", ADIS16350},
>  	{"adis16354", ADIS16350},
> 

