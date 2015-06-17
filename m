Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:51353 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbbFQHOo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Jun 2015 03:14:44 -0400
Message-ID: <55811E5E.8050209@gmx.de>
Date: Wed, 17 Jun 2015 09:14:38 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 1/7] iio:light:cm3323: clear bitmask before set
References: <cover.1434492557.git.knaack.h@gmx.de> <5c3a23e64da5989f97bb6948c4290642d1e642b7.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <5c3a23e64da5989f97bb6948c4290642d1e642b7.1434492557.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hartmut Knaack schrieb am 17.06.2015 um 00:17:
> When setting the bits for integration time, the appropriate bitmask needs
> to be cleared first.
> 

And it needs to be done right. I will fix it in V2.

> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/light/cm3323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 869033e..1e6092a 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -123,7 +123,7 @@ static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
>  	for (i = 0; i < ARRAY_SIZE(cm3323_int_time); i++) {
>  		if (val == cm3323_int_time[i].val &&
>  		    val2 == cm3323_int_time[i].val2) {
> -			reg_conf = data->reg_conf;
> +			reg_conf = data->reg_conf & CM3323_CONF_IT_MASK;
>  			reg_conf |= i << CM3323_CONF_IT_SHIFT;
>  
>  			ret = i2c_smbus_write_word_data(data->client,
> 

