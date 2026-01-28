Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035792F5331
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592548; cv=none; b=n+2HN+PLVsyYQ3n/NGNmt6roOzcTlUuE3I71HczJ3Egvo/IqWNJvP8EFQgzqoP9kCdMCrbyOGak9z8qFtm3PpcI7ApaOiO1FaF5clig7Y7UHBojwzmGi9Rxo8GVeDW9AnoTqpmvAuWv44WW6dj8y63K6KBNx0zA3LGtJ0As0ECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592548; c=relaxed/simple;
	bh=UP+WW7Dc9SoOQ1SJaOin/KlKCDh8HTR0VomQ0nz2Kek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VA2FqV4zURgG7fVstdbKhFcVUFIFs2ozKcV0AxZXHndTYd0MuPFZZPuv8C9eOF3ylWuTjo202QyeTnUaosFFILGljAnn/9Yn4og0j4+kzfrPJPA/9+2marbp9ObJyMzYXyYIFN3aXiFBQSNn+nLHzFfAIxmSq6N8ach688b3+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9wUPlET; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9wUPlET"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3996058f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769592544; x=1770197344; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwOcfsfrDBPmMGisp6X+dkj3y6n6qfrea/qIENi+t2I=;
        b=D9wUPlETXphj9xcQVvMkON8ogRds7Esz1sjCHxbocBwOLUqAva4cKOxjDlah6krmi/
         Hw+pb5U0iiOlwz+OgCYAXPnG3S0WlEYN5JOovzaOvTTZcZc2cs+MocwoRKwZCCIB+/DC
         tTWXZjYzKykfYE+8wukuQjqnP+CNs0znzyPbFVg6OWvP3KWUNw3q+V8Wa4cqoSK8HoYf
         3tK2kct/zo4AWA+tBosaRxB5Glc6NT3LxbpA4w3Ofnqnc0STANUs0NYAu5RKJNObyPlA
         GuxYj22QZIwChwl9beC22vYVtJYo7wOPl1kRrZYxadqGiv4Ku41ucKl1qzXCg95kK4ce
         YEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592544; x=1770197344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwOcfsfrDBPmMGisp6X+dkj3y6n6qfrea/qIENi+t2I=;
        b=pvZKugU6dKdcAU02gc+QwTCYu8b1qZFfVe6LCQUt2m7Reb4F7vZhmuG8U2z3v4mm5x
         ZRIaypOnJV5eslucnLpLR0V2iCDnjijy9XrUZKIIey6M/Hs1+2vMCpd8Zko8X1jpR14x
         Rv18a3k2Y9A1gISTdQnGlDbfgQQGHQSgtHZB1/EHa02pebq7w15FyboL1cZXI1O1W0kn
         2WBDQAEmph2AHMYNOwUVQygTCaRHRdUPsgxmGA5Qw8NNBn4PD91MF075eBludNfPQg3T
         5T14pf8BFJzcqfxUfjcDFZPDfmNYjvJ4O/FFP6m4OGIQ8Gx0SLUUeozmQpnO34TCDHne
         uhlw==
X-Gm-Message-State: AOJu0YxIowxKth4xq1mH3BBGu13U5/10H09gkmn5EoLtNG4jgSpCrkDp
	VQHpGOa9akDxaGz6RUN+TEVSSZVmNIG5GvntHLqdqNKxNwqVkhHIUlmW
X-Gm-Gg: AZuq6aLYKIiEWX2tN/Dl9zUYfWMTUjywFERuijgwlCC7KZtjOmII7/3Djk6F3waZCa4
	GyQACI0LLHhLXb1SOmh81Y72aPdkXCO1jbWxCNNr+I/PID+gfrICy1gSmUvOP+DfgtobnAZ8As0
	t/JPePmyjSnTfwW5GCBHGeLlJg9NryHRj7hfDggMwTqcyjdzk4wf2wv3Afm1AFBQ2cmAhHEkBcG
	UkGFxfsUhSGpIyJfh8ZnyIXjTrAlbvMMEaE9ttMJUKiiqY8zGY8hCLeOlMAHUcmaJiEI4JKuxP/
	2a+3hRrrHF5cN57VEiAWJ/L6QvNU9+yGyePabDrMgzkJtQfA9c+JUA4Uvg/Ub2xONDWYX+CxsHj
	MgdZWtx48DjLDFZRtkkzMtwN8rrMrYn8AXVOz0Iml9AMFtU8ZDCTTYMJetB3Ymo+7mX+AA5oLRl
	FmCOie69zrTZD/tNFsKx0=
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48069c6970fmr52404085e9.19.1769592544055;
        Wed, 28 Jan 2026 01:29:04 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm129275515e9.9.2026.01.28.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:29:03 -0800 (PST)
Message-ID: <a820c04c224366e31ffbc6d7fe38068f8aab4137.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: vf610: Add missing check for
 device_property_read_u32_array
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>, haibo.chen@nxp.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 09:29:47 +0000
In-Reply-To: <20260128042700.2260803-1-nichen@iscas.ac.cn>
References: <20260128042700.2260803-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-28 at 12:27 +0800, Chen Ni wrote:
> Add check for the return value of device_property_read_u32_array() and
> return the error if it fails in order to catch the error.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> =C2=A0drivers/iio/adc/vf610_adc.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index d7182ed0d2a7..d53723ccc5b2 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -871,7 +871,10 @@ static int vf610_adc_probe(struct platform_device *p=
dev)
> =C2=A0
> =C2=A0	info->vref_uv =3D regulator_get_voltage(info->vref);
> =C2=A0
> -	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max=
_adck_rate, 3);
> +	ret =3D device_property_read_u32_array(dev, "fsl,adck-max-frequency",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 info->max_adck_rate, 3);
> +	if (ret)
> +		return ret;

As Andy pointed out, this is changing behavior so it needs to be properly j=
ustified. Also since we
are here, maybe use ARRAY_SIZE(info->max_adck_rate).

- Nuno S=C3=A1

> =C2=A0
> =C2=A0	info->adc_feature.default_sample_time =3D DEFAULT_SAMPLE_TIME;
> =C2=A0	device_property_read_u32(dev, "min-sample-time", &info->adc_featur=
e.default_sample_time);
