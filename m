Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6723E4C63
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368527; cv=none; b=BVode4Np2xjNA4qFvLcE2gWuTV7yqGvnzvKHZ9VfSey/YJV1LoGcsR5CDOxCQbeGsn6rb7CDRLuv3of9d0CyPSwF+VP4JlhAtE4HdMPAN7S7LTBa7h4tXZzAjz2XM8sQZ1sSctPex23wyOkK9UAWh0W4eiKtdu82toY1x+O5pWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368527; c=relaxed/simple;
	bh=xADwBg60ajDb7nmR1hlj16mg9zPwSn36+EuyPhLkdMk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cOPY6kJLk0y7kCL6XSQRIuBxi2ZwhxnTnrhKzTcFakVfNcw0leOPsx7dH0o6NPqKK/bmpzaIYsKZh+rMdYuqpie+x/tzUdk3+JrH766fYwxINdgl12+9yPtKnT/IAYyBIfDsXGJDxiy6PHmNQzC3qz6OOzCrxmb6OFZ57/xZAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTwN8uzr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTwN8uzr"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso7230524a91.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776368516; x=1776973316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYVpFt/TTEE6G8deD78l3aDh+bZpbNaEN4R56Ew+4SY=;
        b=FTwN8uzrPDtGdJai8YnO+ITX3TZn1HI/GTAHcR92AxjTktFrxDe2hM+6AfFAqWjTB+
         vS3mXmUD984RjSLzFisaVyjeZkA+XGbTQcNhN3hYNczwUAyX7bdOhUEM4snMuqhBwEN2
         x+s8eZThfnutmbkoTUTVSXw/YK5nzEQFYwGLQXrBX7GE+n8olTheaXH2difxEK3DixC9
         Icd7dsMMgWO+43GVyfJw4Rq4dcUD8dY7cJMEKVgTAeIx90Mh6Wt1sMGrZbj32FSU5xR6
         7Y4jOZAb8wm0eLgff0DoxbOAUS1gSoOfRpeE+8ZaK5N3qCiKR1EfjoFoBzkfhqR/wEtz
         EBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776368516; x=1776973316;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYVpFt/TTEE6G8deD78l3aDh+bZpbNaEN4R56Ew+4SY=;
        b=JAO5VfzzzAeGIMRYniD+8JKQxm5wvuEYuMHv/LRGky8Ynze80fUnfygxViPoc11uXF
         XIwxZEoelbLg5RS4sIkEgj/vn0sePBKPYhTUlyLgxA8P3X4PCV4e3G/E+JEq7dNCqjwm
         zz/I0kTx6RxB2pnBbN+G7aAvWSBfi8OW2xrG8C8YnPDU6pEqLk7gCUgjQc/kPTR+u34/
         tAGehrVSzTf0rid2wdY6HeWUcnsGyBfO0dAcQ/tSclR+HuT3qdNnntxdly0uXH9copmL
         65cSgtZkfFRp4NE0FZgi/xVKe5JpvbDMN9ae65AW5XAhWZ4TI68EPJo2RL5tjQDq9Fe9
         +Zxw==
X-Forwarded-Encrypted: i=1; AFNElJ8i1dtJUwIffdEJru8LhiTb3T9v7oX1AhVAnnM2KgWFwfzuWsvk8nLAyc2fkI8gPAZ2pPHqVu5GAug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1b35iJRtW6IWGkQgO4osi4JmKcyVa9nTpvwr1VTc1rtAxMLL
	flExYzSwAXjeGO61ROrrFOhxES+r16RvvuJs9kkVU0AczOvuAAve12Y+
X-Gm-Gg: AeBDiet1nIglCtjncHurQ2x+OW/eFcfOTVZLols1altop/FmxgXrU4tTYM6DPE4e3wo
	fB+oZEVhx/UAXW2B0z3vNb/wNsKc1juMmUgEs6j3pg4tDVn6FMkYt8tGgmrJDiNlk3DSs1kPCnl
	Nih3RJmLcYm5G7ZnhFeAtBcYd8u6rIYpt8C36SgeaLmC3aGLjXVlkveJ2Dp5Ss+EMaf5IbDzYUS
	yEvPmGuA005h3T1RHH5e8KHfX8MK8s9hgOWAP4DWli/XrGLmlAzxDI4x50JtWvc0ni3g/SBaP3v
	J0QfDP9fhcxtKpxTEm+1FMxk3Flc4F5bL0i+kDZi7J0vIi3bnHdnXHXZ0PkbqZLXWJdDPLUl9WJ
	HPLoVGW6zWPzvs9tc1CWeYjR6/JDsZykRFNW5DWFHyQ4W4idBLSdq53BBSfbwyw1hWxkwK65gyt
	ekBJlxkMJwNOQHjFQdjRA0NbNrgehv5aOOk9HZnHBhX1u3dv7Z4vyoCO/pOw==
X-Received: by 2002:a05:6a20:3d20:b0:39f:706d:630c with SMTP id adf61e73a8af0-3a088f9ff4dmr379197637.22.1776368516110;
        Thu, 16 Apr 2026 12:41:56 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c031:753d:8278:1adb:ffe8:549a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eeb35csm4963020a12.12.2026.04.16.12.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 12:41:55 -0700 (PDT)
Date: Fri, 17 Apr 2026 01:11:48 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: adxl313: Use dev_err_probe
User-Agent: Thunderbird for Android
In-Reply-To: <aeCcz9GgFmig1d7U@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com> <20260416051631.551250-4-sanjayembedded@gmail.com> <aeCcz9GgFmig1d7U@ashevche-desk.local>
Message-ID: <32FEAA09-BCBC-449D-B152-DC3400AEA508@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 April 2026 1:54:47=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Thu, Apr 16, 2026 at 10:46:31AM +0530, Sanjay Chitroda wrote:
>
>> dev_err_probe() makes error code handling simpler and handle
>> deferred probe nicely (avoid spamming logs)=2E
>
>=2E=2E=2E
>
>>  	regmap =3D devm_regmap_init_i2c(client,
>>  				      &adxl31x_i2c_regmap_config[chip_data->type]);
>> -	if (IS_ERR(regmap)) {
>> -		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
>> -			PTR_ERR(regmap));
>> -		return PTR_ERR(regmap);
>> -	}
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
>> +				     "Error initializing i2c regmap\n");
>
>Add
>
>	struct device *dev =3D &client->dev;
>
>to the top of the function and use it here as
>
>	if (IS_ERR(regmap))
>		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing i2c regm=
ap\n");
>
>Note, it's fine to have trailing string literals, even in strict mode
>checkpatch won't complain=2E
>
>=2E=2E=2E

Thank you Andy for the input=2E

I will address review comment in next series=2E Also, string literals is u=
nder 100 after the dev changes so keeping single line for both i2c & spi=2E

>
>> -	if (IS_ERR(regmap)) {
>> -		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
>> -			PTR_ERR(regmap));
>> -		return PTR_ERR(regmap);
>> -	}
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
>> +				     "Error initializing spi regmap\n");
>
>Same way as in I2C driver=2E
>

