Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA5330311
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586814; cv=none; b=VAZzWB1lNZFO4qiaizE6PTAOT1aGON0JzBVRfDw9kHt0wjPRbaQTIJPo+WPn9bw1q6ZVlia+ZPrATX8U/ETnJSEI9wpEV+O0eHAezZaqdJx3b65fn84U23jg2nC3g/lddFV9PFQihQ/p5I1IXzHPWTKJ/VvzDAcnNVOXZAKDRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586814; c=relaxed/simple;
	bh=m91/Pj6i562vC9RgSAKF0lAmXFt7YMj8wOrD5dUjLts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hqMPS6OsjUH2qZFZJ+NYl1Y6gan5vUa8+b19YPR01sxiYmjzhEG3DWfgmAfoYpALbVd+Ygv1SiP+S3jTr4a/u4DD4sejgnNx8txSc6HDQgRIftunNQOW/LWJXoPMSk1AsbjPNsveZz/qzhuaL2sp16b3ErGMI8tPVnrdXs5cHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=WlDvS1KO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="WlDvS1KO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so2537911a12.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771586809; x=1772191609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83zz9Fx5gsW9BIv6c8ksqWZjM7IcWR5idqwhbUOB91Y=;
        b=WlDvS1KOyibyFVCCqJYzkavPTQYwMCrJrR1gCfkhpkNF23AFSKSY+Up0Iv6MUlmgxE
         PXDuz1A/97WtcAr0YtYUGl7rJ68Bh/eE6CONVuBcbcodcwMl5QgtPKDX6VNHyDzCpc8u
         H0dkeiQYKV24KqYmXnT/GjGoGJKHYR/a+a6k9xkGUjFaZq+sB99hUzVrr5ot7LbV/s1L
         vVXJF3vftRivB5EREc9uShQmwh35W8/9GtfzeRuISyBK/3U3D/wZpWRDstRzvYY2PVxs
         hKVSH4Q5Tz605zqKfqa5PSxa4Oi/KgW4IFVmuEPejgHiNP1bbBvnI4Ozo7FsnIsjpQZq
         fO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771586809; x=1772191609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83zz9Fx5gsW9BIv6c8ksqWZjM7IcWR5idqwhbUOB91Y=;
        b=s2g98hs9jJX8LrHjaFc8BCwrwSRCtgIWwS07lanpCUK/A69JZRpTQdkdQTqFm+lI1v
         PA7SHzvomQ4t9Gk5Eex4mA7r0UcQ4w/Dy7jb3j7OyV375oymnYL67grOVCEzMZ+SD2Zo
         86JURs5yPNq974jQAN/i3cmhH3nA/CWk3G7hOfZPImPzJZIdyX2sHVbBqtu2578rxu2t
         521CFxCaiTHbUelEThKMap0o1GAY6Dnbsy+CbQEx9WfkpEc6UE4nheuVoOtTV1mem9pd
         bH5PPtJAAElvXVclYeKA8p4KRpQCUJ1Fk9kEQLbUZdqyrizZyO6nKuqQvQUxrG6K8T4R
         GeOg==
X-Forwarded-Encrypted: i=1; AJvYcCUEJzKG1JcgkC0ytsbw4GCL+7cXa0/pwMiYp7V354k0HRNhKY/W6fT+bFZy3/6Iw5Lwm/grPi9pbR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDJUrESHXJdU8a5B5egmY6ol8CvBxm3oa0nA87xzr2yLGttx9
	wR8E3KpxxaYn/2hkdu5RKfKB1ZCQB17p9GRpNnitR6DRbiLEoUWO+dq1F1WkjsHZEVc=
X-Gm-Gg: AZuq6aKC+NeRbPVWRoUc1N2kJc9yWU3nsXYNoLFwMPhjzRCxP1ieLahiHkx6xrAGwJ6
	em/ja4HQL0HIp4OH9psuv1cYOJskH7o0DaO1aa8ruI8NVHfm1t24B2YtkOiJibVXDEM+Ba39ZEh
	81JDq6H9ueHu3Pqiw6/vg7di5/pCCNKjgOXEXGnutBMJgQ+agsjKdqjbak0bpOh4bEL9ndJtGuu
	bUVNau/Ve60D0j/NfygSRztzwPYH1J68JUtMwLNjJF0Jl+Jx/hR4R3Le3I99JzZhHhM5I1LgNzA
	Xj+STm8zs0dzMW6qYQzsOQ8vQJhWLTYucFJQDyM0vJue4Ydmt4qjIzMWzfA8hmCM9Vj3Ob/TC3N
	kErFY3xsKm7y+NcdnpaX7q1bmPtPSPzVD6RyfTmICMM42NNlGOYPgIWO2n5rN5S426E430+rQnB
	/kYV+q0EFbidvbc30Cr7sBup+MSTexmoA75s9w27sqmZ9Xhz1AlprDT7zdAa6DKsnkij1eGHuFB
	NIZ1Po=
