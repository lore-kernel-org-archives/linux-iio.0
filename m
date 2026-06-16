Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476847A0D4
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630837; cv=none; b=g7QGkNMFsKfVtlbujNRV2X8IyBXLyAtiW6oFyDxQP79I8QskqqSFdHxFwn8h9d0qbAqdztu7wmCIwWQa67XcDteD6CCN+EFU2hv/eKRxwraiSxjL0sLlbKIqYYOeIZ1D3cQtG8nMQMh8+NtucGbaa0n/VRrcnxtxEvKn6GVjEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630837; c=relaxed/simple;
	bh=USp5WdhvQ3MeifLT/XFpVHX5rd59XSUKlYpZOB/7If8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=OKJPyPexhzZZgGNtjEGSZSYZYiIxuCtlmtMkOAwD1ZMuvBW4l0uRkr3RSX+x25bGehaHZvRea2xrCiKuFV+Z2iWOG9DlUQ8K6eUbFLRuG+PIVtNXS0mTgvY2lFtlmtS39dSD2vYzs2BvxzOJQlBJ9K+fLoD8pEHzkN3qXdLM9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeoZQQMa; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeoZQQMa"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9667ea2fc22so988932241.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630831; x=1782235631; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAOtIJz1/9y1wuDUHu4I6gop50GkdzNRIO7VAPrvWDE=;
        b=CeoZQQMag+OqpG8ERGvK1iRNuRpvMRiP6XDBRDGba68W5SSvlYlbhINzSk2De7Fr4i
         LKbqz0cWhCZD+ZY9acRj3eXjPE/jnlxk/Z0g4TwZ6GP7Fbg21mAX8FSeE/MOr1RLJ9uM
         f1hZ7kJ1AScb+5pKRGiuRHNnd/86PNJXo5yT8vWHfz5K05udepA6SxvjqYZFUAjO2ziR
         UJTPOCu1FCtOiOIBUwxBC3llAhxanH5A0gtLEtyak/j2/sx0WdKDFW0wmcshKYwbtNxV
         yHEsMLfl0JdA4gdFqZxd0LjC/h0xDSG2FqpC/vKq/mwRRqTvr/bizRoPyQKtg/00YcuE
         fMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630831; x=1782235631;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAOtIJz1/9y1wuDUHu4I6gop50GkdzNRIO7VAPrvWDE=;
        b=N2WvMXCp7rkgt3PKQLUtwEu+uiw3VDQjt3mO547fYoGWk0qYRmgBA7YbqSpT5FwTkk
         09uX7AwhcdWNd6dVReUJT6rD9MT/oM22RbUE+bhhExdi0+NRHsQ+rKCwlIupZFb+9zBF
         Kp71356wT1c79QJah3SHdjVyLVYNy6OyJozXPe7seNrMXXwAcm/mzfjuV0ypLMAx9G9i
         Sw2Qoe8XXJiABYGvsw5XZ6/+yBh7LPf9NtWFWtMOwtmQXH8d5jylhNO74XYU6w41hwKn
         qFiQ3fWUC9tuwFwyfHTJY5t3unmaOibEnoXceQslL3IiuIuVWcEZ7Wrtbk+lL+wnfY6c
         HqVA==
X-Forwarded-Encrypted: i=1; AFNElJ/PGNDHVVr2YoupvUeklcM+Pe3L+i9ilqeDRjx7qeENEK3D1+IHCl+V7jCaHjN1fu53FjP7/lNkHrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUgKMa/GNBZg5R60L+aAlm3j/EtA36XANxyJI8GS+lYaOCMDe
	1b4Te4Ssmq0AXexFQefLyqCIuHHV8gEqvQhBFZX6qBvm5ubBT3PyzSrL
X-Gm-Gg: Acq92OFF+u6dlmx2cnJLhmp2paJWLBsyGaESU8gfKbTCRlNhTBeqBnhuLjf2auxhJkY
	EOl07V/j8HyLHuI7a9qHob9vMWBkfYwRA2gRHcpebfyTbPvHpYgqZzGiANWfyFQQvwduUKRViVu
	/FIohTqbXMU/+vBXbeviRawHcJt/iwKP2Fhuy6k58FLNPoFMIusd1g1375JLfTxY9XtD05BAIB0
	Za3ilVAXEWbhMovvaemwF7EOaw/+eP+xXosztnrdCVCcJWmGsYsrs7DfGM5aNFiACkSNICNhqJx
	kgGrsNExn/cFQgMoDySnWPi2bdZRHaexvn4YUtleAdqTugKSgT4oEzSIMEKcSO1PJtzBcodrQ91
	ajG7vBIRae0C/H6FKD2mOE/Hx0eJZ/qbP3S7wtZ11YsnAiZbW/N+qIyXyRqgUW/OUItwWn5Vp9L
	+AkRP0o855xm+Odg==
