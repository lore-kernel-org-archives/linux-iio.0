Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102434A3D8
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833055; cv=none; b=B9swugVaP/IO8aq+dvF7Z66YA2VeT3JjImneQEjqqSt0xiiP3MmlbK6yYQE+rzUyHssrZLHFHRYbIT2jrEIyyQD89/FlCx3+QpC9P9g9Hv2YEk1cfVBa9PM0O2d9e1e5PRMGTBXIu0CmHtsR9BYbf76qzU7bp3qiN9/h3vRMKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833055; c=relaxed/simple;
	bh=myrYEPr/R1pVr+HcXiT9MOTW/An54yWrX6KWA186BlE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SfyhUsl537WdZNrN+4PDjfnrUZ4I+3idR6u7QK0WrMmHcTSEXhtmNg76x6d2s1XQn/d/2PL0M5q3IPrV7ILrblnYnI9r9o8wZ9vFKNPJyjjMIU02afwt6ArG6OFsAi4ZjTti4DUmPfCSF08lfkza4400EMuy5aCkNNCtMxOdJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Vfj1Mg1J; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Vfj1Mg1J"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so7555275a12.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 23:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771833052; x=1772437852; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERYQol69KzvMZw4jEOTjkJFG/z3wRah/VmniZQD/41w=;
        b=Vfj1Mg1Jtj3zNWPsyWcoDtm2oFvl+48/lxpC6XCUaeYoAjjLFjglwV1CPlX00jL+is
         mFquk3O73OI9NlWw+W/CJ6zEQzJdDF5UNdrzdWYrwnW7fuQDLVVGB9Mylg6FpeGJqbMa
         3OWyVeEfJtysaGOQw9ntC8EbUfOG3IjMe4apFhDi2YGDzzVs4yj0KVIpqzoxnA93OLu0
         lSqnCwHaP+weWaEfwXd4e6MiNGK4Y1ol0bwZXgJu81QfA55aIBC9zUD2yw2V1n83v1Id
         Q/OSayAy7fj3isTKCXbikkwT0y1s81U2QT5ObyWyk2QXg4UcHxVlZbamdRUI3aSER76x
         E1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833052; x=1772437852;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERYQol69KzvMZw4jEOTjkJFG/z3wRah/VmniZQD/41w=;
        b=KMD70CBhgiUUYi+HywKFzFL8nXbPgsTcWWTjdjuoW3UNROK+3nvEvmP59/pgP08amH
         kcrmJwm5dAOuWtIsamPrvCPpl8Cn/EjesvfCV/oOq97TjXNxhhrfs3nj1FFJ+kVWvGdC
         Y2YgPZhVqNEgV4M3131nyjqCoSrIueCiBa4Aecg0KfFYW0ag4eFL5Ep/AtNnxefwp3M7
         8uecDHip1XKvP8jdxL1OuUWwGvFXUFd8TRilsCJo+OrcMHLmwtkgKbsE4sY1TMD7AmJA
         7g5jMk7PbaY/NJwknfzxoas+PlGWh7SQk/3z5AmR+8W3l/0TB2Io6dUhZAfVOhQ1Bei9
         1T6w==
X-Forwarded-Encrypted: i=1; AJvYcCVk/7KgBgU69G+mNAVzaNIAf+62JM95c7S5M5t9Oq4Em+aeTYWrtFecxYYuK5/dSu3pJa5oaErs+Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0iK4mswcBYx/+IuX03PIkibUA7g80LZ2S8VcXbtMuujAqEd0
	mozpAOc4LccmPmxCH7aehLGSLbkR78w3kbUX2/pF4kVzPe8jsZP+eYVA+N/3XQLzDBg=
X-Gm-Gg: AZuq6aKI/GQBkGzl6YNNaHu39nCj2YxN+gQJaOdTkqiDiB6o3164aowwYouWT1o0j6i
	B43dE8xd/2fq38nVfMDLLNl7qvpff56ZNCxwfmUFpV/UW7eCBR5f7cHfqDm7onW1PrxoQjhIyxK
	klKvSB83Zap6Z4T1PxUzL4ZW2hfJewCX+ZCYtroY3FAkLAVfie/NBFbA/bnh7q0KhJnS4od3rpf
	pYAt10Ijl+F0CX8r+r58PELFF8s1tzy118RZts4U1y6H6Vwz2o8sDOdNqNZpDYViL5qBPO5Dbup
	/17nt8xy6nzfo5TCKSLVUkQcfBYNn1kp2PSz/YzMfFD9uMX4aRz7mLg5H6Pjdtwc6COsWSn26Q2
	j3M9TGQkC2yWtCmTdtbKUgbnPv/7wGBxCI/ObegmIRKS5BBBtLNXfxQVAZl9E1zxbryRVxPAU0R
	bodQXNsr9+0unnXF0uyzYf5+s6gp7kJKBC6GmOk/jqsEom8/yXcSBdqb3rK3tJ8lpzunEG9+DVN
	aQJ/Ls=
X-Received: by 2002:a17:906:9fd2:b0:b90:3436:9f71 with SMTP id a640c23a62f3a-b9081bbf557mr536112366b.47.1771833051868;
        Sun, 22 Feb 2026 23:50:51 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e8d0d9sm297348066b.50.2026.02.22.23.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 23:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 08:50:50 +0100
