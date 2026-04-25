Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD41175A7D
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777115111; cv=none; b=b7Gv3JKOdm1jlB2cf/EfYGxqsqAKJ6teV2XOkbkJVW0HmOkClfzW1RROKFOORhqOU5wR2axyyge2q3nQeFCLlc9+MxZYJxOKgpXZB+lPFqA1MIyULpbXOkyJrjAEjBVkNt67Hv0kyR79n9MnbEQ2B+lfNjqBIUzPucBMhsna9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777115111; c=relaxed/simple;
	bh=bNp67NYBB3RnPAWeYvdLOQDWL2qwF6HM4omSBGIjmoA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l2+GiwGSxwEOXFQ6pq+i3l43/ixwWT66K06pvKnnJpHUqqmuLvxSRD51+tYd7SbEVjFeVCJfXrCfZGtQ3as2SXY/MDReced9CWMQBUZMfL+9oPdZyUugevnCvvsHozNeiENqaSdpJ7zycfL4G4xc2TSAv/0Y3845l7UTCZd3BuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgNSoUFX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgNSoUFX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adbfab4501so42495535ad.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777115109; x=1777719909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GG5ggmwA080pLAGNQ4HPn0pDmF6foX0wyJctIPCnbZc=;
        b=MgNSoUFXERqh84aj2fERod9nkstKZiwA+bhLIhifnQqWy0ngQnlQZFXTjOsoTtTnbU
         xL3SskcrgTzQnM1/a/gWuS7SchznYUJyVPBW2RK+jJ7cnmxNSTeYcFddtbfjJONMpl7J
         rtS1HLgsE24/XKbcYtCX8PCTXjdmb7eTQEfstXlkwqL/shM+aYIrbNC6SQo44y9MNSl9
         KoVT2CzsqXuFti6At0Jys8M75YwVRY9kAX8GSwhjDZNoNoR0p3NBG4Hrf8fPddQ1Nay4
         1+Mmx8+BlKmXNdae7n7D62EFiELJwrWBP9r7zvIrq2wm+Kdx35LPGpjHS5Q3fIDJlvNY
         ue6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777115109; x=1777719909;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG5ggmwA080pLAGNQ4HPn0pDmF6foX0wyJctIPCnbZc=;
        b=rP//HACtbOtzPAymmF/wegz6hPPKcCQfIpiRxF/138trYZRmPe5uaYmFAynyjrC0Nu
         dRKWJsnuebjWwNLSxDKA232hgCiFZ8VukmyGFA03Hv4Vo7OkEhOuGlvYIBI6XSsSEYsN
         faCvAAsbJ/QH5X7qe/XoThHtuwd1+eqj4vReQ6DJdANxNm9dB2WI/R+cyq/HF+oid05n
         hW0YMKckYL+PKxvZOvz4GJmgucflcjBuRwUH7bpb2DZGYfQupvYOCjERD73KU1z6W/CW
         bMT6VT+0NgzpoTW8jM8kPBqm3kYHY5ofwTW6/ug5v1zzBwzEj9JXGElDZJD5G8M2vEiI
         xnmg==
X-Forwarded-Encrypted: i=1; AFNElJ+7oRKR3Wja1p3Ate1tf1H2OkPxLMZd3T1IPO8NhiCYcYNXt1xcXUFZC9WVnCVTiBp2qI2A9+QjrAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/DHQ4Oj8YtHhyFXlIbcU7lUiyI+8eLnw+4qm2bSSP8tsYmQp
	aCIRQHko/2gCoK0zVhyNAtk0xnOvZXCEjc5rQtIFMl+aedHyXkjCeUPv
X-Gm-Gg: AeBDieuiJrCLVUxp1Zh7OdV3lXCfQpATwnt2L4Nj7iAM3TLM9HApAHYk1wmr5r0M593
	h/JOnyeUCcKAD7OUuBimxF9+57AXwieSfl89dKsps8nmrfHC0h8Mrcw1JCnj0NW8xEAYKGSTpZC
	SGjNRIOrMUMD/ZRU82Lnw+mENHk19rRZUkIaFAXgjYpS3uDt2pkiZzVaHVkSN4K6ZHspwnewL0H
	5eiyjFPUb2dLWMAbEOKtRVtujs6+9o3rELGyWXsksVmWqWVOw6G5K1mh/GjlSqNtjI5BOGlz8BI
	4osCMOBEQOB9R16UCCZcH3uOXWaiRHj3QnZdRUp/Ivo7q0Ln32zBQF9zlmESKYKWUs0SwsPP6GK
	UOMEuCPlSx7U/CTwvZONqvNszk5XyoYGKmZdKWvOWq4NzeJaw31ofVC25bZeXTApfNyPAH0eNPY
	VicAOxOPDoC0wjCTIuy9EmlumYmQCluxIzQuJBEIV583kyH/xfUBfG3g65
