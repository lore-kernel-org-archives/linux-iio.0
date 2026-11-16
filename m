Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843833;
	b=ELuBOLVpF2qql+PqiFR3zQwM+JYZJq3dLUaj8DZ1H+zrtWfhEYsh/320kZgeHs4Lg8bn
	 xGBhkZbg4fw+AofOBQ7FnVAFMTPp01+7xGA7NkT7qEZvs//0XzuXhXa3D28fDsl1ju21B
	 FUojlMg4fJ5hNc5C50W8cE2j+TbJmqJbEXlUs6qj33Ii67bhgjdkvmFfDNrrXsLxiufIb
	 fAPfKzXevYY9ib4kDFJ/BsKi2zn+Y2QGAFMylu98ng0TIC5b4+A6GWEnKDKwjJ7kEFjZq
	 /fielfGNZmc3P66ZoO/lM8NLqwqd0Chnxq4n186sDRoWr1oY2NBm5ULDxnKfbEWdAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
	b=L2mnbdoPRaWZes+DW+SBv9+IJ5Ew83Eo/7OpYhfo+VSnuMsHPzP3NToPl+34gzqA/c7v
	 pY2hSm5QK6r2Z3uDlaBixjyHgmVLXwXRNiD5vgtlRvMkRFCJTr9FxEJ54k9of7qvSKKAI
	 JBGqKSC5Ma8f4jX0PpOtD0ZodTLdl5pYeLv2M+Jph1WwBEXooUSdZ1w+63YVFmRTx4oYD
	 4vLA4DgUMraFb6oqPtZmoxb8hVSsD2m1xpsmtplwOt1M0DdMKdTJQiRO6fvM/rk/mCUhl
	 OmNSzEuJzWYiVsx6O3CyaURYIAFG+4DNy+lj25w1yHwaBnL6RaMsqwhj5Pql/ti9A2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l5yFnpD8;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC21606A32F
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC21606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l5yFnpD8
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c468bd799ecso531361966b.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794843831; x=1795448631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
        b=l5yFnpD8es3PZ8hErhgAyB6jNHgRJQL2UrqaB+35VDA03JWtWhtFRjub4w8iKrO77e
         FcXuh9bolv6SYa88Apk3Cj+9S5ZwpsJlBdiFSEej53nktGjQ0LAsYndjgYq4DB2bD0yl
         Nyiy5scYIfhVrAS4QNSBaNJydK3icLZBN4M0F1B1L6Waj2/CbMjaV0UG6L7lgr8aVaGD
         pXTH8mr0Uek6+QgkGZxJY+7f0zkWMqOFQHSdN9vHIUiEuWSmJok/yRbEEZJRUESbTGNj
         3zjw9jYFXIMQVSV2tbewdyiO4fsAHVQXDakxoF3J1EzoW4EzlIXY/FZ/rBxt0ZFpDLkw
         9Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843831; x=1795448631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
        b=n10IBrOviNdQc68SpMlBB8R/kMZ/nlD/kuPEEXcRx49jGZoM+7FJp4aC4f6H+Lhkzk
         bh0GIhIBoYjW/dQ1EI5UxPYhmGImcnGCBs5Xsa+M7qplGVH9bUI8hP8TaqBQ+0H3dwpF
         HpEggpLwAIIeP+6iCLzWssMAXuCZcLaP092PZls0KWBR9KWZkJC3FZ7SRyWKYjmllTHN
         ltdUT53UjPQIJDmYZl7MwSEw9xCSB9BqvXfuRo6urrhP2NZzHWfs5FeH/wxbtXB9n2+S
         ExBGUkHV9y0RFReI8j2arrU3+wnPWtX7IE/FIhV8vyzbl8k8/3Ak2SXa8jS+pL4eIg/o
         nn5g==
