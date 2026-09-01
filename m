Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FA4A2616
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293998; cv=none; b=CNPfLkE49ogFSRdgTjzfN7gP7DILObOIBrpNCArR4QeBGa/bmyRNj3k2e00MZY0/XvYmqn81rXE5ZiSn6syxhzU4Adzk3lYeiGaa7mshhMc10qWmgzst4/aq6qNFGx1EXpu7aAJFaD8529SswBIcUsAnEI78ju0zvCyQr0Qo26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293998; c=relaxed/simple;
	bh=2vrFX13Q2xq55tR6vY0ajYJCi8sf6gwHFJWZQ6UfzJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QullNherKSEhciN2FeZmVPsdNQJOeh1GZ2+fTbOdnqjojC00VMnLzY2eOR5Ohkey8/C+/BzUGTTjHls6trXlKQPuXkQ12i6S61LCQXD02r/tCJH1FCId5iFzBZ1g8SkqC+okGUxnDpKXLx8hZSV7XreJ/lqcVr38bWskMN2dLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7mDJHT/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7mDJHT/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f633e6058so317099f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788293994; x=1788898794; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8CVgkVR/XaIisVA7GQ1DF+bXEJ2xiWA/zkss4Eq01g=;
        b=H7mDJHT/KVo1jUK92WOINddIcKwLmvJr1y+45djUSrnwqroiDoMcro6RC9jBRJN0Up
         wOZ1FMNN4UNt5KMNAWLDLx1CtvUPRHGwTdKppjrWOKtGo9W+IrhkefpWR0wTKL6oC0JB
         MVT9atCmpGqWRv+J4XNTzN+6aUIjXC9TRwrB8sa62APtxG2e4TvyqDDZCd9G/hA7to+C
         m7l6rHxfz5UF6zqcuzUcco8E0PPfa0ud4r4RSYADD9KYt2q8UcFVG2uUw1a/lDGrMBlz
         I5ulqXaH1Gz9qXQWmkq/xNWSiP2KhuMWhLul2Uni6611VsAhgh6vwy7TUOVwYky9GmHV
         kfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788293994; x=1788898794;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c8CVgkVR/XaIisVA7GQ1DF+bXEJ2xiWA/zkss4Eq01g=;
        b=LxAikj+wHJjp7VJ0lqvCoMhYdgsjXQ7+NRalP95MhMWaZ15IIseF6QODxnOYtDTHdD
         mVcRQ08WfIwrhaWhNW0rxn2UiqObgZhF4UU+38Yh45QWCfa0lRadX70Ciq+vEXW52x5p
         p/Xb5EH6lrIQxrgI7AM78vqstEscrnmBVrGatKF2Q5c2FVVOJFkX2H7F4jWgSTqpfUde
         8iXRH67YjzlJFmJDmzC8tJ6svTYtFN+uVRYu6ApSXUDIsAThGvYXguGfLnYAcDHdFiwy
         2oozdCe9BG7KdLDvU7HJ2dwaReB38oLIhYwIc42j5Z7m2flAR1JpMz10CODPozfHciSD
         8tiA==
X-Gm-Message-State: AFuF++mx62AnQnyL3vGWZDtsCmZ1PeQ4ehuxNpgUq7DcW4UuQ/dvVdGB
	NxnA3gQxINPBDWTBzG02IoIXKJ0FZ3nJ9DxOczE4XvcVCXE81PJqxvXq
X-Gm-Gg: AR+sD10fybZiLKaDcdWZw3DV6slxBnmbwD2ZcVSt2M4yNdXx4qNXPDsh1Gjn+uQSKWQ
	zrwp046JXtPkqkM1RGC1NP6BsqpwfsKtsGfwNJp0uc95LIpeAlaDRtnV2FB3BQ0gZ10x3l4gVCP
	VWoYZEXaYzSfJjDFpaoeaa/Xg8JY3gmWa7PkPLKGlc1RsfnnWviCwkztinFXpwJLL0rdZPGcH7S
	Nduv4vJWelHimizJ2mXlUt87snjOyHd4KEeYK3fQh8aiO6yaOMQSe3J6JyrlBVuN1V59v+mpcSP
	0tA7T5aLuV6752h7nmtzEImdm9oEIvETrAo0PNPSXgd6kPxNwHon3dMT4e+g6GfeF1y3pbKXUEh
	D8yrY9iQ9wFdKrKw9eT96yifL5dRQnIiTxpaHyCJVUEkJ7tiXtFjBF9yoAVyyQjiOgnGJogqUCa
	hOX5UoKHUXiQnyb65nmaJBzGONToeCwVZcnNHeZcY1Oe1msJlbqGz5V8hChI8ktphL3ErhYPIl
X-Received: by 2002:a05:600c:3113:b0:49b:924e:9a28 with SMTP id 5b1f17b1804b1-49ce58163aemr2032655e9.1.1788293993799;
        Tue, 01 Sep 2026 13:19:53 -0700 (PDT)
