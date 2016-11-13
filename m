Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40581 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933747AbcKMMa6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:30:58 -0500
Subject: Re: [PATCH v4 24/26] staging: iio: tsl2583: remove unnecessary
 variable initialization
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-25-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e111fedf-9336-5ff0-6bdc-df432bdcf716@kernel.org>
Date: Sun, 13 Nov 2016 12:30:56 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-25-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> The ret variable in tsl2583_suspend() and tsl2583_resume() was
> initialized to 0. This is not necessary so this patch removes the
> initialization.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 712f753..b787952 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -849,7 +849,7 @@ static int __maybe_unused tsl2583_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -865,7 +865,7 @@ static int __maybe_unused tsl2583_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> 

