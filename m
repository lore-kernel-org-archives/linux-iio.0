Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A833267B89
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584062; cv=none; b=eZGvlA3QL+vi+Lg1mchPQD+2+QjKapJ+71bXeIq87PCEyZm8CQjvfqGUl2Y+6a3Y4tAkse4AphAVgf1IQEYAytCdnNn+bWgoa82kYrLVvG4MDWTlR9n5G8vyaEQMDEdiYA+JKQk2ycswMnTUn5CmqckBq65tApxRZx3Rd9cbOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584062; c=relaxed/simple;
	bh=lCfjiFCpKJoa+6uB16bTXpWJQyvUj3mvFlbxKEOoSYE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MVdp19e5kgbn+lUxpYD7rZ8jbNwqnwcawQ8GIn4nEQ71dAuKDglQeQtHC1B9aGe85u1OwT7s6Dz5ZVR0HQS08Wa8Qr1YN3GSrG4BoMsUGnHdi5+jFAEtJRjwUFITUJk66tuADo4rxd9QoR1tXu1gN99vg/FmmXyynnZd1cC2kX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Cx5MsgJk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Cx5MsgJk"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b885a18f620so338631366b.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771584058; x=1772188858; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4tgaqGFqrzVKKPOb+iFZ3JERZen8Ej1v/LIDxYhK+0=;
        b=Cx5MsgJkG9oj7APqKUjH43BrcK93sBkvrR9uvqcW3+WgQxYIby7Z70/GQmH/9sMPTB
         iTFvlnLZUsfREVfIT8h9JEn6ageY55GZFmOSxcGM5gQVDgvZ34b36TuowJfG9vX9O5Th
         EW9fx1ICNQfmxW94+axh4GugWhJTNY3YcAKmjfRfsokim005XjhelAP3uBdEAD0eGpRo
         AEAyVVAQW3/TrSGMrt0zQRSkVRrqLeHWs2+XtTHmgUoG3bKEEJi1X1En0Lo3mZenj6lZ
         XxUABx770Ns1ng8jGfWFnHL0O/Gyan1LIgouu1BMaBxikef9eopFUuQysP3OwuWzM7Bb
         yxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584058; x=1772188858;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4tgaqGFqrzVKKPOb+iFZ3JERZen8Ej1v/LIDxYhK+0=;
        b=F8yqu5JRpnG3eSXu3HwephiKarI8W5BIGaPF3LNrqhpX02CHJeARf8Wi4TW4bzT/mJ
         5ZntGY/KjJJrLoIJA45EkpN71tlOMkPClKcS7w8zJOnYP2VoDFJUiY/RaYivBqfGBqlE
         f40MmHtPvpXHTVMoIGwD1+cWpKcujf36jyUbXLyxjMp/tQerTCZ4tNV6dUtw4xKZHh5z
         6Hi4sImStE0ylnLQzrkoJHblB0Z9HcyDC0x3h3TPC1K/dRHC/jw9UDU786jP/B0xXKqo
         sC+h84BwpteE8yZg9hbxWu3RIJj0U1qn1GfbRDWuHwUhwzxcSBab10BJm8UpsBi9ykLL
         hWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5YXQYLwU5cLFgbfKBsG1zu3qGTFOEJMLoLU+HYcIhbT9sWloWJe/Saw45YnQaG7Gp+2VvsRdRfgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09NmspuLDuMaP1xnwdxXm56ZqtQeOoStzl49vQaz3BaRa/NIl
	kkedTsxzfu3cJyCBa2Gr9U1Ez7bmsp8b8LPIHSH4mJutGmLSDaL9V96uo11pvOM717E=
X-Gm-Gg: AZuq6aIhDQVpn2hJSC7o9hvHCjzBkDuDjJ0VExc52GYXoOdezmGkQQPLRe+GJYqxIf1
	AabbDR6BaxuEvE0ph2AccBrwpCTn/m+3PE57Cvu09e0E+OHjLqc77poSSQd98dwiRlNG8nW3Eo6
	knt1W3gG5VXjTO1vt1MpPHEbzB7kf/xgCac0uEk0j8suj693fxunHYJMsWIwylC/zF7aMXmGi8e
	/upogU10vjrqDfuc3N+2Juw7Sgha5t3wbfcjcsmQobDdlsDA/XeFLpQA+Js2xn9BER9CqPBNjYI
	MKbj8h4HPV9kDvyKOH3OvcdyPT/V97xIGeKdmCF3+xYjm2OL53JvYz4oZzuhs2E6t33yYJGS7pN
	cnyz2acIdsHrKHXCq9iEb8iY2tintSz9yaGgSlAK5S/nwl/o3dmupbWA7xpLwNGeFAoIAfntCzg
	Sdf6zEdGTtddDU5xOnFBI5sZihTJWEaEyfErzmSjGBl8ztRhK1GB29vV3+uTp3Mao9B62S
X-Received: by 2002:a17:907:98d:b0:b90:3436:9f71 with SMTP id a640c23a62f3a-b90731fef13mr72589166b.47.1771584058260;
        Fri, 20 Feb 2026 02:40:58 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385e60sm661232566b.19.2026.02.20.02.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 02:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 11:40:57 +0100
Message-Id: <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
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
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
In-Reply-To: <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>

On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
> On 2/20/26 10:19 AM, Luca Weiss wrote:
>> Add a generic-adc-thermal node to convert the voltage read by the
>> battery temperature ADC into degree Celsius using the provided lookup
>> table.
>>=20
>> This will later be used as input for the fuel gauge node (QGauge on the
>> PM7250B).
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 ++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/ar=
m64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> index b697051a0aaa..7857003099a6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>>  		io-channel-names =3D "sensor-channel";
>>  	};
>> =20
>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>
> nit: this should be a little higher

meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.

>
>> +		compatible =3D "generic-adc-thermal";
>> +		#thermal-sensor-cells =3D <0>;
>> +		#io-channel-cells =3D <0>;
>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>> +		io-channel-names =3D "sensor-channel";
>> +		/*
>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC with a
>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>> +		 */
>
> I think this looks good. Is this data going to be correct for all/most
> devices (i.e. is there a single battery sku)?

Yes, from my info there's just a single battery SKU, so that makes it
easy here.

For Fairphone 3 there's two battery SKUs:

* (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
* (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm

In reality, one can probably ignore the difference between the LUT for
either B value since it only differs by a marginal amount, but
conceptually I'm not sure how this should really be resolved.

We could have both battery definitions in the dtb, and then the charging
driver could determine the battery that's actually present in the
system (based on the BATT_ID measurement), but given the design here
now, I'm not sure how this temperature lookup table would be propagated
to the rest of the system...

Regards
Luca
