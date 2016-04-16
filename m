Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48140 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcDPMel (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:34:41 -0400
Subject: Re: [PATCH 07/10] iio: common: ms_sensors: use tab for indention
To: Slawomir Stepien <sst@poczta.fm>, knaack.h@gmx.de,
	pmeerw@pmeerw.net
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-8-git-send-email-sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5712315F.7090600@kernel.org>
Date: Sat, 16 Apr 2016 13:34:39 +0100
MIME-Version: 1.0
In-Reply-To: <1460662602-2951-8-git-send-email-sst@poczta.fm>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 20:36, Slawomir Stepien wrote:
> This fixes the error reported by checkpatch.pl:
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Applied, 

Thanks,

Jonathan
> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 669dc7c..ecf7721 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -106,7 +106,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
>  				unsigned int delay, u32 *adc)
>  {
>  	int ret;
> -        __be32 buf = 0;
> +	__be32 buf = 0;
>  	struct i2c_client *client = (struct i2c_client *)cli;
>  
>  	/* Trigger conversion */
> 

