Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B0317170
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124054; cv=none; b=Rl5SApZaiWniedY4z8S0fig8MsqGDy3I8AXAPlCKyYgpPaGkZDiyVgaZI5JgWKb4un4nl7xOqeyNALH3gz1Im7P+cwC6LhGLIPsktdv/4+vDUmvM+QfSfIAdZbtGipQqnux2hf5/6eq85p7nRjIQiAdM9Wsry4PwtxcA7b5Jtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124054; c=relaxed/simple;
	bh=CE68Rb9kC/HDA2cBAQQX3Im6WA6S7tlqNN172Y2yO0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZysVByyQg0nNTmrMhx4Z7lWTp3z6vDaNiPEsokhvZHXHV+byZoATxMabyUrw2V7rqJbX0fxnNsvWTNZFOCoxZHen0TKazaxqxpO++ZON+uVCeD2al0Cwbn+alnHb+/4dcwE+a+BmRbkw87kSSrnrqivkvEJcjhEOp9BobBF351I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF0chKqZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF0chKqZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ec555a26so35550835e9.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784124051; x=1784728851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BArhhnpdI/Cv8HoI1hRJgRyqIoDXROOU23KIbFFyDpY=;
        b=NF0chKqZXNAYbYItWEXZ3DZExK7A5RJqN7QOeYBSh12Ajs+OHrbRqoa1TgPTK7Z6VQ
         K6tVtB0AbXfJH+51zDu1y9qZ7mLX7JLvycymiqvgE+wweAekdS5hV7L+y+XV5xNxrcqU
         WecjiUe0oNE4WIc1JN3DWs4nj61fgiXuRzxBFEeMEIYPwM5b+2FRIsGn3m1YLBJfDuXH
         BsHkkCvRRDkE7bO3igyluWt+nH1OC0LqBUis8g5HJLF92lA9rtTkwENQX2cydE6pFITG
         NWXeZIV77CI52qRVolSjJHWbrVz2GuWEotUEPB+7PG+7d1beyGhYNHcG3cPP2lYlMQqi
         c6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124051; x=1784728851;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BArhhnpdI/Cv8HoI1hRJgRyqIoDXROOU23KIbFFyDpY=;
        b=swUId7f2KMaswO/p0i8mfCTl/CAD9Ld2y36i9PQUg7gt+TCpRGHra8FDCKeGm7keP8
         vVpTnN1Rynz4yQzVsorvidD9p7B0VqVSmgpN7Xb1LN2ZxYKdtEa3NqHF9HVV6B1HIPnd
         oe68TFVVeZ92XTihHqWtiXWs5cYxVpy3IAUZ9WiWcvOxtkN7fwBnU1jqormGw1U5ysm+
         YZW3xRXtz82YV0ZqOu3/+11CqHIIgnpmCWwFFnEXlmzv1YvWYMPMr7VJrcsCcZ0g73ok
         aoPELK2RGeHBxXzRUWmYxlfV6Udru7PYw+kC+3e1K4RV4coIGgac779zbKvA56a2BcpD
         mLPg==
X-Forwarded-Encrypted: i=1; AHgh+RqPDp1ri4zxQDHmo/uiOutr5z0j1Pll+iUzycURzeuCuif7+VQdv+Sw+JzaGIKqqPc0Y1lZurd8UG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u06tnVMvLKBHxlblPB+UE91V9Ea8ZuHhRjCQj2vjh9EOLtKG
	DleDyU0rIGrPkPuY/WqXFzSmTfdDH/0PoEbUy6JGHUeLjC8FLIHZSb2s
X-Gm-Gg: AfdE7cnrVROaMtkU0q97sYLhydtcKtUmhXUvjmS+aXcp77HKtCjFfWXSJN2xSiSmpZ+
	Ccc6wJqiPfmk518UW7QIwgWVi4R+MfHYgC9Dxkf7lF6jhtVeeIO0mq9pTMINS9g5KFGG/rH0Dtd
	E8/seNU7C2QBybbFXGzBv17swz+5C/t7hlO2s2hsSTAWmrKuv/uqUjtK3u2oHeBrZlyLj3KqVe2
	kSe18zzOZpuck2apz7OiFNpdbO8gAJKiUOt43hY9fOHDka0+uV0bvDs7bkYW2qKizBrL2qaPdRt
	vdW9zogKKtgUofr+EDm8V8KOdi0gRDxarYpi73bQhXzreFt9yNUklsQoU+Su/cN86I4DLblWZig
	v3jlFYmJp88EH4k79IVds3zZ5V/LXToXxqzRDEQTow2vV2GS3U1bfBCyaOd4ra0EDBm9TWlhiXY
	YQFJ8fkzRAULqbF48wQ2m0Cnf61lMjyWAqTk9zVvNDFV5QasScfU0NC7e1Lo9r79diaaXEZrnUq
	if5sLBO7MqTpOJG8Dt/25BOqkvIt3jLViCS3TGR+Ktt8pbh6LdRDeRaU8a85nGL2gYzWK30QC2Y
	PZyTJTCsPjp16FKlB4TC58lekDbAO2CrOQ2yPb2ppfVVFC+Eq8U54lnD4wgB/1+zNHTxtDJSiqT
	hk0KKDexdhC762ubnAZc8mlQ=
X-Received: by 2002:a05:600c:6211:b0:495:3a21:4e5d with SMTP id 5b1f17b1804b1-4953c001211mr34667645e9.0.1784124050314;
        Wed, 15 Jul 2026 07:00:50 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2edd6fsm150750035e9.11.2026.07.15.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:00:50 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:00:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, William Breathitt Gray
 <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>, David Lechner
 <david@lechnology.com>, linux-iio@vger.kernel.org (open list:COUNTER
 SUBSYSTEM), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), linux-omap@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP)
 DRIVER)
Subject: Re: [PATCH 0/3] counter: Remove redundant error messages on IRQ
 request failure
Message-ID: <20260715160048.00000737@gmail.com>
In-Reply-To: <20260715135030.326290-1-panchuang@vivo.com>
References: <20260715135030.326290-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 21:50:27 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in counter drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.
> 
> Pan Chuang (3):
>   counter: stm32-timer-cnt: Remove redundant dev_err()
>   counter: ti-ecap-capture: Remove redundant dev_err_probe()
>   counter: ti-eqep: Remove redundant dev_err_probe()
> 
>  drivers/counter/stm32-timer-cnt.c | 10 ++--------
>  drivers/counter/ti-ecap-capture.c |  2 +-
>  drivers/counter/ti-eqep.c         |  2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 

LGTM.

-- 
Kind regards

CJD
