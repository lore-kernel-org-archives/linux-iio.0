Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59776 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbGEN0T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:26:19 -0400
Message-ID: <5599307A.8020102@kernel.org>
Date: Sun, 05 Jul 2015 14:26:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: tmp006: Use GENMASK
References: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net> <1434923422-17609-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434923422-17609-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 22:50, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git.
Will cause some trivial fuzz when the fix before turns up.

J
> ---
>  drivers/iio/temperature/tmp006.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 7a80509..a107087 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -36,9 +36,9 @@
>  #define TMP006_CONFIG_DRDY_EN BIT(8)
>  #define TMP006_CONFIG_DRDY BIT(7)
>  
> -#define TMP006_CONFIG_MOD_MASK 0x7000
> +#define TMP006_CONFIG_MOD_MASK GENMASK(14, 12)
>  
> -#define TMP006_CONFIG_CR_MASK 0x0e00
> +#define TMP006_CONFIG_CR_MASK GENMASK(11, 9)
>  #define TMP006_CONFIG_CR_SHIFT 9
>  
>  #define MANUFACTURER_MAGIC 0x5449
> 

