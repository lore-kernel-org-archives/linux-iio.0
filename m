Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88B33D509
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563992; cv=none; b=LAS3eUAWh8x4kpMGhh8RCwb732+tSAotS91P/MbNkaTREs/x7Xc2/RO4nVmD+GIkSh+h+q3E1c+d+jh8keNVJvWPVgVuIYX0wxvTCNV7l9iwN7+K4aDbdApyOjS5AFAZd0Vl2rGU1Fa8usQjrSEA1SaVtWVVFclBnyJWl2w9haU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563992; c=relaxed/simple;
	bh=+xzriWSR5iGt8WjlG2DY92+pZ7PIMUvY0YdgOUgFfco=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QDSoDJ/k57kBZoc36QR5zBPYlGUzZeCQh9fQHMtcDN7kpoyqXfUWZ3XVs4PyXxCfE49eqxdC9xesEZaf+rtvGXBxl2tbHn/64jO+LnJ7zyPdv+i9j5OkvQhsjPi95CC7DpWPoFFd27ITv9vmAW9DecOSOVaOUmYs+skghrA+0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUCxohCm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUCxohCm"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso4836600e87.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563990; x=1771168790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W15qM4zjUo3jkGGj+XoI8VU/D/d6+cRvXAz+lQ/6Xi0=;
        b=SUCxohCmgYBUg1Doaa0sWREY1ExnWioYyxlVQOjTgL/iEYFU0UG4XsHNsQ6OCVhkvK
         bcPooG5fPikQ/ygZmJ+40ys7Jm1U7Y0rVs8LIAZ5nDfY9HSAl+SxuUy5rkhVSaiznFJv
         fxCefGGML/XdtYQKKou9qYYX9hAbN4TggSDpGr2zcdXeFpOqRs697S+iKY4mwki660KK
         IPLaKC1kx5zzhMQvGVIBJb4JXEf/6hu38tqoGDYeQnp07jL2lBHSYuYV34nTMncZ+gna
         g8lM6F/P1M2AM+DrcWXvZAfCIh5j+dJbd4GvGgpq3NhlzeZHvKIKOALiU59mz8ODEzK1
         LEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563991; x=1771168791;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W15qM4zjUo3jkGGj+XoI8VU/D/d6+cRvXAz+lQ/6Xi0=;
        b=Q/jqtnxvyA0FVzk/QOHvqleFqYwx1Eu6BxRKQ2qiImGT4PueIM1tD5kI6GTn+FEfMq
         S1TstmjfC01izOtQlvDrnTa0D88B8oqi8k/KPh5ugMCcDt3rRfff+dsrWvKLNd4xHFEl
         xz//IoM3Hi8HEPUvlD597/847xLxzP7QrvbN/zWaN+AhDXZRfyvYjO24eutf/G2+77Qs
         oDUh5x8Wbk206SREKyDS1gqhWO0UQHbJPIkjiThHTpmZSUi0/l/h6GixzmvGkSisdkng
         pDE66zpYxVy/TQS1vEuCrfnXs9Eu3DRRxEeCfvo7Fe6STXMRiRuFqM3es3quq5xNDqje
         exmA==
X-Forwarded-Encrypted: i=1; AJvYcCXw42XrBVLt4p8yI+xWawICZSMA2a2OElxUrOVCiD38oEhp4DiAndvsojUZUYkdAhp/dHFnpI9Qfjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRj5G6z3mJYNNmXZ8owa7+tqRzAjMxEApkFcblmnKxv2wMZWC
	NtJ+YJDn/DJ279By7SMvjpeV1RgWdgeFhTQSN6dQ4/j7kL8sk3uAa+SY
X-Gm-Gg: AZuq6aIzRin8nlit7ueA1rSElI+iFZ2H52PUVtYIIt6DS3cSzzcfIHsuyjmXe7hIKrG
	WhcNUiIfq9rkKfUafpNAgU7vzKQhO0VFePe6/XYnC5fxrH6/npgZOGCtphbyMA/EXUfBQnmxVXy
	8usdZPjaFb8IRSgoHYQSDBw1Vl20ckn8d8NR/eebISoEpLgbtpcT5VlMlgd2QpyblTyYQVqZpEj
	h7SVsE97IL5F3HjnzccoCxHYQRxUjr9sck9EJeaFAnTboU0LotIRa2D+Z08llJzd+RvYKTq/adh
	m6BYrTcqDOFFU/YU/eExqyNle3GvyyGFbdh6piFiO+X7+0z17tBFjmI1v4Jkf+LMc4FWR/3RRIU
	0dT2tLuL53dRDuvW9SrVMq1thTKIxUuTKWd0MPb3A5ukMAdna6Tn5eUEKHzmqIlrSG03x0d0M0Q
	KF0YlWdvFSp6lorQa57lMO
X-Received: by 2002:a05:6512:2508:b0:59e:4f97:ad59 with SMTP id 2adb3069b0e04-59e4f97af15mr263855e87.10.1770563990386;
        Sun, 08 Feb 2026 07:19:50 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.246.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6e8fsm1963107e87.9.2026.02.08.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 07:19:49 -0800 (PST)
Date: Sun, 08 Feb 2026 17:19:49 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/11=5D_mfd=3A_motorola-c?=
 =?US-ASCII?Q?pcap=3A_diverge_configuration_per-board?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aYiHnUW93AB0ARJH@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-11-clamor95@gmail.com> <aYiHnUW93AB0ARJH@smile.fi.intel.com>
Message-ID: <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 14:54:53 GMT=
+02:00, Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> =D0=BF=D0=B8=D1=
=88=D0=B5:
>On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
>> MFD have rigid subdevice structure which does not allow flexible dynami=
c
>> subdevice linking=2E Address this by diverging CPCAP subdevice composit=
ion
>> to take into account board specific configuration=2E
>>=20
>> Create a common default subdevice composition, rename existing subdevic=
e
>> composition into cpcap_mapphone_mfd_devices since it targets mainly
>> Mapphone board=2E
>
>=2E=2E=2E
>
>> -static const struct of_device_id cpcap_of_match[] =3D {
>> -	{ =2Ecompatible =3D "motorola,cpcap", },
>> -	{ =2Ecompatible =3D "st,6556002", },
>> -	{},
>> -};
>> -MODULE_DEVICE_TABLE(of, cpcap_of_match);
>> -
>>  static const struct spi_device_id cpcap_spi_ids[] =3D {
>>  	{ =2Ename =3D "cpcap", },
>>  	{ =2Ename =3D "6556002", },
>> +	{ =2Ename =3D "mapphone-cpcap", },
>>  	{},
>>  };
>
>This  also needs to be converted to use driver data=2E
>

I can do that, but is it needed? This id table, if I understand correctly,=
 is here solely to silence warnings about missing spi id table=2E Driver it=
self does not use it in any way and will never use since all available devi=
ces that use this driver rely solely on the device tree, all possible futur=
e devices will be relying on device tree too due to obvious reasons=2E

And please, may you contain all your reviewing in one iteration=2E Then bo=
th of us will spend less time working on the patch=2E Thank you!

>>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
>
