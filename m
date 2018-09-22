Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbeIVTgN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 15:36:13 -0400
Date: Sat, 22 Sep 2018 14:42:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180922144230.7d5e6c80@archlinux>
In-Reply-To: <20180918125314.GA12752@embeddedor.com>
References: <20180918125314.GA12752@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 18 Sep 2018 07:53:14 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Cast factor to s64 in order to give the compiler complete information
> about the proper arithmetic to use and avoid a potential integer
> overflow. Notice that such variable is being used in a context
> that expects an expression of type s64 (64 bits, signed).
> 
> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index dcd7fb5..e360e27 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
>  	if (voltage > 0) {
>  		voltage *= prescale->den;
> -		temp = prescale->num * factor;
> +		temp = prescale->num * (s64)factor;
So factor is an unsigned int so could be 32 bits.  In reality it only
takes a small set of values between 1 and 1000

Maximum numerator is 10 so a maximum of 10,000.

Hence this is a false positive, be it one that would be very hard
for a static checker to identify.

So that moves it from a fix to a warning suppression change.
I have no problem with those, but description needs to reflect that.

Let me know if I've missed something, if not I'm happy to apply
this and will put some text in the message to explain the above
reasoning.

Thanks,

Jonathan

>  		voltage = div64_s64(voltage, temp);
>  	} else {
>  		voltage = 0;
