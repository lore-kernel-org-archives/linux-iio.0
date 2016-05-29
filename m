Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34214 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbcE2TKA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:10:00 -0400
Subject: Re: [PATCH] iio: proximity: as3935: remove redundant MODULE_ALIAS
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1464071250-21097-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e3995ee2-5e49-9c32-a3cc-e889e5669eae@kernel.org>
Date: Sun, 29 May 2016 20:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <1464071250-21097-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 07:27, Matt Ranostay wrote:
> MODULE_ALIAS isn't needed since the module name is the same as the alias
> defined.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git

Thanks

Jonathan
> ---
>  drivers/iio/proximity/as3935.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 8730451..5769017 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -468,4 +468,3 @@ module_spi_driver(as3935_driver);
>  MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
>  MODULE_DESCRIPTION("AS3935 lightning sensor");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("spi:as3935");
> 

