Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37915 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0K3QGA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Nov 2010 11:06:00 -0500
Message-ID: <4CF52280.2050600@cam.ac.uk>
Date: Tue, 30 Nov 2010 16:12:48 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] staging: iio: dds: ad9834: Enable driver support for
 AD9833 and AD9834 DDS devices
References: <1291045919-11141-1-git-send-email-michael.hennerich@analog.com> <4CF43350.4000703@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771312F081809@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771312F081809@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/30/10 15:20, Hennerich, Michael wrote:
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>> On 11/29/10 15:51, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> staging: iio: dds: ad9834: add missing include file
>>>
>>> staging: iio: dds: ad9834: fix typo
>>
>> Hi Michael,
>>
>> Thanks for this driver and in particular the first thoughts on a
>> suitable abi design for these parts.  There are a few nitpicks
>> in the driver body that will be trivial to cleanup.
>>
>> The abi needs more open discussion. I have inserted a few
>> suggestions here, but I would also like to see it formally
>> proposed as an RFC separate from the driver to linux-iio and
>> lkml. It's a fairly substantial new abi that we want to try
>> and get right. Given similar postings of IIO abi's in the
>> past the lkml posting may fall on deaf ears, but then at least
>> you can use it to bash latecomers over the head with when
>> they disagree with your interface 6 months down the line...
>> It won't help but it always makes me feel better and we might
>> get a few more people who did read it at the time coming
>> in on our side if we are lucky :)
>>
>> Just wait... Someone will want to use a nice general DDS
>> as a clock input for some other part and hence ask about
>> in kernel interfaces...
> 
> Hi Jonathan,
> 
> That's something we can add later.
:) 
> 
>> Thanks,
>>
>> Jonathan
>>
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> ---
>>>  drivers/staging/iio/dds/Kconfig  |   11 +-
>>>  drivers/staging/iio/dds/Makefile |    1 +
>>>  drivers/staging/iio/dds/ad9834.c |  348
>> ++++++++++++++++++++++++++++++++++++++
>>>  drivers/staging/iio/dds/ad9834.h |  108 ++++++++++++
>>>  drivers/staging/iio/dds/dds.h    |   99 +++++++++++
>>>  5 files changed, 565 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/staging/iio/dds/ad9834.c
>>>  create mode 100644 drivers/staging/iio/dds/ad9834.h
>>>  create mode 100644 drivers/staging/iio/dds/dds.h
>>>
>>> diff --git a/drivers/staging/iio/dds/Kconfig
>> b/drivers/staging/iio/dds/Kconfig
>>> index d045ed6..4c9cce3 100644
>>> --- a/drivers/staging/iio/dds/Kconfig
>>> +++ b/drivers/staging/iio/dds/Kconfig
>>> @@ -11,11 +11,18 @@ config AD5930
>>>       ad5930/ad5932, provides direct access via sysfs.
>>>
>>>  config AD9832
>>> -   tristate "Analog Devices ad9832/3/4/5 driver"
>>> +   tristate "Analog Devices ad9832/5 driver"
>>>     depends on SPI
>>>     help
>>>       Say yes here to build support for Analog Devices DDS chip
>>> -     ad9832/3/4/5, provides direct access via sysfs.
>> This is somewhat 'interesting'.  Please add to commit comment to say
>> whether this change was due to only partial support existing in the
>> 'old' driver or if it never worked in the first place for these
>> parts.
> 
> Actually support for the ADP9833/34 never existed in the AD9832 driver.
...
>>> +   struct iio_dev *dev_info = dev_get_drvdata(dev);
>>> +   struct ad9834_state *st = dev_info->dev_data;
>>> +   int ret;
>>> +
>>> +   mutex_lock(&dev_info->mlock);
>> Use the sysfs_streq instead for these? (avoids possible white
>> space issues etc).
> 
> Thanks - sysfs_streq is much better.
I only came across that one whilst reviewing someone elses
code the other day.  Very handy little function.
...
>>> +static const struct spi_device_id ad9834_id[] = {
>>> +   {"ad9833", ID_AD9833},
>>> +   {"ad9834", ID_AD9834},
>> I don't think you ever use the enum values. If you don't
>> and there is not likely to be a need anytime soon, it
>> would be a little cleaner not to specify them. That
>> would make it clear the parts are identical as far as the
>> driver is concerned.
> 
> The AD9833 is a bit different from the AD9834.
> In the patch I'm going to send out shortly device_id is used
> in a few places.
That's fine then.
 


...
>> Good to see so much documentation. I would ask that this also exists
>> in the Documentation directory. Given there is so little overlap in
>> attributes between this and our existing elements, it probably makes
>> sense to add a new file called something like sysfs-bus-iio-dds.
> 
> I'll create this file after posting the RFC.
> I don't want to update more or less the same documentation, in multiple
> places.
Sure. I'd personally separate out the docs from here into the file
and base the discussion on that.  We don't currently have anywhere near
this good a set of docs in the headers for the other types whereas
we do have fairly thorough documentation files and they may come up
in the discussion.
> 
>> I also think this interface is worth posting (in that form) as an RFC
>> to
>> lkml. Note Greg just merged a big cleanup of the existing docs so that
>> should be in linux-next etc tomorrow.
> 
> Shall I just post the dds.h file as patch?
Could do, though then I suspect most of the discussion will be about the
implementation rather than the actual abi. It would probably be easier
to do it with a straight documentation file perhaps with the dds.h
and the driver provided as later elements of the series (basically
as an example of use),
> 
>> I am going to read this pretty much without referring to the datasheet
>> so as to see how it might read to someone coming in with a different
>> dds device.
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/freqX
>>> + * Description:
>>> + * Stores frequency into tuning word register X.
>>> + * There can be more than one freqX file, which allows for pin
>> controlled FSK
>>> + * Frequency Shift Keying (en_pincontrol is active) or the user can
>> control
>>> + * the desired active tuning word by writing X to the en_freq file.
>>> + */
>>> +
>>> +#define IIO_DEV_ATTR_FREQ(_num, _store, _addr)
>>       \
>>> +   IIO_DEVICE_ATTR(freq##_num, S_IWUSR, NULL, _store, _addr)
>>> +
>> Do we need a base name for these? If we have a device that combines a
>> dds
>> element with other IIO elements things could get rather confusing. This
>> is
>> also true if we have a single device with multiple dds channels
>> (perhaps
>> a more common situation).
> 
> Good catch, in fact there is a quad channel device, featuring 4 independent dds outputs.
> 
>> Perhaps somthing like...
>>
>> ddsX_freqY
>> ddsX_freq_en
>> ddsX_phaseY
>> ddsX_phase_en
>> ddsX_phase_scale
>> ddsX_phaseY_scale
>> ddsX_phase_en
> 
> Looks good!
> 
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/freq_en
>>> + * Description:
>>> + * Specifies the active output frequency tuning word.
>>> + * To exit this mode the user can write pincontrol_en or disable
>> file.
>>> + */
>> Based on the description I didn't really follow this one.
>> Looking at what the code does, it's a simple input for of the current
>> FSK symbol?
> 
> Yes - writing this file selects the frequency tuning word.
> It basically overwrites the pin control mechanism.
> This can be useful when pin control is not used, and you alternatingly update
> dds0_freq0 and dds0_freq1 with new values. The chip then ensures that the new
> frequency value get's updates during the zero cross. Which avoids a lot of
> unwanted distortions.
> 
>> _en is not a good name for it.  I'd go with ddsX_freqsymbol or
>> something like
>> that. The value then corresponds to the Y in ddsX_freqY.
> 
> ok
> 
>>> +
>>> +#define IIO_DEV_ATTR_FREQ_EN(_store, _addr)                                \
>>> +   IIO_DEVICE_ATTR(freq_en, S_IWUSR, NULL, _store, _addr);
>>> +
>>> +#define IIO_CONST_ATTR_FREQ_SCALE(_string)         \
>>> +   IIO_CONST_ATTR(freq_scale, _string)
>> This should probably be under the freqX element as that is what it
>> applies
>> to. I'd like to see some explanation.
> 
> Added
> 
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/phaseX
>>> + * Description:
>>> + * Stores phase into phase register X.
>>> + * There can be more than one phaseX file, which allows for pin
>> controlled PSK
>>> + * Phase Shift Keying (en_pincontrol is active) or the user can
>> control
>>> + * the desired phase X which is added to the phase accumulator
>> output
>>> + * by writing X to the en_phase file.
>>> + */
>>> +
>>> +#define IIO_DEV_ATTR_PHASE(_num, _store, _addr)
>>       \
>>> +   IIO_DEVICE_ATTR(phase##_num, S_IWUSR, NULL, _store, _addr)
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/phase_en
>>> + * Description:
>>> + * Specifies the active phase which is added to the phase
>> accumulator output.
>>> + * To exit this mode the user can write pincontrol_en or disable
>> file.
>>> + */
>>> +
>> These have the same questions as above for frequency.
>>> +#define IIO_DEV_ATTR_PHASE_EN(_store, _addr)                               \
>>> +   IIO_DEVICE_ATTR(phase_en, S_IWUSR, NULL, _store, _addr);
>>> +
>>> +#define IIO_CONST_ATTR_PHASE_SCALE(_string)                \
>>> +   IIO_CONST_ATTR(phase_scale, _string)
>>> +
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/pincontrol_en
>>> + * Description:
>>> + * The active frequency and phase is controlled by the respective
>>> + * phase and frequency control inputs.
>>> + */
>>> +
>>> +#define IIO_DEV_ATTR_PINCONTROL_EN(_store, _addr)                  \
>>> +   IIO_DEVICE_ATTR(pincontrol_en, S_IWUSR, NULL, _store, _addr);
>> Is it just about plausible we will get a device with separate pin
>> control
>> for phase and frequency? (I really don't know much about these devices
>> ;)
> 
> Yes that's the fact. There are even parts without pin control.
> 
>> If so that naming should allow for it.  Perhaps you are allowing for
>> it here and the specific ones would be
>> ddsX_pincontrol_phase_en
>> ddsX_pincontrol_freq_en
>> or
>> dds_pincontrol_en for one that covers all channels and both phase and
>> frequency?
> 
> That's it.
> 
>>
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/disable
>>> + * Description:
>>> + * Disables any signal generation, the output is set to midscale
>> Is the midscale a feature of this part of absolutely general? i.e. do
>> we want to enforce this by documentation or allow for some flexibility
>> (and a means to specify if it is something else?).
> 
> AFAIK the midscale thing is pretty common.
> But there might be parts that shut down the output completely.
> I'll better remove this comment.
Either that or add another attribute that tells you what value
is when shut down.
> 
> 
>>> + */
>>> +
>>> +#define IIO_DEV_ATTR_DISABLE(_store, _addr)                                \
>>> +   IIO_DEVICE_ATTR(disable, S_IWUSR, NULL, _store, _addr);
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/signbit_output_en
>>> + * Description:
>>> + * Enables an auxiliary square wave output
>>> + */
>>> +#define IIO_DEV_ATTR_SIGNBIT_OUTPUT_EN(_store, _addr)
>>               \
>>> +   IIO_DEVICE_ATTR(signbit_output_en, S_IWUSR, NULL, _store, _addr);
>> How standard is this?
> 
> Only a few devices feature this, maybe remove from dds.h and just have it in the driver?
I'd prefer to see it handled as described below as I think that will generalize
reasonably well to similar situations.
> 
>> Can we make it look more general. See next
>> comment.
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/output_mode
>>> + * Description:
>>> + * Specifies the output waveform.
>>> + * For a list of available output waveform modes read
>> available_output_modes.
>>> + */
>>> +#define IIO_DEV_ATTR_OUTPUT_MODE(_store, _addr)
>>       \
>>> +   IIO_DEVICE_ATTR(output_mode, S_IWUSR, NULL, _store, _addr);
>> ddsX_waveform (or perhaps wavetype)  seems more descriptive to me.
>> Output mode
>> could cover a whole host of things!
>>
>> dds0_wavetype (sine, triangle, square)
> 
> Makes sense.
> 
>> From a generalization point of view we don't care that the square wave
>> is a
>> random bonus option the part happens to be able to kick out.  Ideally
>> we
>> want a naming scheme that makes it's relationship to the other
>> waveforms
>> apparent though and it's not entirely obvious how to handle that (e.g.
>> how to handle the double frequency square wave this part can produce).
>> Things will get more fun if parts have multiple outputs tied to one dds
>> channel.
> 
> Actually that's the case here on the AD9834. The signbit is an independent
> output. It therefore can't be handled with the dds0_wavetype file.
Then have dds0_wavetype0 (sine triangle) and dds0_wavetype1 (square).
Document that the second index is only required if there are multiple physical
outputs from a given channel.

> It can be enabled/disabled while the DDS generates a sine wave on the main output.
> 
> On the AD9833 the signbit square wave feature is routed to the DDS main output.
Then that part just has the dds0_wavetype (triangle sine square) as suggested above.
> 
>> I'd also like to see the docs including the current options and a
>> description
>> of each. It's fairly obvious for those we have here, but there are
>> going
>> to be less simple cases in future!
> 
> Will add docs once we all agree on the userspace abi.
Sadly the docs are what is needed for people to understand the proposed
abi.  However we also need to see code for the more complex stuff to
understand how it actually works.  Hence I think the ideal here is
a series to LKML with

[RFC 1/3] IIO: Direct digital synthesis abi documentation
[RFC 2/3] IIO:dds.h convenience macros
[RFC 3/3] IIO:DDS:ad9833 / ad9834 driver

Obviously that adds some work, so you could probably get away with merging
the first two as long as absolutely everything in the header is documented.

> 
>>> +
>>> +/**
>>> + * /sys/bus/iio/devices/deviceX/available_output_modes
>>> + * Description:
>>> + * Lists all available output waveform modes
>>> + */
>>> +#define IIO_CONST_ATTR_AVAILABLE_OUTPUT_MODES(_modes)
>>       \
>>> +   IIO_CONST_ATTR(available_output_modes, _modes);
> 
> 

