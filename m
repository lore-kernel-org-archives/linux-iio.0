Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC830C142
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781474244; cv=none; b=lRqTJl8WVAZhRUsuAvz2br2bSn7W0VMy7BEtZ653uTMnSjZhUkpSwj1FZRWJ2Xf9yZvn29ADRznFd34AjSwqgzX5OW3YaMMlhYlzwjXjIidzJt15QzwCrqk3b4WUIAHBjhM3kbHS4hSmovKLDtsiAhA8qEsLuS14WJ8jiIWEGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781474244; c=relaxed/simple;
	bh=sGk/U72tZEkF2KYoBS0hK0weNNaNbKa7jZafhRh3xvc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DB+v00uOvqscz1rlS4ko6Bbv0HPchxel8Ssieq+Mcq4SB8V0AdW25j+JH+KC6LHzVFsV62er1tF23eR/JiV8Nfpr8+pwk3PafLIkBBQ6QDPpU2uRAJ+bB2JKM7jhvs284nPJSCmw/f1bkXL2gjiMOz2bcU/i7czHPA5rUqsyUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju/bKq0M; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju/bKq0M"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59dc1714d44so824387e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781474242; x=1782079042; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slxehqDwE4bbkZOJYryV9/GE1Y8sTVTKoHQjRDCh1JI=;
        b=Ju/bKq0MhFa19gp5dONOLYd8mG/3iCYnjUMY8795tyzVGI+KTIe9eEpQwKJnYCF2Db
         xxJkh6znSl25lMreue0JZsWuTdAz67YQyowKquBG0keX+ij7U726SV0ZhFcrqaFydJfZ
         GP3L7YsUZy6lgYJf9qsD4Hg0ne4MKl/rJvry5F//RWjTil3ewhELx6zk04zOOqYMnG9r
         hui1dKm/2CjzbfLE4/Vu7EMXBGDASFzZjYo+EujfIUl9V/2/rl+UXRawFA7Rlw8GylNd
         oOO384t7A0uoNYvXHDRm0uOS7BepVsqXXXQNflW9RQQixfsYMJQj0yHIoCtYR1Xf2qup
         x5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781474242; x=1782079042;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slxehqDwE4bbkZOJYryV9/GE1Y8sTVTKoHQjRDCh1JI=;
        b=cZTstF+BG+6Nf+CdPr2DuA5qXOflSJRfB5xDiu4C97J0572j2U7TXiRrqhceyxW1hC
         +Ldq1lUrnZUYTQHT4FGzaxh16Rhm3F7Oym6VFPysio5qnJaoTF/Z4P26XKN4P7HvsR7b
         XyEkfFRVcD/HU+xeRCIwJ7keMiDb/RawlHgdyADCXGOd5NVIoPuBSVCsgjYaeHTxImN1
         l+pt/VH2+OvanJXE+Um1nNAIRUkpuCojU/9lmdiTGvrcV8KAi9RV+OyFjOzr6YcWsxVz
         lavJLIlK8vk8Z87oNTfHwnoKFxRGYHc4VCFOG8DJ4y/faCXlNtLBsTajXEXrhrAcXfbJ
         uY1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9C6KFMzvYLCv61qQltfqa8Qm9oQ2SpIh+uNAn6kH5x9VtDC2gCOAD3uIdxv9a/hVreIJ7he2TYWGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHc5AkA7jNgbjnWQ6wJ+gqNTctjZvw/G2kdzaQ2VfAlvX+yR1A
	fLk9FQ32IaVsM44CevOIrhHHDjqFJtjVfGicP4IT7X0Wrb5n5gTw45Aa
X-Gm-Gg: Acq92OGHKp3d7/0RzFAySOgtpVVBTLqRqybt4kzaUX7JdIRG5OnAwrru0G5NE3ztyKe
	k6RI/JRfq/49M3Ki+Gs8r04KJhBZTB5N0heoNSvvv7eIhn/cB5G3k2rk3lyEzKwwx+upUnqsjVW
	7cucrO4uWkbgdo1DrrLQW7P13MqCkFs0ozWRRrW7vn5oz70SOCswwEou1MXHBObg+VkrurWQZpr
	pxXGLfE/0i+1zqUy7XPqkLnisJ56VLChQT8Bi2FIAmKTMujb951J9RTAxZ5tPaIjN2nB7o31Zmc
	kNGveIR7G95DF1L00ruyiSlHP99norUv5GOe6bRSzLE5pSAt2lkiQ5UaT2PH1dXn4IOwtvmIsln
	gwhfOHq88qd33iNOLlhpp/FZo+HCFbl+cKn590ABRHA6ApJpYDFvvJjHgPxjogvuwvf1Q/TGpBj
	vYVZYXb/CrVvXD2A==
