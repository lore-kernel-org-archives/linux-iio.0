Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388041E633C
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907695; cv=none; b=jUI7E03gzQuyv5L6PZklLA6NqTUDZrzW9C0utCtnXSI9Bs5u1ZkbQfsYUgRkFJ0hMf0NyzynT2AAZZ7kRNaS2YoWZdsLW66JpeONxH9DKbfWBzE75f27HXNIRtwMQB0GYbfi2VKIsMWf0BVbRVZz7gVaG+3926dQUwW1jWH434Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907695; c=relaxed/simple;
	bh=W1nOInobauqhWR55LUyEwXQV2pJv56J3u5fSBwMoa7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LOAJtPTneUuIrNkejiUM6d4O08uiY0SMrcOcfQP6024IB30N6tjQvhGeJQMnnG+VI2Cwsj3QCB4aE2Lsk1hjqvVIsafITJULvCRN2/F84MZWgxfhH323IyrrSig1VUq8nzdYRzRvGxhkTcYuoDy+BYruPfT2DMgT7Y3B4EQ+1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnBTamRl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnBTamRl"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so2596325a91.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775907693; x=1776512493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qj/YA69tK8OayNqIO/aiIJnQgpjfgWaqvEfEq2cuNao=;
        b=dnBTamRl3xyaFkizCovn/JUcFxB6QIu5y11vc2NR+9sa4GAYzQMqAFROSDyiyi7Kke
         x5yIDmSQc5CK2ptbKJS9bUpHadtdxaqv/FacJoUMgRHwI/32JKIRiQYA2E6CAmerLFIt
         hbciccw+d1rgvdW+udCvPuZFqjAn1pr8X3nga5opHLadcfupO1OT9IIHcmTUUXPT9nmc
         w7NLVA5uTtLKR0+MRihTF3f/LOvQdKkjhP7Kyeda+AQaWPhkWC8BQOaY8pLXiVHyXuXS
         t0mMrJVxNSJl5wXMXb4R8YVEk/sGMIM8s9fnD8G7jVabjC0r792y27GfSd0PDCC6PrT8
         KQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907693; x=1776512493;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj/YA69tK8OayNqIO/aiIJnQgpjfgWaqvEfEq2cuNao=;
        b=nK/rwWheAf40Tbjnn41bjyB4KyS2J6nJ6lAUaCmUf/nSiRbGAYeVHtLvVIZ81K5Tvr
         mo2D0usScjBbIL0P6VR9jtCuo0vpTPgdU1T43gEVB1QAHtQk/jq7LNfN9sVUdB+fxYKN
         ww1RhdOUbOZCRkyPGxs20wNG0m1T4ELBCGxCdymeBs3Bb5Ck439nIux0maLwWyK9mNYy
         1Ko6L5ZbTWGOeb2DwvnuRKLLpTYv0v+6EJcdhA6KOEHqywNPUXXzlUv/T87nEIH4R+iT
         fGJfoZ/gN/8dLExbjtAfyrdTXQLRpm2ZiPtib9thHVIcxKNxqNzqHRhqISp6QeN7ajtM
         oDNw==
X-Forwarded-Encrypted: i=1; AJvYcCX5YZBeh7bl7VVbKIgFO7zsfqXJb8OoeL0NTJSKqWf8qFu9+1wfPjeocB4DRDQZzAY+HtL06F2MnzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxVR5L5SQelrsJbBw5k/zkwzhsrrQ/Pi9BmEPBwTmz+RZf/vf
	+TyZ7LqfOsFLCsW/oxV3MH0SBrkQdV8/9Et16IoQQFak42/EixT5JOuL
X-Gm-Gg: AeBDievleo+PfcY2ywA2XHD1M+fMvQi6LwcFH8QAUvexal/fgxPbEhfuBiJyTh/7NxG
	pYgmLgl33fbnfSAMdo8THf+KtgJf40y9+DJJPuGOqAbjbe3qRtTqu+Xxhnto49jS/ViBnTOqIdO
	KYbB3/kv2f07VXAmUqmgHaEgipGHubeOjnUS8fyCagzXsT7N6A8yQNQg9CSyAs3dUWIyQKNiSkj
	LO5odKd3NGqdORE+2Ah4ITlcQkMzy/DJdcRv0lLUpmYKLQawsggXodvwi8RpWVcW12IzGeATvCK
	91AgDbF0KhGWiKN3Kuvp81TomdB3ygdrJZ2wvKcEJmCgxEsoVKVg//SYuk5xfn3ckPqACHvNv2g
	QCxD+djErx9UUHfF56oqcr2GvsgksUL7bI6zqKD1QlMFK61UeKVOianX5xvOeyY58NdnvXfNR+w
	Rssn0/aZ2oCScGqHvCVi9b/nsGTzOqVsHBAh21mx4=
X-Received: by 2002:a17:90b:5285:b0:35d:95eb:879a with SMTP id 98e67ed59e1d1-35e4282be05mr7062476a91.13.1775907693519;
        Sat, 11 Apr 2026 04:41:33 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1955:aff9:1:0:8c78:2328])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4133743bsm6347786a91.15.2026.04.11.04.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 04:41:33 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:05:47 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
CC: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_4/5=5D_iio=3A_ssp=5Fsensors=3A_us?=
 =?US-ASCII?Q?e_devm_APIs_for_mutex_and_IRQ_resources?=
