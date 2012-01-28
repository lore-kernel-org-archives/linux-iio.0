Return-Path: <jic23@cam.ac.uk>
Message-ID: <4F23C1DA.4020009@cam.ac.uk>
Date: Sat, 28 Jan 2012 09:37:30 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marek.vasut@gmail.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Wolfram Sang <w.sang@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, Wolfgang Denk <wd@denx.de>,
 Peter Rusko <rusko.peter@prolan.hu>,
 Stefano Babic <sbabic@denx.de>, Sascha Hauer <kernel@pengutronix.de>,
 linux-iio@vger.kernel.org
Subject: Re: [RFC] IIO LRADC for mach-mxs
References: <201201241408.08083.marek.vasut@gmail.com> <201201261130.01130.marek.vasut@gmail.com> <4F21C5A8.8010407@kernel.org> <201201272244.34136.marek.vasut@gmail.com>
In-Reply-To: <201201272244.34136.marek.vasut@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/27/2012 09:44 PM, Marek Vasut wrote:
>> On 01/26/2012 10:30 AM, Marek Vasut wrote:
>>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> On Jan 24 2012, J.I. Cameron wrote:
>>>>>>> On Jan 24 2012, Wolfram Sang wrote:
>>>>>>>> On Tue, Jan 24, 2012 at 02:08:07PM +0100, Marek Vasut wrote:
>>>>>>>>> Hi guys,
>>>>>>>>>
>>>>>>>>> I've been playing with a custom mxs board recently and I'd like
>>>>>
>>>>> to
>>>>>
>>>>>>>>> tinker with ADC. Well, apparently there was some effort but it
>>>>>
>>>>> died
>>>>>
>>>>>>>>> silently.
>>>>>>>>>
>>>>>>>>> Now, there are two approaches how to go about the MXS IIO LRADC.
>>>>>>>>> Firstly though, here are some hw details:
>>>>>>>>>
>>>>>>>>> 1) The ADC has 16 channels in total, some dedicated to particular
>>>>>>>>> function 2) The ADC can sample only up to 8 channels at the same
>>>>>
>>>>> time
>>>>>
>>>>>>>>> 3) The ADC delay triggers can trigger only up to 4 kinds of
>>>>>
>>>>> sampling
>>>>>
>>>>>>>>> for those up to 8 selected channel
>>>>>>>>>
>>>>>>>>> So how should we go about this:
>>>>>>>>>
>>>>>>>>> A) Implement functions, to configure and select a channel at
>>>>>
>>>>> probe-time
>>>>>
>>>>>>>>> and then never allow (at runtime) different channel to be
>>>>>
>>>>> selected.
>>>>>
>>>>>>>>> + Channel configuration is static, passed via plat_data
>>>>>>>>> + The channels don't need to be reconfigured => when data are
>>>>>
>>>>> demanded,
>>>>>
>>>>>>>>> the channel doesn't need to be reconfigured (if it's not
>>>>>
>>>>> configured in
>>>>>
>>>>>>>>> one of those 8 options) and the user doesn't need to wait for
>>>>>
>>>>> data.
>>>>>
>>>>>>>>> - Only 8 channels can be used
>>>>>>>>>
>>>>>>>>> B) Allow channel to be configured on-demand -- when it's value is
>>>>>>>>> requested, it is configured (if it's not already) for the
>>>>>
>>>>> particular
>>>>>
>>>>>>>>> function.
>>>>>>>>>
>>>>>>>>> + All 16 channels can be used
>>>>>>>>> - It's clunky and fragile to breakage
>>>>>>>>> - It's hard to implement good channel replacement algo
>>>>>
>>>>> (replacement as
>>>>>
>>>>>>>>> on the delay triggers and on those 8 slots)
>>>>>>>>>
>>>>>>>>> Which way do you consider better ?
>>>>>>>>
>>>>>>>> CCing Jonathan and the iio-list (as found in MAINTAINERS). They
>>>>>
>>>>> probably
>>>>>
>>>>>>>> have more experience regardings those scenarios?
>>>>>>>
>>>>>>> Thanks Wolfram,
>>>>>>>
>>>>>>> My instinct is always to make anything configurable at runtime where
>>>>>
>>>>> we
>>>>>
>>>>>>> can even vaguely conceive of a reason it might be useful.
>>>>>>>
>>>>>>> Having said that, right now special function (e.g. input, hwmon
>>>>>
>>>>> directed
>>>>>
>>>>>>> channels) are currently set up via board files (will be device tree
>>>>>
>>>>> the
>>>>>
>>>>>>> moment anyone has a need).  I doubt there are many usecases where
>>>>>
>>>>> you'd
>>>>>
>>>>>>> want to change these functional elements.
>>>>>>>
>>>>>>> For your channel replacement strategy these special function
>>>>>
>>>>> channels will
>>>>>
>>>>>>> be in use if the client is reading form them (e.g. triggered usage).
>>>>>
>>>>> In
>>>>>
>>>>>>> IIO we only allow for triggering a whole set of channels off a given
>>>>>>> trigger.  It's going to get really ugly otherwise.  Perhaps the
>>>>>
>>>>> following
>>>>>
>>>>>>> will work? (I am assuming 0-8 channels can be associated with any of
>>>>>
>>>>> the
>>>>>
>>>>>>> 4 triggers subject to the condition that the total number of
>>>>>
>>>>> channels
>>>>>
>>>>>>> being captured is less than 8).
>>>>>>>
>>>>>>> Register 4 iio devices, each with all 16 channels.  Associate one
>>>>>
>>>>> with
>>>>>
>>>>>>> each of the triggers.  Driver then maintains a count on channels
>>>>>
>>>>> enabled
>>>>>
>>>>>>> and refuses to enable more than 8 whatever happens.  You don't have
>>>>>
>>>>> a
>>>>>
>>>>>>> replacement strategy, you simply refuse to have too many.  We
>>>>>
>>>>> already do
>>>>>
>>>>>>> this for some of the devices with strange possible channel sets.
>>>>>>>
>>>>>>> Any in kernel users (hwmon, input etc) will have to be configured to
>>>>>
>>>>> use
>>>>>
>>>>>>> the iio device associated with the right trigger.
>>>>>>>
>>>>>>> Does that do the job for you?
>>>>>>>
>>>>>>> The reason for associating the triggers with different iio devices
>>>>>
>>>>> is that
>>>>>
>>>>>>> a given iio device can only feed a fixed width scan to the demux
>>>>>
>>>>> unit.
>>>>>
>>>>>>> Hence if we have some channels triggering at one time and others at
>>>>>>> another, there is no way of handling the data stream.  Whilst they
>>>>>
>>>>> are on
>>>>>
>>>>>>> the same hardware they are really acting as separate devices that
>>>>>
>>>>> just
>>>>>
>>>>>>> happen to share some pins and control hardware.
>>>>>>>
>>>>>>> (Note I'm being useless and not pushing out the new version of in
>>>>>
>>>>> kernel
>>>>>
>>>>>>> IIO stuff, but I should get to that at the weekend if not before -
>>>>>
>>>>> one
>>>>>
>>>>>>> fiddly issue with preventing removal of in use devices still to work
>>>>>>> out.).
>>>>>>
>>>>>> Yikes. This device is more complex than I thought.  The 'triggers' as
>>>>>
>>>>> above
>>>>>
>>>>>> can also trigger each other alongside causing a set of channels to be
>>>>>> captured.
>>>>>>
>>>>>> I don't think this changes the logic behind my above answer, but it
>>>>>
>>>>> does
>>>>>
>>>>>> mean you are going to have some trouble coming up with a control
>>>>>
>>>>> interface
>>>>>
>>>>>> for the triggers. This may need some core changes to allow for a
>>>>>
>>>>> graph of
>>>>>
>>>>>> triggers setup (it's not even restricted to a tree).  To illustrate.
>>>>>> Trigger 1 can fire after T1 secs.  That can then start any other
>>>>>
>>>>> trigger
>>>>>
>>>>>> (including restarting it's own count down) and/or cause channels to
>>>>>
>>>>> be
>>>>>
>>>>>> sampled.  Lets say it starts trigger 2 and not itself.  Trigger 2
>>>>>
>>>>> then
>>>>>
>>>>>> fires after T2 seconds and starts up Triggers 1 and 3. etc...
>>>>>>
>>>>>> sometimes I think hardware designers go out of their way to make
>>>>>
>>>>> general
>>>>>
>>>>>> purpose software design really really tricky...
>>>>>
>>>>> Hi Jonathan,
>>>>>
>>>>> let's not overcomplicate things. Let's do it like this:
>>>>>
>>>>> 1) Register 4 IIO devices
>>>>> 2) Each device has one delay trigger
>>>>> 3) Each delay trigger can be reconfigured only if it is not used by any
>>>>> channel
>>>>> (meaning that on that particular IIO, no channel is opened)
>>>>> 4) We well allow only 8 channels in total
>>>>> 5) Each IIO will have to have attributes -- how many samples it should
>>>>> do, how
>>>>> long between them
>>>>>
>>>>> Are there some utils to test the IIO? Other than sysfs, which won't
>>>>> allow me to
>>>>> try continuous sampling of multiple channels.
>>>>>
>>>>> M
>>>>
>>>> Yes. See the documentation directory. Your plan sounds sensible.
>>>
>>> All right. Also, what did you mean by wiring touchscreen and such? I
>>> assume I'd rather think about it in the design too, but how should I go
>>> about it?
>>
>> There are two elements to this.  Pull devices (hwmon type - basicallyl
>> polled from userspace) and push device (off trigger).
>>
>> The connection infrastructure is the same either way.  A version was
>> reasonably widely reviewed but picked up some last minute comments that
>> I have addressed in my dev tree but not pushed out more publically
>> (small issue with order of module removal causing seg faults I need to
>> chase down).
>>
>> Anyhow, discussion wise...
>>
>> https://lkml.org/lkml/2011/10/20/103
>> http://www.spinics.net/lists/linux-iio/msg03930.html
>>
>> Code wise, if you want to see the latest I just tend to hide my dev
>> trees under odd names on kernel.org currentlly see.
>> http://git.kernel.org/?p=linux/kernel/git/jic23/iio.git;a=shortlog;h=refs/h
>> eads/inkern-staging3
>>
>> To outline briefly the current form (after working on Greg KHs
>> comments). (pretty similar to regulators).
>>
>> In board file (or device tree - not implemented yet) platform data
>> describing the consumers of channels on a given iio device is
>> provided as an array of
>>
>> struct iio_map {
>> 	const char *adc_channel_label;
>> 	struct device *consumer_dev;
>> 	const char *consumer_dev_name;
>> 	const char *consumer_channel;
>> };
>>
>> The driver then passes and a pointer to the associate iio_device
>> to the core.
>>
>> Lets take the more complex triggered capture case.
>>
>> A consumer asks the iio_core for all iio_maps that match it (can request
>> individual ones of course).
>>
>> This causes a new buffer to be inserted into a list that are fed
>> by a demux unit into which data goes directly from the chip.
>> This buffer is alongside any 'iio' buffers that are using the same
>> part (and may contain some of the same channels).
>>
>> It simply calls a callback function provided by the consumer passing
>> in a block of data matching one set of channels as requested by the
>> consumer.
>>
>> Example in the tree mentioned above is a half written iio->input
>> bridge.   We had some brief discussions a while back about how to
>> handle the extra weirdness that touchscreen adcs use and didn't
>> reach any firm conclusions IIRC.
>>
>> I'd imagine you'll need to expand some elements of this to support
>> your usecase.  For starters there is no inkernel control of trigger
>> parameters at the moment.
>>
>> All comments welcome.  I'll hopefully get a few mins to get the
>> pull interface stuff out shortly then we can start hammering the
>> push interface bit and for real fun how to combine the two.
> 
> Jonathan ... I'm getting seriously lost in this stuff. Basically:
> 
> 1) Are there any userland utilities at all to test the IIO ? If so, where?
yes, drivers/staging/iio/Documentation/generic_buffer.c

