Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdGAKOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 06:14:35 -0400
Date: Sat, 1 Jul 2017 11:14:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][iio-next] iio: adc: stm32: make array
 stm32h7_adc_ckmodes_spec static
Message-ID: <20170701111429.6e7ba6a9@kernel.org>
In-Reply-To: <29afb806-8634-0938-081b-dfab4efa04bf@st.com>
References: <20170628130650.21872-1-colin.king@canonical.com>
        <29afb806-8634-0938-081b-dfab4efa04bf@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 28 Jun 2017 16:35:04 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 06/28/2017 03:06 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The array stm32h7_adc_ckmodes_spec does not need to be in global scope, so
> > make it static.
> > 
> > Cleans up sparse warning:
> > "symbol 'stm32h7_adc_ckmodes_spec' was not declared. Should it be static?"
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index e09233b03c05..9d083c2338f9 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -172,7 +172,7 @@ struct stm32h7_adc_ck_spec {
> >  	int div;
> >  };
> >  
> > -const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
> > +static const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
> >  	/* 00: CK_ADC[1..3]: Asynchronous clock modes */
> >  	{ 0, 0, 1 },
> >  	{ 0, 1, 2 },
> >   
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

