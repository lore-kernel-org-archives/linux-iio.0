Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC728467D
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913679; cv=none; b=W0FdlLGOyQ1m24hCLIrirXNh1NLnWWGEeFwjX4ROIKJmLtQwg2t4PPBVKC/XIgQbTY4Cow12w+DNRmKJBk/gcJ9ay1ookImxRj1oUlEzPnjGj80ZdDzS55vcGCXorpHhHAenWJbVArDxt4nOJlN/vRdBIrP1EGflgAwUG6vByTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913679; c=relaxed/simple;
	bh=/tblmHC0qFx3bZgRPBeuZnTj16yfQaND1dxQ/YjVEOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCN7FN22xw51D2zLfK1QUoKpQGbT5flKlsPGOUKXPuGdtga3AJHFOrY0JZYMjfvYnoORXa7MqKnkQrUNni0sr6vb90+g1ZWmeN2MAc3HHzCta3y6eEPoAPjAfZwKur4uiZVyWonU5WbgRTHwFnhFhEEwWVreih2DWPAII0pUffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CUVqQBeD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CUVqQBeD"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d738fe814cso805951a34.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772913676; x=1773518476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/obXvNTnckFfznBxBFuvNB61WXeXpSfrS4gLNDCRiQ=;
        b=CUVqQBeDCMyY3Pgg1aU2W49JwsJsAEOWJIiWirvq+X4EmPYmPdVrFt7XISN5zRQimO
         KhR8JYqKGjDbiiHL9ghvXBTRHZ8H8RrnGYjwQjCMERzVhZMGL6GKTGJaEmQ0JZIzWHz6
         y8GWE1S7s7KZCEZ8emFZSxiv18rOfXmUR6UGF/ZyR3c218BOtEnTnipolaDLOeaQYtJn
         elWuhojplmdzYKFvpJIfs4hhlA4WekBmI3ot/ljh5XKA41VO3m2q4vWFXVNst5Pdv5m2
         NF7lBvgaBeXDB14Dj3TQCc+2bKTLbTYuR3reaXxEVmc2JUCUcgBFOr1PEqnp3wy9TK5e
         ho3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772913676; x=1773518476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/obXvNTnckFfznBxBFuvNB61WXeXpSfrS4gLNDCRiQ=;
        b=k8MQvkJu4jEhmgNyEAAj8GMM9cBpd3B4djYllrCtjhScOZz9jf3hVrgbaEl0KXKIQ3
         YKpV1YT1OtcoXmj2cmRgMDERQBvoWV7ODg6PuTmxEkeQh/tezIk7wMQKAHf7OATSSpjR
         XsOnnQk+unck/+VNUvL18QMa5+m4SJJaL0Dx7LwS7nqgC1FFvNQAx+JrbSTqPtZcxuyV
         FcJDXHJMvt+K5LXxf740Sg30okQ11bRFpmL5V9k22qZ2LTgv9aJAN8QlIKGxmJW29r4T
         lV/6qWpaFwsJDUO1tFrhTsCZfdonM1qwBDgKVD0QnUsWtlGl5hLwYhr8v+eGltGbTd90
         VJfw==
X-Forwarded-Encrypted: i=1; AJvYcCUQGavTFPwRL5nMUs+gkXxfJvet5OCniSiK9kaEp0R1Zffw9KfW0fDrL1V3qrCgsImaLEGerKX8+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnakAMgaV3AUd+gBiuWburd/hrbBwgzQt1KoBf1OUX7a3y3K/
	JqQlameSlsiMoD61pjbcedbY9nzPg8Fbx9OlJGJjhUH0vH+Qql589UWAmAmx3RZEXS8=
