Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49904 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbbITKgp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:36:45 -0400
Subject: Re: [PATCH 1/2] iio: adc: twl6030-gpadc: Fix module autoload for OF
 platform driver
To: Luis de Bethencourt <luis@debethencourt.com>,
	linux-kernel@vger.kernel.org
References: <20150917170200.GA27396@goodgumbo.baconseed.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Axel Lin <axel.lin@ingics.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE8C3B.605@kernel.org>
Date: Sun, 20 Sep 2015 11:36:43 +0100
MIME-Version: 1.0
In-Reply-To: <20150917170200.GA27396@goodgumbo.baconseed.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/09/15 18:02, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Applied to the togreg branch of iio.git as I am treating these
as additions of functionality rather than explicit fixes.
I am guessing previous users didn't care about autoprobing
(and a lot of embedded systems don't use it).  Hence it
can wait for the next merge window.

Thanks for clearing these up,

Jonathan
> ---
>  drivers/iio/adc/twl6030-gpadc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index df12c57..becbb0a 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -875,6 +875,7 @@ static const struct of_device_id of_twl6030_match_tbl[] = {
>  	},
>  	{ /* end */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_twl6030_match_tbl);
>  
>  static int twl6030_gpadc_probe(struct platform_device *pdev)
>  {
> 

