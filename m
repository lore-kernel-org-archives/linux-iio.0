Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58430 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbGMHp0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 03:45:26 -0400
Message-ID: <55A36C95.6080902@kernel.org>
Date: Mon, 13 Jul 2015 08:45:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Crt Mori <cmo@melexis.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>
Subject: Re: [PATCH 0/1] iio: mlx90614: Implement filter configuration
References: <CAKv63usGO4DxYhx-Sz_BugWmi_ztJF7=ce035Wr1EZw+-wMOfg@mail.gmail.com> <BBC430FE-127C-493F-B3AF-1ED207261F9C@jic23.retrosnub.co.uk> <CAKv63usafKwiLqYA00Fn2dDgmYAaq7VqiS4upwkLEVGqxMa5qQ@mail.gmail.com> <55A15F1C.9040203@kernel.org> <CAKv63us9reCPv295Hn0O2Lhfw+BDcZ=ZypCnbM01UyYxA3aafQ@mail.gmail.com>
In-Reply-To: <CAKv63us9reCPv295Hn0O2Lhfw+BDcZ=ZypCnbM01UyYxA3aafQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/15 22:14, Crt Mori wrote:
> On 11 July 2015 at 20:23, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 08/07/15 21:51, Crt Mori wrote:
>>> On 8 July 2015 at 18:59, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>>>> On 7 July 2015 15:44:51 BST, Crt Mori <cmo@melexis.com> wrote:
>>>>> Implemented FIR and IIR filter configuration which are located
>>>>> within the configuration register of EEPROM. I have used the
>>>>> IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY for FIR settings and
>>>>> IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY for IIR settings just
>>>>> to reuse IIO_CHAN_INFO structure with closes resemblance of the
>>>>> settings (although it would have been better to drop that
>>>>> 3DB_FREQUENCY part).
>>>>>
>>>>> The diff is made towards togreg branch as that branch seems to have the
>>>>> most recent updates of mlx90614 driver
>>>>
>>>> I am having a rather silly week, hence very brief reply from a train. Sorry about that,!
>>>>
>>>> Using existing abi in a non documented way is always a bad idea.  Either work out
>>>> how to fit in with what is there fully or if that isn't possible propose new ABI for
>>>> what you need.
>>>>
>>>> Will have to postpone reading actual code for a few days. Train arrived
>>>>
>>>> J
>>>
>>> Thanks for the comment. I was considering a new ABI, but FIR filter is a LOW
>>> PASS filter (except that it is not on 3dB frequency), while IIR filter
>>> is a HIGH PASS
>>> filter (again not on 3dB frequency). That 3dB frequency on end was
>>> really not well
>>> thought as it is not general enough.
>> It's a standard 'user friendly' description of a filter.  What people care
>> about is roughly where 'most' of the signal is being blocked.  Might not
>> be how a particular data sheet presents it, but it is pretty much the
>> basic standard for filter description.
>>
>> Having looked at the application note provided I can see your challenge
>> in figuring these out!
>>
>> http://www.melexis.com/Assets/Understanding-MLX90614-on-chip-digital-signal-filters-5272.aspx
>>
>> hmm. Don't suppose you have access to what the filter design underneath actually
>> is?  What the tap weights are and number of stages etc? That way we could probably
>> (and I'm stretching back a way to remember how!) compute the frequency response
>> and map it to a vaguely standard form.
> I have, but I rather go with assumption that normal user will just have what
> is presented in datasheet and application note. And there are percentage
> values for IIR filter and binary value combinations coefficients for FIR filter.
I disagree.  The normal USER will not have ready access to either of these.  They
will have some userspace application offering a configuration screen where they
get to pick from some basic filtering controls.  The interface we present to those
userspace applications has to be consistent across all devices (or as much as
we can).  Yes, not all users will know what a 3db frequency is, but then
it is down to the application to decide how to present it.

To use either of thing versions in your datassheet ever application will need
to know about the specific sensor being used and probably every user will need
to actually find and understand the datasheet if they want to change anything.

Datahsheets focus in device integrators  and driver developers.  They are the only
people who commonly read them (and this includes application notes).  We
need to provide a consistent interface across many devices, each with it's own
'unique' description in the datasheet.  This is far from the first device
to need a little bit of maths to compute the values to be presented in the
unified API.

> I have based this on datasheet and that is why adding to ABI (FIR and IIR
> filter) would have made more sense, but like you said - you can probably
> figure it out from application notes as well (at least basic Wikipedia
> answers give you that FIR = low-pass, while IIR = high pass).
Basic being the key word.   FIR and IIR can be used for either type of filter
just fine (and bandpass filters for that matter).

> Crt
>>
>> For others who don't feel like diving into the datasheet, it ispresented
>> in terms of the percentage change seen when the sensor observes an
>> impulse (single very different value given obviously you can't actually
>> observe and impulse with digital sampling if we assume there isn't an
>> effectively analog filter going on as well).
>>
>> Jonathan
>>
>>> But now it is used in quite few
>>> drivers and I
>>> would assume changing that to more general would not be possible?
>> Changing no.  Adding to yes.  If we have filters where more complex
>> description is needed then we extend the abi to cover them.  I'm not
>> convinced that is true here.  What we have is a rather 'unusual'
>> description of a very standard filter form (I think!)
>>> The filter settings are also very specific and require good knowledge
>>> of datasheet
>>> so I assume that enough skilled users will be using it to understand this two
>>> options.
>>>
>>> Once you read the code tell me if you still think it needs a special
>>> ABI  - I prefer
>>> to use already established ABIs as they allow easier hardware changes.
>> I think there is a fairly nasty mapping to be worked out to get the
>> values that correspond to the existing ABI, but I'm yet to be convinced
>> that that ABI isn't capable of providing a useful description of these
>> filters.
>>
>> Jonathan
> Like I said - only the 3dB part is misleading as it would require a lot more
> information to user to find out that it is/is not the limit.

hmm.  No filter has a hard limit in frequency response.  There is a
reason a 3 dB frequency is used pretty universally if you want a single number
for a cut off frequency.  The percentage description is effectively an artefact
of the precise nature of the sampling done by this sensor.  Obviously in the
ideal circumstances, full frequency response graphs would be available, but
they don't map well to kernel interfaces!

I also doubt the sensor has a substantially shorter analog response than it's
maximum sampling frequency allows for.  Hence the chances of actually getting
a well defined single sample event is very very low.


> At the moment
> there is no intention to publish some additional explanations, so I
> would go with what is public at this moment. I think FIR and IIR filter
> descriptions are more proper, because of limited choices, but for
> general public low pass and high pass is much more used. Since
> change levels here are fixed, it does not quite justify the
> low-pass/high-pass combination indeed, but I would still back up
> the patch with current ABI.
If it is really impossible to map these (for whatever reason) then
we may have to user device specific ABI.  I don't want for example
to end up with the percentage stuff in the standard ABI because
it will just confuse matters for filters where we have a more
standard description (ideally a frequency response graph!)

This is done via additional attributes (similar to how the available
attributes are currently handled).  

Whatever we do however, lets not push things through an ABI that
implies they are different to what they are.

Jonathan
> 
> Crt
>>>
>>>>>
>>>>> Signed-off-by: Crt Mori <cmo@melexis.com>
>>>>> ---
>>>>> diff --git a/drivers/iio/temperature/mlx90614.c
>>>>> b/drivers/iio/temperature/mlx90614.c
>>>>> index 909278a..d767d2f 100644
>>>>> --- a/drivers/iio/temperature/mlx90614.c
>>>>> +++ b/drivers/iio/temperature/mlx90614.c
>>>>> @@ -20,7 +20,6 @@
>>>>> * always has a pull-up so we do not need an extra GPIO to drive it
>>>>> high.
>>>>> If
>>>>>  * the "wakeup" GPIO is not given, power management will be disabled.
>>>>>  *
>>>>> - * TODO: filter configuration
>>>>>  */
>>>>>
>>>>> #include <linux/err.h>
>>>>> @@ -79,6 +78,25 @@ struct mlx90614_data {
>>>>>  unsigned long ready_timestamp; /* in jiffies */
>>>>> };
>>>>>
>>>>> +/* Allowed percentage values for IIR filtering */
>>>>> +static const u8 mlx90614_iir_values[] = {50, 25, 17, 13, 100, 80, 67,
>>>>> 57};
>>>>> +
>>>>> +/*
>>>>> + * Find the IIR value inside mlx90614_iir_values array and return its
>>>>> position
>>>>> + */
>>>>> +static inline s32 mlx90614_iir_search(int value)
>>>>> +{
>>>>> + u8 i;
>>>>> + if (value < 0 || value > 100)
>>>>> + return -EINVAL;
>>>>> +
>>>>> + for (i=0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
>>>>> + if (value == mlx90614_iir_values[i])
>>>>> + return i;
>>>>> + }
>>>>> + return -EINVAL;
>>>>> +}
>>>>> +
>>>>> /*
>>>>>  * Erase an address and write word.
>>>>>  * The mutex must be locked before calling.
>>>>> @@ -236,6 +254,31 @@ static int mlx90614_read_raw(struct iio_dev
>>>>> *indio_dev,
>>>>>  *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>>>>  }
>>>>>  return IIO_VAL_INT_PLUS_NANO;
>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR setting */
>>>>> + mlx90614_power_get(data, false);
>>>>> + mutex_lock(&data->lock);
>>>>> + ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>>>>> + mutex_unlock(&data->lock);
>>>>> + mlx90614_power_put(data);
>>>>> +
>>>>> + if (ret < 0)
>>>>> + return ret;
>>>>> +
>>>>> + *val = (ret & MLX90614_CONFIG_FIR_MASK) >>
>>>>> + MLX90614_CONFIG_FIR_SHIFT;
>>>>> + return IIO_VAL_INT;
>>>>> + case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR setting */
>>>>> + mlx90614_power_get(data, false);
>>>>> + mutex_lock(&data->lock);
>>>>> + ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>>>>> + mutex_unlock(&data->lock);
>>>>> + mlx90614_power_put(data);
>>>>> +
>>>>> + if (ret < 0)
>>>>> + return ret;
>>>>> +
>>>>> + *val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK];
>>>>> + return IIO_VAL_INT;
>>>>>  default:
>>>>>  return -EINVAL;
>>>>>  }
>>>>> @@ -263,6 +306,52 @@ static int mlx90614_write_raw(struct iio_dev
>>>>> *indio_dev,
>>>>>  mlx90614_power_put(data);
>>>>>
>>>>>  return ret;
>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* FIR Filter */
>>>>> + if (val < 0 || val > 7)
>>>>> + return -EINVAL;
>>>>> +
>>>>> + mlx90614_power_get(data, false);
>>>>> + mutex_lock(&data->lock);
>>>>> +
>>>>> + /* CONFIG register values must not be changed so we must read
>>>>> + * them before we actually write changes */
>>>>> + ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>>>>> + if (ret >= 0)
>>>>> + {
>>>>> + /* Write changed values */
>>>>> + ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
>>>>> +  (val << MLX90614_CONFIG_FIR_SHIFT) |
>>>>> +  ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))));
>>>>> + }
>>>>> + mutex_unlock(&data->lock);
>>>>> + mlx90614_power_put(data);
>>>>> +
>>>>> + return ret;
>>>>> + case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter */
>>>>> + ret = mlx90614_iir_search(val);
>>>>> + if (ret < 0)
>>>>> + return ret;
>>>>> + /* If there is no error, then we have a sensor equivalent value
>>>>> + * in ret. We need to store it temporary to val, as we still
>>>>> + * have more data to save in ret before we can actually write */
>>>>> + val = ret;
>>>>> +
>>>>> + mlx90614_power_get(data, false);
>>>>> + mutex_lock(&data->lock);
>>>>> + /* CONFIG register values must not be changed so we must read
>>>>> + * them before we actually write changes*/
>>>>> + ret = i2c_smbus_read_word_data(data->client,MLX90614_CONFIG);
>>>>> + if (ret >= 0)
>>>>> + {
>>>>> + /* Write changed values */
>>>>> + ret = mlx90614_write_word(data->client, MLX90614_CONFIG,
>>>>> +  (val << MLX90614_CONFIG_IIR_SHIFT) |
>>>>> +  ((u16) ret & (~(u16) MLX90614_CONFIG_IIR_MASK)));
>>>>> + }
>>>>> + mutex_unlock(&data->lock);
>>>>> + mlx90614_power_put(data);
>>>>> +
>>>>> + return ret;
>>>>>  default:
>>>>>  return -EINVAL;
>>>>>  }
>>>>> @@ -275,6 +364,10 @@ static int mlx90614_write_raw_get_fmt(struct
>>>>> iio_dev
>>>>> *indio_dev,
>>>>>  switch (mask) {
>>>>>  case IIO_CHAN_INFO_CALIBEMISSIVITY:
>>>>>  return IIO_VAL_INT_PLUS_NANO;
>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>>> + return IIO_VAL_INT_PLUS_MICRO;
>>>>> + case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>>>>> + return IIO_VAL_INT_PLUS_MICRO;
>>>>>  default:
>>>>>  return -EINVAL;
>>>>>  }
>>>>> @@ -294,7 +387,9 @@ static const struct iio_chan_spec
>>>>> mlx90614_channels[] =
>>>>> {
>>>>>  .modified = 1,
>>>>>  .channel2 = IIO_MOD_TEMP_OBJECT,
>>>>>  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>> -    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>>>>> +    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>>>>> + BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
>>>>> + BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
>>>>>  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>     BIT(IIO_CHAN_INFO_SCALE),
>>>>>  },
>>>>> @@ -305,7 +400,9 @@ static const struct iio_chan_spec
>>>>> mlx90614_channels[] =
>>>>> {
>>>>>  .channel = 1,
>>>>>  .channel2 = IIO_MOD_TEMP_OBJECT,
>>>>>  .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>> -    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>>>>> +    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>>>>> + BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
>>>>> + BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
>>>>>  .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>>>>>     BIT(IIO_CHAN_INFO_SCALE),
>>>>>  },
>>>>
>>>> --
>>>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>>

