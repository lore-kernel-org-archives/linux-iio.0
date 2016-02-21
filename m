Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60632 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcBUUvR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:51:17 -0500
Subject: Re: [PATCH v3 1/6] iio:pressure:ms5611: fix ms5607 temp compensation
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1455731233.git.gregor.boirie@parrot.com>
 <44529c257a18d7fb978476375e8dad2dc92bcb12.1455731233.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA233F.3080409@kernel.org>
Date: Sun, 21 Feb 2016 20:51:11 +0000
MIME-Version: 1.0
In-Reply-To: <44529c257a18d7fb978476375e8dad2dc92bcb12.1455731233.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/02/16 17:52, Gregor Boirie wrote:
> Computation of sens2 was wrong and is fixed by this patch, sens2 should be:
>     2 * (t - 2000)^2
> See page 8 of ms5607 datasheet here:
>     http://www.meas-spec.com/product/pressure/MS5607-02BA03.aspx
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Hmm. We are late enough in the cycle now that I'm going to take this through
the togreg branch rather than fixes-togreg.  Partly this is to make my life
easier wrt to noise vs the rest of this series.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the auto builders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index c7885f0c..84ab8d2 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -136,17 +136,17 @@ static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_inf
>  
>  	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
>  	if (t < 2000) {
> -		s64 off2, sens2, t2;
> +		s64 off2, sens2, t2, tmp;
>  
>  		t2 = (dt * dt) >> 31;
> -		off2 = (61 * (t - 2000) * (t - 2000)) >> 4;
> -		sens2 = off2 << 1;
> +		tmp = (t - 2000) * (t - 2000);
> +		off2 = (61 * tmp) >> 4;
> +		sens2 = tmp << 1;
>  
>  		if (t < -1500) {
> -			s64 tmp = (t + 1500) * (t + 1500);
> -
> +			tmp = (t + 1500) * (t + 1500);
>  			off2 += 15 * tmp;
> -			sens2 += (8 * tmp);
> +			sens2 += 8 * tmp;
>  		}
>  
>  		t -= t2;
> 

