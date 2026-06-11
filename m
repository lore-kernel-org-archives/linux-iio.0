Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F619403B13
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194055; cv=pass; b=BSb9b6wqOlTAKEcR9LApOlU6XgP/80c/yiLEDchUT4dG9CnPNbV2rkQ2fB1BvJuibksLNveK/Qn2rom5TFyPsdzi8DQniRm2VfvNtto9pSBIx9MwC6cCHEF8DbijzSSp5zSGs8BLiUagWGSSPUq2YeRDJ1nPPo6GVkF5KrnJq4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194055; c=relaxed/simple;
	bh=pMIPPfvXhysxiiMWPWBMU/WNhyGFXzFylEplC/HXXRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/DKk23DjoEmayY1ZXMgzT7BKNvi/UsVqyAtg1ZqBn77pchLI2q4tdZmERqvcJn6ddSxnD4vtix2csTGAQzEifd1VLnpBcKCO9IbJCIvEErgaUgZGjwOoHBYSsvyRG6TS3GGA3GMfVAXUh+xdMwXNive0M7Vsp6kjq8SAOSVaHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjiwFc3A; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjiwFc3A"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e2fd65f968so78834277b3.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 09:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194053; cv=none;
        d=google.com; s=arc-20240605;
        b=DYrSQVBr2oXbeHalTBZEAhufV4NF6eni4zz/XdRqPYtXq74IbkcWkTgwUZfmwIfr3E
         s4vn/O9PHPKpTN30kR0NcbjaxrupNqIS3XIKkgZrlEgjAUh4F1brzfGEqBnkxAHrJfBG
         jbv0Yq9FFGLSHBOohGy1C8GNRwHtJxtooIn1wT9RvX3YVwKX2bBzA/6Hl7lb252HPvuC
         ddCfMFazE4+As5RaTo/dr7d/VZFn4RGZVVWpuZIAFE9q/VD3fi6LSKHaR4Uf5/bmf82T
         hYHLxCsOaPX5bjGvuB4mf5TcIs+A2wVpBPDVIbYHuMLt1a/MJqpBzgbjCA2QM5DlGJzf
         K7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXXzo4vROWpZwVJN1pIQILOm2VIbpgsaN8smw0A/DuA=;
        fh=AG2UXpcVn8HdSo9Z8NHjSMcVDaL1EXrrMg5SM9QuwvQ=;
        b=AOwPNLsB7jkLKoWpNm6LbNxE5fU7lQghU+7eQ2938zRVrhThzweaUUrcoZegJY+AvN
         WncwybHTkcA0UAelaMMaiLRgrDAvNc2W/OKvzlTD9W2vkFobnNd9TkaT/l9T0pRQFGLh
         fG9mMr6LFDBdZ2TWWFjUYLCXok/JUodlmWSsyEDrcmqLz472VUWWM+TEZBF2ptMA0W2g
         5AiIawle4qIb5QqHBYEUqRNcrilqDsHM0Yteeq5kp1CUvpkB1lKM3/HE7RqYNaEaDF5G
         4yK6hIKAvR3FBsr0X3SybM0gRn18a4cl6Gh158GsgbVvJ4swqFDyprW2wq/1vveHxkrA
         cywA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194053; x=1781798853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXXzo4vROWpZwVJN1pIQILOm2VIbpgsaN8smw0A/DuA=;
        b=JjiwFc3A9FXpg39bP6bbypX418hKcZY5IM8m4aK/TC6wjQLNgN9gwZ/Za2Pn7nAACe
         WWajf321OGOPHQkgMNwYicFN7Um67BF/6BKMm2CZTLoFH/HVX2VXCS8EGkHpImICWwAL
         ivrqJtwASnsKt3Nw7bO85J/7dha3zs0KPDCooeW+SCZXJwX0XNNiVAlB9/9whSq5trSt
         OH+lGhgJCdvybOUlGMUhixJbYz8t6vvM9ApPaRLvq+RZgyfdcCYOTSkHQWXeotu2Z5WM
         6t0JY9SGHDF/FVknK+9FlUkiq4x+HjWSDSMQ5YUrT4PAYad1akDfrCKkGPzfnV5uNnda
         s/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194053; x=1781798853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXXzo4vROWpZwVJN1pIQILOm2VIbpgsaN8smw0A/DuA=;
        b=IcuwvaMRPEsdCpFHNkMbmSWlYvEB94rA9q9/XzuDSoByIngoY2pAorUXsdz3n+qhs4
         O0Z7knAtYWob+6lOZ4cOB7pIojvePbRzCRwViEknSgKVUKpyfbYURHSRTN3XiV310ibD
         cpKyqndUPPZixR2hYMvvvdrJRpnGpHBMz7dG349kBTvk/1EGlNfroSpcJM4tz1Yg5+i4
         cqXUX68sq7Md5Vxj1r6ZSGJeCR5k7ljEyojAHlqZsbdOCVkvhSj8DRpwWwn94fv+4lsy
         2pCqzfrNGnkO7u7BDJg5rHB90CZrGnUFA0HYp5ANGDNXk8S5kRsvhYrOGq//qlO/1FCp
         XwaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eN9XkTXX9yHc2AUymq2rZsdgOKqz8pvBNvFCtQ5i3CjxYOa88VdusKSpxMM5LEs1ksR1OL7SfOlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJIx7Sso8Kx/0fd3TWC/gUuADLgKQTmaybX9wq46f8p6EkzEE
	psTX7/xlxlZPNolprpeXSTAahREcrEOyIS1xe5j7JiBOF/dkxpncja4Kwk235xu7XNIewKF3ZSS
	iwieLQXvsXEzMcSFtPKU47s7jHI2OcVs=