Received: from localhost ([2001:4bb8:16d:f647:967c:bbf0:49e2:fbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10148sm89545935e9.5.2026.09.01.13.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 13:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 22:19:51 +0200
Message-Id: <DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>
Subject: Re: [PATCH v8 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: <linux-iio@vger.kernel.org>
To: <sashiko-reviews@lists.linux.dev>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
 <20260901-veml6031x00-v8-4-532cb4f2168a@gmail.com>
 <20260901132208.EE64C1F000E9@smtp.kernel.org>
In-Reply-To: <20260901132208.EE64C1F000E9@smtp.kernel.org>

On Tue Sep 1, 2026 at 3:22 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Use-After-Free of iio->pollfunc in IRQ handler during device unb=
ind or probe failure.
> - [Medium] Unintended I2C read of configuration register when pushing tim=
estamp to buffer
> - [Medium] The interrupt_users counter can permanently underflow during e=
rror recovery, breaking hardware interrupt control.
> --
>
> commit c87f3d48e1ee614fc184995b816c8f8679a6b774
> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> iio: light: veml6031x00: add support for events and trigger
>
> The device provides a shared interrupt line to notify events and data rea=
dy.
> Add support for configurations with and without an interrupt line, provid=
ing
> events and trigger support when an interrupt line is available.
>
>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml603=
1x00.c
>> index 3d5a27a0baaed..7bd7975eb1a76 100644
>> --- a/drivers/iio/light/veml6031x00.c
>> +++ b/drivers/iio/light/veml6031x00.c
> [ ... ]
>> +static irqreturn_t veml6031x00_irq(int irq, void *private)
>> +{
> [ ... ]
>> +	if (trigger_poll) {
>> +		iio->pollfunc->timestamp =3D timestamp;
>> +		iio_trigger_poll_nested(data->trig);
>> +	}
>> +
>> +	pm_runtime_put(dev);
>> +
>> +	return IRQ_HANDLED;
>> +}
>
> [Severity: High]
> Could this lead to a use-after-free of the pollfunc during device unbind =
or
> if probe fails?
>
> Because the IRQ is requested via devres inside veml6031x00_init_iiodev()
> before the triggered buffer is set up in veml6031x00_probe(), devres will
> tear down the buffer (and free iio->pollfunc) before freeing the IRQ. If =
an
> interrupt fires during this teardown window, the IRQ thread could be
> preempted and then dereference the freed iio->pollfunc here.
>
> Would it be safer to ensure devm_iio_triggered_buffer_setup() is called
> before the IRQ is requested?
>

I will register the IRQ right after calling
devm_iio_triggered_buffer_setup(), removing it from
veml6031x00_init_iiodev(). It was there not to check i2c->irq twice,
because that is also necessary to properly initialize the IIO device
with the right data, but it is true that the tear down is not clean at
the moment.

> [ ... ]
>> +static int __veml6031x00_set_trigger_state(struct veml6031x00_data *dat=
a, bool state)
>> +	__must_hold(&data->irq_lock)
>> +{
> [ ... ]
>> +	data->trig_en =3D state;
>> +
>> +	return 0;
>> +
>> +clear_interrupt:
>> +	veml6031x00_set_interrupt(data, !state);
>> +
>> +	return ret;
>> +}
>
> [Severity: Medium]
> Can data->interrupt_users permanently underflow here during error recover=
y?
>
> If an I2C error occurs in __veml6031x00_set_trigger_state() while disabli=
ng
> the trigger, this error recovery path calls veml6031x00_set_interrupt() t=
o
> revert the counter, but fails to update the software state (data->trig_en=
).
>
> If a subsequent successful disable happens later, the counter will be
> decremented again, potentially underflowing to UINT_MAX and silently skip=
ping
> all future hardware writes.
>
> [ ... ]

That is not true because the error path will *increment* the counter to
re-enable the IRQ and keept it consistent with data->trig_en. If an I2C
operation fails, the trigger will stay enabled in the device registers,
and therefore data-trig_en should stay enabled.

I tested it by adding some hacks to force that situation, and what may
actually happen is that if *on top* of that failure, the I2C operation
in veml6031x00_set_interrupt() also fails, interrupt_users will be
decremented (as it should, because the interrupt could not be
re-enabled), and *then* a second call to disable the trigger will set
interrupt_users to UINT_MAX.

Although this is very unlikely, the fix seems to be trivial:

 if (state) {
 	data->interrupt_users++;
 	if (data->interrupt_users > 1)
 		return 0;
 } else {
 	+	if (!data->interrupt_users)
 	+		return 0;

 	data->interrupt_users--;
 	if (data->interrupt_users > 0)
 		return 0;
 }

Note that this fix is not a hack to just get rid of reaching UINT_MAX, it
reflects the fact that the previous failed operations lead to a disabled
interrupt and an enabled trigger in the hardware, and there is no need
to act on the interrupt again when trying to disable the trigger a
second time.

I will add it for V9 after testing it with some hacks to force that
scenario.

Best regards,
Javier
