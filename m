Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeGUSG6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 14:06:58 -0400
Date: Sat, 21 Jul 2018 18:07:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas@novotny.cz>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 3/4] iio: vcnl4000: warn on incorrectly specified
 device id
Message-ID: <20180721180737.68ea627d@archlinux>
In-Reply-To: <20180717164655.27142-4-tomas@novotny.cz>
References: <20180717164655.27142-1-tomas@novotny.cz>
        <20180717164655.27142-4-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Jul 2018 18:46:54 +0200
Tomas Novotny <tomas@novotny.cz> wrote:

> We can detect incorrectly specified device id for some chips, so warn
> user in that case.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Ah, now the previous patch makes more sense.   Fair enough though
always remember reviewers tend to read one patch at a time, so making
it clear this was coming in the description for that one would have
been good.

Jonathan
> ---
>  drivers/iio/light/vcnl4000.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 0688214fc152..642a366c1479 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -83,8 +83,20 @@ static int vcnl4000_init(struct vcnl4000_data *data)
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
> +					"wrong device id, use vcnl4010");
> +		break;
> +	default:
>  		return -ENODEV;
> +	}
>  
>  	data->rev = ret & 0xf;
>  	data->al_scale = 250000;

