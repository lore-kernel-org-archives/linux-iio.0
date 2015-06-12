Return-Path: <vlad.dogaru@intel.com>
Date: Fri, 12 Jun 2015 10:40:47 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, tiberiu.a.breana@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: sx9500: Fix proximity value
Message-ID: <20150612074046.GB14044@vdogaru>
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
 <1434037774-22081-3-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434037774-22081-3-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 11, 2015 at 06:49:34PM +0300, Daniel Baluta wrote:
> Because of the ABI confusion proximity value exposed by SX9500
> was inverted.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>

Sorry for causing the confusion, it was the only proximity sensor I had
encountered to date.

> ---
>  drivers/iio/proximity/sx9500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 2042e37..01494cd 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -281,7 +281,7 @@ static int sx9500_read_prox_data(struct sx9500_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	*val = 32767 - (s16)be16_to_cpu(regval);
> +	*val = be16_to_cpu(regval);
>  
>  	return IIO_VAL_INT;
>  }
> -- 
> 1.9.1
> 
