Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696108;
	b=tMHPbi62cnT5ljXg5zxQccakpqXTXYzos6EbIR4lBGRtOVmUuYOUPUfxi2pMXb0NR+Wo
	 lND8v4Dx5yLw/3ycti3+YZBIf7LxNb3omxK/WesmEPTgrjpf4lNtKaiL8Y+3AwM/MhcSi
	 gKfQkjS4IQHImRX6X674AUzAMPREy4vxsDxX7TVdXnMALDLcXldi94Y0Rd9PHdcWSyMfP
	 p6wH5mdyH18r1q7t0+nsGKpV0BQF/3mNCxj1SvjGyyxDGcLApqNcpIGrIpHJ5LUlilh5k
	 B238orUI3GQcrSWiSdKXwhazdwlk5Cs68g96ltNU2b9VxmW4HxbCaIdFyspTdDIioeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696108;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=xu4Hob4T/c2RBRj9oSFW3u62G/KKa3D4oPKEkYrOGh0=;
	b=STc34x28KERxoNMYw/cPvNTdQaUbvoAv54YpnuG1DDV5LVgB3sQ2XgN6RT8RqTqbhNGK
	 6STchDJM0RXngAzXbI04if9P1e2HHNk2l2lkGpEO1hzwzINhuUqUdXDrpmf7Sq1MTIf58
	 6GDgLzhqmfGFg13mIfhGri/R/wAMUlbSm9cQNaeULcF+NI2St7VJ3u6650KUW/Uq0xdkA
	 HWAJdw0F0w130sJL1yIHFhKFXQMMae0pTK86ZBd+uZojqH+RWpsPtPBjOHr6gEDxFki5O
	 VMQbiOw+B2g9LJHgWzZ6kzJMsmFMvyRBkUug5P+05qnYdjD2K0GPC6Bi1JzB07Af4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=e6OCY5HE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gPHaXeVY;
	arc=none smtp.remote-ip=103.168.172.137
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6072606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6072606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=e6OCY5HE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gPHaXeVY
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id BD99413803EE
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 07:28:26 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Thu, 26 Nov 2026 07:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795696101;
	 x=1795699701; bh=xu4Hob4T/c2RBRj9oSFW3u62G/KKa3D4oPKEkYrOGh0=; b=
	e6OCY5HEsHMWHDpNXuor4iPuoUZRz06OnWHRGx/Ba40dgAc6p6p/mYAxy+wY5LRR
	JeUV2w/vhulJh1cNFQtCqxlRQBwJ8z1ZAwb44G6SxLAE7TK8dxzFTkB8/MNdEYDN
	Cgsw70JHXhX8zRa3qRQONfffGFLQMBiLEd5LKhTTrDEM7vyWwmsETbX8SfUludqI
	FpN1Iw8sAUxQpUCc997EFsnnWP2ComIns+MtIhUmClaGfp3r6UnAbqyjgn8s5ibZ
	7K2ehZuRBPU0C6fP2IeaHaDF9hO+ixpnLJ4qDm+FIIfQk3YLGOiiF07R3sr2IWtR
	yROge4h1CIePk9TBBlnveQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795696101; x=
	1795699701; bh=xu4Hob4T/c2RBRj9oSFW3u62G/KKa3D4oPKEkYrOGh0=; b=g
	PHaXeVYZ/awO7BEIXECg9Z9mXPu5macsqgjq5m/8KsyzM0r0GinSKa+LDTmPypPU
	wUem9iJ9ynhVjSv/fB4OXr361SQWYQUvUD8a9y6kna9fZ6vyRh7g88eICT4ekHlY
	WRDg/Z4Q/4UnGYlGYve8WM3H7Zy5dijr4wd8mxY5LLTNwh54jVFrakYnNK/5BvKO
	xkNT6huE2oQWBzXSVMDX4iF8znKYV8kpaUVYGWVXFmudhWIutNo4UqHZ5wTUOr1M
	t+dhRNMd+jhM/DsWxXQM8g0ISBhZCIqYIBq7upvYUP+oM/Li0ACHaTs50JyCHHZG
	4kkepmtkG+b93LOCTHmbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795696101; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:j+4Ft+oosK9Oydl+Z3zF7YOA1MvwyQ2nIh0bUriP9+nFvXy
	CiJtMz810TCOAbH4KyB+J+1F11KuThvK48AkNX0KwkLzoeGlSz4RQoVwqJZbAnFx
	BCYGd8njaeD6CHOCx8XhwPqeC0VyWWDXR1tHMZlb18o9tE6JtENlHJXEUeQQ9GdT
	Kj27601yxGf/VdcCbfdxiO/jCp4vRGue+3WK5VASNCz5ijHoSxsDfMug1tUbrz88
	xdWjFW7+9A9qQf6ZGZejCH7yp8YJcUNZwwT+qdzfkg2j+Y63e1AqijRTM1agWHty
	k30l+EwFjch64Zub5ce8zFFAwE47lpz//+15d1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jkOwiisYvaimaD7aEFu0qippkfrPA824FSsblOr4xpw=:OiNd1Uft4081bt2SCEBPZKHGE7rtaoQoTYPz7jv/7Oc=;
