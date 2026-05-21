Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1D33A9DA
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402876; cv=pass; b=QHNr9twHWE/hUldMqVhoSPeCOpN+5jUYKN8+Hy8rzU3OjmO/QvosCM0y363pbz+m0rr1Ef9vlCM+dlpQOdvPfKa1cN5CvyUR94K2vyUucs0lu8uYhmruNkSp7N4XyzEMcFLkEd9qCob3iWfMF/OmPXqY+4mRz/ZTfr3Lp4Z/8rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402876; c=relaxed/simple;
	bh=mhArStkcWM3iK1CFaFs5eNLMOZxVrRC5m7xoktEmPi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV8ce5wJwgis5cwSoRr4tliRJ88ygj0/siciykpwlsbMIll/byWu83ssqw0roZ1xVwM7fQmP39n2MeE0nDc2M5nh62JOwZZN8itHO1IxMsSKMgVNhoM3OKcV3mCsicY2wKBl1Rxylx1fBV+RsnbwjhlapFZIBw9WaphWV9iZ+5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAW13tT2; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAW13tT2"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c2cd216c9so5737485d50.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 15:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779402874; cv=none;
        d=google.com; s=arc-20240605;
        b=UfpfIo4HnouXZZtBEDOA4ukzUhCUiLfY622X/WEcj2qlvgXD6F0pfUi/w2FSskXvKE
         OgsrreADnvJMZlCcq4DtGZDLOE7VsKM1CBeygtfCSAIKHYGHa8Tjz/d0hfnpC+qrM4H7
         4NlfiLFZBV0nHDCkZX5GyS3EmRpv8cU3pwo7KyGYJoKTTRAaYvtBc2r24cQoXImUY6EM
         09eFT4rFiwb2G63AlmhGlJGoUBOd6Y/lAYVz+SqnRY3z3jd0x6UqcozJBzFFIBc3yeFl
         2sMte/1ysy+GfXSRSyezCmY2vYGhmO/nFt7t72iPuE+MT5IQb34nsJnT61M9DIUDbLCG
         nDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FzD9WpTP1jsShhKHnMGI2DTH5MDC4tmr4MXo2S4FbLQ=;
        fh=JbcBEQbA/KmMkUcLXLdGhCu0sk3bugH/8dJZaE/Ubz0=;
        b=JXiSF9dWekjD6nrKmiZB/mw0nZb4aoGVkbM1ngovWwHbQdeHcABcLc+SwL/opblfRP
         HaHW3IXXGzyjdiLoxCIpQ8k7O4oYhqD9HYrGXSV9ZwHmBoLZfcW1diCUEVLn8H6aI9AN
         IvN6RZ72clEybUMPV9Neu3r5kZmIOPOie3oT+ZQe82IaXO9LB1UYw0b5/K7g+05n2IJ6
         HhlQg7WGkvuPws5fLPdTmlrUzHsqHCCcBc+2Nq9kbaJLesPCQiDq/lim7lJLBmq1qzd/
         prJhEuxPJGkCre+CAALeg6JD21TYJaC0KfeZBZxC5MpI1MLP5JXwLIRlABokN1u45jov
         a7hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779402874; x=1780007674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzD9WpTP1jsShhKHnMGI2DTH5MDC4tmr4MXo2S4FbLQ=;
        b=PAW13tT26ycQkBXuyFHA4VSnI+uYnkfy0oGdzbdknUawMh5xfuJilf3VKyUkWnMJrK
         NKgvjG1WIMVlqj75cfa1NIGaumcJqGPErX9mSRqo47Dc4ZdewXBp1h0TUUjbXUKxRRCS
         xZxtvfZSFWgZP2H+7ua7cXwjoBqMVcOEtj/T0dNqOyDuVfREZCAVP3Ri4GrV0pPj+A0o
         3y7s0nfw782XChrrEVTjI8i9b5/J9f4hds1m0SNUkH5BRRWhGEz0Ou23UX3wER04vW+/
         6KrVfU9pRaBviqQX96ddasGFiIIpFXTYYRb681qmJ+h1TyI9+rUpJNM22B0ALcKrHZzQ
         HmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779402874; x=1780007674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzD9WpTP1jsShhKHnMGI2DTH5MDC4tmr4MXo2S4FbLQ=;
        b=IOnYBSfCDxDzEGVe9/al1SwlEe7Xg5JUaEwAeXxzlBkU/Ipr0H24iC726zA6PYYXhF
         zqEgNl2xLVh0L0A0Oujby5qE0zMp1jQAlSysOrm0KyxEP9P3OYnXfnAO67GVHd+6sWCZ
         +6NsT/aNBJ1Xw48CFGR4xxRwd6PPj0/vHw8gF0duKn8LvgO6jmLdv8mlFTQqwPiaAJGC
         mzWYMrLeKCKR8963VZ8vKW5YF/iUCC5EBVR+/Tzv7ETwGwX+P5/b5fqavv2aGAmUN69w
         igTbGT0SKfVL12eJCStPu4VPRGVcu41A/cDlp+E2ffKz+cOE0AgP7WGUSbDvRNNQyv9R
         JRcg==
