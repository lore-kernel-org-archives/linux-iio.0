Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48338 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab3K3LL0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:11:26 -0500
Message-ID: <5299C7DC.4000807@kernel.org>
Date: Sat, 30 Nov 2013 11:11:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 09/15] iio:vcnl4000: Mark transfer buffer as __be16
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
> 	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
> 	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
> 	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index ecb3341..2f2c9be 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -56,7 +56,7 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  				u8 rdy_mask, u8 data_reg, int *val)
>  {
>  	int tries = 20;
> -	u16 buf;
> +	__be16 buf;
>  	int ret;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> 