X-Received: by 2002:a05:6102:8498:20b0:6d3:aad5:6d16 with SMTP id ada2fe7eead31-7246c88cf46mr138008137.16.1781630831007;
        Tue, 16 Jun 2026 10:27:11 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966a05a6cb6sm5923169241.8.2026.06.16.10.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 10:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:26:58 -0500
Message-Id: <DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: "Nguyen Minh Tien" <zizuzacker@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
 <d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
In-Reply-To: <d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>

On Tue Jun 16, 2026 at 10:21 AM -05, David Lechner wrote:
> On 6/15/26 7:18 PM, Kurt Borja wrote:
>> Hi David,
>>=20
>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
>>> This adds support for TI ADS112C14 and ADS122C14 ADC chips.
>>>
>>> The closest thing we've seen to this in the kernel already is ads124s08=
.
>>> However, that has a completely different register map and the DT
>>> bindings are incomplete and the driver is extremely basic. So I've just
>>> started from scratch here.
>>>
>>> We've also had a similar submission recently for ADS1220 [1]. That chip
>>> is in a similar situation to ads124s08 in that it has a different
>>> register map (but the submitted DT bindings are better than the ones fo=
r
>>> ads124s08, even if still a bit incomplete). And literally as I was
>>> writing the previous sentence, another series [2]  was sent for yet
>>> another similar family of chips (ADS1262). That one is even more comple=
x
>>> in the feature set than the ones I am working on. I was going to polish
>>> up the driver a bit more before submitting it, but now it seems more
>>> urgent to coordinate with the other two series to align on how we would
>>> like to handle all of these.
>>>
>>> [1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacke=
r@gmail.com/
>>> [2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03=
ed@gmail.com/
>>>
>>> All of these chips have in common that they are designed for use with
>>> RTDs and thermocouples and so they look very similar to each other in
>>> terms of wiring and feature set, even if the register maps are
>>> different. They are in the gray area where we could either keep them
>>> separate because they are just different enough, or we could do like
>>> we've done before with ad_sigma_delta and have a bit of an abstraction
>>> layer for the register differences and otherwise try to share as much
>>> code as possible. Normally, I would lean towards keeping them separate,
>>> but in this case, I'm considering trying to share code because the
>>> devicetree bindings for the inputs is complex and is going to be mostly
>>> the same across all of these chips.
>>=20
>> The channel configuration is indeed very similar for the three chips.
>> All three have IDAC, BOC and VREF configurations.
>
> Hmm... I forgot to include the burnout current in the DT bindings. Follow=
ing
> the channel =3D "conditions for measurement" pattern that I have set out =
here
> I guess that would mean that we would need to have the same inputs twice
> when using the burnout. One "channel" would be the one used to do a "prec=
ision"
> measurement and the other would be the one to do open/short circuit detec=
tion.
>
>
>     i2c {
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>
>         adc@40 {
>             compatible =3D "ti,ads112c14";
>             reg =3D <0x40>;
>
>             avdd-supply =3D <&avdd>;
>             dvdd-supply =3D <&dvdd>;
>
>             refp-supply =3D <&avdd>;
>
>             #address-cells =3D <1>;
>             #size-cells =3D <0>;
>
>             channel@0 {
>                 reg =3D <0>;
>                 diff-channels =3D <1>, <2>;
>                 excitation-channels =3D <0>, <3>;
>                 excitation-current-microamp =3D <500>;
>                 current-chopping;
>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
>                 label =3D "rtd-precision";
>             };
>
>             channel@1 {
>                 reg =3D <0>;
>                 diff-channels =3D <1>, <2>;
>                 excitation-channels =3D <0>, <3>;
>                 excitation-current-microamp =3D <500>;
>                 burnout-current-nanoamp =3D <1000>;
>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
>                 label =3D "rtd-diagnostic";
>             };

This would mean we wouldn't be able to use iio_chan_spec .channel and
.channel2 to describe inputs because of duplicate sysfs attributes, no?

>         };
>     };
>
>>=20
>>>
>>> If we decide to go the route of sharing code, we could still merge this
>>> series as-is and then do the refactoring to add the abstraction layer i=
n
>>> a follow-up series that also adds support for the first of the other
>>> chips.
>>=20
>> Do you have a proposal of how such an abstraction would look like? I do
>> like the idea of abstracting the firmware parsing, scales and shared
>> calculations.
>
> As mentioned, it would look a bit like the ad_sigma_delta ADC driver.
> Basically, each chip (family with same registers) would still have it's
> own driver that include the chip-specific const info structs. In this
> case, these would also include function pointers for all of the functions
> that need to access registers. And there will be lots of supports_... boo=
l
> flags for the shared code to use.
>
>>=20
>>>
>>> This series includes just basic support for reading single measurements
>>> from the ADC and gain selection via the scale attribute. I plan to
>>> follow this up with additional series to add support for buffered reads=
,
>>> filtering/oversampling configuration, event support, gpio controller
>>> support and perhaps a few other things that are slipping my mind right
>>> now.
>>>
>>> The most interesting part about this (that I alluded to above) is the
>>> way channels are handled. These are multipling ADCs with differential
>>> and single-ended inputs. But what sets them apart from other similar
>>> chips is that since they are designed for use with RTDs, there can also
>>> be a current output required to excite the RTD and this current output
>>> might be different for different channels. So the way I conceptualized
>>> the channels is that the devicetree specifies the conditions needed
>>> to take a particular measurement rather than being purely a physical
>>> channel.
>>>
>>> This makes things more flexible, but does make the driver a bit more
>>> complex. For example, knowing when the current output needs to be
>>> enabled or disabled. For now, I have chosen a lazy-enable where they
>>> are not turned on until the first measurement is taken that requires
>>> them, but then they stay on until another measurement is taken that
>>> doesn't require them. This can lead to some oddness with the diagnostic
>>> channels that may be measuring something that indirectly requires the
>>> current output (i.e. the external reference voltage when it is connecte=
d
>>> to a resistor rather than a power supply). This means you need to take
>>> a measurement that requires the current output to be enabled before the
>>> diagnostic channels will give accurate readings.
>>=20
>> This is the same approach I took around the BOC, it feels kinda hacky
>> but it makes sense. Just an idea I thought about just now: What if we
>> have an additional write-only "_enable" sysfs attribute for these
>> channels?
>
> I would not want to make a write-only attribute, we always want to be
> able to read back what the current state is.

Yeah, I don't know why I said WO. Reading would be fine too.

>
> Do you mean an _enable for just the BOC? I think I would do it like I
> suggested above instead.

No, no just the BOC. The BOC, IDAC and rest of side effects. Thinking
about it some more, it would be a bit redundant but clearer if proper
documentation is provided.

>
>>=20
>> The approach I took for the IDAC was to have a single configuration that
>> it's enabled for all channels. This makes some sense in my device when
>> thinking about optimal software sequencial reads, because of the
>> register layout, but I also see the value in having per-channel IDAC
>> configuration. I think I will take your approach, so we have the same
>> channel configuration around this.
>
> There are only two IDACs but on chips with 8 AIN pins we could have two
> RTDs wired up and if both require 2 IDACs, then we can't have a fixed
> setting for the IDACs. This is why I made it per-channel.

I'll make it per-channel too.

>
>>=20
>> Have you thought about how to implement the BOC? In the ADS1262 the
>> feature can be found "Sensor Bias". What I did was add per channel DT
>> properties for this too.
>
> See above.
>
>>=20
>> Another question. When you implement power management in the future,
>> will you enable autosuspend? IDAC currents will be lost if autosuspend
>> is enabled. Is this acceptable? In my case I did enable autosuspend, but
>> I have some doubts about this.
>
> I don't like to implement power management unless I have an application
> that actually requires it. Otherwise, I consider it premature optimizatio=
n.
> It is difficult to know if we would be implementing it in a way that is
> actually useful for a real-world use case. These chips seem like they
> would mostly be used in an industrial setting, not in battery powered
> applications, so I'm not sure anyone is going to worry about saving a few
> milliamps.

Makes sense. I can probably drop the autosuspend in that case.

>
>>=20
>>>
>>> I have also pushed a branch to [3] that contains the start of some
>>> documentation for this driver that can give some more insight into how
>>> the implementation works. It still needs some work and also documents
>>> some things that haven't been implemented yet, so I haven't included it
>>> in this series yet.
>>>
>>> [3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Docume=
ntation/iio/ads112c14.rst
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>> David Lechner (TI) (4):
>>>       dt-bindings: iio: adc: add ti,ads122c14
>>>       iio: adc: add ti-ads112c14 driver
>>>       iio: adc: ti-ads112c14: implement gain on internal short SYS_MON =
channel
>>>       iio: adc: ti-ads112c14: add measurement channel support
>>>
>>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  224 +++++
>>>  MAINTAINERS                                        |    8 +
>>>  drivers/iio/adc/Kconfig                            |   12 +
>>>  drivers/iio/adc/Makefile                           |    1 +
>>>  drivers/iio/adc/ti-ads112c14.c                     | 1053 ++++++++++++=
++++++++
>>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |   11 +
>>>  6 files changed, 1309 insertions(+)
>>> ---
>>> base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
>>> change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e
>>>
>>> Best regards,
>>> -- =20
>>> David Lechner (TI) <dlechner@baylibre.com>
>>=20

--=20
Thanks,
 ~ Kurt
