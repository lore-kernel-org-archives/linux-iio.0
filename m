Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52645 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbcL3Sjb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:39:31 -0500
Subject: Re: [PATCH] drivers: staging: iio: cdc: fix return value
To: Thomas Preisner <thomas.preisner+linux@fau.de>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <1482519067-5354-1-git-send-email-thomas.preisner+linux@fau.de>
Cc: linux-kernel@i4.cs.fau.de, milan.stephan+linux@fau.de,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d2299697-eeb9-850c-72cf-72a46ec5601a@kernel.org>
Date: Fri, 30 Dec 2016 18:39:27 +0000
MIME-Version: 1.0
In-Reply-To: <1482519067-5354-1-git-send-email-thomas.preisner+linux@fau.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/12/16 18:51, Thomas Preisner wrote:
> At the end of function ad7150_write_event_config(), "return 0" seems
> improper. It may be better to return the value of ret.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188871
> 
> Reported-by: Pan Bian <bianpan2016@163.com>
> Signed-off-by: Thomas Preisner <thomas.preisner+linux@fau.de>
> Signed-off-by: Milan Stephan <milan.stephan+linux@fau.de>
I already see a patch for this from Pan.

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 6998c3d..04861eb 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -274,7 +274,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  error_ret:
>  	mutex_unlock(&chip->state_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int ad7150_read_event_value(struct iio_dev *indio_dev,
> 

