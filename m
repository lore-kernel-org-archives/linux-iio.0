Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AF2C11FA
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728757; cv=none; b=gcCCVKebnZg96cEdIYFmmI3NPrWm3ygMcYtLvxWEEQ7HWNEpmAfNc8hJy7REtar2eVxa7Me4SdMTI/yRIwnPZjAvVMnavctnRi6SyfuP/dq7g396qJ221Y+l95PBEetyG8wwM5Wol5lWxkVT2OafDgpI54oy6i7ofgl/53up10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728757; c=relaxed/simple;
	bh=dNr5npzmjH5TNIPI+SiGCtlCO2PSO7e22Bm+5Tsaivk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bfd+U61mq0S4gi3TZZLbiuz5x39FzCWAQyrdl1TJPivp33Kg+VL592p5nx8X2KvpJu31bZG7ZjYc2OrOdb2qhqVLCm3+WECeIMePAQFTjnN3mR3N6cRNWzcs9bdR2tbaoRac9hkrMVD5MSU7VqHGikB/piFGNElazilpe++9Z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmdrHM+R; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmdrHM+R"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c827313dac0so4813050a12.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779728755; x=1780333555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQxkV4mwVmTVJQL3nPJxg1liRK7ZFd4JwILsN7OzbnU=;
        b=nmdrHM+RtupWIFdW8aon2nnhgB1+fSdmqGzVA+PnRpqd5D5nrbCZmztAkxiOLH03ww
         Z9jEbB/qAyRmuCiAbCYKblBXxKmiUNaC3OCB3suYhHI7wMYlE8cWXxqcHG7iwThFwdTX
         Oc1wNkXMix99fZUv++MMfJ+bwk6OVIEXCuy6hLRrCu1VR1AX378xTvfEUYe5+EijYTGf
         Kie+Bkm5XILZqCOLc2dEF7KND2RHIzafIeskpwkEPwtBHozJDQPp2tx2SHBhZX75QN4o
         1fksuDwSXCENTWz7JKz6RJEqPZFF2qidTfS5MPzVOjU74Wy+LrIynCcsNHi1iWYXGTiJ
         fWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779728755; x=1780333555;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQxkV4mwVmTVJQL3nPJxg1liRK7ZFd4JwILsN7OzbnU=;
        b=sC77D5hByUiGJW60p0UDkZX9XKGtrolX8cbRAvefQ6rpid9Uv00UMpYxBauZurZoRR
         jPMKy3sMuDivMJKTSywt0wvcUNIskgIX9YnhhK/UJb+0x8czacBlV4c7cPXwZheeE0uT
         RskDYqXeK1Bn+7+90ACMDOVKjm00jACr9F/mTarbvZVcc2sgFLVSguiu/ndMbsyZVEvG
         L++I7+EQWAV7ODE7HDb3D4cQWdiutq4NEY47JyIHv4Gf6Gc7zmglLNXqpLfbgy8OqVcf
         AH+h/TIXAv24b0Irw+mqPQkh8mqaYuhmKoN55TB8+BYKMBxKhkKYgBD9Qcgo0tf2V1ti
         C9OA==
X-Forwarded-Encrypted: i=1; AFNElJ/sDpOB51JB6sCKs6nQIE/F2dRXv5/W8IkF0ZdmuQqLZMNkUJBpChmamSmkcNJCYoVUEY3KHbh4S8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/gxnjQyfn5DKkJdOtZG62GuoTralRph6FetUW06c/ZPcauKL
	o9fEhhemcvgQLD12S3XrC8NyRMIapQxFSGGzHG6+zqZTGfCiHSNstblG
X-Gm-Gg: Acq92OEOkIKdN7IJjMdowfR/YkY3Dy2yLx0+NBcAGNtwgsy+OCYjuAKQvAVOsFYsnXZ
	nId+UWf3BSulJxfe655c0pMkU+CyXsfKl9wTzRRJT7fVScJXaV+UWubcjHiZfX7BzHcYfg8dl+k
	+JWxJVbIC7c3qStQgL8GQvQw9haODDG8fplEc3R6Cg7ShD9XHiqgj5u5Dw4brO2qKCDn2bg5kKR
	XPIpgkffv0WRqqHBSLWSW6V/vtUvkmTQvXX4dctKvkyDkDeohGhhzXB5JlJomf03Z3VUkS2dqRK
	CveWZM8I3JH+MMlosU0NIEkFQ+du7RuZ5Qlg0OWQ7nfngnCYrYjPS2uszog17AwgRCkiNO2Mogj
	8VqIlQOeE1XbDcLkqkScJDjixn0qBX0E2n5dYC0Pgph5BnmQ0QsEg75ibku44wLvg1rrjZykSsG
	tafn1qog0hwBy04d+dai56uu94NNrIxMbNZXH6ZvL2r16Vr1ivFuZtsgE0qQ==
