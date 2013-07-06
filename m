Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37782 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3GFKAC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jul 2013 06:00:02 -0400
Message-ID: <51D7EA9F.70506@kernel.org>
Date: Sat, 06 Jul 2013 10:59:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Hector Palacios <hector.palacios@digi.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051341.35612.marex@denx.de> <51D6F78E.5080301@digi.com> <201307051859.01095.marex@denx.de>
In-Reply-To: <201307051859.01095.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 05:59 PM, Marek Vasut wrote:
> Dear Hector Palacios,
> 
>> Dear Marek,
>>
>> On 07/05/2013 01:41 PM, Marek Vasut wrote:
>>> Dear Hector Palacios,
>>>
>>>> Some LRADC channels have a fixed pre-divider, and all can have enabled
>>>> an optional divisor by two which allows a maximum input voltage of
>>>> VDDIO - 50mV.
>>>>
>>>> This patch
>>>>
>>>>   - adds the scaling info flag to all channels
>>>>   - adds a lookup table with max reference voltage per channel
>>>>   
>>>>     (where the fixed pre-dividers apply)
>>>>   
>>>>   - allows to read the scaling attribute (computed from the Vref)
>>>>
>>>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>>>> ---
>>>>
>>>>   drivers/staging/iio/adc/mxs-lradc.c | 122
>>>>
>>>> +++++++++++++++++++++++++++--------- 1 file changed, 93 insertions(+),
>>>> 29 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>>>> b/drivers/staging/iio/adc/mxs-lradc.c index d65a594..012c42e 100644
>>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>>> @@ -107,19 +107,63 @@ static const char * const mx28_lradc_irq_names[] =
>>>> {
>>>>
>>>>   	"mxs-lradc-button1",
>>>>   
>>>>   };
>>>>
>>>> +/*
>>>> + * Max reference voltage (mV) for each channel
>>>> + */
>>>> +static const int mx23_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
>>>> +	1850,		/* CH0 */
>>>> +	1850,		/* CH1 */
>>>> +	1850,		/* CH2 */
>>>> +	1850,		/* CH3 */
>>>> +	1850,		/* CH4 */
>>>> +	1850,		/* CH5 */
>>>> +	1850 * 2,	/* CH6 VDDIO */
>>>> +	1850 * 4,	/* CH7 VBATT */
>>>> +	1850,		/* CH8 Temp sense 0 */
>>>> +	1850,		/* CH9 Temp sense 1 */
>>>> +	1850,		/* CH10 */
>>>> +	1850,		/* CH11 */
>>>> +	1850,		/* CH12 USB_DP */
>>>> +	1850,		/* CH13 USB_DN */
>>>> +	1850,		/* CH14 VBG */
>>>> +	1850 * 4,	/* CH15 VDD5V */
>>>> +};
>>>> +
>>>> +static const int mx28_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
>>>> +	1850,		/* CH0 */
>>>> +	1850,		/* CH1 */
>>>> +	1850,		/* CH2 */
>>>> +	1850,		/* CH3 */
>>>> +	1850,		/* CH4 */
>>>> +	1850,		/* CH5 */
>>>> +	1850,		/* CH6 */
>>>> +	1850 * 4,	/* CH7 VBATT */
>>>> +	1850,		/* CH8 Temp sense 0 */
>>>> +	1850,		/* CH9 Temp sense 1 */
>>>> +	1850 * 2,	/* CH10 VDDIO */
>>>> +	1850,		/* CH11 VTH */
>>>> +	1850 * 2,	/* CH12 VDDA */
>>>> +	1850,		/* CH13 VDDD */
>>>> +	1850,		/* CH14 VBG */
>>>> +	1850 * 4,	/* CH15 VDD5V */
>>>> +};
>>>
>>> Should the above not be in DT ?
>>
>> Do you mean for example:
>>
>> 	lradc@80050000 {
>> 		compatible = "fsl,imx28-lradc";
>> 		reg = <0x80050000 0x2000>;
>> 		interrupts = <10 14 15 16 17 18 19
>> 				20 21 22 23 24 25>;
>> 		vref = <1850 1850 1850 1850
>> 			1850 1850 1850 7400
>> 			1850 1850 3700 1850
>> 			3700 1850 1850 7400>
>> 	};
>>
>> I'm ok with it, but are there other examples of driver using a similar
>> approach? I see for example the spear-adc which reads:
>>
>> 	Optional properties:
>> 	- vref-external: External voltage reference in milli-volts. If omitted
>> 	  the internal voltage reference will be used.
>>
>> which makes me believe the 'internal voltage reference' is hardcoded in the
>> driver. More opinions?
> 
> I'd duke this one out on devicetree-discuss@ list. In general, I'd use something 
> like fsl,vref prop, but this really better be discussed in a separate thread.
Given timing wrt the merge window we have a couple of months to pin this down
without effecting when it hits mainline so I would go ahead and open a discussion
on devicetree-discuss.
> 
> On the other hand, I'd hate to keep these patches here waiting , so maybe we 
> should apply them as-is and remove this part from the driver in a subsequent 
> patch? What do you say, Lars ?
Could do so but as I said, no particular rush unless people have lots of stuff
they want to do on top of these?

> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
