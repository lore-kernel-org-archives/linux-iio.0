Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6B3B2FC1
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911786; cv=none; b=q2feT56yluoswWkiMEWhj51/sdNLv0d80WX/W3vvqJJR6aHEUZT2D/yoP0EXk70KXagZylwOUAX2Oy7magkD1BGoEi7g0P1LVfPgcBzpiczd9UcPK7ldagQIokTFRaSxP2jDdif2TopS0O+VIKsU4gAw/pMl3n4Zy7Jy7kKGNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911786; c=relaxed/simple;
	bh=Na/1nneWkwIsSK0wzdVrB+7PXEUP5PDRPM5F8NcA1Vk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kZqokwOehw7aA5X3vszaaY+DXhpOLiz8OUBNRd9PzQdQT4RxpqrYkMlkCuqkyR00X6C3zDYwPvy14owE7RD7Jh8y0KB/vMZgCe/MRWGnPbkXplOwTcM2OfOsD3moaFZXM46vpuiMPDLFEgyKdnMzaNMznbn8Ymr+el+/KwdeGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLbSJGiA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLbSJGiA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab39b111b9so25126505ad.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776911784; x=1777516584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWnWcrRawl8wN8MZ/HrIoCkuMG7oU3ntDUnTsrIUO/g=;
        b=ZLbSJGiApz2xCUabQ2PDZJJ19FkP5BeCxAOHOuMwELwQvcBmDAc7aa1dnnznMJ257m
         rvnNs75IT98RlytKg/nWMlfLaJwCZtZQbXr7txkVnWLnXhZi0ZQB9ePKG8+IlqiFTKGI
         yLF6nPQgOS6EWgJzcYhd0pYAs5yMxJv5U2l2Vm39p8enYgany0qzcwxfFuVzAvGeGImQ
         T5XHTHxyLZKgDeFtD5Z4RUcJhhb55us5yd4g0jpdV+aUsGoVfN7yBshSOhxMENSg87Pn
         YZyJillUiczWDfBMdPfFwejXq7crClYXmxvlqd2+XFuRLDFPC4EWpQUHoGVIz9NqMiEU
         kBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776911784; x=1777516584;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWnWcrRawl8wN8MZ/HrIoCkuMG7oU3ntDUnTsrIUO/g=;
        b=VttRma5w2mmLHqeNw1zlOmcacc+WApCzfpWFOW7+pAOy0uKMysITbSiMluNVq2sTfi
         vTrWTXUDJ8aJEpTTf9+CcL9zMIT92oq0Q/Vre4N1K9QGqV9fzDlVN68BkPMizTNzD4Ny
         kpjmXlN1KYZURNHSdfHCF5lar4rTtvX3bONsA53tPqDRE9LrY2FjFSHIKyz+5rPX4MNR
         dajHNiZoarpjAHxMQqZBvC8w1Ed2IldAEGoxGzE86C9B1NcmtbrVx6izVLPUA4Nh1juJ
         V31UjvzsdVITIw3pNJdG4ItryjMIz9K0LANCCcvvx8Es6UEr918k0h42m8+vKMS6cWQ8
         KGow==
X-Forwarded-Encrypted: i=1; AFNElJ+yfgAZkZKazvfxPSdP7MHbtfXkCb9raIH8DRTt54VoDbdIRMmYKLuZ7xczy1XkDJkLcuA/6iHxfzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVu92YX/SgFCXJgKhDlzT4G+D8P4J0VOwMW1bOLLBZ56koEm4/
	1XIxRyzCr+/Vu8mIgTF7ygdPYu5O2TwlMQEwTfhe44cDWRwveV2Js1TM
X-Gm-Gg: AeBDievY9540G8CTflcoLddi3GlgG2NuvCzDroopN1lYItBngy2t9JDAbB0L5utenzR
	fxVrrPBXe4M06zfTKdpxYuitKp2eHv3D/6zA+mridt5bviOy5CVUoT4Spae90HcAMp/scX/PMC5
	qbH4yzrAvRDBUqbLxUHcE/kasBqwi5cFJQQBYD61V5VZXleYzzFKmXH5X68DWg9ooxNmJQ24GW8
	f3nFqtmRNxtIWKJxNipDuptbBgMWhULrzaxHhSyUuk9Ok0bGQuS0ytYjHXk1z7i1WeReRLfOCr4
	D/G9wnV7pKWMaKItP05+pCBWuFsntjUkDqXeBLC1zkkRUwRkEozLtxKT+SLdSC9oqyvdQj+Uk52
	kZT9mR+Jnzheg6KzJJLndDzfuCoT7QbebSZOMTzi/a2sFoq261WhTrQAWkxwVQ61SI74cgBZCtG
	hrTGIyCRhhw2ZjSSGIXdHS6MsNydnEgBVNsyRDPfeJ4JlSEchCEhIoR29llA==
