Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99622773EC
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948738; cv=none; b=bBZBWolNaH73ulhS4N/OHx2kcYlWexeBDo4+53yxM3JfqTzBFvgskSDjqytD193qwLGLubkkAIWz0TfRNA5I3sb/X1B6vsx33i5AdqY06ii9wnm1N20p/7bCopajsxhfE9nI/Hpp4OXJOmVaQYFRS6x8XSsNNsZF5x+bHKaKwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948738; c=relaxed/simple;
	bh=job9rYTM+UCqFeY7rxXBeHi2zHxMKKFypYMRXUtyhd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GADohTaYDzB3RT1RKvT+wTJB6gNjyqr9G4fRtVe3oWVa9OwMkCfkxlTacpgSls11Hs37jdTWvSPn83wReoUraKOLe4tU20UGTBqbJgh5I5mmF5uqtivS2pQ4CWGFTNvSKBTXdubl3s2speTBO06tuDlo3MYcxtzZn6B3bDEOUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=i+LaVPlV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="i+LaVPlV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dea1272943so466763a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778948735; x=1779553535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSimK5zaxsSTTvAIbV2ZqT3wvlMvZQ/t+G+wtbYDzlU=;
        b=i+LaVPlVMNRBhAQVQHfg1eE+zecOTyrlRMUe8CIWvGMgIUZm4TpbPVsd2tXT7QPcG5
         dy9mMYKMTdiCKBme5lmoR8VVbICUvpAPboiy8hN79v6zO0PWNeF3UBRLksH4mPG2I4Li
         I8Ry35ahIfobce+4sgVounkvDEi7fulrAS8+m64L5IBKi356Cq6bG/ytPC0icOrZ9D7b
         1vwpdq/XSFjs6KR1TAkw7OL5On8Tm+k6TtOjFxw2WgDQNbFaSFqBpe67VV0MDOHB9jmS
         eeXV75XzkSmi8RUCX1t++EaIJSSQrj4Q2aI42trARVvIaeiIu8j7/Dpc7qzmyvNt7HiE
         6PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778948735; x=1779553535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSimK5zaxsSTTvAIbV2ZqT3wvlMvZQ/t+G+wtbYDzlU=;
        b=Lr/dlUrMFtRFyzH3JoN96FyWLJmyY9ThE53tM3mOVZYz+zn6xcUvHCDCqoI5t8e+re
         qwWjH6FIrYJjsYBpkZv8fLcLHV4hrCbhOkUvPeRVjKpOz+kw7pelWlMJe/ilClBZbxkj
         HbW6CM/v78E3hjo8jIfTJBrhcbNhBUQr4YnrcxHuoQQt0R9evKARK6jlYGP7efdJGr+K
         hC9cAiEjvaa59k2ujJclUmu+miuKJtZJkzEMYXV0wtg6qvvpisuK7kL7q1VC4z1iIojU
         Yi+xRVlZqmaQRY7T1tN9l0KxtZ6gBpkFU40lrA0U02GZlR4dNvjye6Ve5/20EjZT+jzJ
         o/qQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xut9O60CH2Q+94nxu1Gzfhwnk2Dya0xe8rzuaER/7Faugtk2A2I6r41FrTMWCZ78seNyHaqgIv1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwer75Hz68tuBsf+6QC05xh1ncE63BzFB+h/JkQcx+L4CNT81J
	rhIz/b1qhmXZAgT3AltORjT4ktoBayghc5okn/lEdkDSQV44iQw5O04ZyvZ3N+n8M60=
X-Gm-Gg: Acq92OEdAAmxPf/8PGhviHZTALIsm+rQXSlUTKI2eWe5toM4872sNeUbBfwnvAk1E3X
	KkkZnafYHaBGoLz3rxH1y/N3DYObMAYFuvXfwq+kPoGq3BnNH5rsOarCCGD2jCjQeyS5H8MrnNl
	1OZO8rpyIFUQgfCDG7+FBa9sgI1v/8PLHhTcdGHrW8v6qm/9kDbCylxSU7S66BAJlO4DkGDqn0V
	ZTzKnUECU0JYylg/C+z5+A/wibvaaxcBvPKTYDdrEgdsXRFgJAi0/6lKrhkkOh3QDc2GnXfCpvi
	YiKgmJHLBfpSL7SFTN4jdjy+ifyZ3N6I2kOyMOo05teY0W4I4wVfj31i2mIsEQEiBAHoNFAYgJ9
	L3kure0ufpPbvYod1fc4Fs43Y0UUGSbLDiWncW+TjLybG9/fH1CDcYtuUub/+xJaViHDPaRps4j
	jXsVxXbW833v/wKSIkjZpkU8OCc6qFMri23I3lhfMOsGjiB6hElGyXz/C83OWI1OA7/X/8FyzAI
	Q==