X-ME-Sender: <xms:4SUIa7cGedfw092ux_ZCeI0sjCj4irwMpx6uQj2nyUJ7zoL7W46U7A>
    <xme:4SUIa8AZ0zhhDP4t7IeiSnEWG_U9fP4k94KqN5sln3DvzAAp1v0MooMx9tGDnuEwe
    fW49hCOWagmPy-mm5Np3dDIVYuhux8DAPTLu6_p5djkX_eAR9i4ZTl1>
X-ME-Proxy-Cause: dmFkZTGVm0NwrNPzjnsePArY1oNZC8jCvyBd1JNrwF5KI+JZaZ2MpkN+KcCFQFw0MoHSUX
    6vEsjBKhDtCDDqGJbDtk1/F8fxeAfSIqmXJJQMjVt6vG6UD2h5npdRupHgDcaDs268kS4l
    aZ98Ye4pgHukWz2ktCJ0OHs4JQ2IUYRnOOLksu3TJpR7N4vaotEtoQEADjvZI6MXUCZHzF
    VAvrj433NYrLM/wLUnJ/LVskJORGCahkPXm+7f4QAh9iSHp669vTPxdmEZ2z+VAeYELGL1
    RcKNCume5IIJJeDcG1PvBkfNTUcPYCkJUbv98fvlv8SzX59Z6/+VPhvMKmCDt2SoRM0yVc
    8MZtBZw3up6rtTYZd1sTXDOv/asORVwHreP2NYDYFk81oGYxOMRTXrb3Cj/DzeM1WoNtmY
    uSCltdT5SYTv4veZj0XHJf0ymdCEZSKcNFBz14Im6WttQhvzKeNZZomlMxcZ8Ho8alJ4nc
    2g7RwBV4BrMLLCAvzuueIrah78IKPmpgere9RGE276BLeL0znRut4UPdhta1CeuyOm1t6q
    +2ioy79p/duh7zcJOmW6IlwbiU4Ri760w2jBixK9uX2947W1tHr4iVB9dxn9ez7EzJ3/bJ
    +8tMvM+rLhcKFSkiS3UjQxjz3Eb4rzFWJsC9aTCPOA4gYI94jLpioivHgWKw
X-ME-Proxy: <xmx:4yUIa72EDJ56HSB41dkGWe1HGZD3vTaywXNDV2SiEGgfmlWJPkGhOg>
    <xmx:4yUIayMk0fmBKWyeCGEm2tCvHK_slq2nP5Ww6yZtSju0Rj1lbc0sEA>
    <xmx:4yUIa7biYLjmHB3Uw83X0njxb5EP6YGHSGpqlIAUxLMHwlG6KrE0mg>
    <xmx:4yUIawyKIrND_LjniQUbp1BuIfxbsxzz71Vmd74EiS7XpfuUJi5iYA>
    <xmx:5CUIa7mYZAIs0an1vbImXT_aQ14qy83LK5YxBf01KlK3UyXqeIydKqUY>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 65656F800A1; Thu, 26 Nov 2026 07:28:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AJ3dJRnBKuuc
Date: Thu, 26 Nov 2026 13:27:57 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Biju Das" <biju.das.jz@bp.renesas.com>,
 "Biju Das" <biju.das.au@gmail.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-Id: <3b689e6a-98ad-422c-8b67-45d4a44377f2@app.fastmail.com>