X-Forwarded-Encrypted: i=1; AFNElJ8cxzGKwusCvkjrx8uU9Dj+GjLZUW3DbfrmtaCXSyu4ddIXnzkfqSjuwGashHp+92blpqu9qcaxifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdxCMuDh8IS449zK1GyCno71TEPurWqDA0D3r+iaWXHfKESas
	XbD6IEzx6TeeMx5fdyCfXqi+tie7CSgGK4i6/DoG3qDNT+mAIwo1epSf4MQNqaPp/qIArRH1FnC
	6pJrcccBe6COywOBXM2V4kWwJstLoA4M=
X-Gm-Gg: Acq92OG3Xhb2mvzmP/hbO4JNd0mMt39IlO7AXhi9guvO2Cb8CxmsWVS8YB3LjozGR9T
	XNsK+2dxXwdTW2B4CJyWwevCcbytGM6BNOk5yaeI8y8TEbEZUPE5gQdB/BLmcB8GshC3pql7Ro9
	TzdEhDBeBDPAOZr3qIE1+48AC+z+MXwEoI+x0VsqVMjDzmYiaf/JN9YKJpA7xjmk3zY6x5r4fMk
	RQz9KPZYASkH1+5PhPMnVIj1OpJ3J+fRTmJLwgo2zx8FHtKZf5IfOqzjmxmRjMQTrlNgoGW3sxq
	EjBxEGvzuF3kBvg=
X-Received: by 2002:a05:690e:1517:b0:65e:40ee:a431 with SMTP id
 956f58d0204a3-65ec99868d0mr1275095d50.52.1779402873955; Thu, 21 May 2026
 15:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521223044.61410-1-m32285159@gmail.com>
In-Reply-To: <20260521223044.61410-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 21 May 2026 17:34:23 -0500
X-Gm-Features: AVHnY4IWr00nwYBqHWzduwUXjYpr2hGNOE4ybzeM8MEKsXILmHHBCSaIMEtkugY
Message-ID: <CAKqfh0GKRViR-_rW8=JSm+Ui2DubqUGBaLo_Ho=NN-=zVoptJg@mail.gmail.com>
Subject: Re: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:30=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> Include linux/cleanup.h to take advantage of new macros.
>
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate to simplify
> error paths and eliminate manual locking calls.
>
> Add new helper function kmx61_read_for_each_active_channel() to mitigate
> certain style issues and to prevent notifying that the IRQ is finished
> whilst holding the lock.
>
> Update certain returns, and add default case to return -EINVAL in
> kmx61_read_raw().
>
> Remove now-redundant gotos and ret variables, as the new RAII macros
> make them unneeded.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 129 +++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 62 deletions(-)
>
[snip]

Crap, forgot the whole changelog.

v2:
- Remove redundant blank line per Andy.
- Put kmx61_set_mode() function call in kmx61_runtime_suspend() on one
  line per Andy.

v3:
- Add dedicated scope for guards.

v4:
- Fix certain scoping in switch-case blocks.
- Remove stray ret variable.
- Used scoped_guard() in kmx61_trigger_handler() instead of guard()().

v5:
- Added new helper function kmx61_read_for_each_active_channel() per
  Jonathan's suggestion.
- Add default case to return -EINVAL in kmx61_read_raw() per Andy's
  suggestion.
- Add blank lines between guard(mutex)() calls and regular code per
  Andy's suggestion.
- Change last return statement of kmx61_write_event_config() to be 0
  per Jonathan's suggestion.

v6:
- Rebased onto TOCTOU fix per Jonathan's suggestion.
       - (note: now dependent on said commit, link below)
       - link: https://lore.kernel.org/linux-iio/CAKqfh0GHVtAS6Uw3Bjo+B0PCp=
cfT8FogqEPCmt2x59zhmmh1Kg@mail.gmail.com/T/#t

v7:
 - Remove some unneeded parentheses.
 - Remove stray whitespace.
 - Fix up return value (from return ret; to return 0;) since we won't
ever return anything other than 0 from that return statement now.

Note:
 Will save the dev_get_drvdata() patch for later.

best regards,
max
