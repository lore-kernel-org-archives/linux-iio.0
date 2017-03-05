Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59673 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdCELOh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 06:14:37 -0500
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
To: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
 <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
 <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
 <d64bd76d-a2c6-6148-c126-fa73e96019a1@kernel.org>
 <79e01c5c-d27c-89ea-4d8f-9e66a6c091e6@st.com>
 <f486bd08-b562-5101-01ba-c8e36ac0d83b@metafoo.de>
 <84b7cbab-1342-7f80-cab6-132324e002a4@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c306b51a-da1f-2e92-afb5-1bd2c19484a0@kernel.org>
Date: Sun, 5 Mar 2017 11:14:30 +0000
MIME-Version: 1.0
In-Reply-To: <84b7cbab-1342-7f80-cab6-132324e002a4@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/17 10:14, Fabrice Gasnier wrote:
> On 02/28/2017 09:34 AM, Lars-Peter Clausen wrote:
>> On 02/28/2017 09:21 AM, Fabrice Gasnier wrote:
>>> On 02/25/2017 04:11 PM, Jonathan Cameron wrote:
>>>> On 24/02/17 16:04, Fabrice Gasnier wrote:
>>>>> On 02/19/2017 01:09 PM, Jonathan Cameron wrote:
>>>>>> On 15/02/17 16:55, Fabrice Gasnier wrote:
>>>>>>> Add documentation for 'st,adc-res' dt optional property.
>>>>>>>
>>>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>>>> I'm happy with this, but would like to leave time for a device tree review.
>>>>>>
>>>>>> Ultimately we may well want to make this a generic property and call it
>>>>>> something
>>>>>> like adc-resolution but perhaps we need to wait until we have a few more
>>>>>> devices
>>>>>> supporting setting it via device tree to figure out what the best
>>>>>> interface is.
>>>>>> It would exactly be a problem to support this as a deprecated binding at
>>>>>> that
>>>>>> point.
>>>>>
>>>>> Hi Jonathan,
>>>>>
>>>>> I agree with you on this... It may be better to have generic property
>>>>> for this, especially if you see that it will come in the near future.
>>>>> May I suggest this prop to be less restrictive, e.g. like
>>>>> resolution-bits as is may also be worth for other device types, e.g.
>>>>> DAC as an example ?>
>>>> Sure, why not - no loss of meaning here.  We may never use it for anything
>>>> else but that doesn't matter.
>>>
>>> Hi Jonathan,
>>>
>>> Following Rob's comment, how you see such a common property can be
>>> integrated. Currently I don't see much devices are doing this.
>>> Do you have ideas or preferences on this ?
>>>
>>> - Do you think replacing 'st,adc-res' by 'resolution-bits' in current
>>> patchset is enough for now ?
>>
>> That name would be a bit confusing. Considering that the devicetree
>> describes th capabilities of the hardware this name would suggest that this
>> is the resolution supported by the device.
>>
>> If we want to allow selecting runtime configuration parameters for IIO
>> devices from the devicetree we should probably follow the precedence set by
>> the clock framework and use properties with the 'assigned-' prefix.
> 
> Hi Lars,
> 
> This makes sense. Then, do you see 'assigned-resolution-bits' as a
> better candidate ?
> Also, do you think listing all devices caps in property like 'resolutions-bits', e.g. 'resolutions-bits = <6 8 10 12>', is
> suitable/necessary ?
Only suitable / necessary if what the options are is dependent on the hardware
in some way that is not adequately described by the compatibility element.
> 
>>
>> But to be honest I'm not convinced yet that the whole approach of allowing
>> runtime configuration parameters to be configured via the devicetree is the
>> right approach. Converters and sensors often have a lot of runtime
>> configurable parameters, typically we expose them to the application layer
>> to allow maximum flexibility. Why is the resolution special in this case and
>> should be pre-configured via the devicetree instead?
> 
To be cynical because it is PITA to change the assumption of it being
fixed :)  Oh well, another design decision that we got wrong a long time
back.

> As I understand it, currently lots of devices have hard-coded 
> (maximum?) resolution, then exposed to application layer as read only
> data format. Then resolution depends on HW used (e.g. sensor,
> converter). Depending on the application board, it may be worth to
> offer pre-configured intermediate/lower resolution depending on
> analog sources. Is it ok to offer devicetree pre-configuration ?
> 
Hmm.  It is in theory acceptable to put default values that make sense
for a given set of hardware in device tree.  They are kind of a 
'well this will work' state.  Make sense if there are states that
don't make sense for a given hardware setup.

If all states make equally good sense, then perhaps we should look at
fixing up the IIO core to handle variable resolution devices.
That strikes me as a non trivial exercise, but could probably be
done.  We'd need to keep the simplicity of the current code
for the vast majority of devices, but provide some relatively clean
way of changing it when needed.

Whilst I'm happy if someone else wants to look at this, it is
nowhere near the top of my list!

Jonathan
> Best Regards,
> Fabrice
>>
>> - Lars
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

