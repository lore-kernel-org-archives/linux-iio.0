Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdIJQAp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 12:00:45 -0400
Date: Sun, 10 Sep 2017 17:00:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: stm32: fix adc/trigger link error
Message-ID: <20170910170040.7eb1f768@archlinux>
In-Reply-To: <50ec54e0-85f7-8c32-475c-9b27a4e6ebd3@st.com>
References: <20170906125722.2522781-1-arnd@arndb.de>
        <50ec54e0-85f7-8c32-475c-9b27a4e6ebd3@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 6 Sep 2017 18:16:33 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 09/06/2017 02:56 PM, Arnd Bergmann wrote:
> > The ADC driver can trigger on either the timer or the lptim
> > trigger, but it only uses a Kconfig 'select' statement
> > to ensure that the first of the two is present. When the lptim
> > trigger is enabled as a loadable module, and the adc driver
> > is built-in, we now get a link error:
> > 
> > drivers/iio/adc/stm32-adc.o: In function `stm32_adc_get_trig_extsel':
> > stm32-adc.c:(.text+0x4e0): undefined reference to `is_stm32_lptim_trigger'
> > 
> > We could use a second 'select' statement and always have both
> > trigger drivers enabled when the adc driver is, but it seems that
> > the lptimer trigger was intentionally left optional, so it seems
> > better to keep it that way.  
> Hi Arnd,
> 
> This is correct, not all stm32 have this hardware.
> > 
> > This adds a hack to use 'IS_REACHABLE()' rather than 'IS_ENABLED()',
> > which avoids the link error, but instead leads to the lptimer trigger
> > not being used in the broken configuration. I've added a runtime
> > warning for this case to help users figure out what they did wrong
> > if this should ever be done by accident.
> > 
> > Fixes: f0b638a7f6db ("iio: adc: stm32: add support for lptimer triggers")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>

This may take me a few weeks to pick up.  I don't want to
pull the mfd immutable branch in just to have this fix, so this will
get sorted after rc1 is out.

As ever, poke me if it looks like I've forgotten about it.
Sorry for the delay!

Jonathan

> 
> Many thanks for the fix,
> Best Regards,
> Fabrice
> > ---
> >  include/linux/iio/timer/stm32-lptim-trigger.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
> > index 34d59bfdce2d..464458d20b16 100644
> > --- a/include/linux/iio/timer/stm32-lptim-trigger.h
> > +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
> > @@ -16,11 +16,14 @@
> >  #define LPTIM2_OUT	"lptim2_out"
> >  #define LPTIM3_OUT	"lptim3_out"
> >  
> > -#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> > +#if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> >  bool is_stm32_lptim_trigger(struct iio_trigger *trig);
> >  #else
> >  static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
> >  {
> > +#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> > +	pr_warn_once("stm32 lptim_trigger not linked in\n");
> > +#endif
> >  	return false;
> >  }
> >  #endif
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