Message-Id: <DGM6EAN8EJU0.2JLEY3CA0R5G9@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>,
 "Lukasz Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Jens Reidel"
 <adrian@mainlining.org>, "Casey Connolly" <casey.connolly@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
 <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
 <DGJR40B5R6MB.1V4ZK5SW1PXAV@fairphone.com>
 <yikwygc5gasmr3cdyv5emfr2flaoraxcz7ap3j55wn4ib6wfqx@4yxoly5zrucx>
In-Reply-To: <yikwygc5gasmr3cdyv5emfr2flaoraxcz7ap3j55wn4ib6wfqx@4yxoly5zrucx>

On Sat Feb 21, 2026 at 3:49 AM CET, Dmitry Baryshkov wrote:
> On Fri, Feb 20, 2026 at 12:26:48PM +0100, Luca Weiss wrote:
>> On Fri Feb 20, 2026 at 11:51 AM CET, Konrad Dybcio wrote:
>> > On 2/20/26 11:40 AM, Luca Weiss wrote:
>> >> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
>> >>> On 2/20/26 10:19 AM, Luca Weiss wrote:
>> >>>> Add a generic-adc-thermal node to convert the voltage read by the
>> >>>> battery temperature ADC into degree Celsius using the provided look=
up
>> >>>> table.
>> >>>>
>> >>>> This will later be used as input for the fuel gauge node (QGauge on=
 the
>> >>>> PM7250B).
>> >>>>
>> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >>>> ---
>> >>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++=
++++++++++++
>> >>>>  1 file changed, 83 insertions(+)
>> >>>>
>> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/ar=
ch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> index b697051a0aaa..7857003099a6 100644
>> >>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>> >>>>  		io-channel-names =3D "sensor-channel";
>> >>>>  	};
>> >>>> =20
>> >>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>> >>>
>> >>> nit: this should be a little higher
>> >>=20
>> >> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v=
3.
>> >>=20
>> >>>
>> >>>> +		compatible =3D "generic-adc-thermal";
>> >>>> +		#thermal-sensor-cells =3D <0>;
>> >>>> +		#io-channel-cells =3D <0>;
>> >>>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>> >>>> +		io-channel-names =3D "sensor-channel";
>> >>>> +		/*
>> >>>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC wi=
th a
>> >>>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>> >>>> +		 */
>> >>>
>> >>> I think this looks good. Is this data going to be correct for all/mo=
st
>> >>> devices (i.e. is there a single battery sku)?
>> >>=20
>> >> Yes, from my info there's just a single battery SKU, so that makes it
>> >> easy here.
>> >>=20
>> >> For Fairphone 3 there's two battery SKUs:
>> >>=20
>> >> * (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
>> >> * (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm
>> >>=20
>> >> In reality, one can probably ignore the difference between the LUT fo=
r
>> >> either B value since it only differs by a marginal amount, but
>> >> conceptually I'm not sure how this should really be resolved.
>> >>=20
>> >> We could have both battery definitions in the dtb, and then the charg=
ing
>> >> driver could determine the battery that's actually present in the
>> >> system (based on the BATT_ID measurement), but given the design here
>> >> now, I'm not sure how this temperature lookup table would be propagat=
ed
>> >> to the rest of the system...
>> >
>> > The path of least resistance (pun intended) would probably be to make
>> > generic-adc-thermal consume an ID channel and accept a number of LUTs.=
.
>>=20
>> Not the worst idea ;)
>>=20
>> >
>> > That sounds sensible since most battery ID mechanisms are probably als=
o
>> > ADC-based and one would hope (tm) that the values output by these ADC =
channels
>> > would then be distinct enough for the driver to have an easy time conf=
idently
>> > selecting one of the options (or a fallback)
>>=20
>> Charger / fuel guage and everything else battery-related would also need
>> to get the correct battery properties for the actual one present, not
>> just this generic-adc-thermal driver.
>>=20
>> But I feel like soon DT maintainers will say that Linux shouldn't
>> dynamically detect hardware that's present and the DT should be the
>> absolute source of truth. That works fine in simple cases, but in case
>> of interchangeable batteries, display panels, camera sensors, this won't
>> work. *Something* needs to determine what's actually there.
>
> How is it handled for the Android boots? I assume there are (at least)
> two DTBOs and the correct one is being selected somehow (via the msm-id
> / board-id?). Or does ABL pass some kind of battery identifier to the
> kernel?

On downstream the Linux driver will do the selection, there you have two
batterydata nodes in the dtb with each their qcom,batt-id-kohm property
and the driver will choose the correct one at runtime.

Similar with multiple display panels, but I think there usually the
'detection' happens via what's passed on cmdline from the bootloader.
But not with two dtbs, the driver is selecting the correct panel from
one dtb.

For cameras, the camera stack is 95% in user space, so it's not quite
comparable but also there usually I think there it's trying probe camera
#1, if it fails try probing camera #2.

Regards
Luca

>
>>=20
>> And for most of the ways to detect which of those are present in the
>> device that is booting, you need half a kernel to power up the various
>> hardware and do some basic communication to figure out what's there. Of
>> course you could say that's U-Boot's job for example but not sure you
>> want to add a CCI (I2C), ADC driver and much more...