X-Received: by 2002:a17:902:f710:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2bea21da1bbmr178325865ad.9.1779728755289;
        Mon, 25 May 2026 10:05:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:2c19:f0b2:176f:f0e0:aaf2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ebcsm102045615ad.49.2026.05.25.10.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:05:54 -0700 (PDT)
Date: Mon, 25 May 2026 22:35:50 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_35/36=5D_iio=3A_pressure=3A_hid-sensor-pre?=
 =?US-ASCII?Q?ss=3A_drop_hid=5Fsensor=5Fremov?=
 =?US-ASCII?Q?e=5Ftrigger=28=29_using_devm_API?=
User-Agent: Thunderbird for Android
In-Reply-To: <0a8ebbd2-5de6-48d2-9218-f7b816eb3455@wanadoo.fr>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com> <20260524192943.1196773-6-sanjayembedded@gmail.com> <0a8ebbd2-5de6-48d2-9218-f7b816eb3455@wanadoo.fr>
Message-ID: <39A229F0-436E-4AAC-82A4-9B04733E9EE3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25 May 2026 3:39:11=E2=80=AFpm IST, Christophe JAILLET <christophe=2Eja=
illet@wanadoo=2Efr> wrote:
>Le 24/05/2026 =C3=A0 21:29, Sanjay Chitroda a =C3=A9crit=C2=A0:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Use devm_hid_sensor_setup_trigger() to automatically release resource
>> during fail, unbind or removal of driver using devres framework=2E
>>=20
>> This simplify the setup, remove goto, avoid manual resource cleanup in
>> teardown path=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>>   drivers/iio/pressure/hid-sensor-press=2Ec | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/iio/pressure/hid-sensor-press=2Ec b/drivers/iio/pr=
essure/hid-sensor-press=2Ec
>> index fee7dcb86801=2E=2E8438498c9aeb 100644
>> --- a/drivers/iio/pressure/hid-sensor-press=2Ec
>> +++ b/drivers/iio/pressure/hid-sensor-press=2Ec
>> @@ -291,8 +291,8 @@ static int hid_press_probe(struct platform_device *=
pdev)
>>     	atomic_set(&press_state->common_attributes=2Edata_ready, 0);
>>   -	ret =3D hid_sensor_setup_trigger(indio_dev, name,
>> -				&press_state->common_attributes);
>> +	ret =3D devm_hid_sensor_setup_trigger(dev, indio_dev, name,
>> +					    &press_state->common_attributes);
>>   	if (ret) {
>>   		dev_err(dev, "trigger setup failed\n");
>>   		return ret;
>> @@ -301,7 +301,7 @@ static int hid_press_probe(struct platform_device *=
pdev)
>>   	ret =3D iio_device_register(indio_dev);
>
>Hi,
>
>Looks like devm_iio_device_register() would now make sense and simplify t=
hings even further=2E
>
>CJ

Hi CJ,

Yes, as mentioned in cover letter most of HID IIO drivers have potential a=
nd will converted to devm based driver gradually=2E

Welcoming all suggestions and especially if someone can validate and have =
Tested-by tag=2E

Thank, Sanjay

>
>>   	if (ret) {
>>   		dev_err(dev, "device register failed\n");
>> -		goto error_remove_trigger;
>> +		return ret;
>>   	}
>>     	press_state->callbacks=2Esend_event =3D press_proc_event;
>> @@ -318,8 +318,6 @@ static int hid_press_probe(struct platform_device *=
pdev)
>>     error_iio_unreg:
>>   	iio_device_unregister(indio_dev);
>> -error_remove_trigger:
>> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>>   	return ret;
>>   }
>>   @@ -328,11 +326,9 @@ static void hid_press_remove(struct platform_dev=
ice *pdev)
>>   {
>>   	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->dev)=
;
>>   	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>> -	struct press_state *press_state =3D iio_priv(indio_dev);
>>     	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>>   	iio_device_unregister(indio_dev);
>> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>>   }
>>     static const struct platform_device_id hid_press_ids[] =3D {
>
