Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46118 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbKOLMW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 06:12:22 -0500
Subject: Re: [PATCH] iio: adc: mxs-lradc: Prefer using the BIT macro
To: Nizam Haider <nizamhaider786@gmail.com>, gregkh@linuxfoundation.org
References: <1447079162-12531-1-git-send-email-nizamhaider786@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	stefan.wahren@i2se.com, kristina.martsenko@gmail.com,
	ciorneiioana@gmail.com, hamohammed.sa@gmail.com,
	alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56486894.20105@kernel.org>
Date: Sun, 15 Nov 2015 11:12:20 +0000
MIME-Version: 1.0
In-Reply-To: <1447079162-12531-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/15 14:26, Nizam Haider wrote:
> Replaces bit shifting on 1 with the BIT(x) macro
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
Applied to the togreg branch of iio.git - guess I'm going to start
getting the autobuilder warnings shortly!

Will be pushed out as testing for the autobuilders to play with it.

Jonathan
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index d997d9c..5f1375c 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -324,7 +324,7 @@ struct mxs_lradc {
>  #define	LRADC_DELAY_TRIGGER(x) \
>  				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
>  				LRADC_DELAY_TRIGGER_LRADCS_MASK)
> -#define	LRADC_DELAY_KICK			(1 << 20)
> +#define	LRADC_DELAY_KICK			BIT(20)
>  #define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
>  #define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
>  #define	LRADC_DELAY_TRIGGER_DELAYS(x) \
> 

