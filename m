Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18244998F
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839813; cv=none; b=KAodgE7lNl3noeC01ZdKHxibR80FVzEWMZ6ryazPts/umqD+VFXHXHuxD7N5rNNK6m/Wioe3GF3QRucsFJHa8RGoXoXbFK4/UiqYEhkCHlT65rRc8WOxNsG0FSdpbe6XzrCbpPMv2N+NuQLLNK/dQs0zieX+samIlIP0p+0+KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839813; c=relaxed/simple;
	bh=4womcYsF9mcBGVtFV27nvc/PSxv0+NBwgwSEiADK8oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFJlI6LEz/TJ1FSP4GoXOqORX4FXQVlSJQdue2yezgPcJuolZdusEJN6smtAezuyTNknLqOyG8F0ngJKoaRe6Qp+XtrmEXsoICvwhCWNMTnAcRJukHknFloNALWVoFLYoOkzwQnCRh4p2FWpIIcnFz+cdS/suiLy4YJrd6UpjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHxUuCQi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHxUuCQi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2661358f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785839809; x=1786444609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wfrbatFPCH8NCTYo6x4uNCytfKAxBGUxu1j+wIy4q8=;
        b=KHxUuCQie+x/e5x3GbwZdpF9LUMt9sIhifFvllZgZ78b4U3ZNxKcwkX8Mb0VSpox+u
         /Iz28fCic7gKp81WorkWm2g7n6z/+Bg2W/mnbSwXt0UpTOKfhEK+np5VUobNDXm9TKL4
         9Hg5rW0mokGGcjtjR+PWBAG0rTjZk+qoH82zwzn921+BjLpH0w+qSD3a1wNEDAeTCoOx
         YeZwFcJ3KOoOEIvDbLDqpmc4cbEmoPDIKjJD6pws8cOQMREJjS/zhrxiDqQ88fOXcvt0
         oIwe1Lf+kAk8KaVVJh2g6aLkSf9/ac3vDay2hxrny4IZuS3TzWl98rJqD9nH9pJtByi4
         iQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785839809; x=1786444609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wfrbatFPCH8NCTYo6x4uNCytfKAxBGUxu1j+wIy4q8=;
        b=TRCBDQNZFIX5EuafaJbhIO88p7cVNrTZWgLtq86azoypPPj7blPrrx5lKl0Y2Vn5Oo
         rHeAgcDIiutxiZ0jC0a4TGtxTdrUQ5knNkTh94CvR5Kjfs5CGKkGkFGgqQ6wwVPvLuMg
         pykU9Lst7gdWo0wHUB8GH7+w3Los7tjH0iWTy5IYVYinPDKqz8GG/Ebdw3/KJtQUwdyo
         3EB0laKoDWdb8BX8KThXmGikle0qv042rLDVjbKQzAawXiNLDrvf3FjhBuduG9up3jlw
         nkPP3Nvk2tcHn5I4RZ7sAlM5Gog6on6cKmZV4pPfag51LeFV7a7/iNiJYsfCGvmL1ukh
         ya/g==
X-Forwarded-Encrypted: i=1; AHgh+RqJHgyLVxDXG58Y72V90OLZOyGBvD1p7ZRFe2mFUu6GTUbuxZxEluAuA0iirrHQEtQdyDehrhwsxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9Wl6Mmiqre71a7F3RXV8Sy65WnHWkFCz7uIUr7WWFVsAx/3h
	4ASD8Q02r/aB3dL5P3i7cLiZ7p2o+udA06HlCOrAjS6EmDxa9MUIqGiD
X-Gm-Gg: AR+sD10rKk6MrLWQdxEb89N+qI82z6qr+lmn2A/y0eDT8LxDprKksEVgfUecwXr08wg
	mxHrX5O4w8mr5OMsE1X4XU0fyr+GPF5DtH/YMhAlooccA8Y6f7ZI8nuw2CZvMLWhnDamA6ECpOq
	nqPlZ9dBvQH5MGjD9CPjmSNyCwtrHDvtk9CcgffXxnm8ADATWRDEXP32eqyiMkwFpoLVDee3opc
	is/I7p02pV49DJJZqej2yTksZk9Z1z/yJBCVv62iy+DkjgyvenXPU84Tk6Rzg8Hx2xBbgchCkZH
	XW0i5cudDP+SinHtWeX66iBa0OwZlP4uugswNwAOw1xHZSaN8By2YZZ9s0sQASYph0UVJ9qGRxi
	tpDf9lyyveR1wvL4kDKl6gSas+q+4VkWLF+zlL1nQlAaZ/uQuYsKXs8TKJprgNQ0xjG7doDFUNA
	eCescCMGOIP9WhYP8xzhOv9Gx5CiJnSTL3YScD1HlIN8aO8ePrySuZ47U0OJl9VCla1gPZFS4w4
	ln0BAN1Bt6U/BXKveU2BR3wZ9zr/IkCuVX3kkv3aa/Mc3j9CpQtvzZpWo0jKTuDocC6UhNqTFe3
	TrM=
