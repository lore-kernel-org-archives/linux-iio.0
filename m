Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52699 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcL3Sqn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:46:43 -0500
Subject: Re: [PATCHv4 4/8] Fix braces not present on all arms of if else
 statement
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-5-git-send-email-scott@matheina.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9e9dafdc-1687-9392-5087-a2b846804b7d@kernel.org>
Date: Fri, 30 Dec 2016 18:46:41 +0000
MIME-Version: 1.0
In-Reply-To: <1482696216-8013-5-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/12/16 19:56, Scott Matheina wrote:
> Adds braces to second arm of if else statement.
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
This patch is actually correct so applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 2b584a0..e78d302 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  			chip->dac_bits = 12;
>  		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
>  			chip->dac_bits = 10;
> -	} else
> +	} else {
>  		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> +	}
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
>  	if (ret)
> 

