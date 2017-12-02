Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdLBLWs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 06:22:48 -0500
Date: Sat, 2 Dec 2017 11:22:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: stm32: fix adc/trigger link error
Message-ID: <20171202112244.61eeedf6@archlinux>
In-Reply-To: <da83af87-6c70-8b00-b602-342a9274f81f@st.com>
References: <20170906125722.2522781-1-arnd@arndb.de>
        <50ec54e0-85f7-8c32-475c-9b27a4e6ebd3@st.com>
        <20170910170040.7eb1f768@archlinux>
        <6b5ff28a-859d-973c-2da5-60a8bf50c378@st.com>
        <20170925111604.00000c02@huawei.com>
        <20170925182617.18bf5ce8@archlinux>
        <da83af87-6c70-8b00-b602-342a9274f81f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Nov 2017 10:09:47 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 09/25/2017 07:26 PM, Jonathan Cameron wrote:
> > On Mon, 25 Sep 2017 11:16:04 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> >> On Mon, 25 Sep 2017 11:54:06 +0200
> >> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>  
> >>> On 09/10/2017 06:00 PM, Jonathan Cameron wrote:    
> >>>> On Wed, 6 Sep 2017 18:16:33 +0200
> >>>> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>>>       
> >>>>> On 09/06/2017 02:56 PM, Arnd Bergmann wrote:      
> >>>>>> The ADC driver can trigger on either the timer or the lptim
> >>>>>> trigger, but it only uses a Kconfig 'select' statement
> >>>>>> to ensure that the first of the two is present. When the lptim
> >>>>>> trigger is enabled as a loadable module, and the adc driver
> >>>>>> is built-in, we now get a link error:
> >>>>>>
> >>>>>> drivers/iio/adc/stm32-adc.o: In function `stm32_adc_get_trig_extsel':
> >>>>>> stm32-adc.c:(.text+0x4e0): undefined reference to `is_stm32_lptim_trigger'
> >>>>>>
> >>>>>> We could use a second 'select' statement and always have both
> >>>>>> trigger drivers enabled when the adc driver is, but it seems that
> >>>>>> the lptimer trigger was intentionally left optional, so it seems
> >>>>>> better to keep it that way.        
> >>>>> Hi Arnd,
> >>>>>
> >>>>> This is correct, not all stm32 have this hardware.      
> >>>>>>
> >>>>>> This adds a hack to use 'IS_REACHABLE()' rather than 'IS_ENABLED()',
> >>>>>> which avoids the link error, but instead leads to the lptimer trigger
> >>>>>> not being used in the broken configuration. I've added a runtime
> >>>>>> warning for this case to help users figure out what they did wrong
> >>>>>> if this should ever be done by accident.
> >>>>>>
> >>>>>> Fixes: f0b638a7f6db ("iio: adc: stm32: add support for lptimer triggers")
> >>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>        
> >>>>> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>      
> >>>>
> >>>> This may take me a few weeks to pick up.  I don't want to
> >>>> pull the mfd immutable branch in just to have this fix, so this will
> >>>> get sorted after rc1 is out.
> >>>>
> >>>> As ever, poke me if it looks like I've forgotten about it.      
> >>>
> >>> Hi Jonathan,
> >>>
> >>> Di you apply this one?    
> >>
> >> I think I still need to rebase my branch. Greg took my fixes pull this morning
> >> so I can fast forward that branch next time I'm on the right PC and then pick
> >> this up.
> >>
> >> Thanks for the reminder.  
> > 
> > Applied to the fixes-togreg branch of iio.git.  
> 
> Hi Jonathan,
> 
> Sorry to raise this again. Maybe I missed something, but I can't find
> this fix on recent tag (4.15-rc1). Do you know if this patch from Arnd
> is on its way in ?

Hi Fabrice,

You are absolutely correct to raise this (and please do so if similar
seems to have happened in the future).

I dropped this one somehow - now applied to my fixes-togreg branch of iio.git
and definitely pushed out.

Sorry about that.  Will hopefully get a pull request out in the next
day or so.

Thanks,

Jonathan
> 
> Please kindly let me know.
> BR,
> Fabrice
> > 
> > Thanks,
> > 
> > Jonathan  
> >>
> >> Jonathan
> >>  
> >>>
> >>> Thanks,
> >>> Best Regards,
> >>> Fabrice    
> >>>> Sorry for the delay!
> >>>>
> >>>> Jonathan
> >>>>       
> >>>>>
> >>>>> Many thanks for the fix,
> >>>>> Best Regards,
> >>>>> Fabrice      
> >>>>>> ---
> >>>>>>  include/linux/iio/timer/stm32-lptim-trigger.h | 5 ++++-
> >>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
> >>>>>> index 34d59bfdce2d..464458d20b16 100644
> >>>>>> --- a/include/linux/iio/timer/stm32-lptim-trigger.h
> >>>>>> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
> >>>>>> @@ -16,11 +16,14 @@
> >>>>>>  #define LPTIM2_OUT	"lptim2_out"
> >>>>>>  #define LPTIM3_OUT	"lptim3_out"
> >>>>>>  
> >>>>>> -#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> >>>>>> +#if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> >>>>>>  bool is_stm32_lptim_trigger(struct iio_trigger *trig);
> >>>>>>  #else
> >>>>>>  static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
> >>>>>>  {
> >>>>>> +#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> >>>>>> +	pr_warn_once("stm32 lptim_trigger not linked in\n");
> >>>>>> +#endif
> >>>>>>  	return false;
> >>>>>>  }
> >>>>>>  #endif
> >>>>>>         
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html      
> >>>>       
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel    
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

