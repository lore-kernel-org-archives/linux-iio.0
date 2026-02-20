Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AB331219
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587100; cv=none; b=Ib1+L8yTr0Wf6rWju0dMCCp6BVIz8hDVxAoVDjV2l6FrEuBKVNXJl6wu1oInrUOKKhFZ3mY+hFohnxYEkYe0RRo5T70jUu49EWhWMvTAaEEEt291sjs+MZ+iCq98hAz+ahIAmnRtYsjoYvpphYict813x9zVlOcN0v1dEKJp9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587100; c=relaxed/simple;
	bh=dL95nES1PvUKDwOE/SzRBysmIFe+L8zYNyzvl+l8sDc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EopmXWDZg8ntju/7MMuHxqb+fRK/xBeoX8tnTozTkuielx9tkYehw42WTQNSZpRBLJfJ0QKCTPfD23PgwDYrOqXfA8plLYozTni8GFJoIh5oZTRDYmwaRj4uet9v2vAHUHSXaCHth7ESNUQZ9Z3scg1MKlFmLD+xfbMkV32d/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4NHgTx+s; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4NHgTx+s"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso2412775a12.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 03:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771587097; x=1772191897; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGfuKGhv7t9katQ89dFkhDx2tsJCNlvP9HCnVuHq6Y8=;
        b=4NHgTx+s20DfwneSZjvrzDD9fpZEe4W9UVaWa3uDZd2yk7x5f4ZTJ2hrX1qyF0rwc3
         mE2i9g1k4aAN62huoSVqZQQ0r+G0luFFPtWcpI3zpUy3sCk0XoB9SbVEEucFQx1a3eRc
         Dz6UavddF+3GheXjgWPgfRWV2pfEF15PH6fVPFZMIJD8GSdjbbe0T0QISnMvY2UcFX9H
         8wwW35tTTD4Lla+gGXF8YhCQikEEAYZBtyHNLPko8J1VOThanka0vu46lcMm9DLdrou3
         YThe8BJzfkBGvXdHdirakJDZ+hY3fmjrKml4+DGyFks7S5wc1vZyjSbr6c5Pz0jZAUil
         qQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771587097; x=1772191897;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGfuKGhv7t9katQ89dFkhDx2tsJCNlvP9HCnVuHq6Y8=;
        b=GildE3oX0QJz/WOXyOk+xnAeOxTA6YcQpkQ3nVZuD/FHcUPP3KJKLkfm30XvPxbbVE
         ItrjtfvdMwlDv22GW9ZuOCrMKeHguFS+shAPjZQI515WvXMhS54mMDU0g/uYJy4bqN17
         SNyiGZhcHo4J4QPZOEX5xmvqEqQLatOUX38wTSXZOWR9x2dd3DqnuaQDweOVrggTWvWh
         qLR25XDNz7tPvQbJRfrFTaarrCu9Vql1K6uoFq6xPtMF2DcexxqbbofjiDkIBc+Mnb94
         CYKmge6dB643DFpvy5n/kfUTgjaVsKYKXj1zoG6Y2YMvO1VfajaUmyPjVLrpVF3AM71J
         WIkg==
X-Forwarded-Encrypted: i=1; AJvYcCV9KyY/oYEnCSbjsfvATRgbETib+TIO9hNjiflmRdYMrl/byj+2r4YYWcnbeRL8mzOWAPrsSIv8xCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MbjBg8ie8GwBJFi7kfPHI5PRlqPFnIK4fINHh41L7fIHP/1M
	4b34P7+XO7akyUAu+kgf/YNN1E3tuVylfV9ZXqYWmsj3WZKdMU2XlzIjim4nEMPV/Ck=
