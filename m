Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921B354AE3
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705531; cv=pass; b=imEEmcSE0BWF17iqUuMWv4ulM5lpgFPwD/n8cCjwucp1fThMUIJRv+iUEb/5/Q7EG/0cemRBFFpxy3muJPYvqpGRSuEHSE78NEXlITt7/SDaDAZ14oS83jAKRGsrAgmvn8la+aZfKZYjCvco3YU8uPOwPr8D9hN2S2V8zngjp+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705531; c=relaxed/simple;
	bh=Eh+vSyscHQXYP+PlafPR8lsa4dRJdTfTSK2Rzu6Ec5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVpeUtI0pC/BDOTF+wEhh7uuZBCkXdIvrjkfmQllBgtvIOtPHUbGs3C7/N9cxHGWIfu/LFjoUPeUEfv+3U+TEZ0XQdhwmR4Nv6ElVlXnJSRDr/+FLIRvjLBFglkGbB2rgWOAamjioLVR2GzVu50ligCLzVJiqeXhWzXuzLesmFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXzjPWBI; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXzjPWBI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso5213225f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779705528; cv=none;
        d=google.com; s=arc-20240605;
        b=YTjtlwFRspxeAKnnyDJPHRYd5QFag7N6n/uE+0CtzLV1LD96nSCu0oyrifUUmJOs0N
         O6063rJduFroIvbefaFG/KXeePEfBd0RVjOMf83A/HUTlpm4qxCBAoMRF2vgIzkMQsce
         uiLaZZuiL82RI7ACQA40atFnEKjLYSFsDLUUKruuvb9vQw+xV0P9+et0f5F3NFcQ9WZD
         bGnT8ahgEtffV+BmjIl+MUapwQewbwo3H6gz3uj3sQVZhSn5qt9k8CKXYYEzlKKm23tl
         Fhdohim9A13P4hsAFzSXvSNSemLJUgKMEgd90yhLd4O6HPI9VmxffNzMdxrstspiRw71
         SuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=soHbbmDjYlhF8yaXN6wgCVXggYueDJt2rxg10NrYUho=;
        fh=X1Y4eOHjOD7JKXBbwGBIofW5RwGy/6AR2I4HgnzuX0o=;
        b=JJLQrmy0pxmd/+JszoiCysvx+4So2EIvjeHF8Mzt7Yexm+qqjOb2wOrSN38uesVabB
         7fEg0Idd6kQTNO3wh+05jIn6L0o35GtP/U1jf8nKIk2WuMOucMben+l1eNN9kz+VnYGg
         AP2ofsuOGviFGOWH++TSmWj8WZbf226WvhnvYkldEyPfB+IEGox6DUOQ6scj5tiMzT8r
         bpNbuZqVcsAoscwnc8mjRwL8Ye6+G+cvkf9SjLHszjL3kbeAzLGLCFGNy4HegSdxTJqH
         lIeOObtDKZf4HlF0eoBd5LmaYXN2sdhufhTzp3he2b0F8+Wwe8pzYUDGoNzzejzs8D7p
         tAXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779705528; x=1780310328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soHbbmDjYlhF8yaXN6wgCVXggYueDJt2rxg10NrYUho=;
        b=qXzjPWBIXIwRQOyS9g+B7TqmhNWgj/DWzpVvNx6vYci/C0KhMzjhabce6PzL1x1LKo
         K3OvO4snxzHXpipwcEsi0XbrGlTB5/pHx/+tsOmHS0D4Mvr3xljJ4OOg2zlWPGmyzzfE
         F6qlGj1e3pSjlsEX3no0B2n7xRymj7GzAwy29OhquXOW5U+95F97Xc03u+UkPaavlBHl
         FHL8nY1tdOlSLfNNBnvR3FmfhgAdg7sAevZ0F5triRRQZqUKPlh3krj0s0z5GRttCagw
         gwlTijRbXbHSlAQsasuRI74uDkwxZK1xaT4vTcwsQBGU3w17f3z8yyXbFyGAGwEsNrEs
         KUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705528; x=1780310328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soHbbmDjYlhF8yaXN6wgCVXggYueDJt2rxg10NrYUho=;
        b=ZaGsvjoGk/A/XWoRH+xW1qIWlfxCMNebaTEt4zWSBnydCFmkWuTLxifbbgWMaS3OHf
         PBoUKmyXe4jp6NrKizAkahuFuWqnWxBHsDsOd/3ZQ6j6HIu3BMNf/JNlOoa06LGpi8OP
         JWHA25VTEYCkXbUDdPgzsQxVRGGS5HlzjT8X2+A3RdR1oSokn8Ie/r5/z+MXEbZ3I+T5
         ehAC266p2wcZeVU3GNCScwEjaflStHQz3hIsF37Y/Wta23Q5uHg3JwkMRDcHj6+fxC7D
         jkkh1PoEOjNC2OJW93GEcPdlxIsRvUmlgeKCyNmQPzvPaE6G8cYWXNJSjRtrBQQtGaqg
         oDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/m3jsvG5LlDV/2m0OT9UcSo9IOnNkzhQyT8exLVoRvUd41TWZ9P0acEb9d1U6X1TJvdcjwzHbF5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwocruv8fjJ21BqCyHSMmDiLcDK3Xq4qdzNgpEd/5ySGQ+zxaw
	KhOIwHa2btc7a+OqHiaR/9IQ6hSULwrUIyGGZOvyZ2xheGVb55P8jmmSyLXsVUsNAhRO+y6xykP
	4M8172SWkOHPmt2Mqqw6tWDBeDjOOOXo=