X-Gm-Gg: Acq92OGmB9RUcfL5B19CxlUqN9s4pgQtuwYNU+FO+8eX9JF9RAfJUZ5XvaC3jTZxIVe
	tT8z5Ii1uuIew/jCh270RN44yjAXHN6oWqRcJaOXbMW9Jo19VzFNdAupgr8lj7kgOveMXfQfY3o
	ee4Z/zXDwfluTNPb8iiawWGzQ28nMTgizBfx/7cwmi8JEBxtcvk8tYA0nuueeF+PREYVyAzCbbq
	N69487TAfXTGGNLwIBJqetYy0p5l9yys8VTvFB7r1C9bAQshXB4XqMbrAOamCMcMQvuyihumJw7
	Hsy2
X-Received: by 2002:a05:690c:4c09:b0:7f5:69b8:4287 with SMTP id
 00721157ae682-7f6553f7899mr38398427b3.9.1781194053316; Thu, 11 Jun 2026
 09:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610115700.774689-1-jjy600901@snu.ac.kr>
In-Reply-To: <20260610115700.774689-1-jjy600901@snu.ac.kr>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 11 Jun 2026 11:07:21 -0500
X-Gm-Features: AVVi8CeHf7uwhPM76_RfCblG7fJdBhGq4QR16eMi2j2amXBgrgzWYA0X7OPgM7k
Message-ID: <CAKqfh0GVDpfP=TJZPQ2UYkUj=pe1KGn4j1zqbaz_19xawekdnw@mail.gmail.com>
Subject: Re: iio: adc: KASAN wild-memory-access in complete() on early IRQ
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sangyun Kim <sangyun.kim@snu.ac.kr>, Kyungwook Boo <bookyungwook@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:04=E2=80=AFAM Jaeyoung Chung <jjy600901@snu.ac.kr=
> wrote:
>
> Hi,
>
> lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
> spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
> interrupt handler with devm_request_irq() before they initialize
> st->completion with init_completion(). If an interrupt arrives after
> devm_request_irq() and before init_completion(), the handler calls
> complete() on an uninitialized completion, causing a kernel panic.
>
> The probe path, in lpc32xx_adc_probe():
>
>     iodev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzall=
oc-zeroed */
>     ...
>     retval =3D devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>                               LPC32XXAD_NAME, st);           /* register =
handler */
>     ...
>     init_completion(&st->completion);                       /* initialize=
 completion */
>
> spear_adc_probe() has the same ordering: devm_request_irq() for
> spear_adc_isr() before init_completion(&st->completion).
>
> Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
> complete():
>
>     complete(&st->completion);
>
> If the device raises an interrupt before init_completion() runs,
> complete() acquires the uninitialized wait.lock and walks the zeroed
> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
> return false, so swake_up_locked() dereferences a NULL list entry,
> triggering a KASAN wild-memory-access.
>
> Suggested fix: move init_completion(&st->completion) above
> devm_request_irq(), so the completion is valid before the handler can run=
.
>
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
>

Thanks for reporting this; I can start working on a fix shortly
(assuming nobody else is already working on it).


--
best regards,
max
