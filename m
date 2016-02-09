Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44908 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbcBIWOU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 17:14:20 -0500
Subject: Re: [PATCH 2/5] iio: hmc5843: Swap suspend and resume implementations
To: Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com, arnd@arndb.de,
	geert@linux-m68k.org, irina.tirdea@intel.com,
	daniel.baluta@intel.com, octavia.purdila@intel.com
References: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
 <1454883711-15489-3-git-send-email-cristina.moraru09@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA64B9.2090903@kernel.org>
Date: Tue, 9 Feb 2016 22:14:17 +0000
MIME-Version: 1.0
In-Reply-To: <1454883711-15489-3-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/16 22:21, Cristina Moraru wrote:
> Swap implementations of hmc5843_common_suspend and
> hmc5843_common_resume functions for they have been
> inversed. Device should go on SLEEP mode on suspend
> and on CONTINUOUS mode on resume.
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
I'd normally apply this as a fix, but to keep things simple with
the move out of staging I've just applied it to the togreg branch
of iio.git - initially pushed out as testing for the autobuilders
to play with it.

It's been there a long time an no one has noticed, so I'm guessing
any hardware platforms with this on aren't going in for power management!

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index 4e2a7ec..dca8d64 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -612,14 +612,14 @@ static const unsigned long hmc5843_scan_masks[] = {0x7, 0};
>  int hmc5843_common_suspend(struct device *dev)
>  {
>  	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
> -			HMC5843_MODE_CONVERSION_CONTINUOUS);
> +				HMC5843_MODE_SLEEP);
>  }
>  EXPORT_SYMBOL(hmc5843_common_suspend);
>  
>  int hmc5843_common_resume(struct device *dev)
>  {
>  	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
> -				HMC5843_MODE_SLEEP);
> +		HMC5843_MODE_CONVERSION_CONTINUOUS);
>  }
>  EXPORT_SYMBOL(hmc5843_common_resume);
>  
> 

