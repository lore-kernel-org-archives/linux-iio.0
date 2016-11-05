Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50764 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755024AbcKEP7R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 11:59:17 -0400
Subject: Re: [PATCH V3 1/2] iio: adc: spmi-vadc: Update changes to support
 reporting of Raw adc code.
To: "Phani A, Rama Krishna" <rphani@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <1477492887-1663-1-git-send-email-rphani@codeaurora.org>
 <1477492887-1663-2-git-send-email-rphani@codeaurora.org>
 <ee44e76a-b7e1-63b2-2251-6247d9e6bb9d@kernel.org>
 <0beb28aa-1726-3046-1652-96f0029fa5dc@codeaurora.org>
 <de2a0283-201d-fdab-98d0-be45ca71f5ea@kernel.org>
 <a36d7f9c-7716-19bb-2710-7af90f8e0787@codeaurora.org>
Cc: robh@kernel.org, linux-arm-msm@vger.kernel.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <22dcb3e2-aa00-4e61-eeac-a4f1a9afa0e5@kernel.org>
Date: Sat, 5 Nov 2016 15:59:14 +0000
MIME-Version: 1.0
In-Reply-To: <a36d7f9c-7716-19bb-2710-7af90f8e0787@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/11/16 13:12, Phani A, Rama Krishna wrote:
> Hi Jonathan,
> 
> On 02-Nov-16 12:00 AM, Jonathan Cameron wrote:
>> On 31/10/16 08:48, Rama Krishna Phani A wrote:
>>> Hi Jonathan,
>>>
>>> On 30-Oct-16 11:05 PM, Jonathan Cameron wrote:
>>>> On 26/10/16 15:41, Rama Krishna Phani A wrote:
>>>>> Logic to convert adc code to voltage is generic across all channels.
>>>>> Different scaling can be done on the obtained voltage to report in physical
>>>>> units. Implement separate function for generic conversion logic.
>>>>> Scaling functionality can be changed per channel. Update changes to support
>>>>> reporting of Raw adc code.
>>>> Pleas rewrite this description.  Perhaps give examples of the changes
>>>> it makes to what is read from the various attributes?
>>> There are several channels in the ADC of PMIC which can be used to
>>> measure voltage, temperature, current etc., Hardware provides
>>> readings for all channels in adc code. That adc code needs to be
>>> converted to voltage. The logic for conversion of adc code to voltage
>>> is common for all ADC channels(voltage, temperature and current
>>> .,etc). Once voltage is obtained ., scaling is done on that voltage.
>>>
>>> For Ex., Thermal SW wants to know the temperature of thermistor on
>>> PMIC and it expects the temperature to be reported in millidegC. ADC
>>> channel is used to read the adc code and convert it to voltage. Once
>>> the voltage is available based on the thermistor spec that voltage is
>>> mapped to a temperature and then that value is reported to Thermal
>>> SW.
>>>
>>> Mapping of voltage to temperature is called scaling for that channel
>>> and scaling function can be different per channel based on how the
>>> voltage is reported.
>> Is the thermistor always part of the device? (i.e. in the chip) in which
>> case this might be fine.  If it's external then it needs to be described
>> by a separate device which acts as a consumer of the IIO channel and
>> in turn provides the scaled output to thermal.
>>
>> The thermistor should really be separately described.   This is already
>> done in drivers/hwmon/ntc_thermistor
>>
>> Are any of these scalings characteristics of the chip supported by
>> this driver, or are they the result of external hardware?
> 
> All the VADC channels i.e., Voltage, temperature(thermistors and
> other channels) are part of PMIC chip. The scaling functionalities
> supported in this driver are for the adc channels which are part of
> PMIC chip.
>>>>
>>>> I haven't immediately followed what this change is actually doing.
>>>>
>>>> I 'think' the point here is to not apply the calibration to
>>>> the raw adc counts when a true raw read is requested?
>>>>
>>> When a true raw read is requested .,Scaling is not applied.
>>>> There are several unconnected looking changes in here...
>>>>>
>>>>> Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
>>>>> ---
>>>>>  drivers/iio/adc/qcom-spmi-vadc.c | 54 +++++++++++++++++++++-------------------
>>>>>  1 file changed, 28 insertions(+), 26 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
>>>>> index c2babe5..ff4d549 100644
>>>>> --- a/drivers/iio/adc/qcom-spmi-vadc.c
>>>>> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
>>>>> @@ -1,5 +1,5 @@
>>>>>  /*
>>>>> - * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
>>>>> + * Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
>>>>>   *
>>>>>   * This program is free software; you can redistribute it and/or modify
>>>>>   * it under the terms of the GNU General Public License version 2 and
>>>>> @@ -84,7 +84,7 @@
>>>>>  #define VADC_MAX_ADC_CODE            0xa800
>>>>>
>>>>>  #define VADC_ABSOLUTE_RANGE_UV            625000
>>>>> -#define VADC_RATIOMETRIC_RANGE_UV        1800000
>>>>> +#define VADC_RATIOMETRIC_RANGE            1800
>>>>>
>>>>>  #define VADC_DEF_PRESCALING            0 /* 1:1 */
>>>>>  #define VADC_DEF_DECIMATION            0 /* 512 */
>>>>> @@ -418,7 +418,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>>>>>      u16 read_1, read_2;
>>>>>      int ret;
>>>>>
>>>>> -    vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE_UV;
>>>>> +    vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
>>>>>      vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
>>>>>
>>>>>      prop = vadc_get_channel(vadc, VADC_REF_1250MV);
>>>>> @@ -468,21 +468,30 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>>>>>      return ret;
>>>>>  }
>>>>>
>>>>> -static s32 vadc_calibrate(struct vadc_priv *vadc,
>>>>> -              const struct vadc_channel_prop *prop, u16 adc_code)
>>>>> +static void vadc_scale_calib(struct vadc_priv *vadc, u16 adc_code,
>>>>> +                 const struct vadc_channel_prop *prop,
>>>>> +                 s64 *scale_voltage)
>>>>>  {
>>>>> -    const struct vadc_prescale_ratio *prescale;
>>>>> -    s64 voltage;
>>>>> +    *scale_voltage = (adc_code -
>>>>> +        vadc->graph[prop->calibration].gnd);
>>>>> +    *scale_voltage *= vadc->graph[prop->calibration].dx;
>>>>> +    *scale_voltage = div64_s64(*scale_voltage,
>>>>> +        vadc->graph[prop->calibration].dy);
>>>>> +    if (prop->calibration == VADC_CALIB_ABSOLUTE)
>>>>> +        *scale_voltage +=
>>>>> +        vadc->graph[prop->calibration].dx;
>>>>>
>>>>> -    voltage = adc_code - vadc->graph[prop->calibration].gnd;
>>>>> -    voltage *= vadc->graph[prop->calibration].dx;
>>>>> -    voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);
>>>>> +    if (*scale_voltage < 0)
>>>>> +        *scale_voltage = 0;
>>>>> +}
>>>>>
>>>>> -    if (prop->calibration == VADC_CALIB_ABSOLUTE)
>>>>> -        voltage += vadc->graph[prop->calibration].dx;
>>>>> +static s64 vadc_scale_fn(struct vadc_priv *vadc,
>>>>> +             const struct vadc_channel_prop *prop, u16 adc_code)
>>>>> +{
>>>>> +    const struct vadc_prescale_ratio *prescale;
>>>>> +    s64 voltage = 0;
>>>>>
>>>>> -    if (voltage < 0)
>>>>> -        voltage = 0;
>>>>> +    vadc_scale_calib(vadc, adc_code, prop, &voltage);
>>>>>
>>>>>      prescale = &vadc_prescale_ratios[prop->prescale];
>>>>>
>>>>> @@ -552,11 +561,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
>>>>>          if (ret)
>>>>>              break;
>>>>>
>>>>> -        *val = vadc_calibrate(vadc, prop, adc_code);
>>>>> +        *val = vadc_scale_fn(vadc, prop, adc_code);
>>>>>
>>>>> -        /* 2mV/K, return milli Celsius */
>>>>> -        *val /= 2;
>>>>> -        *val -= KELVINMIL_CELSIUSMIL;
>>>>>          return IIO_VAL_INT;
>>>>>      case IIO_CHAN_INFO_RAW:
>>>>>          prop = &vadc->chan_props[chan->address];
>>>>> @@ -564,12 +570,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
>>>>>          if (ret)
>>>>>              break;
>>>>>
>>>>> -        *val = vadc_calibrate(vadc, prop, adc_code);
>>>>> +        *val = (int)adc_code;
>>>>>          return IIO_VAL_INT;
>>>> So this is 'more raw'.
>>> Yes., its raw value.
>>>>> -    case IIO_CHAN_INFO_SCALE:
>>>>> -        *val = 0;
>>>>> -        *val2 = 1000;
>>>>> -        return IIO_VAL_INT_PLUS_MICRO;
>>>>>      default:
>>>>>          ret = -EINVAL;
>>>>>          break;
>>>>> @@ -616,8 +618,8 @@ struct vadc_channels {
>>>>>      VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)    \
>>>>>
>>>>>  #define VADC_CHAN_VOLT(_dname, _pre)                    \
>>>>> -    VADC_CHAN(_dname, IIO_VOLTAGE,                    \
>>>>> -          BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),    \
>>>>> +    VADC_CHAN(_dname, IIO_VOLTAGE,                \
>>>>> +          BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>>>>>            _pre)                            \
>>>> It very unusual to report both raw and processed values.  Please explain
>>>> why that is needed here?  It may be valid to maintain backwards compatibility
>>>> of ABI. Which would be fine. However if I read the above correctly you are
>>>> changing what comes out of reading the raw value so the ABI just changed...
>>>>
>>> With the help of IIO sysfs ., we can read the ADC channel readings
>>> either in RAW format or in processed format. There are two separate
>>> individual entries to read the ADC channel either in Raw format or in
>>> processed format. Most of the clients for ADC expect the readings in
>>> processed format.
>> If we are talking in kernel, that is worked out by the application of
>> scale.  The IIO in kernel interfaces will do this automatically.
>>
>> I we are talking in userspace, then the userspace needs to be
>> extended to support raw and scale reading.
> 
> Every channel present in adc has an unique conversion formula for
> obtained voltage, suggested by Hardware designers.
> 
> Ex: For die_temp channel., Temp = 2mv/Kelvin Above formula has to be
> applied on obtained voltage in order for the channel to report the
> temperature in milldegC.
> 
> Like wise every channel has unique way of conversion logic suggested
> by HW folks. That conversion logic is done in ADC driver.
If it is linear then ideally expose it as a raw channel and offset + scale.
If non linear then a processed channel with the conversion logic in kernel
as we have no means of describing it to userspace.

> 
>>>>
>>
>>>>>  /*
>>>>> @@ -850,9 +852,9 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
>>>>>
>>>>>          iio_chan->channel = prop.channel;
>>>>>          iio_chan->datasheet_name = vadc_chan->datasheet_name;
>>>>> +        iio_chan->extend_name = child->name;
>>>> What's this change?
>>> We can choose how we want to display our adc channel entries in sysfs. Am using the child node name to be displayed as the sysfs entry rather than channel number for easy interpretation.
>>>
>>> For ex: for vcoin(coin battery voltage channel.,) with this change it appears like below in iio adc sysfs
>>>
>>> "in_voltage_vcoin_input"
>> No.  This introduces a mass of undocumented (and uncontrolled) ABI.
>> If there are reasons to add such a label then it should not be done
>> in the file name.
> 
> "extended_name" is an existing field in "iio_chan_spec" structure,
> present in iio.h(include\linux\iio) and has documentation regarding
> the functionality. Pasting it here for quick reference.> 
>  * @extend_name:Allows labeling of channel attributes with an
>  *        informative name. Note this has no effect codes etc,
>  *        unlike modifiers.

> 
> Am trying to use the existing field here., initializing it with a
> value which is easy for interpretation of channel attributes.
OK. I'd misunderstood what was going on here.  If and only if these
channels are internally linked to a particular voltage / temperature
sensor etc it 'may' make sense.

If they are linked to a hardware monitoring channel then ideally we
would also be mapping them across to hwmon through the iio_hwmon
bridge.
>>>
>>>>>          iio_chan->info_mask_separate = vadc_chan->info_mask;
>>>>>          iio_chan->type = vadc_chan->type;
>>>>> -        iio_chan->indexed = 1;
>>>> Or for that matter this one...
>>> reason explained above.
No they still need to be indexed.  If we ever have events etc
on these channels or want to 'consume' them in other kernel drivers
they need to be indexed.  The strings are not available.  They are
just an convenience in naming of channels (and one I'm kind of
wishing we had never provided as it leads to uncontrolled ABI
explosion like here).

Anyhow, the key thing that wasn't clear in this patch description
and left me confused is that the scaling previously reported was
simply wrong and this was fixing it!

You do have several overlapping changes here which confused matters
further.  This extend_name stuff for example is a different
issue.  Your big problem is that it is an ABI change and hence
a non starter at this point.  Fixing wrong scaling is one thing
but changing the naming of sysfs files like this is not going to
be possible now the driver has been out there for a while.

Jonathan
>>>>>          iio_chan->address = index++;
>>>>>
>>>>>          iio_chan++;
>>>>>
>>>>
>>>
>>> Thanks,
>>> Ramakrishna
>>>
>>> ---
>>> This email has been checked for viruses by Avast antivirus software.
>>> https://www.avast.com/antivirus
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Thanks,
> Ramakrishna

