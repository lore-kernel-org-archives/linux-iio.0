Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:43439 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848Ab3AUVgF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 16:36:05 -0500
Message-ID: <50FDB517.700@metafoo.de>
Date: Mon, 21 Jan 2013 22:37:27 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
References: <1358798722-25102-1-git-send-email-marex@denx.de> <201301212200.36917.marex@denx.de> <CAHXqBFKzMgX48EJL_f6RF1tZYkdPLCZhip7M9jNuFkY+wjeQqA@mail.gmail.com> <201301212232.52161.marex@denx.de>
In-Reply-To: <201301212232.52161.marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2013 10:32 PM, Marek Vasut wrote:
> Dear Michał Mirosław,
> 
>> 2013/1/21 Marek Vasut <marex@denx.de>:
>>> Dear Michał Mirosław,
>>>
>>>> 2013/1/21 Marek Vasut <marex@denx.de>:
>>>>> This patch adds support for i.MX23 into the LRADC driver. The LRADC
>>>>> block on MX23 is not much different from the one on MX28, thus this
>>>>> is only a few changes fixing the parts that are specific to MX23.
>>>>
>>>> [...]
>>>>
>>>>> +struct mxs_lradc_of_config {
>>>>> +       const int               irq_count;
>>>>> +       const char * const      *irq_name;
>>>>> +};
>>>>> +
>>>>> +static const struct mxs_lradc_of_config const mxs_lradc_of_config[] =
>>>>> { +       [IMX23_LRADC] = {
>>>>> +               .irq_count      = ARRAY_SIZE(mx23_lradc_irq_names),
>>>>> +               .irq_name       = mx23_lradc_irq_names,
>>>>> +       },
>>>>> +       [IMX28_LRADC] = {
>>>>> +               .irq_count      = ARRAY_SIZE(mx28_lradc_irq_names),
>>>>> +               .irq_name       = mx28_lradc_irq_names,
>>>>> +       },
>>>>> +};
>>>>> +
>>>>>
>>>>>  enum mxs_lradc_ts {
>>>>>  
>>>>>         MXS_LRADC_TOUCHSCREEN_NONE = 0,
>>>>>         MXS_LRADC_TOUCHSCREEN_4WIRE,
>>>>>
>>>>> @@ -857,8 +890,19 @@ static void mxs_lradc_hw_stop(struct mxs_lradc
>>>>> *lradc)
>>>>>
>>>>>                 writel(0, lradc->base + LRADC_DELAY(i));
>>>>>  
>>>>>  }
>>>>>
>>>>> +static const struct of_device_id mxs_lradc_dt_ids[] = {
>>>>> +       { .compatible = "fsl,imx23-lradc", .data = (void
>>>>> *)IMX23_LRADC, }, +       { .compatible = "fsl,imx28-lradc", .data =
>>>>> (void
>>>>> *)IMX28_LRADC, }, +       { /* sentinel */ }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
>>>>> +
>>>>
>>>> Why not s/(void \*)\(IMX.._LRADC\)/\&mxs_lradc_of_config[\1]/ ?
>>>
>>> Check the register layout, it differs between MX23 and MX28, that's one
>>> reason, since were we to access differently placed registers, we can do
>>> it easily as in the SSP/I2C drivers.
>>>
>>> Moreover, there are some features on the MX28 that are not on the MX23
>>> (like voltage treshold triggers and touchbuttons), with this setup, we
>>> can easily check what we're running at at runtime and determine to
>>> disallow these.
>>>
>>> From my point of view, using the number (IMX23_LRADC / IMX28_LRADC) is
>>> much more convenient in the long run.
>>
>> I'm asking, because you don't use this number anywhere other than in
>> mxs_lradc_probe()
>> and there only to dereference the irq-names table. After that the
>> structure and number
>> are forgotten.
> 
> Certainly, so far it's used only this way. But please see my argument about 
> register layout, that's why I went down this road of abstraction.

You'll probably be better of by putting these differences into the
mxs_lradc_of_config struct as well, instead of adding switch statements here
and there throughout the code.

- Lars