User-Agent: Thunderbird for Android
In-Reply-To: <e7ac60dc-fcf6-4ed8-847a-dc29ecfca142@baylibre.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-5-sanjayembedded@gmail.com> <e7ac60dc-fcf6-4ed8-847a-dc29ecfca142@baylibre.com>
Message-ID: <438F2B61-7F4D-4488-82D0-E1EE23FBF766@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 April 2026 9:44:33=E2=80=AFpm IST, David Lechner <dlechner@baylibre=
=2Ecom> wrote:
>On 4/6/26 3:08 AM, Sanjay Chitroda wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Convert mutex initialization and IRQ registration to use devm-managed
>> helpers, tying their lifetime to the device=2E
>>=20
>> This removes the need for explicit cleanup in the error and remove
>> paths, as the resources are automatically released on probe failure
>> or device unbind=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev=2Ec | 36 +++++++++++-----------=
--
>>  1 file changed, 17 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_dev=2Ec
>> index da09c9f3ceb6=2E=2Ef4fc869fc770 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> @@ -510,7 +510,11 @@ static int ssp_probe(struct spi_device *spi)
>>  	data->spi =3D spi;
>>  	spi_set_drvdata(spi, data);
>> =20
>> -	mutex_init(&data->comm_lock);
>> +	ret =3D devm_mutex_init(&spi->dev, &data->comm_lock);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "Failed to init comm_lock mutex\n");
>> +		goto err_setup_spi;
>> +	}
>> =20
>>  	for (i =3D 0; i < SSP_SENSOR_MAX; ++i) {
>>  		data->delay_buf[i] =3D SSP_DEFAULT_POLLING_DELAY;
>> @@ -523,7 +527,11 @@ static int ssp_probe(struct spi_device *spi)
>> =20
>>  	data->time_syncing =3D true;
>> =20
>> -	mutex_init(&data->pending_lock);
>> +	ret =3D devm_mutex_init(&spi->dev, &data->pending_lock);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "Failed to init pending_lock mutex\n");
>> +		goto err_setup_spi;
>> +	}
>>  	INIT_LIST_HEAD(&data->pending_list);
>> =20
>>  	atomic_set(&data->enable_refcount, 0);
>> @@ -533,13 +541,13 @@ static int ssp_probe(struct spi_device *spi)
>> =20
>>  	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
>> =20
>> -	ret =3D request_threaded_irq(data->spi->irq, NULL,
>> -				   ssp_irq_thread_fn,
>> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> -				   "SSP_Int", data);
>> +	ret =3D devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
>> +					ssp_irq_thread_fn,
>> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +					"SSP_Int", data);
>>  	if (ret < 0) {
>>  		dev_err(&spi->dev, "Irq request fail\n");
>> -		goto err_setup_irq;
>> +		goto err_setup_spi;
>>  	}
>> =20
>>  	/* Let's start with enabled one so irq balance could be ok */
>> @@ -553,21 +561,16 @@ static int ssp_probe(struct spi_device *spi)
>>  		ret =3D ssp_initialize_mcu(data);
>>  		if (ret < 0) {
>>  			dev_err(&spi->dev, "Initialize_mcu failed\n");
>> -			goto err_read_reg;
>> +			goto err_setup_spi;
>>  		}
>>  	} else {
>>  		dev_err(&spi->dev, "Firmware version not supported\n");
>>  		ret =3D -EPERM;
>> -		goto err_read_reg;
>> +		goto err_setup_spi;
>>  	}
>> =20
>>  	return 0;
>> =20
>> -err_read_reg:
>> -	free_irq(data->spi->irq, data);
>> -err_setup_irq:
>> -	mutex_destroy(&data->pending_lock);
>> -	mutex_destroy(&data->comm_lock);
>>  err_setup_spi:
>>  	mfd_remove_devices(&spi->dev);
>> =20
>> @@ -589,14 +592,9 @@ static void ssp_remove(struct spi_device *spi)
>> =20
>>  	ssp_clean_pending_list(data);
>> =20
>> -	free_irq(data->spi->irq, data);
>
>Do we need to replace this with an irq_disable() so make sure
>no more timers/work is scheduled after we delete them below?
>
>If it is safe the way it is, add an explanation to the commit
>message=2E
>
>Alternative would be to use devm_add_action_or_reset() to
>handle all of the other cleanup functions in the correct order
>still and get rid of the remove function entirely=2E

Hi David,

Thank you for the input and feedback=2E

Understood, will check and accordingly plan to update commit message or ha=
ve devm_add_action_or_reset()=2E

In my opinion usage of devm API to drop remove() would be better one=2E

>
>> -
>>  	timer_delete_sync(&data->wdt_timer);
>>  	cancel_work_sync(&data->work_wdt);
>> =20
>> -	mutex_destroy(&data->comm_lock);
>> -	mutex_destroy(&data->pending_lock);
>> -
>>  	mfd_remove_devices(&spi->dev);
>>  }
>> =20

Also, I observed that in remove() path, there is duplicate of following wi=
th ssp_disable_wdt_timer():

static void ssp_remove(struct spi_device *spi)
{
        =2E=2E=2E
        ssp_disable_wdt_timer(data);

        =2E=2E=2E=2E

        timer_delete_sync(&data->wdt_timer);
        cancel_work_sync(&data->work_wdt);

        =2E=2E=2E
}

static void ssp_disable_wdt_timer(data)(struct spi_device *spi)
{
        timer_delete_sync(&data->wdt_timer);
        cancel_work_sync(&data->work_wdt);
}

At first glance looks redundant, do we require both ?
>