X-Received: by 2002:a17:903:884:b0:2b2:6cab:313c with SMTP id d9443c01a7336-2b5f9f8328amr230289665ad.20.1777115109025;
        Sat, 25 Apr 2026 04:05:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c01c:e856:a265:6d1:ea2a:2f9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2112csm241506725ad.62.2026.04.25.04.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 04:05:08 -0700 (PDT)
Date: Sat, 25 Apr 2026 16:35:03 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, tglx@kernel.org,
 christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/7=5D_iio=3A_ssp=5Fsensors=3A_convert?=
 =?US-ASCII?Q?_probe_and_teardown_to_devm-managed_resources?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260419183918.23a22e12@jic23-huawei>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-6-sanjayembedded@gmail.com> <20260419183918.23a22e12@jic23-huawei>
Message-ID: <300E6831-80EF-46D6-A6A3-33FC9ADC77E5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19 April 2026 11:09:18=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Wed, 15 Apr 2026 10:37:47 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Convert SSP driver resource management to use devm-managed helpers
>> and devm actions, tying the lifetime of all resources to the device=2E
>>=20
>> Mutex initialization, IRQ registration, work items, timers, and MFD
>> resource are now managed using devm APIs=2E Cleanup logic previously
>> handled explicitly in probe error paths and the remove callback is
>> replaced with devm_add_action_or_reset(), ensuring correct teardown
>> ordering and consistent behaviour on probe failure and device unbind=2E
>>=20
>> This simplifies the probe path by removing goto-based error handling,
>> eliminates the remove callback entirely=2E
>>=20
>> No functional change intended=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>Hi Sanjay=2E
>
>Devm conversions often get complex and end up raising questions
>that weren't as obvious when doing an explicit remove() callback=2E
>
>One of those inline=2E
>
>Thanks
>
>Jonathan
>

Hi Jonathan,

