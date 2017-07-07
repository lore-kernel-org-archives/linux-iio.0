Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:15364
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbdGGEH3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jul 2017 00:07:29 -0400
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() return
 value
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170706220851.GA26284@embeddedgus>
From: Peter Rosin <peda@axentia.se>
Message-ID: <01d4a23f-489a-6d1c-50ef-a77207719eae@axentia.se>
Date: Fri, 7 Jul 2017 06:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170706220851.GA26284@embeddedgus>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-07-07 00:08, Gustavo A. R. Silva wrote:
> Check return value from call to devm_kzalloc()
> in order to prevent a NULL pointer dereference.

Right, thanks for finding that one! There's another one inside the
for loop that is just starting in the context of this patch. Care
to fix checking the return value of that devm_kmemdup as well?

And someone should perhaps teach Coccinelle about devm_kmemdup...

> This issue was detected using Coccinelle and the following semantic patch:
> 
> @@
> expression x;
> identifier fld;
> @@
> 
> * x = devm_kzalloc(...);
>   ... when != x == NULL
>   x->fld
> 
> 

One of these blank lines should perhaps be a "Fixes:" tag?

Cheers,
peda

> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/iio/multiplexer/iio-mux.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 37ba007..a8d672b 100644
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
> 