In-Reply-To: 
 <TYYPR01MB66036BB057404C15BB64E57B86422@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261125-usb_rzg3l-v9-0-ea14d3ab8a53@bp.renesas.com>
 <20261125-usb_rzg3l-v9-1-ea14d3ab8a53@bp.renesas.com>
 <a152df0a-0b0b-4193-b3ac-ee0df0350802@app.fastmail.com>
 <TYYPR01MB66036BB057404C15BB64E57B86422@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Biju,

On Thu, Nov 26, 2026, at 12:53, Biju Das wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>> On Wed, Nov 25, 2026, at 12:05, Biju Das wrote:
>> > From: Biju Das <biju.das.jz@bp.renesas.com>
>> >
>> > Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
>> > exclusively by the TSU) and TSU nodes along with a CPU thermal zone
>> > using passive and critical trip points, with CPU frequency cooling
>> > maps for thermal mitigation.
>> >
>> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>> 
>> Thanks for your patch!
>> 
>> > --- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
>> > +++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
>> 
>> > @@ -381,6 +385,37 @@ scif5: serial@1004e000 {
>> >  			status = "disabled";
>> >  		};
>> >
>> > +		adc1: adc@108c0000 {
>> > +			compatible = "renesas,r9a08g046-adc1";
>> > +			reg = <0 0x108c0000 0 0x10000>;
>> > +			interrupts = <GIC_SPI 378 IRQ_TYPE_EDGE_RISING>;
>> > +			clocks = <&cpg CPG_MOD R9A08G046_ADC1_ADCLK>,
>> > +				 <&cpg CPG_MOD R9A08G046_ADC1_PCLK>;
>> > +			clock-names = "adclk", "pclk";
>> > +			resets = <&cpg R9A08G046_ADC1_PRESETN>,
>> > +				 <&cpg R9A08G046_ADC1_ADRST_N>;
>> > +			reset-names = "presetn", "adrst-n";
>> > +			power-domains = <&cpg>;
>> > +			#address-cells = <1>;
>> > +			#size-cells = <0>;
>> > +			#io-channel-cells = <1>;
>> > +
>> > +			channel@8 {
>> > +				reg = <8>;
>> > +			};
>> > +		};
>> > +
>> > +		tsu: thermal@108d0000 {
>> > +			compatible = "renesas,r9a08g046-tsu";
>> > +			reg = <0 0x108d0000 0 0x10000>;
>> > +			clocks = <&cpg CPG_MOD R9A08G046_TSU_PCLK>;
>> > +			resets = <&cpg R9A08G046_TSU_PRESETN>;
>> > +			power-domains = <&cpg>;
>> > +			#thermal-sensor-cells = <0>;
>> > +			io-channels = <&adc1 0>;
>> 
>> <&adc1 8>
>
> With the above entries, I get below error as adc1 has a single channel
>
> https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/iio/inkern.c#L135
>
> [   15.067383] iio iio:device0: invalid channel index 8

I am not surprised ;-)

>> You cannot have "channel@8" in the ADC node and magically assume consumers should refer to this using
>> "<&adc1 0>".
>
> ADC1 has single channel and HW manual says it is ADCR8(A/D conversion 
> result register 8)
> That is the reason for channel@8.
>
> You mean I should use channel@0 instead to avoid the above error as a 
> single channel
> registered by iio??
> 	channel@0 {
> 			reg = <8>;
> 	}

No, DT describes hardware, and the hardware manual says it is channel 8
(and FWIW, the "reg" property must match the unit address).  If you
want to deviate from this (I think you don't), you would need a DT
bindings header file.

>> I don't buy your rationale in [1]:
>> 
>>    "There is a mapping between internal Linux array index (0) and the actual hardware channel ID (8).
>> 
>>     See the code
>>     https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/iio/adc/rzg2l_adc.c#L354"
>> 
>> This mapping is in the driver, and there is no mention of it in the DT bindings.
>> This means the driver must be fixed first, too.
>
> OK. You mean I should add custom of_xlate in driver?
>
> Please let me know if you prefer adding .of_xlate to the ADC driver
> so we can use <&adc1 8> in the DTS, or keeping <&adc1 0> with the default
> simple xlate.

Please add an .of_xlate() function, so (possibly sparse) hardware
channel numbers are mapped properly to software channels.
Thanks!

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
