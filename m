Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0095.outbound.protection.outlook.com ([104.47.0.95]:26866
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752470AbdHZIRH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Aug 2017 04:17:07 -0400
Subject: Re: [PATCH] iio: multiplexer: check memory allocation failure
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20170826054952.1449-1-christophe.jaillet@wanadoo.fr>
From: Peter Rosin <peda@axentia.se>
Message-ID: <1773a907-698f-d441-2fac-5a8f134aa3dd@axentia.se>
Date: Sat, 26 Aug 2017 10:16:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170826054952.1449-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-08-26 07:49, Christophe JAILLET wrote:
> Check memory allocation failures and return -ENOMEM in such cases, as
> already done few lines above for another memory allocation.
> 
> This avoids NULL pointers dereference.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Hi!

This is a dup of an older patch [1].

Cheers,
peda

[1] https://patchwork.kernel.org/patch/9829567/

> ---
>  drivers/iio/multiplexer/iio-mux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 37ba007f8dca..74831fcd0313 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -285,6 +285,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  	child->ext_info_cache = devm_kzalloc(dev,
>  					     sizeof(*child->ext_info_cache) *
>  					     num_ext_info, GFP_KERNEL);
> +	if (!child->ext_info_cache)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < num_ext_info; ++i) {
>  		child->ext_info_cache[i].size = -1;
>  
> @@ -309,6 +312,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  
>  		child->ext_info_cache[i].data = devm_kmemdup(dev, page, ret + 1,
>  							     GFP_KERNEL);
> +		if (!child->ext_info_cache[i].data)
> +			return -ENOMEM;
> +
>  		child->ext_info_cache[i].data[ret] = 0;
>  		child->ext_info_cache[i].size = ret;
>  	}
> 

