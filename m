Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeIYCBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:01:02 -0400
Date: Mon, 24 Sep 2018 20:57:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180924205709.41a5f567@archlinux>
In-Reply-To: <01297ad3-34a9-994a-f6f4-874dfeb9242b@metafoo.de>
References: <20180918125314.GA12752@embeddedor.com>
        <20180922144230.7d5e6c80@archlinux>
        <b16657d2-250e-2cef-5aca-2c32b3fac8a4@metafoo.de>
        <01297ad3-34a9-994a-f6f4-874dfeb9242b@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 24 Sep 2018 19:19:34 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/24/2018 07:18 PM, Lars-Peter Clausen wrote:
> > On 09/22/2018 03:42 PM, Jonathan Cameron wrote:  
> >> On Tue, 18 Sep 2018 07:53:14 -0500
> >> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >>  
> >>> Cast factor to s64 in order to give the compiler complete information
> >>> about the proper arithmetic to use and avoid a potential integer
> >>> overflow. Notice that such variable is being used in a context
> >>> that expects an expression of type s64 (64 bits, signed).
> >>>
> >>> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
> >>> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>> ---
> >>>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> >>> index dcd7fb5..e360e27 100644
> >>> --- a/drivers/iio/adc/qcom-vadc-common.c
> >>> +++ b/drivers/iio/adc/qcom-vadc-common.c
> >>> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
> >>>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
> >>>  	if (voltage > 0) {
> >>>  		voltage *= prescale->den;
> >>> -		temp = prescale->num * factor;
> >>> +		temp = prescale->num * (s64)factor;  
> >> So factor is an unsigned int so could be 32 bits.  In reality it only
> >> takes a small set of values between 1 and 1000
> >>
> >> Maximum numerator is 10 so a maximum of 10,000.
> >>
> >> Hence this is a false positive, be it one that would be very hard
> >> for a static checker to identify.  
> > 
> > I think the reason why it complains is because temp is s64. So it infers
> > that the idea was that the result of the multiplication can be larger
> > than 64 bit. For 32bit * 32bit -> 32bit it should not complain.  
> 
> "lager than 32 bit"
> 
> >   
> >>
> >> So that moves it from a fix to a warning suppression change.
> >> I have no problem with those, but description needs to reflect that.  
> > 
> > Maybe just change the type of temp to u32. There is also
> > mul_u64_u32_div() which could be used here to further simplify things.
> >   
That would be a nice improvement to this patch.  Gustavo,
if you don't mind doing an updated version that would be great.
If not I'll get to it sooner or later.

Thanks,

Jonathan

> 
