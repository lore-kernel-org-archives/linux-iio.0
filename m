Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57657 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdCOTuA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 15:50:00 -0400
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: fix fifo overrun recovery
To: Michael Engl <michael.engl@wjw-solutions.com>
References: <1489154347.20665.9.camel@wjw-solutions.com>
 <d76e4b85-6f8f-eae7-41be-de2a15d928cd@kernel.org>
 <1489260881.20665.28.camel@wjw-solutions.com>
 <3bf88afd-3f37-cb8e-7320-97fc652832dc@kernel.org>
 <1489604475.20665.31.camel@wjw-solutions.com>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6a77114c-2a54-5db3-8c31-a93adb73acc6@kernel.org>
Date: Wed, 15 Mar 2017 19:49:34 +0000
MIME-Version: 1.0
In-Reply-To: <1489604475.20665.31.camel@wjw-solutions.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 18:59, Michael Engl wrote:
> On Mon, 2017-03-13 at 21:22 +0000, Jonathan Cameron wrote:
>> On 11/03/17 19:32, Michael Engl wrote:
>>>
>>> On Sam, 2017-03-11 at 18:07 +0000, Jonathan Cameron wrote:
>>>>
>>>> On 10/03/17 13:57, Michael Engl wrote:
>>>>>
>>>>>
>>>>> The tiadc_irq_h(int irq, void *private) function is handling
>>>>> FIFO
>>>>> overruns by clearing flags, disabling and enabling the ADC to
>>>>> recover.
>>>>>
>>>>> If the ADC is running in continuous mode a FIFO overrun happens
>>>>> regularly. If the disabling of the ADC happens concurrently
>>>>> with
>>>>> a new conversion. It might happen that the enabling of the ADC
>>>>> is ignored by the hardware. This stops the ADC permanently. No
>>>>> more interrupts are triggered.
>>>>>
>>>>> According to the AM335x Reference Manual (SPRUH73H October 2011
>>>>> -
>>>>> Revised April 2013 - Chapter 12.4 and 12.5) it is necessary to
>>>>> check the ADC FSM bits in REG_ADCFSM before enabling the ADC
>>>>> again. Because the disabling of the ADC is done right after the
>>>>> current conversion has been finished.
>>>> The relevant comment in the latest version of that manual (rev O)
>>>> is at the end of 12.3.5
>>>> "The FIFO can also generate FIFOx_OVERRUN and FIFOx_UNDERFLOW
>>>> interrupts. The user can mask
>>>> these events by programming the IRQENABLE_CLR register. To clear
>>>> a
>>>> FIFO underflow or FIFO overrun
>>>> interrupt, the user should write a ‘1’ to the status bit in the
>>>> IRQSTS register. The TSC_ADC_SS does not
>>>> recover from these conditions automatically. Therefore, the
>>>> software
>>>> will need to disable and then again
>>>> enable the TSC_ADC_SS. Before the user can turn the module back
>>>> on,
>>>> the user must read the
>>>> ADCSTAT register to check if the status of the ADC FSM is idle
>>>> and
>>>> the current step is the idle step."
>>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>> To trigger this bug it is necessary to run the ADC in
>>>>> continuous
>>>>> mode. The ADC values of all channels need to be read in an
>>>>> endless
>>>>> loop. The bug appears within the first 6 hours (~5.4 million
>>>>> handled FIFO overruns). The user space application will hang on
>>>>> reading new values from the character device.
>>>> Impressive to track this one down, but it's the sort of nasty
>>>> hardware race that we need to be very careful with when trying
>>>> to get a fix in place.
>>>>>
>>>>>
>>>>>
>>>>> Signed-off-by: Michael Engl <michael.engl@wjw-solutions.com>
>>>>> ---
>>>>>  drivers/iio/adc/ti_am335x_adc.c | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c
>>>>> b/drivers/iio/adc/ti_am335x_adc.c
>>>>> index ad9dec3..4282cec 100644
>>>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>>>> @@ -169,7 +169,9 @@ static irqreturn_t tiadc_irq_h(int irq,
>>>>> void
>>>>> *private)
>>>>>  {
>>>>>  	struct iio_dev *indio_dev = private;
>>>>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>>>>> -	unsigned int status, config;
>>>>> +	unsigned int status, config, adc_fsm;
>>>>> +	unsigned short count = 0;
>>>>> +
>>>>>  	status = tiadc_readl(adc_dev, REG_IRQSTATUS);
>>>>>  
>>>>>  	/*
>>>>> @@ -183,6 +185,15 @@ static irqreturn_t tiadc_irq_h(int irq,
>>>>> void
>>>>> *private)
>>>>>  		tiadc_writel(adc_dev, REG_CTRL, config);
>>>>>  		tiadc_writel(adc_dev, REG_IRQSTATUS,
>>>>> IRQENB_FIFO1OVRRUN
>>>>>  				| IRQENB_FIFO1UNDRFLW |
>>>>> IRQENB_FIFO1THRES);
>>>>> +
>>>>> +		/* wait for idle state.
>>>> Standard multiline comment syntax preferred.
>>>>>
>>>>>
>>>>> +		 * ADC needs to finish the current conversion
>>>>> +		 * before disabling the module
>>>>> +		 */
>>>>> +		do {
>>>>> +			adc_fsm = tiadc_readl(adc_dev,
>>>>> REG_ADCFSM);
>>>>> +		} while (adc_fsm != 0x10 && count++ < 100);
>>>> What slightly bothers me is that we are papering over the
>>>> problem,  yet
>>>> this is far from guaranteed to fix it (I think!) as we might get
>>>> a
>>>> race
>>>> as it starts the next conversion after we have checked, but
>>>> before we
>>>> disable...
>>>>
>>>> Note I'm only looking at this fairly superficially so please
>>>> point
>>>> out if I have missed something!
>>> Probably my comment is a bit confusing. The ADC has already been
>>> disabled by writing the config some lines above the while loop. 
>>>
>>> "
>>> config &= ~(CNTRLREG_TSCSSENB);
>>> tiadc_writel(adc_dev, REG_CTRL, config);
>>> "
>>> But as stated in the Reference Manual the ADC needs some time to
>>> finish
>>> the current conversion to finally disable the ADC. 
>>>
>>> Description of "Enable" Bit in the CTRL Register (table 12-14):
>>> "TSC_ADC_SS module enable bit.
>>> After programming all the steps and configuration registers, write
>>> a
>>> 1to this bit to turn on TSC_ADC_SS.
>>> Writing a 0 will disable the module (after the current
>>> conversion)."
>>>
>>> That means once the adc_fsm is equal to 0x10 (idle state) the ADC
>>> stays
>>> disabled as long as we enable the ADC again. Which is done by the
>>> original code one line below of this patch.
>> Cool. Thanks for the clarification.  I got lost in the datahsheet ;)
>>
>> Would you mind figuring out a fixes tag for this one as I want it to
>> go for stable?
> 
> From 93ed6e1d4cfd34f30e0201407c92ff8af129a689 Mon Sep 17 00:00:00 2001
> From: Michael Engl <michael.engl@wjw-solutions.com>
> Date: Wed, 15 Mar 2017 19:45:39 +0100
> Subject: [PATCH] iio: adc: ti_am335x: fix fifo overrun recovery
> 
> The tiadc_irq_h(int irq, void *private) function is handling FIFO
> overruns by clearing flags, disabling and enabling the ADC to
> recover.
> 
> If the ADC is running in continuous mode a FIFO overrun happens
> regulaly. If the disabling of the ADC happens concurrently with
> a new conversion. It might happen that the enabling of the ADC
> is ignored by the hardware. This stops the ADC permanently. No
> more interrupt are triggered.
> 
> According to the AM335x Reference Manual (SPRUH73H October 2011 -
> Revised April 2013 Chapter 12.4 and 12.5) it is necessary to
> check the ADC FSM bits in REG_ADCFSM before enabling the ADC
> again. Because the disabling of the ADC is done right after the
> current conversion has been finished.
> 
> To trigger this bug it is necessary to run the ADC in continuous
> mode. The ADC values of all channels need to be read in an endless
> loop. The bug appears within the first 6 hours (~5.4 million
> handled FIFO overruns). The user space application will hang on
> reading new values from the char device.
> 
> Fixes: ca9a563805f7a ("iio: ti_am335x_adc: Add continuous sampling
> support")
> Signed-off-by: Michael Engl <michael.engl@wjw-solutions.com>
As a general rule please don't paste a patch inside another thread.
It makes it really fiddly to apply.  All I was after was the fixes
line! 

Anyhow, thanks for tracking this down.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c
> b/drivers/iio/adc/ti_am335x_adc.c
> index ad9dec30bb30..752e92ffce94 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -169,7 +169,9 @@ static irqreturn_t tiadc_irq_h(int irq, void
> *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	unsigned int status, config;
> +	unsigned int status, config, adc_fsm;
> +	unsigned short count = 0;
> +
>  	status = tiadc_readl(adc_dev, REG_IRQSTATUS);
>  
>  	/*
> @@ -183,6 +185,15 @@ static irqreturn_t tiadc_irq_h(int irq, void
> *private)
>  		tiadc_writel(adc_dev, REG_CTRL, config);
>  		tiadc_writel(adc_dev, REG_IRQSTATUS,
> IRQENB_FIFO1OVRRUN
>  				| IRQENB_FIFO1UNDRFLW |
> IRQENB_FIFO1THRES);
> +
> +		/* wait for idle state.
> +		   ADC needs to finish the current conversion
> +		   before disabling the module
> +		*/
> +		do {
> +			adc_fsm = tiadc_readl(adc_dev, REG_ADCFSM);
> +		} while (adc_fsm != 0x10 && count++ < 100);
> +
>  		tiadc_writel(adc_dev, REG_CTRL, (config |
> CNTRLREG_TSCSSENB));
>  		return IRQ_HANDLED;
>  	} else if (status & IRQENB_FIFO1THRES) {
> -- 
> 2.7.4
> 
>>
>> Thanks,
>>
>> Jonathan
>>>
>>>
>>>>
>>>>
>>>> We could look for a transition, which would potentially reduce
>>>> the
>>>> chance
>>>> of problems, but that's nasty as well and we'd need to disable
>>>> interrupts
>>>> probably to avoid any potential of a clash (for a non trivial
>>>> amount
>>>> of
>>>> time...)
>>>>>
>>>>>
>>>>> +
>>>>>  		tiadc_writel(adc_dev, REG_CTRL, (config |
>>>>> CNTRLREG_TSCSSENB));
>>>>>  		return IRQ_HANDLED;
>>>>>  	} else if (status & IRQENB_FIFO1THRES) {
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