X-Gm-Gg: ATEYQzxmtTcsbOn0CfK1whkVxxL122KeAMx7WDM9JcFj5x7pF5XvEm+CAzwak3pOs9U
	Fs02wDkTuDohK9JLw9gP7ktMbXZqVfb03jnkRy0Du57aiJomRnCknDSLGdpfyIoRoQL1Xw/gbFh
	oy1vrjk3gTbBQzRrYokhQTGDAKQoF3/BiJHDM2uVfdW39xds1AuKgWy1BuqdMN/JQ7GUa6nxkqX
	FHLpz/v48usNx4S5mIzzpvYrQjjUQZBcnvLDfJOOBZtvBHAWE9cQuJ6UpgDyn6Ftx2QPi6JdKD0
	5Vrdrj5ySMxGaLuzV8jscd4EPmMriNf0JGZMZXk9qTWeAh5M226Vbw4NOqNpLoOFyLGj99JvGLC
	AUB+tpnOnHwEytXwsOzTi3iqyzuBmVKqYn2EPpgii4hJHYhoPWhd2/iYQwyVz/A5hUrt/DFRXs3
	Q5TbqNL9mqw//kW+U1A97vCalnlFFp72iJZbIQLtFt4N43mV4wtrLUkAmQLOns0RZns8ZfNMfoW
	w==
X-Received: by 2002:a05:6830:630d:b0:7cf:d1eb:f37a with SMTP id 46e09a7af769-7d726f833a5mr4489403a34.18.1772913676046;
        Sat, 07 Mar 2026 12:01:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728d2e9dcsm3588132a34.23.2026.03.07.12.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 12:01:15 -0800 (PST)
Message-ID: <42fe94df-ff8c-49d2-9a03-7d00e48eb22b@baylibre.com>
Date: Sat, 7 Mar 2026 14:01:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
 <2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
 <bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
 <9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
 <20260301133806.5e706756@jic23-huawei>
 <pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
 <20260307140953.46db3c19@jic23-huawei>
 <7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
 <20260307165816.46a98d34@jic23-huawei>
 <zurbjiq5nqbcid5h6kfworkmhczigirkzsqqsczfkatpg3bbe3@t7ssv76d3t4a>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zurbjiq5nqbcid5h6kfworkmhczigirkzsqqsczfkatpg3bbe3@t7ssv76d3t4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/26 12:54 PM, Rodrigo Alencar wrote:
