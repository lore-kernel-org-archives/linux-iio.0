Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15238 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965801AbeAJPdG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jan 2018 10:33:06 -0500
Subject: Re: [RFC PATCH asoc] IIO: ADC: stm32_dfsdm_stop_filter() can be
 static
To: kbuild test robot <fengguang.wu@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
 <20180110152305.GA83560@lkp-sb05>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <76d70ab9-43a7-88b0-1a76-a3a0275cabaf@st.com>
Date: Wed, 10 Jan 2018 16:32:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180110152305.GA83560@lkp-sb05>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

On 01/10/2018 04:23 PM, kbuild test robot wrote:
> 
> Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  stm32-dfsdm-adc.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c
> b/drivers/iio/adc/stm32-dfsdm-adc.c
> index b03ca3f..e628d04 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -254,7 +254,7 @@ static int stm32_dfsdm_start_filter(struct
> stm32_dfsdm *dfsdm,
>                                    DFSDM_CR1_RSWSTART(1));
>  }
>  
> -void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
> +static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned
> int fl_id)
>  {
>          /* Disable conversion */
>          regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
> @@ -296,9 +296,9 @@ static int stm32_dfsdm_filter_configure(struct
> stm32_dfsdm *dfsdm,
>                                    DFSDM_CR1_RSYNC(fl->sync_mode));
>  }
>  
> -int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
> -                                struct iio_dev *indio_dev,
> -                                struct iio_chan_spec *ch)
> +static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
> +                                       struct iio_dev *indio_dev,
> +                                       struct iio_chan_spec *ch)
>  {
>          struct stm32_dfsdm_channel *df_ch;
>          const char *of_str;
