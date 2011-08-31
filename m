Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46077 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1HaLVI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:21:08 -0400
Message-ID: <4E5E1B12.6080307@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:29:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 06/12] iio: ad7291: fix mask bit generation
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-6-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
oops, another clanger from me.  Good spot and thanks.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged
> ---
>  drivers/staging/iio/adc/ad7291.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 2fafca7..7dfdc27 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -417,7 +417,7 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
>  				~(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
>  		else if (state && (!(chip->c_mask &
>  				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
> -			chip->c_mask &=
> +			chip->c_mask |=
>  				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
>  		else
>  			break;

