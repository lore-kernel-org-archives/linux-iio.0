Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-102.synserver.de ([212.40.185.102]:1096 "EHLO
	smtp-out-102.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab3GEKlO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 06:41:14 -0400
Message-ID: <51D6A2DB.20407@metafoo.de>
Date: Fri, 05 Jul 2013 12:41:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	jic23@kernel.org, marex@denx.de, fabio.estevam@freescale.com
Subject: Re: [PATCH 4/4] iio: mxs-lradc: add write_raw function to modify
 scale
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-5-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-5-git-send-email-hector.palacios@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 10:30 AM, Hector Palacios wrote:
> Added write_raw function to manipulate the optional divider_by_two
> through the scaling attribute out of the available scales.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 55 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 7f98c99..acd05d6 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -188,6 +188,7 @@ struct mxs_lradc {
>  
>  	const int		*vref_mv;
>  	unsigned int		scale_avail[LRADC_MAX_TOTAL_CHANS][2][2];
> +	bool			is_divided[LRADC_MAX_TOTAL_CHANS];

unsigned int, you do math with it and initialize it to either 0 or 1.
Otherwise the patch looks good.

