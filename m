Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B29330675
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907690; cv=none; b=JO1uKhJcMxxtKRPSAjoMP/fifoIT2lqKqtoFdVH6K0fA7jx4gjZE632ROCXjMByq/SKduW3GsB4KZZEaSQP326k/rWVrrFFxCXvS6Qd7193qi9DAWMWsnoxuwR+mAWg/3RjFFchASTehKT9jhnSFm36sA0/rjtq9sPdjhixaesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907690; c=relaxed/simple;
	bh=IPzksGCaeU8esTm/mi3KW34X7blXPfSuUJ2zW8oL9sM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jX+eynjNE3Yzz+yVXi30gzz6fcKUe1NdQcxIlwqDBS4/p/CoviFX0i2aPZSk3o3zhyHBwRI693z6sH3gaPWZLdIp+mCbXd+oPN34f4Vb3LXvA75cOXuw95nuNWNEa8fAOk7oBHWKuOvWOjMaz+60+I0A3PMZLd7ujYYd/+wu+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGtEW5Ot; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGtEW5Ot"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2639200a91.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775907689; x=1776512489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ymxe3oBr0g81Y9358jhnJsOB6rs9CQpqhpch175KhCo=;
        b=EGtEW5OtCIBOoGSTFL2SDzJbN3vZykrlTmKBwBtE4wpv4vTto195EPhbyN5fGBGnoQ
         gTJPhewPf62V9HRrZBxo05mstgPzFCEkRua0cB9ZyDZ3KuhW/nklgimZ3z0lnOBtbNJG
         ckwBTSVMwQXTi1aKnS0AnYZcmYWgQb/m3qL/Xj/lEE6wlwLNK6xNGVRxKkSnvq2spC4a
         i5aDnQGxOlsi6JkRemY14piTnhFZyTziEVFs9wWfmBVzftjVUMPgcgGgTDW1aEsJbmt1
         0yRpiH/cAYb1PSHjbs2/UYAQs5eaRLS89JyrlTrqmh5O1suFqgObJGozAZK8NejG/3S7
         OJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907689; x=1776512489;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymxe3oBr0g81Y9358jhnJsOB6rs9CQpqhpch175KhCo=;
        b=MNj7pN1HB/VpHT1u0kO4iMKbJ2LYGmTccYvLylKOLPp5h1u0NyU1kel6euWOfF9SwD
         rEF5U89ErIFzdYFIYe/9EcngNuKAIrcdEznOPRx3l7PMiaKiub/a9SXnYvGgGxej7vlN
         Oer5QcVZziTDD4SJWuztOhLzm2G3+TybulzVYRYAOPxWzEGfTE+cz400R75I0QbHQrTe
         A3vHmySfw8KTszjcBcHLctbOTqoym7sn0peN5XWaIwYEl2B8INL3bDRQQLwm6zRiz25O
         tte9ss9sg5XTVZtyNTtA2olA0+2uWJ/mk4tA3BQVgIBDKKkUUpj/7n0jxIt6iwShaAep
         Olvg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3XYB3Z/z9bxrPcIoae8sO9iWYqBCKdwzXnVkgj15pT+0+SSL5fbGvNOv4wWpJMcf68cRjlkmTc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6M+Ab/VKWQoAl53M6cKLgIsLZA2MKPgcgfRqZZdw1to0BTFhc
	LNz4T0fBw9JAfi6H7bvIcGoj0Rjl5JJlxOnRxYJDMzZyLaCBZJm7tf6n
X-Gm-Gg: AeBDiet25cjZIXKCmBxr6rMMhC0p5c/m+fNoOKioljcOWViJkdqLplh8trncIKV+7zT
	E/EPNa9Pvcnx/5dPrVCkUvGvpHp5xlsXYR5tj8JDM+prJIAs5oam5f3XRBInp/dPvJiOtTcBjGN
	h9TDQrQlc0GPmjsHMjC4NuqJUOpJZjYdKZcWcDX7/IxYmL3YK93gddCfhNatAYbtVGw6p0v+LYG
	geRy7/R78uimHCpslnsovYCj8IoEi5dIYzhlUjDW0J6nImJdTu1x+oMxEC8Kf4DHoVNC2iFMHPH
	Rzuq+Ka4jheGZF1KXzi6LvbtHDVdtYZnQiFooAvMHTx+kidZOKhZRdtdqgVsFVsj2Z0UzQODayP
	9ewLYjy4DRI/rLW34AZf7j5ga4ce8dRyJflEnlwJz4/FWldVkXaUXscJo25649ThSZNwmuDLrIM
	Ii22iqn/WMDA1AYQa9eb1busIzxbk6L7/RKiVHRCQ=
X-Received: by 2002:a17:90b:4b0e:b0:35d:9b54:c6ff with SMTP id 98e67ed59e1d1-35e4282922fmr7013437a91.15.1775907688821;
        Sat, 11 Apr 2026 04:41:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1955:aff9:1:0:8c78:2328])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa87sm4532424a12.5.2026.04.11.04.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 04:41:28 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:11:23 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_4/5=5D_iio=3A_ssp=5Fsensors=3A_us?=
 =?US-ASCII?Q?e_devm_APIs_for_mutex_and_IRQ_resources?=
User-Agent: Thunderbird for Android
In-Reply-To: <adT70UcWq5EuMwx2@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-5-sanjayembedded@gmail.com> <adT70UcWq5EuMwx2@ashevche-desk.local>
Message-ID: <C57D1C61-6772-43D0-B4E8-D56D4A7525EF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 7 April 2026 6:12:57=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevchen=
ko@intel=2Ecom> wrote:
>On Mon, Apr 06, 2026 at 01:38:51PM +0530, Sanjay Chitroda wrote:
>
>> Convert mutex initialization and IRQ registration to use devm-managed
>> helpers, tying their lifetime to the device=2E
>>=20
>> This removes the need for explicit cleanup in the error and remove
>> paths, as the resources are automatically released on probe failure
>> or device unbind=2E
>
>=2E=2E=2E
>
>> -	mutex_init(&data->comm_lock);
>> +	ret =3D devm_mutex_init(&spi->dev, &data->comm_lock);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "Failed to init comm_lock mutex\n");
>
>The message is not needed here=2E
>
>> +		goto err_setup_spi;
>
>This is half-baked solution=2E When devm is in use there is shouldn't be =
goto=2E
>after it=2E
>
>> +	}
>
Hi Andy,

Thank you for your input=2E

I will replace pending goto and drop newly added redundant error message a=
nd send next series with change=2E

>=2E=2E=2E
>
>> -	ret =3D request_threaded_irq(data->spi->irq, NULL,
>> -				   ssp_irq_thread_fn,
>> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> -				   "SSP_Int", data);
>> +	ret =3D devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
>> +					ssp_irq_thread_fn,
>> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +					"SSP_Int", data);
>>  	if (ret < 0) {
>
>>  		dev_err(&spi->dev, "Irq request fail\n");
>
>Now you should also remove this dup message=2E devm APIs in IRQ core prin=
t
>a message for you=2E
>
>> -		goto err_setup_irq;
>> +		goto err_setup_spi;
>>  	}
>