X-Received: by 2002:a17:902:d503:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b5f9e9cb17mr257918815ad.9.1776911784518;
        Wed, 22 Apr 2026 19:36:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac11:2511:e0be:6376:6b19:86dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa33486sm214238835ad.33.2026.04.22.19.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 19:36:24 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:06:20 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: accel: mma8452: use local struct device
User-Agent: Thunderbird for Android
In-Reply-To: <aekjBaFT8xvM64zh@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com> <20260422165643.2148195-4-sanjayembedded@gmail.com> <aekjBaFT8xvM64zh@ashevche-desk.local>
Message-ID: <BA5F2EF9-C439-47A2-BE91-4ED6E12F2EBA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23 April 2026 1:05:33=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 22, 2026 at 10:26:40PM +0530, Sanjay Chitroda wrote:
>
>> Introduce a local struct device pointer derived from &client->dev=2E
>> This avoids repeated &client->dev usage and improves readability=2E
>
>=2E=2E=2E
>
>> static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool=
 on)
>>  {
>>  #ifdef CONFIG_PM
>
>So, this seems to be a missed in the PM patch=2E
>
>>  	int ret;
>> +	struct device *dev =3D &client->dev;
>
>Keep it in reversed xmas tree order=2E
>
Understood, along with headers would attempt to keep all local variables a=
lso in chronological order=2E

>>  	if (on)
>> -		ret =3D pm_runtime_resume_and_get(&client->dev);
>> +		ret =3D pm_runtime_resume_and_get(dev);
>>  	else
>> -		ret =3D pm_runtime_put_autosuspend(&client->dev);
>> +		ret =3D pm_runtime_put_autosuspend(dev);
>>  	if (ret < 0) {
>> -		dev_err(&client->dev,
>> +		dev_err(dev,
>>  			"failed to change power state to %d\n", on);
>> =20
>>  		return ret;
>
>>  }
>
>=2E=2E=2E
>
>>  static int mma8452_probe(struct i2c_client *client)
>>  {
>>  	struct mma8452_data *data;
>> +	struct device *dev =3D &client->dev;
>
>Same here, reversed xmas tree order=2E
>
>>  	struct iio_dev *indio_dev;
>>  	int ret;
>
Sure, understood=2E
>=2E=2E=2E
>
>>  	data->chip_info =3D i2c_get_match_data(client);
>>  	if (!data->chip_info)
>> -		return dev_err_probe(&client->dev, -ENODEV,
>> +		return dev_err_probe(dev, -ENODEV,
>>  				     "unknown device model\n");
>
>Now it's a single line=2E
>
>=2E=2E=2E
>
>>  	ret =3D regulator_enable(data->vdd_reg);
>>  	if (ret) {
>> -		dev_err(&client->dev, "failed to enable VDD regulator!\n");
>> +		dev_err(dev, "failed to enable VDD regulator!\n");
>>  		return ret;
>
>Convert this to dev_err_probe() before doing this patch=2E In that patch =
you
>introduce temporary dev variable already=2E Here will use in the other pl=
aces=2E
>
Agree with you, will rebase in next series=2E
>>  	}
>> =20
>>  	ret =3D regulator_enable(data->vddio_reg);
>>  	if (ret) {
>> -		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
>> +		dev_err(dev, "failed to enable VDDIO regulator!\n");
>>  		goto disable_regulator_vdd;
>
>Ditto=2E
>
Sure=2E
>>  	}
>
>=2E=2E=2E
>
>> +	pm_runtime_set_autosuspend_delay(dev,
>>  					 MMA8452_AUTO_SUSPEND_DELAY_MS);
>
>Now a single line=2E
>