X-Gm-Gg: Acq92OFML1wMXHpTCmy5ImMlyRryGZxPZl2RCvuKyq8+0jRKBPN/N/gVzdEyWMIMZ/6
	rgSHei/RCxUd88fqVGLN/rasD+Q5wtzPGLS5DV7rVCRg1G4KqsrtiwOSulG9Z/7uxlqfuC+3TYN
	lJHLZMEIasahzsoZbDhsu4tm4Ck8ZHUo9nH+D8W9QwXcNMwhAN1l+yAMw/N0jm1RRDfZVPLWXpW
	0KoK/XzGA/CTvjUM9SfaNy5KIdFr2V2i5wI4owiDlapErfXs6wFbZjGGg71ZMJrmRjt4uNOKM38
	Slenb3ZEwHttARQjyQ2VbYsiJnKKi5aLEPxEv+pXei212s2h6Uj2oMBe8dogMcZDVaK2rFmrPLy
	6OAkVWTB07bxG+24TlYBLnHBPna/ICDVeau0toGAuyyivfI6JuO5v8lOveqJJOyOiXvVoxJi4Qf
	qbNJyaN01Es1W7H9QX
X-Received: by 2002:a05:6000:41dd:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-45eb39f9ab2mr23578000f8f.34.1779705528423; Mon, 25 May 2026
 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 25 May 2026 12:38:37 +0200
X-Gm-Features: AVHnY4JvQ_pwu9OU3v2BIMDY6nOVkJ9J5wE0WAUgT4WpLqcFv1YzicQz11YFZFg
Message-ID: <CALoEA-zHCLnd20DaZC=m+vi4QT5DxMTNRPz-3u8Mv3NS6GMYOg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iio: light: opt3001: driver cleanup
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Maxwell Doose <m32285159@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 May 2026 at 10:20, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> This series deals with cleaning up the TI OPT3001 sensor driver,
> moving it to more modern kernel practices and improving the code style.
>
> While reviewing, Jonathan Cameron (and eventually Sashiko) found a race
> condition where userspace could start interacting with the device
> before the hardware IRQ was set up.
>
> Changes include:
> - moving the driver to use devm_* functions
> - IWYU cleanups
> - removal of unnecessary macros and comments
> - using dev_err_probe() in probe and probe path functions
> - checkpatch.pl warning cleanups
> - fixing a race condition found in opt3001_probe() function
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Sashiko came back with a dead code one liner and then found
a new issue where a function returns instead of calling cleanup
functions. This is definitely a bug that should be marked for stable.

-- 
Kind regards

CJD