> On 26/03/07 04:58PM, Jonathan Cameron wrote:
>> On Sat, 7 Mar 2026 10:50:14 -0600
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 3/7/26 8:09 AM, Jonathan Cameron wrote:
>>>> On Mon, 2 Mar 2026 10:22:47 +0000
>>>> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
>>>>   
>>>>> On 26/03/01 01:38PM, Jonathan Cameron wrote:  
>>>>>> On Mon, 23 Feb 2026 10:02:00 +0000
>>>>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>>>>     
>>>>>>> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:    
>>>>>>>> On 2/22/26 4:01 AM, Rodrigo Alencar wrote:      
>>>>>>>>> On 26/02/21 02:16PM, David Lechner wrote:      
>>>>>>>>>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:      
>>>>>>>>>>> This patch series adds support for the Analog Devices AD9910 DDS.
>>>>>>>>>>> This is an RFC so that we can agree/discuss on the design that follows:
>>>>>>>>>>>       
>>>>>>>>
>>>>>>>> ...
>>>>>>>>       
>>>>>>>>>>> represents a distinct signal path into the DDS accumulator, so the driver
>>>>>>>>>>> models them as separate IIO output channels (all IIO_ALTVOLTAGE type).      
>>>>>>>>>>
>>>>>>>>>> Generally IIO channels represent the physical input/output, not the
>>>>>>>>>> internal channels.      
>>>>>>>>>
>>>>>>>>> That is part of the reason for this RFC. Dividing those top-level modes
>>>>>>>>> into channels allows for better organization, as they can operate together,
>>>>>>>>> i.e., phase or scale can be provided by single-tone profile, while
>>>>>>>>> frequency is controlled by the digital ramp generator (see Mode Priority
>>>>>>>>> section in the datasheet). Also, it allows to explore the most of standard
>>>>>>>>> ABIs like, scale, frequency, phase, sampling_frequency and enable.
>>>>>>>>> Putting everything into a single channel would make things a lot messy
>>>>>>>>> to interface with.
>>>>>>>>>       
>>>>>>>>>> Ideally we would just have the one channel here with a mode selection
>>>>>>>>>> attribute. Documentation can tell us which modes use which attributes.
>>>>>>>>>>       
>>>>>>>>>>> This per-channel separation allows userspace to configure each mode
>>>>>>>>>>> independently through its own set of sysfs attributes, and to
>>>>>>>>>>> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
>>>>>>>>>>> the hardware's own mode selection architecture.
>>>>>>>>>>>       
>>>>>>>>
>>>>>>>> Looking at Table 5 in the datasheet really helped me understand this better.
>>>>>>>> I think this series could benefit from a documentation patch that explains
>>>>>>>> more about how the driver works with some diagrams.
>>>>>>>>
>>>>>>>> So really what we have here are a bunch of digital data generators rather
>>>>>>>> than a bunch of altvotlage output channels. And the same data channels can be
>>>>>>>> mixed and match as the source for up to 3 different components of the output
>>>>>>>> (frequency, phase, amplitude) depending on the priority rules defined in
>>>>>>>> Table 5.      
>>>>>>>
>>>>>>> More bellow... But note that all of the (or most of it) generators are going to
>>>>>>> be feed into a DAC. Your output is altvoltage but maybe we can treat the
>>>>>>> internals as voltage. Not sure.
>>>>>>>      
>>>>>>>>
>>>>>>>> Digital data sources are really more like a buffer in IIO terms than a
>>>>>>>> channel. And before we added the IIO backend stuff, there wasn't really
>>>>>>>> any other digital data source/sink that I am aware of other than buffers
>>>>>>>> (but there are certainly a lot of odd corners of IIO that I haven't explored
>>>>>>>> yet, so maybe I missed some).
>>>>>>>>
>>>>>>>> In a recent discussion, the idea of possibly needing a way to provide
>>>>>>>> some userspace interface to be able to tweak knobs of an IIO backend
>>>>>>>> was also brought up.
>>>>>>>>
>>>>>>>> Putting those ideas together, I'm wondering if we need some new channel
>>>>>>>> type or even a whole new interface (e.g. a new sysfs directory like buffers
>>>>>>>> and events) for managing these digital data sources/sinks that are not an
>>>>>>>> IIO buffer.
>>>>>>>>       
>>>>>>>
>>>>>>> But what would be that channel? In the end of the day, we typically have voltage or
>>>>>>> current DACs and a DDS primary function is indeed to generate alternating waveforms
>>>>>>> that you then typically feed into a DAC (and in some cases from the DAC into a
>>>>>>> power amplifier). So the DDS is just part of the data/signal path. Anyways, not sure
>>>>>>> on the new type and I think we already have the "blocks" in IIO for dealing with this:
>>>>>>>
>>>>>>> . frequency
>>>>>>> . phase
>>>>>>> . amplitude (raw + scale + offset)
>>>>>>>
>>>>>>> But you're right that maybe it's time to think in a better way to fit them together. 
>>>>>>> Maybe a new type (as buffers or events) can make sense where the above are treated as, example, scan
>>>>>>> elements. Maybe it's overcomplicating, not sure. It surely needs  discussion and thinking :).
>>>>>>>
>>>>>>> And spoiler alert, as you might have guessed already, the parallel port stuff is to be
>>>>>>> used with DMA buffers (and IIO backends). At least, that was the plan IIRC. But Rodrigo
>>>>>>> can confirm it.
>>>>>>>     
>>>>>>>> I think we've seen enough of these already to know that things like a
>>>>>>>> "tone generator" and a "ramp generator" are going to be common and could
>>>>>>>> share some standard attributes. 
>>>>>>>>       
>>>>>>>
>>>>>>> I tend to agree. For example, there already some DACs (with dithering) that make use of a similar
>>>>>>> interface (but with a custom prefix). Though the end goal is different, the interface is not that
>>>>>>> far off:
>>>>>>>
>>>>>>>
>>>>>>> https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>>>>>>>
>>>>>>> Anyways, I knew this one would be an interesting one for upstream :)    
>>>>>>
>>>>>> For history buffs, we had a bunch of DDS chips in staging at one point and never
>>>>>> manage to figure out the questions being raised here :(  They are complex
>>>>>> beasts.  Clarity of ABI proposal and documentation is going to be key to driving
>>>>>> this series forwards. In a sense the code is the easy part.    
>>>>>
>>>>> Does that mean that once good documentation is provided, the presented design can
>>>>> be accepted? Even though data generators/sources might not be interpreted as
>>>>> altvoltage channels?  
>>>>
>>>> I'm not sure yet :(  It's a pretty complex design and we haven't really come to a conclusion
>>>> on how to handle this channel 'mixing' case.
>>>>
>>>> If we did go this way, we'd need to figure out a way to describe the mixing part.
>>>> So either we describe it as one channel (which is going to be really complex)
>>>> or we describe it as multiple channels but add extra ABI to make it clear they
>>>> are mixed into a single 'physical' channel.
>>>>
>>>> Jonathan
>>>>   
>>>>>  
>>>>   
>>>
>>> Some ideas have crossed my mind, like adding new option to the in_/out_
>>> prefix for "internal" channels. But I it would take a long time to teach
>>> existing generic userspace libraries/tools about this.
>>>
>>> What has popped into my head just now is that perhaps we could do like
>>> Rodrigo is proposing here reusing existing channels and standard attributes
>>> as much as possible and add a new "subcomponent_of" attribute to provide
>>> the link, similar to "current_trigger" for triggers.
>>>
>>> This way, it would still work with existing userspace tools (even if it
>>> looks a bit confusing). And userspace tools could eventually be taught
>>> to present the channels as a tree-like structure with the main channel
>>> and subcomponents nested under it.
>>>
>>> We would want to spell out up front what all of the anticipated ways of
>>> using it are. For example, I suspect eventually someone will want this
>>> attribute to be writeable to assign a specific limited resource to a
>>> specific channel. An I expect that we would eventually see something were
>>> a single subcomponent is shared between multiple physical channels. In
>>> this case, we would want the value of the "subcomponent_of" attribute to
>>> be able to be a list.
>>
>> Something along those lines might work. I'd not thought about the case
>> of one 'internal' going to multiple 'external'.  Otherwise I was wondering
>> if something informal related to labels would work.  We've done that where
>> we've been associating things like voltage and power measurement from a single
>> pin.  It's rather adhoc though.  Possibly we could roll it into a newer
>> more general scheme.

Hmm... in this case, it sounds more flat where there isn't a clear channel
that would be the "root" of a tree relation.

>>
>> If the association is done as meta data attributes alongside existing
>> channels then as you say existing tools will kind of work, just need some
>> human understanding of what is actually being controlled until they catch
>> up with the newer schemes.
>>
>> Lots of ways we could actually represent the graphs.  Going to take some
>> figuring out!
> 
> I like the idea of subchannels to create logical tree-structures. It opens
> up for other possibilities.
> 
> I wonder if the varying channel index would still confuse a user, even
> with this metadata attribute, like:
> - out_altvoltage0
> - out_altvoltage1
> 	- out_altvoltage1_subcomponent_of = out_altvoltage0
> 
> would there be a different way to name the full_postfix in
> __iio_device_attr_init() that would allow to keep channel index the same
> (e.g. altvoltage0 for multiple internal sub-channel) and still be
> compatible with userspace tools? I don't know, something like:
> - out_altvoltage0
> - out_altvoltage0_0
> - out_altvoltage0_1
> - out_altvoltage0_2
> 
> userspace tools would understand out_altvoltage0_0_frequency as:
> - direction: out
> - type: altvoltage
> - channel idx: 0
> - attr name: 0_frequency
> 
> and that would be a problem?
> 

I have a feeling that could be problematic for existing attribute
parsers.

How about using higher numbered channel indexes instead?

out_altvoltage100_* = physical channel

out_altvoltage101_* = subcomponent
out_altvoltage102_* = subcomponent
...
