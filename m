Return-Path: <SRS0=XJNk=EM=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH] IIO: ADC: stm32-dfsdm: remove unused variable
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180117144644.2302131-1-arnd@arndb.de>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <8dd30c35-011c-1d0f-7331-76df8fcd0c23@st.com>
Date: Wed, 17 Jan 2018 16:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180117144644.2302131-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Arnd,

On 01/17/2018 03:46 PM, Arnd Bergmann wrote:
> A cleanup left one variable behind that is no longer needed and
> can be removed, as shown by the gcc warning:
> 
> drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
> drivers/iio/adc/stm32-dfsdm-core.c:245:29: error: unused variable 'of_id' [-Werror=unused-variable]
> 
> Fixes: abaca806fd13 ("IIO: ADC: stm32-dfsdm: code optimization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 84277bcc465f..6290332cfd3f 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>  static int stm32_dfsdm_probe(struct platform_device *pdev)
>  {
>  	struct dfsdm_priv *priv;
> -	const struct of_device_id *of_id;
>  	const struct stm32_dfsdm_dev_data *dev_data;
>  	struct stm32_dfsdm *dfsdm;
>  	int ret;
> 
Could you crosscheck? This is included in the patch:
https://www.spinics.net/lists/arm-kernel/msg628841.html applied in
Mark's branches ( commit abaca806fd13afd069e04e883de8ec75924b0598)

Regards
Arnaud
