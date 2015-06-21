Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43852 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbbFUNZU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:25:20 -0400
Message-ID: <5586BB3E.3090504@kernel.org>
Date: Sun, 21 Jun 2015 14:25:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 1/7] iio:light:cm3323: clear bitmask before set
References: <cover.1434578207.git.knaack.h@gmx.de> <e7cc60084a46aa75e4b35ac0695c5cf8f1d3984d.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <e7cc60084a46aa75e4b35ac0695c5cf8f1d3984d.1434578207.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 23:31, Hartmut Knaack wrote:
> When setting the bits for integration time, the appropriate bitmask needs
> to be cleared first.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/light/cm3323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 869033e..a1d4905 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -123,7 +123,7 @@ static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
>  	for (i = 0; i < ARRAY_SIZE(cm3323_int_time); i++) {
>  		if (val == cm3323_int_time[i].val &&
>  		    val2 == cm3323_int_time[i].val2) {
> -			reg_conf = data->reg_conf;
> +			reg_conf = data->reg_conf & ~CM3323_CONF_IT_MASK;
>  			reg_conf |= i << CM3323_CONF_IT_SHIFT;
>  
>  			ret = i2c_smbus_write_word_data(data->client,
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
