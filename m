Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7927FD51
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275463; cv=none; b=MWOYzhOcyeOCKbB1RCePZFiypooRpp7eU9tEXbKLf7XnfjNcxK0WuUf56dUrOiWzlhpfu5Nql9jv2Vcr2q6mAvDGt+/ZEnirTR3/3gIxQOS/MfhyF+qAvvlnVkiQS3aVHMEbW0cFVwJ4qaY7Rw78YmIXD6tizkZGiBh4eUYndbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275463; c=relaxed/simple;
	bh=dhI2NSSkHQdnuRHh+TevsjJW+xFqrlGDV2/7Z5uiHks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SxXkEotB9+85DO5JTr9nfMIMtABirZ3K8gkqE88BvHnbENlya4sCfFPhoMz8CPS/BXAtYsSGEUScEmt6YEdkVHSAJ8KW/qAZxl3kDTYE5AiZAcNQXZf2g8InGKPBIHclCf4UDZKP5qcx75S9shIEI8yHQqjTNiO5kngMXoSX0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc+oq6rW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc+oq6rW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso1302320a91.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783275461; x=1783880261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPuWUz6K1vjqfLd89Qgt+4X64jH/WQepHZOhzBXpFBs=;
        b=Mc+oq6rWGUenBzFtmvEUJ+cxwDxZAPvves1/eocNtmNJscDuk6o+nMPF1eH0MGyFrP
         RXkGYbcK7Sc7L4CG0Eu6X93ORKKDklom+QRE4tn2WikivT5U9YDZHMBYxhRUHuPXiTwU
         FdYYaWZ+MKa0z0k+E4WUef9HKZb4TCu/908sXgnr615cW/7DFjFuTZtr271IfgmKcxA5
         lMqEIw1UsE1KWG8cQXYjIIhvVDNa45Ly90bk+A51VlkYJvKNIpQDyywNDpX27zVgR59q
         NTof52fYfmVD+1JZaDWX62fEjFLZyQZ8q51gw06AksHKVJDhWQvkAKfJoU3UUnl8elgC
         He5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783275461; x=1783880261;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPuWUz6K1vjqfLd89Qgt+4X64jH/WQepHZOhzBXpFBs=;
        b=PYHMeYWgRli4hN6JSdjpcBIhvqSnuE91RcNMsTk/sBSDnqxAaiaBjN/oyV/FtIEsW0
         c8HfOw0CD6IsxkgnIL5D5TbloFp0hjnamtZPUBWNpy0KdH8rqhbwFNigJ7SZjomvE7Mn
         2Dc/qVUgJZL6e41I2AgLZjCPNQI2KY0uXPd4ofM9j0hDSJuSJnalh0NUpCk6K0zTjE9F
         2bwqsxOfmgMGBo21OtRc9NPoq6iSn7l6EesYZD0wnc0k8ae9scZLEVO5LuIu3h1c4baq
         RNvvemOANX+cJ//aGCBWZylHW2IsxLSbJXuzSR1meS6iubzX6Hr0mIXzPwAN1ScGHNwS
         h6FA==
X-Forwarded-Encrypted: i=1; AHgh+RoPrqmifDHpS1vdir1U3fHUGYzBY4FWm3NFKgya5w3cuUfjTz9Hq+xYkZicxZKe3NTU4bSoc19JYBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqxb6aVktdr9h0yUHrILDx7+f0tCaLSFwQsMPXZubTsGRVWAyH
	b3PyaUP5MK4LgPHqLa3PF8gJ1bX/2v7hukwgy/g0ulWiU0Fkye6qBzRn
X-Gm-Gg: AfdE7cnwlkZKroYHKbQLg1B1xfhepD1uqlQVSOwWAQY/RGo/QFGm7sYksx7cq5tGKR5
	LJ8UQk9z8IbqVkxCKuxspWjofTSKqA/uRZ15iKmgUqY5n4dgc8U/dLtjqPLd3C3S+FZyN3aA2HL
	4lX5/O1RNgtakusFLuRZdV1qmrHH5kpgf4+h4FmSqQNqg5y8HMMo0PdTN1xrHHTyH67ytDwa+vT
	umcsYHf6ynYRFKPyhfNUShpK4EUbkQW0jnHYKVRI3oQHVaYkODFueQwHYwBla5pWBLL3I7kldic
	gN+zoxTqIad285TslOMhbCBTS+BwKFxeXw1YgRZvZzaUJ4CSiCEUME8qgAgwhyZrsIvIRgLd4wc
	DjbJ83TdEV5VV/pLPXksEQWIejywr+i8XO46GlctEAetBwKcdwDK1O8qEGHKN091z4ECF7npLbk
	+6livbPMiUQSv1xU7AB3l+IBijUPsa5L3Qe06Q