X-Forwarded-Encrypted: i=1; AL+hErEFMugIq1TCm3/00RJ3SOk7hD3Zx6L5+Bz60kmtp5ZIg6WTJtIFpVGwGN0T5216YInImHgU6QzpR8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z98LLXULk1xmtPgl8/do7kmjUfh4bOTrepmQQY79KjL1OLA4Xm1
	Cbu/ErPCv3e1y6d1UcOKycjA+TuyUsF6XlIUAPH7hrl4vyG/IQUcQvCb6IaxlRvnOoY=
X-Gm-Gg: AYBFou2fv+B+s2FZlGt3K5dI5JVNS9rh5p+jOb5HEQBq76l/CHhrqhd3votRuDzpEix
	G4y1oGoyT1V0kSOkanM9lYk2uu6QTtWbETf0O9Ja0krDoB6LA9R4zOXSLjGyLwtesspJMg27bbs
	aS8cr4ZH5kvSLZV2C4lyMNgkQCaz8jpv8XwfBXKWQK0zohvm3uVjjvhC4jJpwdE5uPs04PRBv+C
	TrGiRy1mitVoTKI0Ffh8xAtAVbRsNOpV88HjWfKQKXO5PsiQ29+jeByvQxgVfsT59kaj1zRmzAq
	490J/AKrLbxyhgFynQPIvHoVMG/HXi7h80AL+RDPSlZPwMYHCRkHItb690UOOfXRdk4mm5uu9ed
	Yc2nZUWdFa9FEAUN+2xBajhwDfGEEbw7ifuTijZyRGAaiL9lcaFGLVrTRmuw/XBZo/oUo51b1U5
	/Z+WZNidaN7AE/Jt0wYDSpSiFNw77ZLrYBH5VzmVX3GyhxJiVIKHx5Up32r20nSPe/jOallUstJ
	2EppwjWqZiazymjvoyTOFc/8dyj6vBqjPKfz3pVVYZrpvQ282Lq1y5XDv1IbwXX4MklrOy6G7Vz
	0wtMIzSOlpj8B4D5gGDchegW8hMr5IHSK2zPTGJV23NHFbA+efNh+Gu31DO+ARbFIy8MbKdV7A=
	=
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c50963d50e5mr844840566b.16.1794843830845;
        Mon, 16 Nov 2026 07:43:50 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b40918sm439294866b.39.2026.11.16.07.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 07:43:50 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 16:43:49 +0100
Message-Id: <DMWR1CJJRHMF.33YRRRDXPMBDW@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de
 Goede" <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Val Packett" <val@packett.cool>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
 <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
 <avc5rnvIAEmZbyE1@ashevche-desk.local>
In-Reply-To: <avc5rnvIAEmZbyE1@ashevche-desk.local>

Hi Andy,

On Fri Nov 13, 2026 at 5:24 PM CET, Andy Shevchenko wrote:
> On Fri, Nov 13, 2026 at 04:56:42PM +0100, Luca Weiss wrote:
>> Add the BAT_THERM channels with millivolt as output, which can then be
>> used along with information regarding the NTC in the battery, to get the
>> actual battery temperature.
>>=20
>> A static lookup table in the ADC driver won't work since different
>> devices have different Ohm and Beta values in their battery NTCs, for
>> example a NTC can be 10kOhm & B=3D3435K.
>
> ...
>
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>
> This is broken indentation. Was `clang-format` being used to achieve that=
?

This is how the rest of the file is formatted, I didn't deviate from
that.

>
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_uv)
>
> result_uV

As Sashiko pointed out, this is labelled wrong, the result is millivolt.

The rest of the driver consistently uses "mv" for that, should I deviate
and use result_mV?

>
>> +{
>> +	*result_uv =3D qcom_vadc_scale_code_voltage_factor(adc_code,
>> +				prescale, data, 1000);
>
> 1000 is odd, can you use something from units.h or combination of those
> to show what this multiplier is for?

This is converting microvolt to millivolt.

Shall I use "(MICRO / MILLI)" as used in plenty other drivers? Two
drivers in the tree also have "#define MILLI_TO_MICRO 1000"

Regards
Luca

>
>> +	return 0;
>> +}


