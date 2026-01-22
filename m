Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBF3A2AFF
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120861; cv=none; b=CVW9TbL07vIfvttfvVgl7mOneOkrBzmiDReP8DzAp0qM1lnYmLHqv1VErB7At9tU1zjG2TJQ1MYhXVYpvbx42C2fhzG48IqV52XL5bqTZxx/nOnlbf7TUE80XGRO0rUCUVXCpVN4FKuWXDSiPkF/dTclJ0UDIWcficzrAIWsnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120861; c=relaxed/simple;
	bh=ZssbIbYyhJxGAI1RfQdyrNCll8e8m/BvfBwg2KD5tsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q7ZPvudw4/H9aljAQHu4DIb/DtEeTa60bIlBScTRGlZWsCU8lGn9g3HSpzpP9KkcXyvkeUQaNR/STpuFEuYIv3EwaNOh74FZKK0T2E/OZ/i9ljMKxJSsw+XTRQOQaFy8MnPksa4qDBDAJzTa5EAQu3cCb2iY72OfcfU7Nrfymes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F76yTzCR; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F76yTzCR"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94801cf4bb8so444678241.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120850; x=1769725650; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UklvachexUu0ZUTLfggsuMCR/kjk6daLXKn7WqUk/vU=;
        b=F76yTzCRId1vEjkuxLVoOnQn0O6Lo4UPCKNd3zmsqJTSTpgIFDVzzZALxhojegA0M/
         WSzCqu6uAFa8vPFrKJhKSSty2CYVFQRsvIpLY9qJOCiamMNqH+t9OBFC7JsjsepBeLcM
         mmmkcZILfNdkI5HQ8Udb5zDvn0nfY4xNkZ0id0or4ik0gFofTDVp+O0F7CUiMStLQn96
         eKvMjWoLWYNUzRUrfF5g7wKaFUhbNYhQI5YTI9G505fm30dHG9u9D7T/8qWdwPmXGMIN
         /r5xjC/F/B9NFiJv++2ePOj5OrLetjJlzhRaulUPzxKaokBsDCpiS3V/ch5jx0L71KGC
         vOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120850; x=1769725650;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UklvachexUu0ZUTLfggsuMCR/kjk6daLXKn7WqUk/vU=;
        b=HiRiqXi8DzyqIDyxSdy6W5HF+FNy43UJGuH7P9GjcmT2tEMXoK1NoVT0FIcs0F1nBk
         8IJi1CsDVyHtLCW+Qc5ZFHbH9/tvntHBnNafaxbOdBr2zfQsQnxvrloYHyUqx2RliKT0
         mEIIEuRBBQ7KtC2rw98dJnbhhTHvJxxuACKmowxoTwgRgABwnRauuqkgyOK2HkHRzE25
         dIpd46IjjFmhVlQetTistWrMrrB1GYx7606la5w9VKT1aHDWAQIVkLFfFttD0fFmVjKO
         Onsb0FjQU1W2PFdAcFUUoFWpqsJyThVCt6RYcpFmsMWrzMpoTCz0K+nDhlqfHa1p/y73
         BiAw==
X-Forwarded-Encrypted: i=1; AJvYcCW7SW73T1EpgQM3KVckMH1ZrwSIvRjM1vbZOpVDqcB1yokaq3aGQrTnre4w7JEf+6pY36ZOi18r9uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cc7kPmPqF65EAs9k6tGEjp7T5gKkuhSf1fO8REmbqjyDKJyT
	ISx+t0DKvMS7QgwF1Lw+SCtY3EO1UHNhm1CdU1CR0HrqkJFGG8MekfMJ
X-Gm-Gg: AZuq6aIkE6hJ6d/+ZljnR2xDH9hUAXQFpXcjXgrj2vjnr8hiYcblxFq+1psyPPRFb4O
	vUlQp8rB2LxGg51rwp4t7lkfx/233pRf8VPk5EqaNFW82+Lvqc9lQHTSzZIXbtND8CRqGs3a3/Q
	CHcAh+I6qCYzOxmRWqNq+y0sqKXgsHxALuAWQNctmxXsF8HDrBQ78OkzLk1YynwUR45jVHAaT4R
	d5EdvNyrRS4gbj6cDuyELOZ6jNOutCkwULP78iOgzLHAvZzuKxCzVnuLWFJhrIJBLqNTybCiWBj
	L+VyPyqmBPh1rptQaVTsu9llyn611p4IIrln0f0tNPUG/ViLGS4M9/fpOCHvZ7mHseLfc2V513G
	ds2Qp/ZCuxcRSeGxUo+5U1YabbYOslY6LXP2X6qNzyqz/yy4mhvLgGskv2CUhfiaquLzARAISaE
	EmtJTaTe8=
X-Received: by 2002:a05:6102:508e:b0:5ef:7221:aaa1 with SMTP id ada2fe7eead31-5f54bc6f7bcmr368453137.27.1769120849596;
        Thu, 22 Jan 2026 14:27:29 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:c903:2904:3cc3:8b4c])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9482e37e7acsm100671241.13.2026.01.22.14.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 14:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 17:27:26 -0500
Message-Id: <DFVH012QRDMJ.Y86WT9BEWQ3R@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v5 0/7] iio: core: Introduce cleanup.h support for mode
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
 <20260122191648.2c10cdf6@jic23-huawei>
In-Reply-To: <20260122191648.2c10cdf6@jic23-huawei>

On Thu Jan 22, 2026 at 2:16 PM -05, Jonathan Cameron wrote:
> On Tue, 20 Jan 2026 01:20:40 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Hi,
>>=20
>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>> add cleanup.h support for the lock API:
>>=20
>> 	iio_device_claim_{direct,buffer_mode}().
>>=20
>> Which would allow some nice code simplification in many places. Some
>> examples are given as patches, but the last two are the biggest
>> differences.
>>=20
>> In this version I dropped the RFC tag, as the general feeling is to go
>> through with this after some modifications. Main one is the addition of
>> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
>> the guard classes directly. I also added comments on the forbidden ways
>> to use this API but I definitely still take suggestions on this.
>>=20
>> For now I dropped iio_device_claim_buffer_mode() rename, as this point
>> is still being discussed. My suggestion based on the RFC discussion is
>> to do it, but in a separate patch (using coccinelle) and while we're at
>> it rename the whole API like this:
>>=20
>> 	iio_dev_mode_lock()
>> 	iio_dev_mode_direct_trylock()
>> 	iio_dev_mode_buffer_trylock()
>> 	iio_dev_mode_unlock()
>>=20
>> Let me know what you think and thanks for taking a look!
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> I've queued this up. For now it'll just be pushed out on the testing bran=
ch.
> Hopefully the new noise from sparse won't bother anyone too much.
>
> Jonathan

Thank you for all the feedback!

I'll try to keep an eye on the lists in case of automatic reports.

--=20
Thanks,
 ~ Kurt
