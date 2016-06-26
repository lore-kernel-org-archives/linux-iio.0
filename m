Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47933 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbcFZRCL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 13:02:11 -0400
Subject: Re: [PATCH 1/3] iio: adc: max1363: Fix missing i2c_device_id for
 MAX1164x parts
To: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492969-2185-2-git-send-email-florian.vaussard@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3110ff64-5cd7-a3fa-738f-7f16d007489a@kernel.org>
Date: Sun, 26 Jun 2016 18:02:09 +0100
MIME-Version: 1.0
In-Reply-To: <1466492969-2185-2-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/16 08:09, Florian Vaussard wrote:
> The driver supports MAX11644, MAX11645, MAX11646 and MAX11647 parts. But
> the corresponding i2c_device_id are missing. Add them!
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Applied.  oops.

Thanks ;)

Jonathan
> ---
>  drivers/iio/adc/max1363.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 929508e..b5d28c0 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1680,6 +1680,10 @@ static const struct i2c_device_id max1363_id[] = {
>  	{ "max11615", max11615 },
>  	{ "max11616", max11616 },
>  	{ "max11617", max11617 },
> +	{ "max11644", max11644 },
> +	{ "max11645", max11645 },
> +	{ "max11646", max11646 },
> +	{ "max11647", max11647 },
>  	{}
>  };
>  
> 

