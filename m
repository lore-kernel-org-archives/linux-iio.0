Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45443 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbcBOShq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 13:37:46 -0500
Date: Mon, 15 Feb 2016 19:37:44 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Gregor Boirie <gregor.boirie@parrot.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: =?ISO-8859-15?Q?Re=3A_=5BPATCH_v1_1=2F5=5D_iio=3Apressure=3Ams5611=3A=A0fix_ms5607_temp_compensation?=
In-Reply-To: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
Message-ID: <alpine.DEB.2.02.1602151923540.7180@pmeerw.net>
References: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> See page 8 of ms5607 datasheet here:
> http://www.meas-spec.com/product/pressure/MS5607-ms.aspx

link doesn't seem to work anymore, maybe now it's
http://www.meas-spec.com/product/pressure/MS5607-02BA03.aspx

computation of sens2 was wrong and is fixed by this patch, 
sens2 should be 2 * (t - 2000)^2

Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> ---
>  drivers/iio/pressure/ms5611_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index c7885f0c..a2ff89e6 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -136,15 +136,15 @@ static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_inf
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
>  			sens2 += (8 * tmp);

parenthesis could be removed here

>  		}
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
