Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:62227 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbaLRXXF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Dec 2014 18:23:05 -0500
Message-ID: <549361D1.8030101@gmx.de>
Date: Fri, 19 Dec 2014 00:22:57 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>, jic23@kernel.org,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/3] iio: frequency: Remove 'out of memory' message
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com> <1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Roberta Dobrescu schrieb am 16.12.2014 um 10:11:
> This patch fixes the following checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
Hi Roberta,
I think this is slightly more complex. This function is used in adf4350_probe():

	if (spi->dev.of_node) {
		pdata = adf4350_parse_dt(&spi->dev);
		if (pdata == NULL)
			return -EINVAL;

Since pdata will only be NULL in the case, where you dropped the error message,
I think the EINVAL here should be changed to ENOMEM as well.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> ---
>  drivers/iio/frequency/adf4350.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 63a25d9..2b301eb 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -387,10 +387,8 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  	int ret;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		dev_err(dev, "could not allocate memory for platform data\n");
> +	if (!pdata)
>  		return NULL;
> -	}
>  
>  	strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
>  
> 

