Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeDOPFz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:05:55 -0400
Date: Sun, 15 Apr 2018 16:05:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Message-ID: <20180415160550.4705667e@archlinux>
In-Reply-To: <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:40 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Also remove unnecessary parenthesis
I am probably missing something.  I'm not sure what you mean
by fix bound checking?   There are superfluous brackets, but
I don't see any functional change to indicate there was anything
wrong with the original checks.

> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 516aa93..d793785 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  		ret = 0;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		if ((val < 0) | (val > 0xFFFF)) {
> +		if (val < 0 || val > 0xFFFF) {
>  			ret = -EINVAL;
>  			goto out;
>  		}
> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  		ret = 0;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		if ((val < 0) | (val > 43008000)) { /* 21pF */
> +		if (val < 0 || val > 43008000) { /* 21pF */
>  			ret = -EINVAL;
>  			goto out;
>  		}

