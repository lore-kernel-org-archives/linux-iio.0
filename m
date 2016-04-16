Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48120 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcDPMbv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:31:51 -0400
Subject: Re: [PATCH 03/10] iio: adc: vf610_adc: fix case label indent
To: Slawomir Stepien <sst@poczta.fm>, knaack.h@gmx.de,
	pmeerw@pmeerw.net
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-4-git-send-email-sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571230B5.1040207@kernel.org>
Date: Sat, 16 Apr 2016 13:31:49 +0100
MIME-Version: 1.0
In-Reply-To: <1460662602-2951-4-git-send-email-sst@poczta.fm>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 20:36, Slawomir Stepien wrote:
> This fixes the error reported by checkpatch.pl:
> 
> ERROR: switch and case should be at the same indent
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/vf610_adc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index b10f629..653bf13 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -714,19 +714,19 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
>  	int i;
>  
>  	switch (mask) {
> -		case IIO_CHAN_INFO_SAMP_FREQ:
> -			for (i = 0;
> -				i < ARRAY_SIZE(info->sample_freq_avail);
> -				i++)
> -				if (val == info->sample_freq_avail[i]) {
> -					info->adc_feature.sample_rate = i;
> -					vf610_adc_sample_set(info);
> -					return 0;
> -				}
> -			break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0;
> +			i < ARRAY_SIZE(info->sample_freq_avail);
> +			i++)
> +			if (val == info->sample_freq_avail[i]) {
> +				info->adc_feature.sample_rate = i;
> +				vf610_adc_sample_set(info);
> +				return 0;
> +			}
> +		break;
>  
> -		default:
> -			break;
> +	default:
> +		break;
>  	}
>  
>  	return -EINVAL;
> 