X-Gm-Gg: AZuq6aJEkf7JTjbKZ1N1PlL3CnpzGPpu4OE9wnN5r6WU2pVsoTDoLKV/ZHodSUZ2pXC
	ylp1VUdvsVwCGk+sbLk0Yy8OPooI4qkUA+LhcNfDeEGMkcMQpIN8tBgpZ8OZ2sc4P6+YcmP4V7G
	y3x6SUcSFD0zUaKiaNK/XJXlrR9ij2PaQJKsxBcT223vJ7D840nZX3L9RnNbad8I2EYAGwMuy6i
	R8TiqmW+anvPIU4RKLkYkJKH1n5sgwqXf7Owp0+Eo0EP23XleAzbzN50TdEZMXE+oJkQ9/XU4e5
	PSbaBaFzq2QQ9vLfEAEPdrAPbVMk6Nb0vCoMxJtsJ3yvKP34P7POhnipbnt4wbPJzM6MHpnNJ71
	zu54YYM/cPdg6YpxW/2eLPe/wSgwVMqs9wxT2u4uk3KdLw5O5NkTxCZOIkQQ8G/xI2vfN/PpnQG
	4fKWfoc3rfkzLjMsxeG6XTwulFXrnJfpJf+1Zbij/nCvozTKkRcAfqd+LkRSMxjg4zPqKC
X-Received: by 2002:a17:907:728c:b0:b8e:8874:8384 with SMTP id a640c23a62f3a-b9072e1eb1cmr91962966b.4.1771587096917;
        Fri, 20 Feb 2026 03:31:36 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766531asm666569166b.50.2026.02.20.03.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 03:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 12:31:36 +0100
Message-Id: <DGJR7OIPI2ZS.ZTJ1IJWB3Z61@fairphone.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Laxman Dewangan"
 <ldewangan@nvidia.com>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konradybcio@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Jens
 Reidel" <adrian@mainlining.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
 <aZg8ZqckhGbvkdel@smile.fi.intel.com>
In-Reply-To: <aZg8ZqckhGbvkdel@smile.fi.intel.com>

On Fri Feb 20, 2026 at 11:50 AM CET, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 10:19:07AM +0100, Luca Weiss wrote:
>> If the devicetree node is not referenced in a zone under /thermal-zones,
>> devm_thermal_of_zone_register will fail with -ENODEV.
>
> devm_thermal_of_zone_register()

Ack

>
>> Since the driver is now also registering as an IIO device[0], allow the
>> probe to continue without the thermal zone.
>
> Isn't it dangerous?

Why? The idea is that generic-adc-thermal is the middleman to convert
from one IIO input to one IIO output, and is purely informational, so
that user space can get some temperature value to display somewhere.

How thermal management will be hooked up in the future to charger
drivers is a bit out of scope here I'd say. There's not even any cooling
support in the power supply core anymore, that was ripped out a while
ago if I'm not mistaken.

>
>> We also can't use gadc_thermal_get_temp anymore because we haven't
>
> gadc_thermal_get_temp()

Ack

>
>> necessarily initialized tz_dev.
>
>> [0] commit 3762f5851ac5 ("thermal/drivers/thermal-generic-adc: Add tempe=
rature sensor channel")
>
> You can make it a Link tag:
>
> Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]

Ack

>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> ...
>
>>  	if (IS_ERR(gti->tz_dev)) {
>>  		ret =3D PTR_ERR(gti->tz_dev);
>> -		if (ret !=3D -EPROBE_DEFER)
>> -			dev_err(dev,
>> -				"Thermal zone sensor register failed: %d\n",
>> -				ret);
>> -		return ret;
>> -	}
>> +		if (ret =3D=3D -EPROBE_DEFER)
>> +			return ret;
>
> I believe it's better to return all possible errors. If you see the
> similarities with regulator APIs, then use an explicit check for -ENODEV.

Sure, will update this.

Regards
Luca

>
>> -	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>> +		dev_info(dev, "Thermal zone sensor register failed: %d\n",
>> +			 ret);
>> +	} else {
>> +		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>> +	}

