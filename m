Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52510 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbbEHSaQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:16 -0400
Message-ID: <554CBC0E.1040102@kernel.org>
Date: Fri, 08 May 2015 09:37:18 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	phani.movva@imgtec.com
Subject: Re: [PATCH 3/5] iio: adc: cc10001: Fix regulator_get_voltage() return
 value check
References: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com> <1431033741-1088-4-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431033741-1088-4-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/15 17:22, Ezequiel Garcia wrote:
> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
> 
> regulator_get_voltage() returns a non-negative value in case of success,
> and a negative error in case of error. Let's fix this.
> 
> Fixes: 1664f6a5b0c8 ("iio: adc: Cosmic Circuits 10001 ADC driver")
> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Applied to the fixes-togreg branch of iio.git also marked for
stable (as are the previous 2).
> ---
>  drivers/iio/adc/cc10001_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
> index cf6c6fb..5302bbb 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -232,7 +232,7 @@ static int cc10001_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = regulator_get_voltage(adc_dev->reg);
> -		if (ret)
> +		if (ret < 0)
>  			return ret;
>  
>  		*val = ret / 1000;
> 

