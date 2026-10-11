Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E470363C79
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738768; cv=none; b=DkV1UYRdomqgQNF+emWxH5pxfUDtJeNjk1frcTpNK1vNNZhf3TMLQeu6GwSFMpt7EFyFa/pFD90hQdy144TkQqmdSv+90mcw42E4qsrippm/EdK5PgpkaqsUZirerngfQ9LukuOe+aTPuol+9U/vf+r3Z6R1aKGUrH1ki5YLk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738768; c=relaxed/simple;
	bh=z+1ZpdTDW56EA/XM7p5CM05JDe5+3pamXAxQ9H7t6HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQb7GAesh8WpyZBqmaZX5jrVj1sTJw2rYazIa0XLJEq9vcGVgWqMhoozjmnENpD13YsgKluxEqjftxXmLYRGFR5s7OtkLMywx3y1MQPlwBXBBaX9DjLKEQYq8jk+jNsZiMUJzmlYCPKMeLI4oT67FRxzn5I6LhXCWgNOV1/8CEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBvIBoqp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBvIBoqp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b042c0759so802935f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791738763; x=1792343563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79Z91gLy0Qj3P7l5DuL+kEPlg9n1xATGDeuftWENmqA=;
        b=KBvIBoqpgZk02w21878+tfHeJmiq0VjXiM92RtI3bPmRrKwvVNPJNBigcoHdSRo4nV
         ELH86d6RzhcPKCmixanljp8H94jpIdF1wvnxXDyXjG2Da7HLGgCdGS2MGVI4FxB2RAvP
         GsxzJ38erhXWyYn32iwiB71KI4VCFVur3mELk4ty++MNobi1zUaonhr51ilvpI008Zrm
         ToKmC3+MAt/VUPaqosjo60CBazW2ubwJRmVEriS1pq4Qp0fRdPyckwDsrLOOXeY9pckS
         Ynd+n9cac8iLki84QTHhiK3WkDO5niWcHOgGKfMuRbneWb1m4rBS8dOGN0+PeljZf/jd
         cVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791738763; x=1792343563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79Z91gLy0Qj3P7l5DuL+kEPlg9n1xATGDeuftWENmqA=;
        b=cur12yvjYAgtbeaHFHkjk+xSIlzhuTLOThpf789TXZzOVCyqxnLyI7bHv5ezXMokI7
         ZODjaLhDI+AR1uKqvv2L4U8nNQDsJJ7Y6hbt7XnL5EX8WYP6BOrJKXoRPvbdMI/l7ORN
         Vf6cMOTK3eI07W3N81PTa6bT39L9gs3J0JzCR1eLDS4xQ3J99OTgyLi6K1eNDEoBEr5g
         w33MfmwRDXbUeO40V/5kJzlw18qPdFyQI7uNWoX4Jx9xuNNMYnY0yeKgzEGZYZqifEl9
         yOQQIp7ewGlQkJdAJsAkPon40GklP7z5Rj6TzC24GqYeuNbHa1gv+0h83LyScUHTu2iN
         aAEg==
X-Gm-Message-State: AFq9FYKiDm4gbjEjUMIPj/2QVyRtZ8yMZGFO1xDbiteklIPphY/V6num
	D5qnM4q+S7gILZVEUjq6SfSwRGVgN8+tTZpYr5kTpusiQIPUV+rFznKL
X-Gm-Gg: AYBFou0zxfcOLMNFGv8C7jguFvAf4DdF9T3l24UOsRrsA90YqRue/O3ihccFp6+WM0e
	n3PqkOCQWQkLIyx4+2lUpWrU3zH77B2MtCAAR+VY/Z4STgv30kfpXIJkezuu/Va+2HQI5rdGn8B
	E1Wn6lSAsx8K3V9uixWy0zo+qElLDa1p24VWv+LPPTI9ivgYeNW53IiZ4YJ9dsJs+yu4jK6+h/F
	L7LORpC2jO4hLI8r3Tia7JB6eBl2Q2RMrknHZhpJXaS/rut+dDbx8u/wRxTkgTlzk30kTp5wQAT
	PVfW8ZysWObfWn7HOJT7M2oajrvtmRZ13F+99OWZ0S2EMJHHlNfoc/AQ3Em3bs8dVfAbqgdwr5b
	B4wusnnccl0KaBOoEA9wY48pUWt6/42sK/hCCQ/N3rwnaXloPfX+gkEGh8bdxnVO4ZAP/FRuonG
	8W6zxH5znC4dnea1sBhL1YIzUEoBGTAqZGELpSbuI4SIdids2oIk4KTj+SdhnD3neeYMhFciix9
	1zSpq9JF9CqCD5k1Bk8mOTawNB87HXg7bIYBmp6n0RmFHlOQRGGfGJAfNCsh6nTs6vPi+lc6atO
	BuHtGQ4ykFFVdVIselxFfXfvukfCZ4hDU70TMW6LXTinfHMSHAaLdaDZwRiN8omBZ5XWNSJyscJ
	NF1m83n5DPJTwLjK/RF0lNrqrnP9QIy8=
X-Received: by 2002:a05:6000:184e:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48dbaceba34mr11528014f8f.37.1791738763113;
        Sun, 11 Oct 2026 10:12:43 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db97ce3aasm15337433f8f.21.2026.10.11.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:12:42 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:12:40 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261011191240.5a2ba4f7@systembl0wer>
In-Reply-To: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
References: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 17:53:01 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>  drivers/iio/gyro/mpu3050-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Sashiko review came back and the issue doesn't seem so
straight-forward. I'll probably introduce a local pointer
and then assign it to the mpu3050 data struct.

Attaching Sashiko review below.

> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 07c0f9011c63..096fd0dc608e 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1260,6 +1260,8 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);


Does this unconditionally unregister a trigger that may not have been
successfully registered?

If mpu3050_trigger_probe() fails (for example, if request_threaded_irq()
fails), mpu3050->trig is allocated via devm_iio_trigger_alloc() but it will
never have successfully completed iio_trigger_register().

mpu3050_common_probe() catches that error, logs "failed to register trigger",
and continues. If a subsequent step like iio_device_register() fails, this
code will call iio_trigger_unregister() on the uninitialized trigger.

Because the trigger was never registered via iio_trigger_register(),
iio_trigger_unregister() will call device_del() on a device that was never
added, and ida_free() on an unallocated ID, which can lead to a crash.

>  	if (irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
>  	iio_triggered_buffer_cleanup(indio_dev);
> @@ -1278,6 +1280,8 @@ void mpu3050_common_remove(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);

Can this cause a kernel crash during normal driver teardown if the trigger
probe originally failed?

Similar to the probe error path above, if mpu3050_trigger_probe() failed
during initialization, mpu3050->trig is left allocated but unregistered.

Calling iio_trigger_unregister() here on that uninitialized trigger will
cause the same teardown issues during driver removal.

-- 
Kind regards,
Joshua Crofts
