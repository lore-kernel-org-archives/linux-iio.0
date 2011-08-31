Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49208 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab1HaLYr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:24:47 -0400
Message-ID: <4E5E1BED.60608@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:33:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 07/12] iio: ad7291: introduce IIO_EVENT_CODE_EXTRACT_CHAN_TYPE
 and use accordingly
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-7-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-7-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Fix channel type handling
Gah.  Yet another stupid error.  Good spot.  Certainly implies my naming
of those macros may leave something to be desired if even I assume they
mean something different from what they actually do...
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged.  
> ---
>  drivers/staging/iio/adc/ad7291.c |    6 +++---
>  drivers/staging/iio/sysfs.h      |    1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 7dfdc27..b365a74 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -313,7 +313,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
>  	u16 uval;
>  	s16 signval;
>  
> -	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
>  	case IIO_VOLTAGE:
>  		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
>  			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
> @@ -349,7 +349,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
>  	u8 reg;
>  	s16 signval;
>  
> -	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
>  	case IIO_VOLTAGE:
>  		if (val > 0xFFF || val < 0)
>  			return -EINVAL;
> @@ -377,7 +377,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
>  	/* To be enabled the channel must simply be on. If any are enabled
>  	   we are in continuous sampling mode */
>  
> -	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
> +	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
>  	case IIO_VOLTAGE:
>  		if (chip->c_mask &
>  		    (1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))
> diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
> index aad1f4b..d98d12d 100644
> --- a/drivers/staging/iio/sysfs.h
> +++ b/drivers/staging/iio/sysfs.h
> @@ -147,6 +147,7 @@ enum iio_event_direction {
>  
>  #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
>  #define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
> +#define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
>  
>  /* Event code number extraction depends on which type of event we have.
>   * Perhaps review this function in the future*/