X-Received: by 2002:a17:90b:268f:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-382803bb30emr7701477a91.3.1783275461234;
        Sun, 05 Jul 2026 11:17:41 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:c3f5:258d:4c0a:f0e6:bd1a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm41239387eec.11.2026.07.05.11.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 11:17:40 -0700 (PDT)
Date: Sun, 05 Jul 2026 23:47:36 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer checks
User-Agent: Thunderbird for Android
In-Reply-To: <20260702182205.388efe24@jic23-huawei>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com> <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com> <20260702182205.388efe24@jic23-huawei>
Message-ID: <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 July 2026 10:52:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eo=
rg> wrote:
>On Thu, 02 Jul 2026 21:48:00 +0530
>Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse=2Egmail=2Ecom@kern=
el=2Eorg> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Replace explicit NULL pointer comparisons with implicit checks across
>> HID sensor IIO drivers to follow the preferred kernel coding style=2E
>Is there anything in the kernel wide style guides about this?
>
>I do prefer this style in IIO but perhaps we should document it
>as local IIO style rather than implying general guidance (unless
>there is some!)
>
Hi Jonathan,

I took reference of existing IIO commit message and followed the same=2E

There is no kernel coding guideline for NULL pointer=2E If you think it wo=
uld be useful, I would be happy to work on documenting the preferred conven=
tions under "Documentation/driver-api/iio/", for example as a new "coding-s=
tyle=2Erst" or similar document=2E

Thanks, Sanjay

>>=20
>> Convert 'if (indio_dev =3D=3D NULL)' -> 'if (!indio_dev)'=2E
>>=20
>> No functional change=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> Reviewed-by: Maxwell Doose <m32285159@gmail=2Ecom>
>> ---
>>  drivers/iio/accel/hid-sensor-accel-3d=2Ec       | 2 +-
>>  drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec | 2 +-
>>  drivers/iio/orientation/hid-sensor-incl-3d=2Ec  | 2 +-
>>  drivers/iio/orientation/hid-sensor-rotation=2Ec | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d=2Ec b/drivers/iio/ac=
cel/hid-sensor-accel-3d=2Ec
>> index 9197f3424c0c=2E=2E225f8dd65ab1 100644
>> --- a/drivers/iio/accel/hid-sensor-accel-3d=2Ec
>> +++ b/drivers/iio/accel/hid-sensor-accel-3d=2Ec
>> @@ -325,7 +325,7 @@ static int hid_accel_3d_probe(struct platform_devic=
e *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct accel_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec b/drivers/=
iio/magnetometer/hid-sensor-magn-3d=2Ec
>> index ad10fa20fae0=2E=2E738bad65d74d 100644
>> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec
>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec
>> @@ -463,7 +463,7 @@ static int hid_magn_3d_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct magn_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d=2Ec b/drivers/i=
io/orientation/hid-sensor-incl-3d=2Ec
>> index 870c8929491e=2E=2Ec8efb0dab8b6 100644
>> --- a/drivers/iio/orientation/hid-sensor-incl-3d=2Ec
>> +++ b/drivers/iio/orientation/hid-sensor-incl-3d=2Ec
>> @@ -302,7 +302,7 @@ static int hid_incl_3d_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct incl_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/orientation/hid-sensor-rotation=2Ec b/drivers/=
iio/orientation/hid-sensor-rotation=2Ec
>> index 2dad0453fc67=2E=2E6db253c1635d 100644
>> --- a/drivers/iio/orientation/hid-sensor-rotation=2Ec
>> +++ b/drivers/iio/orientation/hid-sensor-rotation=2Ec
>> @@ -274,7 +274,7 @@ static int hid_dev_rot_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct dev_rot_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>>=20
>
