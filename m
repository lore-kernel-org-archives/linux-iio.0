Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58823 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdBDMPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:15:41 -0500
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell> <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell> <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
 <20170127171746.lf2nbpsaqs3dmy44@dell>
 <3810896b-c982-e9fd-b095-658921422855@kernel.org>
 <80a4e7f9-b972-599c-198a-f05c1713123c@metafoo.de>
 <7a8c7674-5c02-a58c-de7b-bd9caf15cfb4@metafoo.de>
 <2e6c07cb-f67b-64ff-530b-6bc2073272a9@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d33c57fa-7ff7-02f9-dcbc-8cba7d6328af@kernel.org>
Date: Sat, 4 Feb 2017 12:15:39 +0000
MIME-Version: 1.0
In-Reply-To: <2e6c07cb-f67b-64ff-530b-6bc2073272a9@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 11:13, Arnaud Pouliquen wrote:
> Hello,
> 
> Thanks everyone for you feedback!
> My comments below.
> 
> On 01/29/2017 03:34 PM, Lars-Peter Clausen wrote:
>> On 01/29/2017 03:19 PM, Lars-Peter Clausen wrote:
>>> On 01/29/2017 01:28 PM, Jonathan Cameron wrote:
>>> [...]
>>>>>> Jonathan, Mark, Please could you share your opinion on this topic?
>>>> Hmm - based on a fairly quick read through of the code (which is never
>>>> ideal!). I can see that the ideal would indeed be as Lee says, to
>>>> expand the IIO interfaces sufficiently to support what you need.
>>>>
>>>>
>>>> So, reading the code (fairly quickly I'm afraid as had a lot of reviews
>>>> to catch up on this weekend).
>>>> What we need:
>>>> 1) DMA support in the ADC driver.  This would be a good anyway!
>>>> 2) DMA consumer support - I defer to Lars for comments on this.
>>>> 3) Means of describing and controlling the sinc filters applied. 
>>>> 4) Appropriate channel support.  I'm not convinced that it doesn't make
>>>> sense to have IIO channels for the microphones - at least in a streaming
>>>> mode.  It's data - I don't really care what ;)
>>>> Coarsely it's a filtered pulse per period counter which is
>>>> a perfectly valid type to have a channel for.
>>>>
>>>> The big question to my mind is the DMA consumer support. How would
>>>> it work. It it wouldn't this is somewhat of a non starter.
>>>>
>>>> To bring up another slightly ugly MFD case where it is borderline
>>>> on whether an MFD makes sense (just as a reference point of something
>>>> we have discussed a few times before)
>>>>
>>>> ADCs with features directed at touchscreen support.
>>>> These are odd as the ADC bit is generic, but the specific output
>>>> and read sequences used for touchscreen reading don't correspond to
>>>> anything that makes any real sense for other applications.
>>>>
>>>> We have started to get hybrid drives that have an MFD underneath but
>>>> do the ADC reads through IIO consumer interfaces, and the timing
>>>> control from a touchscreen driver.  We haven't really gotten this
>>>> one right yet either.
>>>>
>>>> Here however, to my mind things are different - as I read it
>>>> (and feel free to point out what I'm missing), the sound usecase
>>>> is just a question of setting up sampling frequencies and filters
>>>> appropriate to the microphones and what ASoC expects?
>>>>
>>>> That's not to say the IIO dma stuff is flexible enough (yet) to
>>>> handle the data flows, but perhaps we can work towards that.
>>>
>>> Yeah, so this is a bit different, but not unexpected. And I'm sure we'll see
>>> more similar hardware in the future. I've talked about this before[1], the
>>> cost structure of creating and manufacturing new hardware drives the design
>>> in a certain direction so that we end up with general purpose hardware that
>>> suddenly has applications in multiple frameworks that were previously fully
>>> orthogonal.
>>>
>>> This device is certainly not a multi-function-device. It only has one
>>> function, it's a sigma-delta demodulator. It is rather a
>>> multi-purpose-device. It can be used for sigma-delta demodulation in audio
>>> applications as well as more specialized data capture applications.
>>>
>>> It's comparable to something like a GPIO that can be used to control a reset
>>> pin or turn on and off a LED. The GPIO chip is not considered
>>> multi-function-device though, even though it can be used for many different
>>> applications.
>>>
>>> As for DMA we already have a lot of DMA infrastructure on the audio side and
>>> we probably want to reuse that rather than inserting IIO as a middle layer
>>> since audio buffer capture as different requirements from IIO buffer and
>>> we'd have to go the route of the least common denominator and loose
>>> expressibility in the process.
>>>
>>> I've created a IIO buffer[2] that does not capture data to memory but is
>>> only used to enable/disable the data capture process. We use this in setups
>>> where the data is passed from the converter to a application specific
>>> processing chain without ever going through system memory. This buffer could
>>> probably also be used here on the audio side to control the converter state.
>>
>> I forgot to mention. I think the first thing we should do is work on
>> terminology. This is not an ADC, this is a configurable low-pass-filter.
>>
>> It works in conjunction with a analog frontend (ADC) that produces a 1-bit
>> pulse-density-modulated stream, takes that stream and converts it into N-bit
>> PCM samples. The PCM samples are generated at a fraction of the PDM stream
>> samplerate that corresponds to the decimation factor.
>>
>> This is not an unusual device. Many audio CODEC and audio controllers
>> contain such a core as well as most SigmaDelta converters supported by IIO.
>> What is special about this part is that it is a dedicated core that is not
>> embedded in some other hardware component. This creates greater flexibility,
>> but of course also greater complexity that is required to manage all that
>> flexibility.
>>
>> We shouldn't codify anything about the kernel internal frameworks through
>> which the device might be exposed into the devicetree. We should accurately
>> describe the hardware (including the analog frontend) and then create a
>> appropriate software structures to handle them.	
>>
> 
> So if everyone is aligned, i will abandon the MFD driver and try to bind
> an ASoC driver on IIO interface. The "challenge" is to
> define appropriate relation ship between ASoC and IIO...
> 
> In a first step, a lot of question to answers and points to clarify... i
> will reply to associated mails.
> 
> Then I see two main topics to clarify:
> 	- DFSDM integration in IIO in a generic way. Lars, if i well interpret,
> your proposal should be to introduce front-end and filter notions in
> IIO, to support this kind of hardware?
> 	- DMA engine for audio purpose.
> I propose to come back with RFC for both subjects.
> 
> If you want to have more detail on DFSDM: DFSDM datasheet is included in
> STM32F413 datasheet available here:
> http://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/81/ea/88/1f/97/9e/4a/d0/DM00305666/files/DM00305666.pdf/jcr:content/translations/en.DM00305666.pdf
> 
> DFSDM Block diagram p 384
Sounds like a sensible way forward to me.

Might well go through a few more rounds before we get this right, but
I agree with Lars that this looks to be something we are going to meet
more and more in the future so would be excellent to get it right!

Jonathan
> 
> Regards
> Arnaud
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