> 2) I can't do anything if I don't understand how whole this IIO works at all 
> and/or how to use it with my hardware.
> 
> So I'm still trying to wrap my head around this.
> 
> Considering my hardware can do the oversampling (sum of 1 - 32 samples 12bit 
> samples), where the end of sampling causes an interrupt. I need to add 
> attributes to each of those four IIO devices I created to control this 
> oversampling (setting how many times it should be oversampled and what's the 
> delay inbetween the sampling?)
Oversampling is something we don't currently have controls for in the
core.  However, we could just have a single 'trigger' - in this case the
dataready interrupt push multiple scans (set of channels sampled at more
or less the same time) into the  buffer rather than just the one.
The oversampling becomes a parameter of the trigger not the channel.


> 
> Or that's what that "trigger" stuff is for ?
There are effectively two types of triggers.  Those that cause the data
to be grabbed and those that indicate that it has been grabbed.
These are treated in much the same way as they both result in data being
pushed into the buffers.  Also it can often make sense to use the
dataready signal to start capture on other devices.

Anyhow in summary for a dataready type case as here:

1) Set up the 'scan' elements - what data is going to be captured.
2) Start up the buffer - this will also enable the 'trigger' -here a
dataready signal.
3) Data ready interrupt triggers an irq demux (irq chip).  Anything that
should happen on this interrupt uses an interrupt that it is in turn
triggered by this real data ready signal.
4) Top halves of those interrupts grab timestamps or set a physical
trigger signal.
5) Bottom halves read data from the devices attached to this trigger
(which may or may not be the physical hardware providing it).
6) These threaded bottom half handlers then call iio_push_to_buffers
(Here you will I think end up calling this once per oversample).
7) This push to buffers then passes each scan of data through a demux
that rebuilds the scans as requested by all attached buffers.
8) One attached buffer is either a kfifo or our own ring buffer (going
away soon I hope).  The other buffers are for client drivers else where
in the kernel (e.g. input).
9) Any userspace code polling or selecting on the chrdev associated with
the iio_device will wake up and read the data.,
10) The userspace code uses the sysfs description of the data to figure
out what the scan contains and convert it into what ever form is desired.

> 
> Further question:
> 3) If I want to sample two channels continuously, is there any tool that'll 
> allow me to do it ? Or do I need to write such tool? (This is complementary to 
> question #1).
A few minor changes to the example stated above would allow that.
Basically remove the limit on how many times it reads the buffer and
do the relevant setup of channels via writes to the relevant sysfs
interfaces.
> 
> Thanks
> 
> M
>>
>> Jonathan
>>
>>> Let the
>>> iio driver be a composite device that in turn registers another (input)
>>> device? Or simply put the touchscreen driver input drivers/input/ and
>>> export some calls from the IIO driver to allow the touchscreen driver
>>> somehow bind with it?
>>>
>>> M
