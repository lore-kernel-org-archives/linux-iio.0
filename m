Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425445;
	b=5sX+mgpt3NNUNXWtB5x2hTHEHlsE1ow/mMBs15xs9tqD5Z+74B5AHZGQF4MZ96eaTFf/
	 GnK1aQ+2e8grwOfI4jKrUMnfyl5K6zabHUYjeyEYyyLsydgSDbm2EpD6vdBkCE55RVRjr
	 FXFXYgYuq+cTEJzDEYpsBzFwsUyOe9EDaQ7rdnvVD4zHyZApNt3ErdJuZjuq9HnlKovp5
	 SoX3VDX0HrFDZTFGavmIZ4PJm1iC3q0pDCd5pUG+nevvNUkLcvkZH86beE+/V77Yq2Cyf
	 x5ouGKVezwgbzwWkQbeQO32/1H+nJRsQGp+i772N6R4TSRMdhUgXSNUsIuDV5TjHI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
	b=uiLxO5WRTz+X3P6HQjYflnXVH8/MruZt2KA1wpUCrMG+mgh5+NbSCY9aD+mTZ3w6mVK8
	 SsfLjSGMCqaKdr+gqMjiHx65cn7tZK1WEuNLBfS4JgOP8n8QUtaCY/JRloGwj3RIwTr0q
	 c8y43beiGxzmVfFbE/fibmn4v6ZrWyrqihTJ1aAotrCT7UoWWcD+l10PJv+Lv0SxTc4S1
	 Z9LB5WVilHrXr7jaeTmWNkd2loTbVaowwjfHdXtCzS3AMUGic1USDFa6OOqU0ivBlEePP
	 ikVquxWWaLQnrvzVM3ddrdy72uQ2ZVqVdh0px22VWHMxumpUvDn3RnUuv/6DNVg68ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=mRpGJUoU;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B4606A32A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 09:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072B4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=mRpGJUoU
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d427836e9so418285966b.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795425442; x=1796030242; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
        b=mRpGJUoU5NoqyhwJ0w8OwZQIUnCDN/5fpynpyGn9jzsx1jYEwfaQR/bW/LIbuTv4FP
         HtCOvcQfOBTtQbUygTRXF6/17BZUC/CCtQwrLOvg9292Pv6dsoD7zDbaCvIJT/zRcRxO
         MbIKHbJ1QOBg8Wys2xzfQCj1lY6QfqsTffezatDUGaY2lnhxi2IxR+XFTONEr778NfoU
         UyNZzn7nVB5bVPZcpv2HM9L62dtivuQJ2UJ2jenxhlPTqevL0prFen/4YMwDGWNGpHSx
         IowKIORJ7A0BzCLXZe3ybGG6jO1ZdM8muAingKU/H0QnXL7koAD1dNCNemRlfty9Q4Df
         o5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425442; x=1796030242;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
        b=RDz4IfzqjnoagGM/BwutIx5R1NpFTqm0vGW1xhh5qOpVwHkUpWv3RdkWFkxNDZUOXX
         FR6iFqUfjVvwypJf8p+j5Bijg2IValLhfFaByBe8z8vYKc6Du9VZuV7lIBr7I9sw2bNt
         tpgxPUY3Su1dCra2vcKrKIl6REeqSfooTrNBkQ2NkpJcoouPe/I2SVuPPZxxX4+SOZp1
         cPNQ85I+y04xikoMIDCdtiIs+h0HQrIrUnPc1+hqqEb5JTDjyFPAJvONj5/TuldnY12k
         KnV4CCkHSUzMNfJhuRHlVVBvXWeSblSZPO0lluUkqRFCmYlqLJ5eb6tSdZFddY+PCbBq
         +7ZA==
X-Forwarded-Encrypted: i=1; AL+hErFgTITGGS/CQrbnjntSnvP66wLgOtebffdbp0yqZ7johOTU2uH+BXacYECz1Qh55W5MaQBWDCFDkZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yWlRUsQFcbL1Fun2hYCvMYL/6k7x64sRrc3CuPo5L0HiXgmXj
	+FYp/j2b04uY4anHNfBWZopzmh6LJZa608V1+9vsRkkOevR0EUvLRZVXdRCed5wCdE4=
X-Gm-Gg: AZFdTZeo8SBoslciMbXsSQScHfz6xMNUBEA4Y2ax4glk3hdmkGHzjHRtwCpY/F0WSM2
	Vk/4/qnNlou/MqhTqS15VoaP+4CigY0rHv4T8/zJoRQCSWYqEx7Q6AhAh9gpN63OD+TZwOBQFYY
	HX35NNECl+ZWQRgBNmEdjbrD/wsk606gOlv79mnpYbyZE5xOXO5xBaWHAyYIX3EeM+jSs+HFdaa
	PFirLuvT4WhgpylfPRlThYq/rPOxyhiaaQTfh+t8bggUd2jxS6ErgDR02fFIaSAgDICyTt1HpRH
	HRcOcQLNoyC/ar+FHnY1VfidsmFVkkJKfM64cCPbkzh1BsA4QMjGAglLOFeVPktVN8u4Vb6Nx4s
	ogmEhMiJKBRdH2hkNYaE6CR/UC9toD5PtscKzEBJR7QljTC0IX2E1mGO00Yf+vxSJlO3yY22fgf
	E6hVmZRv8gJuBq7/3ULlYnj8240OP/VdxarmXcItIMa5ZWJhX326z/FoIxI5EMKL8Vx/Zz2Mvop
	3IrMT0RzJp5C19QoS+QGRqaQ4Phd7Tw6u5GWCWD26ix/+7NQcLvd7Lon9FuCXL41u+fAc/2WQku
	4v3MyOnE0iXMX65GJV3oNt/aw/2H/mZYZtid+D225KA9JoKxrZ2GFYm+v1VD1DgCiOAUm5LsmA=
	=