X-Received: by 2002:a05:6122:513:b0:575:24a9:78da with SMTP id 71dfb90a1353d-5bb6c0ec1b4mr5565063e0c.11.1781474242047;
        Sun, 14 Jun 2026 14:57:22 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb8ff961e3sm2159691e0c.3.2026.06.14.14.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 14:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 16:57:13 -0500
Message-Id: <DJ93WSYC3HTT.3NXQW390CLQ82@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: Add TI ADS126x ADC family
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-1-894c788d03ed@gmail.com>
 <20260613-loyal-azure-goldfish-cf6d54@quoll>
 <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
 <f13b9c55-770e-454c-9bfb-5847ff17813b@baylibre.com>
In-Reply-To: <f13b9c55-770e-454c-9bfb-5847ff17813b@baylibre.com>

On Sun Jun 14, 2026 at 4:37 PM -05, David Lechner wrote:
> On 6/14/26 3:53 PM, Kurt Borja wrote:
>
> ...
>
>>> Not a separate device node. Fold into the parent... or explain in
>>> commit msg. You have entire commit msg to explain odd things.
>>>
>>> In that binding description you call it "independent", so it should hav=
e
>>> its own SPI chip select? Why "independent" and part of this binding?
>>> Maybe not independent, so basically part of this device?
>>=20
>> It's independent in the sense that it is a proper subdevice on the same
>> chip. It shares the serial interface but operates completely in
>> parallel.
>>=20
>> I decided to add a subnode because other devices might request their
>> io-channels and most importantly a different voltage reference might be
>> connected to it.
>>=20
>> I'll clarify this in the commmit message on the next version. Although
>> after seeing this submitted bindings [1], I wonder if it's a better
>> approach to do something like
>>=20
>> 	spi@0 {
>> 		mydevice@0 {
>> 			...
>> 			adc@0 { ... };
>> 			adc@1 { ... };
>> 		};
>> 	};
>>=20
>> Any thoughts?
>
> I don't see how this relates to the linked patch at all. The linked
> patch looks just like a normal DAC binding.

Ah, wrong link. This is the correct one [1]. The suggestion just at the
end.

>
> What is the point of the 2nd ADC in this chip? Is it just to be able
> to do simultaneous sampling of two different measurements at the same
> time? We have other simultaneous sampling ADC chips and just model them
> as a single device.

It does simultaneous sampling of the same channel, as well as different
channels. Also the secondary ADC is only 24 bit instead of 32 bit, has a
different noise profile and has a different PGA configuration (goes up
to 128 gain, instead of 32).

Taken from the datasheet (Section 9.3.15):

	Use ADC2 to perform main channel (ADC1) cross-checking
	measurements (for example, diagnostics purposes and redundant
	channel measurements), system background measurements, or
	temperature compensation of the primary sensor (such as
	thermocouple cold junction compensation). Using data rates of
	10, 100, and 400 SPS for both ADCs, ADC2 performs virtual
	parallel conversions with ADC1 on the same input channel.

>
> Since everything can be muxed to either ADC at runtime, I don't see
> any reason the devicetree should care about it. Forcing certain pins
> to be assigned to a certain ADC seems overly restrictive.
>
> And unless you have an application that specifically needs it, I
> wouldn't bother trying to implement the 2nd ADC in the IIO driver.
> I didn't see any hints in the datasheet as to when it would actually
> make sense to use this 2nd ADC. My first thought is that it might
> make sense to use the 2nd ADC for a 2nd buffer so that you can do
> 2 buffered reads at the same time. But without knowing why this chip
> was designed this way, I don't know if that is the right idea or not.

I myself don't have an application for this feature. But I don't see why
not adding support for this feature, given that I already implemented a
driver (Patch 5) and is capable, as you said, of 2 buffered reads at the
same time.

I do believe I have to explain all this better in commit messages
though.

>
>
>> Ack to the rest of comments.
>>=20
>> [1] https://lore.kernel.org/linux-iio/20260519-ad5529r-driver-v3-1-267c0=
731aa68@analog.com/
>>=20

[1] https://lore.kernel.org/linux-iio/25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3=
ce3oqzqz56ehi@le72iqv7ye3d/

--=20
Thanks,
 ~ Kurt