X-Received: by 2002:a05:6402:5186:b0:659:454b:7167 with SMTP id 4fb4d7f45d1cf-65bc7a751a0mr10415695a12.23.1771586809215;
        Fri, 20 Feb 2026 03:26:49 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d295sm4987701a12.8.2026.02.20.03.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 03:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 12:26:48 +0100
Message-Id: <DGJR40B5R6MB.1V4ZK5SW1PXAV@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Jonathan Cameron" <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de Goede"
 <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey Connolly"
 <casey.connolly@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
 <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
In-Reply-To: <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>

On Fri Feb 20, 2026 at 11:51 AM CET, Konrad Dybcio wrote:
> On 2/20/26 11:40 AM, Luca Weiss wrote:
>> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
>>> On 2/20/26 10:19 AM, Luca Weiss wrote:
>>>> Add a generic-adc-thermal node to convert the voltage read by the
>>>> battery temperature ADC into degree Celsius using the provided lookup
>>>> table.
>>>>
>>>> This will later be used as input for the fuel gauge node (QGauge on th=
e
>>>> PM7250B).
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 ++++++++++++++=
+++++++++
>>>>  1 file changed, 83 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/=
arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> index b697051a0aaa..7857003099a6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>>>>  		io-channel-names =3D "sensor-channel";
>>>>  	};
>>>> =20
>>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>>>
>>> nit: this should be a little higher
>>=20
>> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.
>>=20
>>>
>>>> +		compatible =3D "generic-adc-thermal";
>>>> +		#thermal-sensor-cells =3D <0>;
>>>> +		#io-channel-cells =3D <0>;
>>>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>>>> +		io-channel-names =3D "sensor-channel";
>>>> +		/*
>>>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC with =
a
>>>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>>>> +		 */
>>>
>>> I think this looks good. Is this data going to be correct for all/most
>>> devices (i.e. is there a single battery sku)?
>>=20
>> Yes, from my info there's just a single battery SKU, so that makes it
>> easy here.
>>=20
>> For Fairphone 3 there's two battery SKUs:
>>=20
>> * (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
>> * (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm
>>=20
>> In reality, one can probably ignore the difference between the LUT for
>> either B value since it only differs by a marginal amount, but
>> conceptually I'm not sure how this should really be resolved.
>>=20
>> We could have both battery definitions in the dtb, and then the charging
>> driver could determine the battery that's actually present in the
>> system (based on the BATT_ID measurement), but given the design here
>> now, I'm not sure how this temperature lookup table would be propagated
>> to the rest of the system...
>
> The path of least resistance (pun intended) would probably be to make
> generic-adc-thermal consume an ID channel and accept a number of LUTs..

Not the worst idea ;)

>
> That sounds sensible since most battery ID mechanisms are probably also
> ADC-based and one would hope (tm) that the values output by these ADC cha=
nnels
> would then be distinct enough for the driver to have an easy time confide=
ntly
> selecting one of the options (or a fallback)

Charger / fuel guage and everything else battery-related would also need
to get the correct battery properties for the actual one present, not
just this generic-adc-thermal driver.

But I feel like soon DT maintainers will say that Linux shouldn't
dynamically detect hardware that's present and the DT should be the
absolute source of truth. That works fine in simple cases, but in case
of interchangeable batteries, display panels, camera sensors, this won't
work. *Something* needs to determine what's actually there.

And for most of the ways to detect which of those are present in the
device that is booting, you need half a kernel to power up the various
hardware and do some basic communication to figure out what's there. Of
course you could say that's U-Boot's job for example but not sure you
want to add a CCI (I2C), ADC driver and much more...

Regards
Luca

> That said, this is just my guesstimates and perhaps the IIO folks could c=
omment
> on that
>
> Konrad