X-Received: by 2002:a17:907:3cc7:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c513ab4cd0dmr859651666b.36.1795425442222;
        Mon, 23 Nov 2026 01:17:22 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afca58asm371207466b.65.2026.11.23.01.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:17:21 -0800 (PST)
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
Date: Mon, 23 Nov 2026 10:17:21 +0100
Message-Id: <DN2H797ASILD.3P89IOZH1IU1H@fairphone.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
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
Subject: Re: [PATCH v4 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
 <20261117-bat-temp-adc-v4-1-14d5d309ebfa@fairphone.com>
 <20261122031305.0fdc69cd@jic23-hlaptop>
In-Reply-To: <20261122031305.0fdc69cd@jic23-hlaptop>

Hi Jonathan,

On Sun Nov 22, 2026 at 4:13 AM CET, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 09:23:11 +0100
> Luca Weiss <luca.weiss@fairphone.com> wrote:
>
>> Add the BAT_THERM channels with millivolt as output, which can then be
>> used along with information regarding the NTC in the battery, to get the
>> actual battery temperature.
>>=20
>> A static lookup table in the ADC driver won't work since different
>> devices have different Ohm and Beta values in their battery NTCs, for
>> example a NTC can be 10kOhm & B=3D3435K.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Given this is independent of the following elements other than
> the dtsi changes, do you want me to pick it up now?
>
> You may need to use numeric values in dtsi until the header
> catches up then chase with a patch flipping to the defines next cycle.
> That's how we normally avoid that dependency slowing things down.

Sounds good from my side. Thank you!

I think realistically, there's no other option than what's implemented
in this patch, even if PATCH 2/5 (dt-bindings change for generic-adc) is
not reviewed yet. But I hope the dt maintainers will be okay with that
as well.

Regards
Luca

>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
>>  drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
>>  include/linux/iio/adc/qcom-vadc-common.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>=20
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spm=
i-adc5.c
>> index d57ba8526e0c..24ac84580570 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -542,6 +542,12 @@ static const struct adc5_channels adc5_chans_pmic[A=
DC5_MAX_CHANNEL] =3D {
>>  					SCALE_HW_CALIB_DEFAULT)
>>  	[ADC5_XO_THERM_100K_PU]	=3D ADC5_CHAN_TEMP("xo_therm", 0,
>>  					SCALE_HW_CALIB_XOTHERM)
>> +	[ADC5_BAT_THERM_30K_PU]	=3D ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>> +	[ADC5_BAT_THERM_100K_PU] =3D ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>> +	[ADC5_BAT_THERM_400K_PU] =3D ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>>  	[ADC5_BAT_ID_100K_PU]	=3D ADC5_CHAN_TEMP("bat_id", 0,
>>  					SCALE_HW_CALIB_DEFAULT)
>>  	[ADC5_AMUX_THM1_100K_PU] =3D ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-v=
adc-common.c
>> index b03cf584b165..101b3c724f8d 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>>  				u16 adc_code, int *result_mdec);
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_mV);
>>  static int qcom_vadc7_scale_hw_calib_therm(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>> @@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
>>  static const struct qcom_adc5_scale_type scale_adc5_fn[] =3D {
>>  	[SCALE_HW_CALIB_DEFAULT] =3D {qcom_vadc_scale_hw_calib_volt},
>>  	[SCALE_HW_CALIB_THERM_100K_PULLUP] =3D {qcom_vadc_scale_hw_calib_therm=
},
>> +	[SCALE_HW_CALIB_THERM_VOLT] =3D {qcom_vadc_scale_hw_calib_therm_volt},
>>  	[SCALE_HW_CALIB_XOTHERM] =3D {qcom_vadc_scale_hw_calib_therm},
>>  	[SCALE_HW_CALIB_THERM_100K_PU_PM7] =3D {
>>  					qcom_vadc7_scale_hw_calib_therm},
>> @@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
>>  				 voltage, result_mdec);
>>  }
>> =20
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_mV)
>> +{
>> +	*result_mV =3D qcom_vadc_scale_code_voltage_factor(adc_code,
>> +				prescale, data, MICRO / MILLI);
>> +
>> +	return 0;
>> +}
>> +
>>  static int qcom_vadc_scale_hw_calib_die_temp(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/ii=
o/adc/qcom-vadc-common.h
>> index 3bf4c49726a7..7586016ff14d 100644
>> --- a/include/linux/iio/adc/qcom-vadc-common.h
>> +++ b/include/linux/iio/adc/qcom-vadc-common.h
>> @@ -93,6 +93,8 @@ struct vadc_linear_graph {
>>   *	voltage (uV) with hardware applied offset/slope values to adc code.
>>   * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC =
using
>>   *	lookup table. The hardware applies offset/slope to adc code.
>> + * @SCALE_HW_CALIB_THERM_VOLT: Returns voltage in mV of a temperature c=
hannel.
>> + *	The hardware applies offset/slope to adc code.
>>   * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC =
using
>>   *	100k pullup. The hardware applies offset/slope to adc code.
>>   * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC =
using
>> @@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
>>  	SCALE_PMI_CHG_TEMP,
>>  	SCALE_HW_CALIB_DEFAULT,
>>  	SCALE_HW_CALIB_THERM_100K_PULLUP,
>> +	SCALE_HW_CALIB_THERM_VOLT,
>>  	SCALE_HW_CALIB_XOTHERM,
>>  	SCALE_HW_CALIB_THERM_100K_PU_PM7,
>>  	SCALE_HW_CALIB_PMIC_THERM,
>>=20


