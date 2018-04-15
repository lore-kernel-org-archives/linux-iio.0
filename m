Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeDOPHl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:07:41 -0400
Date: Sun, 15 Apr 2018 16:07:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] staging: iio: ad7746: Fix multiple line
 dereference
Message-ID: <20180415160736.2195142b@archlinux>
In-Reply-To: <1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:41 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Clear checkpatch.pl WARNING about multiple line derefence but creates a
> new one of line over 80 characters. In my opinion, it improves
> readability.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
I wouldn't say I personally have strong views either way on this, but
your version is fine so I'll apply it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index d793785..82fac76 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -410,8 +410,7 @@ static struct attribute *ad7746_attributes[] = {
>  	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
>  	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
>  	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
> -	&iio_const_attr_in_capacitance_sampling_frequency_available.
> -	dev_attr.attr,
> +	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  

