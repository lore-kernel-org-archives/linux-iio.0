Return-Path: <SRS0=ZCFX=EM=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH] IIO: ADC: stm32-dfsdm: remove unused variable
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Hartmut Knaack
 <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>
References: <20180117144644.2302131-1-arnd@arndb.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c431c85-4749-b56e-2803-d0d27c9ba980@arm.com>
Date: Wed, 17 Jan 2018 15:27:27 +0000
MIME-Version: 1.0
In-Reply-To: <20180117144644.2302131-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 17/01/18 14:46, Arnd Bergmann wrote:
> A cleanup left one variable behind that is no longer needed and
> can be removed, as shown by the gcc warning:
> 
> drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
> drivers/iio/adc/stm32-dfsdm-core.c:245:29: error: unused variable 'of_id' [-Werror=unused-variable]
> 
> Fixes: abaca806fd13 ("IIO: ADC: stm32-dfsdm: code optimization")

Weird, "git show abaca806fd13" contains this exact hunk. I guess it's 
actually the subsequent merge commit at fault...

Robin.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/iio/adc/stm32-dfsdm-core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 84277bcc465f..6290332cfd3f 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>   static int stm32_dfsdm_probe(struct platform_device *pdev)
>   {
>   	struct dfsdm_priv *priv;
> -	const struct of_device_id *of_id;
>   	const struct stm32_dfsdm_dev_data *dev_data;
>   	struct stm32_dfsdm *dfsdm;
>   	int ret;
> 