Thanks for the review=2E
>> ---
>> Changes in v6:
>> - Drop remove path completely using devm_action with review comment fro=
m David
>> - Convert MFD device to manage resource along with mutex and IRQ
>> - Link to v5: https://lore=2Ekernel=2Eorg/all/20260406080852=2E2727453-=
1-sanjayembedded@gmail=2Ecom/
>> ---
>>=20
>>  drivers/iio/common/ssp_sensors/ssp_dev=2Ec | 88 ++++++++++------------=
--
>>  1 file changed, 38 insertions(+), 50 deletions(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_dev=2Ec
>> index cb4c26a6b76c=2E=2E94ecc794f926 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> @@ -194,6 +194,16 @@ static void ssp_disable_wdt_timer(struct ssp_data =
*data)
>>  	cancel_work_sync(&data->work_wdt);
>>  }
>> =20
>> +static void ssp_shutdown_action(struct ssp_data *data)
>> +{
>> +	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
>> +		dev_err(&data->spi->dev,
>> +			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
>> +
>> +	ssp_enable_mcu(data, false);
>> +	ssp_clean_pending_list(data);
>Where this is called below, it's not obvious to me what particular
>actions it is undoing=2E  So I think you need comments on that somewhere=
=2E
>
>General alarm bell was that it was undoing multiple things=2E
>
>> +}
>> +
>>  /**
>>   * ssp_get_sensor_delay() - gets sensor data acquisition period
>>   * @data:	sensorhub structure
>> @@ -491,9 +501,9 @@ static int ssp_probe(struct spi_device *spi)
>>  		return -ENODEV;
>>  	}
>> =20
>> -	ret =3D mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
>> -			      sensorhub_sensor_devs,
>> -			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
>> +	ret =3D devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
>> +				   sensorhub_sensor_devs,
>> +				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
>>  	if (ret < 0) {
>>  		dev_err(&spi->dev, "mfd add devices fail\n");
>>  		return ret;
>> @@ -503,14 +513,16 @@ static int ssp_probe(struct spi_device *spi)
>>  	ret =3D spi_setup(spi);
>>  	if (ret < 0) {
>>  		dev_err(&spi->dev, "Failed to setup spi\n");
>> -		goto err_setup_spi;
>> +		return ret;
>>  	}
>> =20
>>  	data->fw_dl_state =3D SSP_FW_DL_STATE_NONE;
>>  	data->spi =3D spi;
>>  	spi_set_drvdata(spi, data);
>> =20
>> -	mutex_init(&data->comm_lock);
>> +	ret =3D devm_mutex_init(&spi->dev, &data->comm_lock);
>> +	if (ret < 0)
>> +		return ret;
>> =20
>>  	for (i =3D 0; i < SSP_SENSOR_MAX; ++i) {
>>  		data->delay_buf[i] =3D SSP_DEFAULT_POLLING_DELAY;
>> @@ -523,7 +535,9 @@ static int ssp_probe(struct spi_device *spi)
>> =20
>>  	data->time_syncing =3D true;
>> =20
>> -	mutex_init(&data->pending_lock);
>> +	ret =3D devm_mutex_init(&spi->dev, &data->pending_lock);
>> +	if (ret < 0)
>> +		return ret;
>>  	INIT_LIST_HEAD(&data->pending_list);
>> =20
>>  	atomic_set(&data->enable_refcount, 0);
>> @@ -533,14 +547,17 @@ static int ssp_probe(struct spi_device *spi)
>> =20
>>  	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
>> =20
>> -	ret =3D request_threaded_irq(data->spi->irq, NULL,
>> -				   ssp_irq_thread_fn,
>> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> -				   "SSP_Int", data);
>> -	if (ret < 0) {
>> -		dev_err(&spi->dev, "Irq request fail\n");
>> -		goto err_setup_irq;
>> -	}
>> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> +				       ssp_disable_wdt_timer, data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
>> +					ssp_irq_thread_fn,
>> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +					"SSP_Int", data);
>> +	if (ret < 0)
>> +		return ret;
>> =20
>>  	/* Let's start with enabled one so irq balance could be ok */
>>  	data->shut_down =3D false;
>> @@ -548,53 +565,24 @@ static int ssp_probe(struct spi_device *spi)
>>  	/* just to avoid unbalanced irq set wake up */
>>  	enable_irq_wake(data->spi->irq);
>> =20
>> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> +				       ssp_shutdown_action, data);
>
>See above=2E At minimum this needs some explanatory comments on why
>the stuff in there needs to be called from this point onwards=2E
>Before this patch it wasn't called if there was an error in the next
>few lines=2E
>
The intent of the devm action is to define the point at which SSP MCU can =
become active and start IRQ, watchdog, pending command completion=2E

As of now, this is handle explicit at remove path, but probe failures afte=
r MCU enable may leave the device partially active=2E

I will add comments explaining this part in next series=2E
>
>> +	if (ret)
>> +		return ret;
>> +
>>  	data->fw_dl_state =3D ssp_check_fwbl(data);
>>  	if (data->fw_dl_state =3D=3D SSP_FW_DL_STATE_NONE) {
>>  		ret =3D ssp_initialize_mcu(data);
>>  		if (ret < 0) {
>>  			dev_err(&spi->dev, "Initialize_mcu failed\n");
>> -			goto err_read_reg;
>> +			return ret;
>>  		}
>>  	} else {
>>  		dev_err(&spi->dev, "Firmware version not supported\n");
>> -		ret =3D -EPERM;
>> -		goto err_read_reg;
>> +		return -EPERM;
>>  	}
>> =20
>>  	return 0;
>> -
>> -err_read_reg:
>> -	free_irq(data->spi->irq, data);
>> -err_setup_irq:
>> -	mutex_destroy(&data->pending_lock);
>> -	mutex_destroy(&data->comm_lock);
>> -err_setup_spi:
>> -	mfd_remove_devices(&spi->dev);
>> -
>> -	dev_err(&spi->dev, "Probe failed!\n");
>> -
>> -	return ret;
>> -}
>> -
>> -static void ssp_remove(struct spi_device *spi)
>> -{
>> -	struct ssp_data *data =3D spi_get_drvdata(spi);
>> -
>> -	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
>> -		dev_err(&data->spi->dev,
>> -			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
>> -
>> -	ssp_enable_mcu(data, false);
>> -	ssp_clean_pending_list(data);
>> -
>> -	free_irq(data->spi->irq, data);
>> -
>> -	ssp_disable_wdt_timer(data);
>> -
>> -	mutex_destroy(&data->comm_lock);
>> -	mutex_destroy(&data->pending_lock);
>> -
>> -	mfd_remove_devices(&spi->dev);
>>  }
>> =20
>>  static int ssp_suspend(struct device *dev)
>