X-Received: by 2002:a05:6830:6614:b0:7d7:d615:3040 with SMTP id 46e09a7af769-7e4f2b865d1mr5772418a34.17.1778948734590;
        Sat, 16 May 2026 09:25:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b95b82fsm4418210a34.12.2026.05.16.09.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 09:25:34 -0700 (PDT)
Message-ID: <fe766c2a-3662-4896-b7ec-b569791630cd@baylibre.com>
Date: Sat, 16 May 2026 11:25:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
To: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Santos <jonath4nns@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
 <af2gJyG3rDjsjFmo@nsa> <agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com>
 <20260516113738.4103f388@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260516113738.4103f388@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/26 5:37 AM, Jonathan Cameron wrote:
> On Fri, 15 May 2026 13:31:02 -0300
> Jonathan Santos <jonath4nns@gmail.com> wrote:
> 
>> On 05/08, Nuno Sá wrote:
>>> On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:  
>>>> Hi all,
>>>>
>>>> We have a request to support multiple devices tied together in a single evaluation
>>>> board. The goal is to be able to read them simultaneously via the IIO framework,
>>>> while also controlling them individually. Currently we have two ADC devices that
>>>> would benefit from this, but there might be more in the future.
>>>>
>>>> This is the scenario:
>>>>
>>>> +---------------+                                                 
>>>> |     ADC 0     |                                                 
>>>> |               |                                                 
>>>> |        SYNC_IN|---+---------------------------+                 
>>>> |          DRDY0|---|------------------------+  |                 
>>>> |               |   |                        |  |   +------------+
>>>> |          SCLK0|---|------+                 |  |   |    HOST    |
>>>> |           SDI0|---|------|--+              |  |   |            |
>>>> |            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |

							Is this arrow
							supposed to be
							going the other
							direction?

>>>> |          DOUT0|---|------|--|--------+  |  |      |            |
>>>> |               |   |      |  |        |  |  |      |            |
>>>> +---------------+   |      +--|--------|--|--|----->|SCLK        |
>>>>                     |      |  +--------|--|--|----->|MOSI        |
>>>> +---------------+   |      |  |        |  |  |      |            |
>>>> |     ADC 1     |   |      |  |        |  |  |      |            |
>>>> |               |   |      |  |        |  |  +----->|DRDY0       |
>>>> |        SYNC_IN|---+      |  |        |  +-------->|CS0         |
>>>> |          DRDY1|---|------|--|----+   +----------->|MISO0       |
>>>> |               |   |      |  |    |                |            |
>>>> |          SCLK1|---|------+  |    |                |            |
>>>> |           SDI1|---|------|--+    +--------------->|DRDY1       |
>>>> |            CS1|---|------|--|-------------------->|CS1         |
>>>> |          DOUT1|---|------|--|-------------------->|MISO1       |
>>>> |               |   |      |  |                     |            |
>>>> +---------------+   |      |  |                     | .          |
>>>>                     |      |  |                     | .          |
>>>>        ...          |      |  |                     | .          |
>>>>                     |      |  |                     |            |
>>>> +---------------+   |      |  |            +------->|DRDYN       |
>>>> |     ADC N     |   |      |  |            | +----->|CSN         |
>>>> |               |   |      |  |            | | +--->|MISON       |
>>>> |        SYNC_IN|---+      |  |            | | |    |            |
>>>> |          DRDYN|----------|--|------------+ | |    +------------+
>>>> |               |          |  |              | |                  
>>>> |          SCLKN|----------+  |              | |                  
>>>> |           SDIN|-------------+              | |                  
>>>> |            CSN|----------------------------+ |                  
>>>> |          DOUTN|------------------------------+                  
>>>> |               |                                                 
>>>> +---------------+                                                                                                    
>>>>   

Would there actually be 4 DRDY inputs on the host system? I assume that
they would be the SPI offload trigger. But there can only be one trigger.
So I would expect all DRDY going into an N-input AND gate and the output
of that gate used as the trigger.

