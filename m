Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49968 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbJLRWM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 13:22:12 -0400
Subject: Re: [PATCH] iio:light:apds9960 Fix sparse endian warnings.
To: linux-iio@vger.kernel.org
References: <1443036962-30729-1-git-send-email-jic23@kernel.org>
Cc: mranostay@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561BEC41.3050406@kernel.org>
Date: Mon, 12 Oct 2015 18:22:09 +0100
MIME-Version: 1.0
In-Reply-To: <1443036962-30729-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 20:36, Jonathan Cameron wrote:
> This patch is a tidy up of warnings from the autobuilder.
> 
>>> drivers/iio/light/apds9960.c:495:32: sparse: cast to restricted __le16
>    drivers/iio/light/apds9960.c:635:24: sparse: cast to restricted __le16
>>> drivers/iio/light/apds9960.c:672:21: sparse: incorrect type in assignment (different base types)
>    drivers/iio/light/apds9960.c:672:21:    expected unsigned short [unsigned] [usertype] buf
>    drivers/iio/light/apds9960.c:672:21:    got restricted __le16 [usertype] <noident>
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: mranostay@gmail.com
Ah well, been on the list for a while and is kind of obvious.

Applied.
> ---
>  drivers/iio/light/apds9960.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index bf80ce47926b..7d269ef9e062 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -472,7 +472,7 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct apds9960_data *data = iio_priv(indio_dev);
> -	u16 buf;
> +	__le16 buf;
>  	int ret = -EINVAL;
>  
>  	if (data->gesture_mode_running)
> @@ -613,7 +613,7 @@ static int apds9960_read_event(struct iio_dev *indio_dev,
>  			       int *val, int *val2)
>  {
>  	u8 reg;
> -	u16 buf;
> +	__le16 buf;
>  	int ret = 0;
>  	struct apds9960_data *data = iio_priv(indio_dev);
>  
> @@ -649,7 +649,7 @@ static int apds9960_write_event(struct iio_dev *indio_dev,
>  				int val, int val2)
>  {
>  	u8 reg;
> -	u16 buf;
> +	__le16 buf;
>  	int ret = 0;
>  	struct apds9960_data *data = iio_priv(indio_dev);
>  
> 

