Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58609 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751312AbdF1Ofz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jun 2017 10:35:55 -0400
Subject: Re: [PATCH][iio-next] iio: adc: stm32: make array
 stm32h7_adc_ckmodes_spec static
To: Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20170628130650.21872-1-colin.king@canonical.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <29afb806-8634-0938-081b-dfab4efa04bf@st.com>
Date: Wed, 28 Jun 2017 16:35:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170628130650.21872-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/28/2017 03:06 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The array stm32h7_adc_ckmodes_spec does not need to be in global scope, so
> make it static.
> 
> Cleans up sparse warning:
> "symbol 'stm32h7_adc_ckmodes_spec' was not declared. Should it be static?"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iio/adc/stm32-adc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index e09233b03c05..9d083c2338f9 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -172,7 +172,7 @@ struct stm32h7_adc_ck_spec {
>  	int div;
>  };
>  
> -const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
> +static const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
>  	/* 00: CK_ADC[1..3]: Asynchronous clock modes */
>  	{ 0, 0, 1 },
>  	{ 0, 1, 2 },
> 
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
