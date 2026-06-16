Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD526B0A9
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623284; cv=none; b=Ew6lhZPFF8SSeHYP6sCZdySC4WQ/UEiK9+nQB76VmAT6fFw7MVpXB6bOzRU4EP+ShEUSUbkV414tpFFR8UZW6afWfd0advIO2gIOYKBxLBeKsGDoLI/MExrtKXWy4fNXrWldda+lDMPISI9o61k2DvAQJlbb3U/hrxLVpUK7hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623284; c=relaxed/simple;
	bh=+qsEwzDaJpqMf1b/Iyy+htP2649+vSch4XQlFsNXdU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFXMbGYHc2K/KjFfMkanmJ/3k8Rwj/geBjaR8fY53gHxJ22EXrlHyBPIP7eyh6sQlUUVyH1BaT2MYCHnaC/Ba3XkeekCSNMUiJnIMm6U4gKDgnsFNBOGO/dXqigXNL+Tp/khaIJB+YDCHINplvTei2nYBvl9JS4buCopjlDNaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mCe+46vK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mCe+46vK"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6e9408e30so3317027a34.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781623282; x=1782228082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNdT+XhJozqfpz4fe+qnm4StGxBNuXMaq3lxFAPMpTE=;
        b=mCe+46vKNYn3MYMbJIxZkDu3Gb4voGsvpVrj1/Ds6aUImLn83fTLWfXQY+jSnRZGCC
         AA9mI/9iGIbDd09zrYbar+MPhwT2eiNNcIpA1nJxhwyhmL4KBUmipyWDJLmp/GhG2DWt
         5OOyR8y0Ob8x62uI0w0rN9DNOVIoJLQv1C7Y1I5ZM/mDcozhkqP+PLOJ+2Xncwtuv1DA
         G5HLMyyZqppiiwBY+To9wFtzKAzWtie7edgVS1AsrsH2os3sjVgNEyyQcmiFk1B//CDc
         gVDTdJ5ZlfKCKyNZqfZoQNzjiKrHzLAGxd+RXRkHBQJJ2FrcWcAZcVOmQNHa13q+GuHg
         eX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623282; x=1782228082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNdT+XhJozqfpz4fe+qnm4StGxBNuXMaq3lxFAPMpTE=;
        b=j0S6SWng2JQV+xH+r/ZYWFuAoNdPUOBIFLCSL3RunI3JD3wdvg/5mz2OThXZS9NsnK
         2ui18kk+BtcBay767kDufujO7SwRmTH5/hLha7JtaBgnfsI+RIvuXkocqoP5ORjFpomy
         l53yFkZ1jmcP6jOotiV3Lf0/PDUQ77IKWrSz/cKyD2UxJOLvlHnSkUdWmSt0sFH+SCYp
         glNP37s7/rOmx3Dpbc9SWwXQw8H4E9TfTc/YkC1jTh+dNHARFVgA152yLJtPJzk6MaAN
         o672gr+f9ZJvfg03HvWDWH348ArACSaCKjsvozo+2shmEXujEopOyD3CLPKAlGjR9vTM
         saJA==
X-Forwarded-Encrypted: i=1; AFNElJ9lWNdymOoI7w0hA653dLZRiDS1C5f+eht7TLfXpycXEUdc6dCf1hrGYZZ3by03xfaXpTi1tymAkUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2DUx1GqraFi72PEjEtiRDaXeJM0XnxlQqUcnYIgDd2R7xA53
	mp03xL6mRwykHQk9kxGjEWjLE78gsvYaJwcYQZkOMxdl2IbcmkBJECX2O4ccnRdyieI=
X-Gm-Gg: Acq92OGoufwxZNfNgNhuvwBf/1SKJpsODiLFFGS4fMrkWPilUYCaFWJ6mZEBrd76NRV
	MlyKEi+kRB99/yr7X8tAZqPteJpsB85qGwNbpQ1QJKESd4bAKFE4bu3BN/8a1lacSrXOwU2YFl6
	4cG7RJJFJWW0t1bP6KeIM1lNxfnx5wGsfGgbee6pl4Sa7idXubTva6zNWKD7EiTs97PqEqsH94c
	VLPx3eA5DFoiJ5Kv4U9+vNQipXnN1imJQfHl9u+9rbSg6lP0n9FYwMIHm7qf3pVy154CgdlnCpY
	BqhiuXpNP6o2R+t98bPKyicCNhwHkL3SESxuglEWThcappf0hWyKHnqzOHQXOBVdMsjUNLmLWNZ
	0sbw6fpgobzCZnHz10eoMTILjeGat3deUBgCRJCyBpBh7BkofYza8448eObHAKOcCoFwNdnn7a8
	RPR9csIqwCBJnIM06I+i2g4r26X66u/o7ZsMVLsq3QHRP5gdK3bokhwwzBRLkw1Ep6FLG9EcqtC
	2APHrw3nIRq
