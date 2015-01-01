Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMQQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:16:16 -0500
Message-ID: <54A53A8F.7010106@kernel.org>
Date: Thu, 01 Jan 2015 12:16:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 1/2] iio: amplifiers: ad8366: Remove space before ','
References: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com> <1419965144-3988-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965144-3988-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:45, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl error:
> ERROR: space prohibited before that ',' (ctx:WxW)
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied
> ---
>  drivers/iio/amplifiers/ad8366.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index ba6f6a9..fce25a0 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -166,7 +166,7 @@ static int ad8366_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ad8366_write(indio_dev, 0 , 0);
> +	ad8366_write(indio_dev, 0, 0);
>  
>  	return 0;
>  
> 