> Took me a while to get to this. 
> 
> Another datapoint to perhaps look at is daisychain SPI devices. That's
> moderately common on high end ADCs with applications such as electric car battery
> monitoring as they need to scale to 100s of devices and separate CS for each would
> be a pain.  
> 
> For those we just handled it in the ADC driver.
> 
> If we need to have a device specific aggregator driver to make any scheme work
> then it might be better to just make it a driver problem.
> 
>>>
>>> Do we have any FPGA IP for high speed transfers? If so, it would be nice
>>> to have it in the above diagram.
>>>   
>>
>> We only use the SPI-engine offload with the new multilane data feature.
>>
>>>> To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
>>>> chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
>>>> is to allow users to aggregate these devices so they can be read simultaneously
>>>> from the user space.
>>>>
>>>> I found a similar case here involving the AD4880 (ad4080 driver), which consists
>>>> of two independent ADC channels, each with its own SPI interface for configuration.
>>>> In that instance, the ancillary device feature was used because it was considered
>>>> the approach of a single device with independent channels rather than independent
>>>> devices connected together. Additionally, the backend handled the buffered data
>>>> aggregation.
>>>>
>>>> However, I would like to discuss a more generic approach to support device aggregation
>>>> across different drivers. Marcelo suggested a while ago to consider the components
>>>> framework. This would allow us to create a virtual device responsible for 
>>>> aggregating and controlling the sub-devices in a standard yet flexible manner.  
>>>
>>> component might fit here but it has it's limitations and I fear (one of
>>> the reasons I did not used for the backend stuff) is that it looks too geared for DRM. But yeah,
>>> in theory is more or less what we have here with the distinction (I
>>> think) that the type of devices are actually different :).
>>>   
>>
>> Yes, they are different, but i did not find something more similar. Here
>> the goal is to define a standard way of aggregating multiple devices
>> from the same driver.
>>
>>>>
>>>> The aggregate driver could either be an extension to the main driver (e.g. ad7768-1.c),
>>>> or a separate file (e.g. ad7768-1-agreegator.c).   
>>>
>>> I guess we could support this in the main driver (more on this below).
>>>   
>>>>
>>>> Here's an example of how the devicetree would look like: 
>>>> (includes the multiple data lanes feature)
>>>>
>>>> spi {
>>>>     #address-cells = <1>;
>>>>     #size-cells = <0>;
>>>>
>>>>     /* AD7768-1 physical devices */
>>>>     adaq7768_1_0: adaq7768-1@0 {
>>>> 	compatible = "adi,adaq7768-1";
>>>> 	reg = <0>;  /* CS0 - First physical device */
>>>>         spi-tx-lane-map = <0>;
>>>>         spi-rx-lane-map = <0>;
>>>> 	/* other properties */
>>>>     };
>>>>
>>>>     adaq7768_1_1: adaq7768-1@1 {
>>>>         compatible = "adi,adaq7768-1";
>>>>         reg = <1>;  /* CS1 - Second physical device */
>>>>         spi-tx-lane-map = <0>;
>>>>         spi-rx-lane-map = <1>;
>>>>         /* other properties */
>>>>     };
>>>>
>>>>     adaq7768_1_2: adaq7768-1@2 {
>>>>         compatible = "adi,adaq7768-1";
>>>>         reg = <2>;  /* CS2 - Third physical device */
>>>>         spi-tx-lane-map = <0>;
>>>>         spi-rx-lane-map = <2>;
>>>>         /* other properties */
>>>>     };
>>>>
>>>>     adaq7768_1_3: adaq7768-1@3 {
>>>>         compatible = "adi,adaq7768-1";
>>>>         reg = <3>;  /* CS3 */
>>>>         spi-tx-lane-map = <0>;
>>>>         spi-rx-lane-map = <3>;
>>>>         /* other properties */
>>>>     };
>>>>
>>>>     /* AD7768-1 aggregator/virtual device */
>>>>     quad_adaq7768: ad7768-1-aggregator@4 {
>>>>         compatible = "adi,ad7768-1-aggregator";
>>>>         reg = <4>; /* ? */
>>>>
>>>>         adaq7768-components = <&adaq7768_1_0>, <&adaq7768_1_1>, <&adaq7768_1_2>, <&adaq7768_1_3>;
>>>>           
>>>
>>> I guess we can avoid the dummy device! The one having the components
>>> with be the main/controller device but I guess we would still need a custom
>>> property for the other nodes in case they need to do something specific
>>> for this arrangement.
>>>   
>>
>> Yeah, defining one device as the controller looks cleaner, but we still
>> have that problem of the main "owning" or using the CS from the other
>> devices (if they are registered separately).
>>
> Long ago I did some thinking about the fidlier problem of aggregating multiple
> unrelated device driver buffer outputs - was for sensor fusions stuff.
> In the end I concluded it was easier to just do it in user space.  As long
> as they ran off the same trigger then the data alignment problem wasn't too hard.
> 
> Obviously here things are a bit different as the SPI offload IP is doing the
> data marshalling.
> 
>>>   
>>>>     };
>>>>         
>>>> };
>>>>
>>>> Is it ok to proceed with component helper for this purpose or do we have something
>>>> better? If yes, I have some following questions:
>>>>   
>>>> -> How to read all devices simultaneously in buffer mode given we can't assert   
>>>> all CS from the virtual device?  
>>>
>>> Isn't this also an HW question? Not sure how that can be done
>>> simultaneously without some kind of HW synchronization. In SW, I'm not
>>> seeing other way other than  N SPI transfers and put them together in the buffer. 
>>>   
>>
>> In HW we have that multiple data lane feature that receives the data
>> from eache SDI lane and put them in order (for FIFO mode and offload mode).
>> If we are not using offload, we could set N SPI transfers and then
>> aggregate them into one buffer. But how to do that in offload? We cannot
>> control the CS mask from userspace.
> 
> If it's not doing hardware offload is it worth the pain?  Easy enough to do
> it in userspace - particularly if we have timestamps as a bit of nearest
> timestamp maths allows easy buffer alignment.
> 