X-Received: by 2002:a05:6830:81fb:b0:7de:4f6b:9e10 with SMTP id 46e09a7af769-7e90b237f61mr132612a34.0.1781623281612;
        Tue, 16 Jun 2026 08:21:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfae9sm6873968a34.23.2026.06.16.08.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 08:21:21 -0700 (PDT)
Message-ID: <d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
Date: Tue, 16 Jun 2026 10:21:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 7:18 PM, Kurt Borja wrote:
> Hi David,
> 
> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
>> This adds support for TI ADS112C14 and ADS122C14 ADC chips.
>>
>> The closest thing we've seen to this in the kernel already is ads124s08.
>> However, that has a completely different register map and the DT
>> bindings are incomplete and the driver is extremely basic. So I've just
>> started from scratch here.
>>
>> We've also had a similar submission recently for ADS1220 [1]. That chip
>> is in a similar situation to ads124s08 in that it has a different
>> register map (but the submitted DT bindings are better than the ones for
>> ads124s08, even if still a bit incomplete). And literally as I was
>> writing the previous sentence, another series [2]  was sent for yet
>> another similar family of chips (ADS1262). That one is even more complex
>> in the feature set than the ones I am working on. I was going to polish
>> up the driver a bit more before submitting it, but now it seems more
>> urgent to coordinate with the other two series to align on how we would
>> like to handle all of these.
>>
>> [1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
>> [2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
>>
>> All of these chips have in common that they are designed for use with
>> RTDs and thermocouples and so they look very similar to each other in
>> terms of wiring and feature set, even if the register maps are
>> different. They are in the gray area where we could either keep them
>> separate because they are just different enough, or we could do like
>> we've done before with ad_sigma_delta and have a bit of an abstraction
>> layer for the register differences and otherwise try to share as much
>> code as possible. Normally, I would lean towards keeping them separate,
>> but in this case, I'm considering trying to share code because the
>> devicetree bindings for the inputs is complex and is going to be mostly
>> the same across all of these chips.
> 
> The channel configuration is indeed very similar for the three chips.
> All three have IDAC, BOC and VREF configurations.

Hmm... I forgot to include the burnout current in the DT bindings. Following
the channel = "conditions for measurement" pattern that I have set out here
I guess that would mean that we would need to have the same inputs twice
when using the burnout. One "channel" would be the one used to do a "precision"
measurement and the other would be the one to do open/short circuit detection.


    i2c {
        #address-cells = <1>;
        #size-cells = <0>;

        adc@40 {
            compatible = "ti,ads112c14";
            reg = <0x40>;

            avdd-supply = <&avdd>;
            dvdd-supply = <&dvdd>;

            refp-supply = <&avdd>;

            #address-cells = <1>;
            #size-cells = <0>;

            channel@0 {
                reg = <0>;
                diff-channels = <1>, <2>;
                excitation-channels = <0>, <3>;
                excitation-current-microamp = <500>;
                current-chopping;
                ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
                label = "rtd-precision";
            };

            channel@1 {
                reg = <0>;
                diff-channels = <1>, <2>;
                excitation-channels = <0>, <3>;
                excitation-current-microamp = <500>;
                burnout-current-nanoamp = <1000>;
                ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
                label = "rtd-diagnostic";
            };
        };
    };

> 
>>
>> If we decide to go the route of sharing code, we could still merge this
>> series as-is and then do the refactoring to add the abstraction layer in
>> a follow-up series that also adds support for the first of the other
>> chips.
> 
> Do you have a proposal of how such an abstraction would look like? I do
> like the idea of abstracting the firmware parsing, scales and shared
> calculations.

As mentioned, it would look a bit like the ad_sigma_delta ADC driver.
Basically, each chip (family with same registers) would still have it's
own driver that include the chip-specific const info structs. In this
case, these would also include function pointers for all of the functions
that need to access registers. And there will be lots of supports_... bool
flags for the shared code to use.

> 
>>
>> This series includes just basic support for reading single measurements
>> from the ADC and gain selection via the scale attribute. I plan to
>> follow this up with additional series to add support for buffered reads,
>> filtering/oversampling configuration, event support, gpio controller
>> support and perhaps a few other things that are slipping my mind right
>> now.
>>
>> The most interesting part about this (that I alluded to above) is the
>> way channels are handled. These are multipling ADCs with differential
>> and single-ended inputs. But what sets them apart from other similar
>> chips is that since they are designed for use with RTDs, there can also
>> be a current output required to excite the RTD and this current output
>> might be different for different channels. So the way I conceptualized
>> the channels is that the devicetree specifies the conditions needed
>> to take a particular measurement rather than being purely a physical
>> channel.
>>
>> This makes things more flexible, but does make the driver a bit more
>> complex. For example, knowing when the current output needs to be
>> enabled or disabled. For now, I have chosen a lazy-enable where they
>> are not turned on until the first measurement is taken that requires
>> them, but then they stay on until another measurement is taken that
>> doesn't require them. This can lead to some oddness with the diagnostic
>> channels that may be measuring something that indirectly requires the
>> current output (i.e. the external reference voltage when it is connected
>> to a resistor rather than a power supply). This means you need to take
>> a measurement that requires the current output to be enabled before the
>> diagnostic channels will give accurate readings.
> 
> This is the same approach I took around the BOC, it feels kinda hacky
> but it makes sense. Just an idea I thought about just now: What if we
> have an additional write-only "_enable" sysfs attribute for these
> channels?

I would not want to make a write-only attribute, we always want to be
able to read back what the current state is.

Do you mean an _enable for just the BOC? I think I would do it like I
suggested above instead.

> 
> The approach I took for the IDAC was to have a single configuration that
> it's enabled for all channels. This makes some sense in my device when
> thinking about optimal software sequencial reads, because of the
> register layout, but I also see the value in having per-channel IDAC
> configuration. I think I will take your approach, so we have the same
> channel configuration around this.

There are only two IDACs but on chips with 8 AIN pins we could have two
RTDs wired up and if both require 2 IDACs, then we can't have a fixed
setting for the IDACs. This is why I made it per-channel.

> 
> Have you thought about how to implement the BOC? In the ADS1262 the
> feature can be found "Sensor Bias". What I did was add per channel DT
> properties for this too.

See above.

> 
> Another question. When you implement power management in the future,
> will you enable autosuspend? IDAC currents will be lost if autosuspend
> is enabled. Is this acceptable? In my case I did enable autosuspend, but
> I have some doubts about this.

I don't like to implement power management unless I have an application
that actually requires it. Otherwise, I consider it premature optimization.
It is difficult to know if we would be implementing it in a way that is
actually useful for a real-world use case. These chips seem like they
would mostly be used in an industrial setting, not in battery powered
applications, so I'm not sure anyone is going to worry about saving a few
milliamps.

> 
>>
>> I have also pushed a branch to [3] that contains the start of some
>> documentation for this driver that can give some more insight into how
>> the implementation works. It still needs some work and also documents
>> some things that haven't been implemented yet, so I haven't included it
>> in this series yet.
>>
>> [3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Documentation/iio/ads112c14.rst
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> David Lechner (TI) (4):
>>       dt-bindings: iio: adc: add ti,ads122c14
>>       iio: adc: add ti-ads112c14 driver
>>       iio: adc: ti-ads112c14: implement gain on internal short SYS_MON channel
>>       iio: adc: ti-ads112c14: add measurement channel support
>>
>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  224 +++++
>>  MAINTAINERS                                        |    8 +
>>  drivers/iio/adc/Kconfig                            |   12 +
>>  drivers/iio/adc/Makefile                           |    1 +
>>  drivers/iio/adc/ti-ads112c14.c                     | 1053 ++++++++++++++++++++
>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |   11 +
>>  6 files changed, 1309 insertions(+)
>> ---
>> base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
>> change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e
>>
>> Best regards,
>> --  
>> David Lechner (TI) <dlechner@baylibre.com>
> 

