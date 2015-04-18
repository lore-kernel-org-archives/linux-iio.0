Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33587 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbbDRTg2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:36:28 -0400
Message-ID: <5532B23A.7000005@kernel.org>
Date: Sat, 18 Apr 2015 20:36:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:tmp006: Prefix #defines with TMP006_
References: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net> <1429130378-19941-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1429130378-19941-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/15 21:39, Peter Meerwald wrote:
> just cleanup, no functional change
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied.
> ---
>  drivers/iio/temperature/tmp006.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 84a0789..fcc49f8 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -41,8 +41,8 @@
>  #define TMP006_CONFIG_CR_MASK 0x0e00
>  #define TMP006_CONFIG_CR_SHIFT 9
>  
> -#define MANUFACTURER_MAGIC 0x5449
> -#define DEVICE_MAGIC 0x0067
> +#define TMP006_MANUFACTURER_MAGIC 0x5449
> +#define TMP006_DEVICE_MAGIC 0x0067
>  
>  struct tmp006_data {
>  	struct i2c_client *client;
> @@ -191,7 +191,7 @@ static bool tmp006_check_identification(struct i2c_client *client)
>  	if (did < 0)
>  		return false;
>  
> -	return mid == MANUFACTURER_MAGIC && did == DEVICE_MAGIC;
> +	return mid == TMP006_MANUFACTURER_MAGIC && did == TMP006_DEVICE_MAGIC;
>  }
>  
>  static int tmp006_probe(struct i2c_client *client,
> 

