Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44956 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1JSNDD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 09:03:03 -0400
Message-ID: <4E9ECA8C.80902@cam.ac.uk>
Date: Wed, 19 Oct 2011 14:03:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 4/4] staging:iio:dac:ad5791: Fix scale unit
References: <1319027030-9696-1-git-send-email-lars@metafoo.de> <1319027030-9696-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1319027030-9696-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/11 13:23, Lars-Peter Clausen wrote:
> Scale is currently reported in volts instead of millivolts. This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5791.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> index 9ba45f1..6fbca8d 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -239,7 +239,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
>  		*val = 0;
> -		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
> +		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
>  		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);