X-Received: by 2002:a05:6000:200d:b0:47f:25e4:5c34 with SMTP id ffacd0b85a97d-47fd7309771mr35812640f8f.29.1785839808450;
        Tue, 04 Aug 2026 03:36:48 -0700 (PDT)
Received: from [172.24.138.145] (dynamic-176-002-083-080.176.2.pool.telefonica.de. [176.2.83.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456220esm43851882f8f.18.2026.08.04.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:36:47 -0700 (PDT)
Message-ID: <c20621fd-571b-4c96-8397-c644970c6548@gmail.com>
Date: Tue, 4 Aug 2026 12:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
 <20260730000929.2ec20cf8@jic23-huawei>
 <20260730-impaired-protector-b58ae56ae3f6@spud>
 <20260801024114.4c606ef7@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260801024114.4c606ef7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/1/26 03:41, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 19:02:08 +0100
> Conor Dooley <conor@kernel.org> wrote:
>
>> On Thu, Jul 30, 2026 at 12:09:29AM +0100, Jonathan Cameron wrote:
>>> On Wed, 29 Jul 2026 21:47:45 +0100
>>> Conor Dooley <conor@kernel.org> wrote:
>>>    
>>>> On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:
>>>>> On Tue, 28 Jul 2026 17:00:55 +0100
>>>>> Conor Dooley <conor@kernel.org> wrote:
>>>>>      
>>>>>> On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:
>>>>>>> On Sat, 25 Jul 2026 15:57:07 -0500
>>>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>>>        
>>>>>>>> On 7/22/26 2:54 AM, Janani Sunil wrote:
>>>>>>>>> Add the generic spi-device-addr property to the binding and deprecate
>>>>>>>>> the existing vendor specific microchip,hw-device-address property.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>>>>>>>> ---
>>>>>>>>>   .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
>>>>>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
>>>>>>>>> index 675319276197..de1ea289e7f5 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
>>>>>>>>> @@ -80,6 +80,7 @@ properties:
>>>>>>>>>       $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>>>       minimum: 0
>>>>>>>>>       maximum: 3
>>>>>>>>> +    deprecated: true
>>>>>>>>>       description:
>>>>>>>>>         The address is set on a per-device basis by fuses in the factory,
>>>>>>>>>         configured on request. If not requested, the fuses are set for 0x1.
>>>>>>>>> @@ -91,6 +92,12 @@ properties:
>>>>>>>>>         clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
>>>>>>>>>         which is first one on the wire).
>>>>>>>>>   
>>>>>>>>> +  spi-device-addr:
>>>>>>>>> +    maxItems: 1
>>>>>>>> Does it not make sense to all for more than once device connected
>>>>>>>> to the same CS here? I would expect maxItems to be 4 to match the
>>>>>>>> number of possible addresses.
>>>>>>>>        
>>>>>>> I think for this part their isn't a reason to aggregate.
>>>>>>> No magic accesses that touch them all at once.  So this hits
>>>>>>> exactly the point you raised about how we set the address for
>>>>>>> more than one of them.
>>>>>> No David is actually right here, and maxitems should be 4.
>>>>>> Setting the address for multiple was already discussed I thought, with
>>>>>> the property being an array and each compatible being used to determine
>>>>>> the "stride" between entries based on the number of supported channels?
>>>>> I don't think that applies for this device or at least to do so
>>>>> is a major driver rewrite, not a simple binding change.  Probably we'd
>>>> Whether or not it is a big driver change, the binding should represent
>>>> what the hardware is capable of.
>>>>    
>>>>> just add a bus and hang the 4 instances off it. They are running on own
>>>>> timing etc so we can't grab data across all of them in any sort of
>>>>> synchronous way - the clocks will probably drift over time etc.
>>>> Did I miss something about the ADI devices in this thread where they
>>>> have some multicast ability to read all devices at once? I thought that
>>>> that was a different series where each device had dedicated mosi and
>>>> miso lines, rather than the shared ones here. I didn't think the ad5529r
>>>> did anything special from my reading of the datasheet but I'm not the
>>>> expert in this area!
>>> It's a DAC so other way around but yes they have exactly that in the section:
>>> https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
>>>
>>> 	Register Details: Hotpath DAC registermap.
>>>
>>> The is a brief description earlier of the whole feature that might
>>> serve for this discussion:
>>>
>>> "DAC HOTPATH
>>> The DAC hotpath is a dedicated register region that optimizes
>>> DAC updates in multidevice configurations where several AD5529R
>>> devices share a common SPI bus. It reduces the number of SPI
>>> frames required to write DAC data and supports synchronized
>>> output updates across devices. In single device systems, the hotpath
>>> offers no advantage over the standard register map and can be
>>> disregarded."
>>>
>>> As an example
>>> MULTI DEVICE SW LDAC MODE 0 REGISTER
>>> "This register sends a software LDAC update to the selected devices
>>> that share the SPI lines but have different addresses, using the ID0
>>> and ID1 pins. The selection is done on a per-device basis corresponding
>>> to the configured bit field."
>>>
>>> This one triggers all selected DACs (there is bit corresponding to
>>> each address) to update in sync. (Lets put aside normal systems
>>> where an LDAC gpio is wired to multiple devices as that is a whole
>>> different problem).
>>>
>>>
>>> It is this part that is driving the suggestion of having
>>> a combined device representation for multiple physical devices.
>>> In practice it is very similar to chained devices where we do that
>>> already in that a longer access sequence is used to talk to multiple
>>> devices at once.
>> Ah I see. I definitely missed this section.
>>
>>> Those SPI messages do not carry the address (or they are ignored - I didn't
>>> dig into the mechanism).
>> It's definitely hard to tell this at a glance, nor does it really
>> matter.
>>
>>>>> They are independent devices (think of them using spi-device-address
>>>>> like an i2c address) -  so why have one DT node for up to 4 of
>>>>> them?  Note this is different from the AD5529R where the design
>>>>> is intended for them to operate as one single larger device.
>>>> I don't buy this argument, I just don't see what differs between the
>>>> devices. The microchip datasheet I read talked about using 3 devices to
>>>> measure 3 phase power setups (I think that's what it was) which is, in
>>>> my book, evidence that they're not just intended to be used
>>>> independently.
>>> Sure but that could just as easily be done with normal SPI and 3 chip
>>> selects. For these devices there is no broadcast write magic (I think
>>> anyway!)
>> I don't think there's any magic, and yes I do buy the argument that it
>> could be done normally.
>> Quite frankly, I don't know why the device works like this other than
>> pin saving. Probably some customer asked for it rather than there being
>> a generic use case.
>>
>>>> That said, the more this discussion goes on, the more I think that
>>>> merging the devices into a single node is a mistake. Logically there may
>>>> be one device, but really there are one to four devices. Doing the
>>>> logical device thing is nice maybe for software but I no longer think
>>>> that it represents the hardware correctly. I know this will cause
>>>> problems with registration of devices in the SPI core, but we need to
>>>> pick one representation for these devices that fits in all usecases
>>>> and with the things brought up in the other mail I am having a lot of
>>>> doubts.
>>> This wasn't about use cases as such but the broadcast like facilities the
>>> ADI parts have which to me smell like the main reason you'd put them on
>>> a single bus and use this feature in the first place - you are making
>>> one big DAC from multiple chips.
>> No, I think the use case bit is important. The representation (in dt)
>> shouldn't change because someone wants to use the device as one big dac
>> or 4 smaller dacs. The multicast thing does certainly lend a lot of
>> weight to treating the dacs as one device, so I guess that would be the
>> designated representation for this dac.
>> But then I don't see why the microchip devices couldn't be dealt with in
>> the same way, even if they don't have multicast, in order to create a
>> single consistent way of describing the devices.
> How about we kick this down the road. Leave the two microchip devices
> alone for now with their vendor binding (which we have to carry on supporting
> anyway) and just do the AD part.  For future devices we can push towards
> that model if they have such a device-address feature.
>
> I don't mind changing the microchip parts in principle, but it is going
> to be a non trivial change and I'd certainly be nervous to make it without test
> parts
>
> Of course if anyone does mix parts we have to think again.
>
> Jonathan

Hi All,

Based on the discussion for v8, I plan to:

1) Drop the Microchip-related patches from this series
2) Keep the spi-device-addr property and the AD5529R binding/driver and represent AD5529R sharing one CS as one device using the address array.

This would reduce v8 into just three patches related to the AD5529r.

Please let me know if I missed anything.

Regards,
Jan

