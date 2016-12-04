Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34168 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbcLDK6Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2016 05:58:25 -0500
Subject: Re: [PATCH 1/1] staging: iio: cdc: fix improper return value
To: Pan Bian <bianpan201602@163.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1480772670-6898-1-git-send-email-bianpan201602@163.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4c6e37ee-43bf-78a8-9aa9-7103715fd9e3@kernel.org>
Date: Sun, 4 Dec 2016 10:58:21 +0000
MIME-Version: 1.0
In-Reply-To: <1480772670-6898-1-git-send-email-bianpan201602@163.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/16 13:44, Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> At the end of function ad7150_write_event_config(), directly returns 0.
> As a result, the errors will be ignored by the callers. It may be better 
> to return variable "ret".
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 5578a07..50a5b0c2 100644
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

