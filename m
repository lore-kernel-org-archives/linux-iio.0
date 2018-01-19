Return-Path: <SRS0=qTwe=EO=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH-next] IIO: ADC: drop unused 'of_id' struct
To: =?UTF-8?Q?Christopher_D=c3=adaz_Riveros?= <chrisadr@gentoo.org>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <broonie@kernel.org>, <arnd@arndb.de>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180118234415.32410-1-chrisadr@gentoo.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <667a16d3-5b23-76d7-0206-6ebd5a001c79@st.com>
Date: Fri, 19 Jan 2018 14:15:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180118234415.32410-1-chrisadr@gentoo.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Christopher,

On 01/19/2018 12:44 AM, Christopher Díaz Riveros wrote:
> When CONFIG_STM32_DFSDM_CORE is enabled, stm32-dfsdm-core.o is compiled,
> which raises a next warning:
> 
> drivers/iio/adc/stm32-dfsdm-core.c: In function ‘stm32_dfsdm_probe’:
> drivers/iio/adc/stm32-dfsdm-core.c:245:29: warning: unused variable ‘of_id’ [-Wunused-variable]
>   const struct of_device_id *of_id;
>                              ^~~~~
> 
> Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
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
Arnd was faster :)
https://patchwork.kernel.org/patch/10172885/

Regards
Arnaud
