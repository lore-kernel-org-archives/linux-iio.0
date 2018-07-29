Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeG2NGI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 09:06:08 -0400
Date: Sun, 29 Jul 2018 12:35:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>
Subject: Re: [PATCH v3 3/4] iio: vcnl4000: warn on incorrectly specified
 device id
Message-ID: <20180729123555.1b3a02bc@archlinux>
In-Reply-To: <20180725151821.17566-4-tomas.novotny@tbs-biometrics.com>
References: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
        <20180725151821.17566-4-tomas.novotny@tbs-biometrics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Jul 2018 17:18:20 +0200
Tomas Novotny <tomas.novotny@tbs-biometrics.com> wrote:

> From: Tomas Novotny <tomas@novotny.cz>
> 
> We can detect incorrectly specified device id for some chips, so warn
> user in that case.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Applied, thanks.

Jonathan
> ---
> Changes v2..v3:
> - update warn message, vcnl4020 is now valid device id
> 
>  drivers/iio/light/vcnl4000.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 980eb3b77d5f..a0cd1dcbf935 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -84,8 +84,20 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  		return ret;
>  
>  	prod_id = ret >> 4;
> -	if (prod_id != VCNL4010_PROD_ID && prod_id != VCNL4000_PROD_ID)
> +	switch (prod_id) {
> +	case VCNL4000_PROD_ID:
> +		if (data->id != VCNL4000)
> +			dev_warn(&data->client->dev,
> +					"wrong device id, use vcnl4000");
> +		break;
> +	case VCNL4010_PROD_ID:
> +		if (data->id != VCNL4010)
> +			dev_warn(&data->client->dev,
> +					"wrong device id, use vcnl4010/4020");
> +		break;
> +	default:
>  		return -ENODEV;
> +	}
>  
>  	data->rev = ret & 0xf;
>  	data->al_scale = 250000;