For this type of SPI controller where it can read multiple data
channels at the same time, the .dts should look like this:

spi {
    #address-cells = <1>;
    #size-cells = <0>;

    adc@0 {
	compatible = "adi,adaq7768-1";
	reg = <0>, <1>, <2>, <3>;
        
        spi-rx-bus-width = <1>, <1>, <1>, <1>;

	/* other properties */
    };
};

The reg property is the 4 CS lines and spi-rx-bus-width having 4 items means
that the controller has four SDI lines (the value <1> could be different if
each data channel/device was dual or quad SPI).

This goes along with what jic23 suggested about making it similar to
what we do with daisy-chaining.

The only tricky part with that is when devices don't share all of the
same of another property. For example, in the wiring diagram above, I
see that the DRDY lines are not connected together. But I would assume
that everything else is the same (all chips share the same power supplies,
etc.).

We would need to modify devicetree bindings a bit in cases where a property
needed a per-chip value. But I think that this happens rarely enough, that we
can just do that on an as-needed basis rather than trying to make every property
support multi-device use.



>>
>>> thou>   
>>>> -> Should the physical devices be registered in IIO during probe, or should only  
>>>> the aggregator be exposed to control attributes and general configuration?  
>>>
>>> Good question but it would likely make for a better/simpler interface if only
>>> one device was registered (with multiple channels - depending on the
>>> number of devices). Similar to backends. I guess the idea is also to
>>> only have one IIO buffer for all the channels?
>>>   
>>
>> Yes, the ideia is to have a single buffer to allow reading them
>> simultaneously from the userspace.
>>
>>> Or, IIUC, at the very least, only the aggregator could expose a buffer.
>>> But again, linking the other device channels to the buffer is not really
>>> doable without major changes in the core.
>>>
>>> Something that also just come to my mind! What about the IIO inkernel
>>> interface and things like 
>>>
>>> industrialio-buffer-cb.c
>>> industrialio-hw-consumer.c
>>>
>>> Maybe they have some limitations but something that we can work on? Not
>>> sure though...
>>>   
>>
>> The Inkernel is interesting, I will see what can be done to cover this
>> case.
> 
> How common do we think this requirement is?  If it's just a couple of
> devices I'd go a similar route to the daisy chaining case and do
> something in the specific driver.  Maybe the only point of generalization
> is the dt-bindings if we got that way.  Designing that to maybe let
> us do a generic answer in the long term might be the right compromise
> in not adding complexity to the core until it's proven to be needed.
> 
> Now if you have customers asking for it on 10 different devices today then
> sure let's look at it sooner!  Even then it might be some library code that
> the drivers use rather than big changes to the data flow in the IIO core.
> 
> Jonathan
> 
>>
>>> - Nuno Sá
>>>   
>>>>
>>>> Regards,
>>>> Jonathan S.
>>>>   
>>
> 

