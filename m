Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2D366555
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920902; cv=none; b=O/Xe2L1kP4YhIMrPhNViJyHVTrTqFSNGjKhTO+b9dOyKFps/2QwAwRi/UuGsBUnnbR4HHiersx3e/Jw7w7UBfhTbwUrokDEgwT1N6b1CtTZ4IdhjEH3TMrHDCFLtRQrzEVym2alBjrkXVuAxXLf5CDvFjJUVv2USN5d/yIUXylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920902; c=relaxed/simple;
	bh=9BNqf2MxT2KB9V3RmWVoDEyDdtAfYIbH0M7+sdJqyF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QDAUNQr0+aoeIw0zI9olsrAq2TOz9VLHNNm0KjX7wRwHuBqLfmSx/BbwMVtZku9aBndMsPUMYROM0Onp00wzM/9kYp5MaiTduP8335UsdQBuQXc8Cv84U5a878wLh+0sgNayV2FqlR+HWW/pk+0A21z+Vte/dInf3lX39iW9HMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=e/PLKYYK; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="e/PLKYYK"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b885a18f620so921711966b.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771920899; x=1772525699; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKXXJGWnu9K3xWMW9HyaDVo1/D1y/DKuzi9/eiBk4qI=;
        b=e/PLKYYKTVwvOJC59T6f+2vp9KK35XkixfJUCi8jTKZP0yiHMyS6pfcomFjzHxfpbQ
         knxi8XFrWlEjfuXlgFAvgTkKZBq4gWLEfJMZD4+jfhKoN2q4G/bj9slSFvButfSgrN9Y
         YsNAVtK/Dq7GCFsgV7LuF1IlOrVmsv97R4MrP6FPstwdbxKns0TovrENx8qlxgrGl0fu
         UzJdPC0FT9ESwfqQ4Cog01EcdUEfyXd7qaWKbRYmgvymrA3s1U1XmEO6/OGrzUZxdfBo
         W3pqi3H33scQHyOm6TBC0uE/8w1ehNpixQ5vjnb4NXm8cRabSWM7CaxS+RUe3/3aVBCx
         xUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920899; x=1772525699;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKXXJGWnu9K3xWMW9HyaDVo1/D1y/DKuzi9/eiBk4qI=;
        b=K93lE/BJjCshGDodxNTGBRZb31a/VsXSa+DNwXqc8RNEsvOJMPjDsVb6RIfSTL+ZAM
         7W+e5vjz0GOdr/LOkr9ij+lUQKUqYUT/zHwCnZH6y+Id3h948NRjY3NM6OQ6gwj5TIXZ
         +PBblOE0GJ9AYhT5InW+wu/ZbFDmzos25JqyOIFWQmYQiln+jhIbLkhctAv3quwCmZLZ
         8VmbhYhHJYFmtDhuiipcvsYm1ZyT1nMeklCCog2Yo7LduqG5Tju605DHxY4Buu9TG0KY
         Jv77cSMAcGSS0gdROWFKoHLnKlWB5wfMdcXLTY/VaGPORKU2ZpDFzAm/L7zbk1LCnR+6
         2xeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKfoTXPbZHe15rrwrfOhbmYnz7P3Wfcv2D8IkgjKMDu+5x45rpiUmY0nNhAlIbwm025WPCffEEfh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8yW4TcoflBpRetzNEtgG/38HXP9Q1ixIxMMSsPacmRyfLFeZ
	CscoXxjkuSzeAuRiaZShcsrEUOGEm/VXyWUpCN6lP56LmqVwwBWRnnJPT+fVeYPPtB4=
X-Gm-Gg: AZuq6aLyxpUjlEouwhxdYNnRLvAuks4Sb6wo4vINosIBoA88e/HgU/tTs+i5yEN9C7N
	0vVrFmg/rgQKAtmVDkp2j9ELsZmGArhkPbJ/2FFNVIxonMMzQn+6UrqZwoKjVkS6RzEZB746OLl
	n1I+jsjhOVMqKyxOyRIz4gGx0V4PBmTKxYMyKU1z1SiBDy9ZhgcopxsV4p0NhUqBtPfMJwyHxhh
	WzwjOKqhl219phxdIoW9rFauEUlalK1WXj3ZCYwD4xRx2tQCtGK2/zsjH2Ng+X5GzES8BB4j84L
	7Zu9KFGPqF1NxUFQQu0lDgsJBrUQsn9C00ttmQSg9SWWHRNrNk54glsdaTWJnbowfZu6vBvv/9b
	jAdnacDme1CBXNrW6BrcTklPW/nde+ammBIRQTwsXCa++A+BFcvhur+gRiO+7Nf/pkdXqtgRE4R
	zEG8a0J+J9hyomcsfDvWwlam8fxm6uW7mD4COq136hORYfm/LXyipRUR7lDbkB9/sy1lntox+Ih
	AvT+PM=
X-Received: by 2002:a17:907:e0d8:b0:b88:5957:2d65 with SMTP id a640c23a62f3a-b9081b40c12mr380726366b.37.1771920899412;
        Tue, 24 Feb 2026 00:14:59 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4bfe6sm399567166b.44.2026.02.24.00.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 00:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 09:14:58 +0100
Message-Id: <DGN1JB8J9YG5.JZDBJ9WBLDXC@fairphone.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Rob Herring" <robh@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de
 Goede" <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey
 Connolly" <casey.connolly@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
 <20260223184815.GA144001-robh@kernel.org>
In-Reply-To: <20260223184815.GA144001-robh@kernel.org>

On Mon Feb 23, 2026 at 7:48 PM CET, Rob Herring wrote:
> On Fri, Feb 20, 2026 at 10:19:06AM +0100, Luca Weiss wrote:
>> Document the property to allow using this sensor with io-channels.
>
> Why? On the surface, it looks like you are adding a provider property to=
=20
> a consumer. Maybe that's right?=20

Correct, commit 3762f5851ac5a65dcccadf73dbe853b1b346f561
("thermal/drivers/thermal-generic-adc: Add temperature sensor channel")
added support for this in the driver, this documents the dt parts of it.

Regards
Luca

>
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 =
++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-therm=
al.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
>> index 12e6418dc24d..317fc39ed46a 100644
>> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>> @@ -24,6 +24,9 @@ properties:
>>    '#thermal-sensor-cells':
>>      const: 0
>> =20
>> +  "#io-channel-cells":
>> +    const: 0
>> +
>>    io-channels:
>>      maxItems: 1
>> =20
>> @@ -58,6 +61,7 @@ examples:
>>      thermal-sensor {
>>          compatible =3D "generic-adc-thermal";
>>          #thermal-sensor-cells =3D <0>;
>> +        #io-channel-cells =3D <0>;
>>          io-channels =3D <&ads1015 1>;
>>          io-channel-names =3D "sensor-channel";
>>          temperature-lookup-table =3D <
>>=20
>> --=20
>> 2.53.0
>>=20

