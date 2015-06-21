Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbFUN1O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:27:14 -0400
Message-ID: <5586BBB1.3080701@kernel.org>
Date: Sun, 21 Jun 2015 14:27:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 3/7] iio:light:cm3323: pass up error value
References: <cover.1434578207.git.knaack.h@gmx.de> <729e23b785dfa67011e8d2cfde7f5bac84d6f147.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <729e23b785dfa67011e8d2cfde7f5bac84d6f147.1434578207.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 23:32, Hartmut Knaack wrote:
> cm3323_get_it_bits() returns a valid error code, so pass it up in
> cm3323_read_raw().
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/light/cm3323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index a1d4905..feb4dbc 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -175,7 +175,7 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>  		i = cm3323_get_it_bits(data);
>  		if (i < 0) {
>  			mutex_unlock(&data->mutex);
> -			return -EINVAL;
> +			return i;
>  		}
>  
>  		*val = cm3323_int_time[i].val;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
