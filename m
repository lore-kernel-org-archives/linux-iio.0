Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH v2] staging: iio: ad7192: implement
 IIO_CHAN_INFO_SAMP_FREQ
To: Jonathan Cameron <jic23@kernel.org>, Michael.Hennerich@analog.com,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
References: <1475308164-3461-1-git-send-email-eraretuya@gmail.com>
 <a1258b09-192c-3870-e7b2-057ceeb1dc62@kernel.org>
 <20161003040045.GB2267@Socrates-DK>
 <3cc1b4d1-b1c9-21f4-8ab1-3672b3aa3845@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3b78d80a-dfa4-1d60-f7d4-e3466d6c8d36@metafoo.de>
Date: Tue, 4 Oct 2016 21:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <3cc1b4d1-b1c9-21f4-8ab1-3672b3aa3845@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/03/2016 09:56 PM, Jonathan Cameron wrote:
> On 03/10/16 05:00, Eva Rachel Retuya wrote:
>> On Sat, Oct 01, 2016 at 12:35:26PM +0100, Jonathan Cameron wrote:
>>> On 01/10/16 08:49, Eva Rachel Retuya wrote:
>>>> This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ attribute
>>>> wherein usage has some advantages like it can be accessed by in-kernel
>>>> consumers as well as reduces the code size.
>>>>
>>>> Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the sampling_frequency
>>>> attribute instead of using IIO_DEV_ATTR_SAMP_FREQ() macro.
>>>>
>>>> Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ() into
>>>> respective read and write hooks with the mask set to IIO_CHAN_INFO_SAMP_FREQ.
>>>>
>>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>>> Given this is heading away from the generic staging fixes and into the
>>> list of specific IIO tasks, please do make sure to cc the linux-iio
>>> list.
>>>
>>> (I'd prefer that for all IIO touching patches - but give that's somewhat
>>> of an oddity for staging I don't really mind that much)
>>>
>>
>> My apologies for that. I will include the linux-iio list in the future
>> revisions and patch submissions. (cc'ing the list now..)
>>
>>> Otherwise, almost perfect, but there is a weird corner in this driver.
>>>
>>> Take a look at what write_raw_get_fmt is set to...
>>> For this write it should return be IIO_VAL_INT;
>>>
>>
>> I had set the return to IIO_VAL_INT already. Can you please point out where
>> else I had missed?
> You return that for the read which is quite correct, the interesting one
> is the write_raw callback change.  Have a bit of a dig into how that knows
> what it is getting (in val and val2).
> 
>>
>>> Lars / Michael, this driver is only a very small distance from being
>>> fine to move out of staging.  I'm basically seeing two bits of
>>> custom ABI that need documenting and review, but otherwise post
>>> this cleanup looks in pretty good state to me.
>>>
>>
>> By any chance, are you referring to these:
>> static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>> 			     in_voltage-voltage_scale_available,
>> 			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
>>
>> static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
>> 		       ad7192_show_scale_available, NULL, 0);
> Those two are actually standard ABI (though there is a long term plan to handle
> the available attributes in a nicer fashion)
> 
> The custom pair are bridge_switch_en and ac_excitation_en,

I've looked at this a while ago and I think the bridge switch should really
be a GPIO, since that is what iti s. At last logically, it's an external pin
that can be on or off. At least logically, it is special physically and
intended to be used for specific function in a measurement applications. It
is capable of sinking a much higher current than the other GPIOs. The only
downside of making it a GPIO is that it is no longer part of the IIO device
and needs to be accessed via other methods which makes some applications
more complicated to implement.

The excitation is a bit different, it controls a circuit that toggles two
external pins in relation to the sampling frequency. They are meant to be
connected to external circuitry that reverses the polarities of the
excitation voltage of the bridge. This is done to remove any onesided bias.

This is a bit more difficult to express in generic API, maybe we could make
it non user controllable for now and enable it unconditionally if it is
connected (reported by either platform data or DT) and otherwise leave it off.
