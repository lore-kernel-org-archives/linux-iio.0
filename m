Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeIXV5y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Sep 2018 17:57:54 -0400
Date: Mon, 24 Sep 2018 21:24:52 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180924155452.GA7529@himanshu-Vostro-3559>
References: <20180918125314.GA12752@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918125314.GA12752@embeddedor.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Gustavo,

On Tue, Sep 18, 2018 at 07:53:14AM -0500, Gustavo A. R. Silva wrote:
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

As Jonathan pointed it is a false positive, let me share some more
insight on this particular set of warnings.

`num` is u32 and `factor` is unsigned int(u32 on most implementations).

So, if multiplication b/w them exceeds UNIT_MAX then that is perfectly
defined behavior in C. And often called "wrapping".
https://port70.net/~nsz/c/c11/n1570.html#6.2.5p9

And *if* it exceeds UNIT_MAX, then it is certainly wrong arthimetic
implementation by the author.

On the other hand, if it were the case signed int overflow then
certainly it is undefined behavior and called "overflow".

And here `temp` is guaranteed to not overflow!

But I don't understand what issue are you trying to resolve here and I'm
interested in this particular set of warnings because I too get coverity
scan reports on the same although I only search for IIO drivers issues.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
