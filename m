Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47789 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965171AbcIVRjT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 13:39:19 -0400
Subject: Re: [PATCH] iio: accel: sca3000_core: avoid potentially uninitialized
 variable
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20160922094432.2230485-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        Ico Doornekamp <ico@pruts.nl>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55b3334b-cc97-f8df-0636-531991b0fdd0@kernel.org>
Date: Thu, 22 Sep 2016 18:39:16 +0100
MIME-Version: 1.0
In-Reply-To: <20160922094432.2230485-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/09/16 10:43, Arnd Bergmann wrote:
> The newly added __sca3000_get_base_freq function handles all valid
> modes of the SCA3000_REG_ADDR_MODE register, but gcc notices
> that any other value (i.e. 0x00) causes the base_freq variable to
> not get initialized:
> 
> drivers/staging/iio/accel/sca3000_core.c: In function 'sca3000_write_raw':
> drivers/staging/iio/accel/sca3000_core.c:527:23: error: 'base_freq' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This adds explicit error handling for unexpected register values,
> to ensure this cannot happen.
> 
> Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied to the togreg branch of iio.git. Initially pushed out as testing for the
autobuilders to play with it.

'Bug' has been there a long time.  The patch just move the code so I'm not
going to rush this one in. Worth hardening this corner though!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index d626125d7af9..564b36d4f648 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -468,6 +468,8 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
>  	case SCA3000_MEAS_MODE_OP_2:
>  		*base_freq = info->option_mode_2_freq;
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  error_ret:
>  	return ret;
> 

