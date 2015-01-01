Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55741 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbAAMPA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:15:00 -0500
Message-ID: <54A53A42.3070107@kernel.org>
Date: Thu, 01 Jan 2015 12:14:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 2/2] iio: light: lm3533-als: Remove space before ','
References: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com> <1419965330-4102-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965330-4102-3-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:48, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl error:
> ERROR: space prohibited before that ',' (ctx:WxE)
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied.
> ---
>  drivers/iio/light/lm3533-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index ae3c71b..076bc46 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -657,7 +657,7 @@ static ALS_HYSTERESIS_ATTR_RO(3);
>  #define ILLUMINANCE_ATTR_RO(_name) \
>  	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO, show_##_name, NULL)
>  #define ILLUMINANCE_ATTR_RW(_name) \
> -	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO | S_IWUSR , \
> +	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO | S_IWUSR, \
>  						show_##_name, store_##_name)
>  /*
>   * ALS Zone threshold-event enable
> 

