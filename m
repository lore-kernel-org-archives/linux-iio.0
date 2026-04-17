Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4133B961
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411292; cv=pass; b=LE7x/Xk2BLiWblyXmEVzQ/rCOs3R5xB+rczlqv5M14vmztA8widhNtAu+L30Bdwze5hrNCCYC+02xOciZLgIkG2gypuDsu+w57EM4SmUBKQM+UF+NRCdktR2JW2ST3p7VlAercircvnGY6Auu6HjWdRRgBOAV0I6IGdwwaMtdJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411292; c=relaxed/simple;
	bh=c7f4ivgvUKZHgMVu0TQuosjS+MtcsdeUVE7bDMVHgIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZeTNmZAujoWVuJEf+tAmCXUfRevGjXRV2lk4dHlGKYA/06gE5rQzO9rHvS/2kSDDjC5uu3nmN0E356qH0+yhxp0vCwrBUHXM4E39u1vZ9rIv4QUuqbMOCBdgvh6e/TRM7GviM1tLvUUcKnechwQDpHriQ9rnxVFdMsG1OqGmbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5X+1I18; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5X+1I18"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso4850505e9.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 00:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776411290; cv=none;
        d=google.com; s=arc-20240605;
        b=TRo6Ae/nwkEHuhfUUvZndbRmb0LXDABA7/sfAbdF9VNlicih1N6VtsCX66wiRaP0ce
         EDOYm337UxT7dlu++6Iz90/0AjV7Oun5Ay0JZ+kWd9UTxc2nj+LbJ1qRI7L31Qq1ePRE
         w352uwGAVYc+DiGo307mnqMgIfZhvfTjteMHX4JQfNH4gEnRQqnTQlfLxWJXAE7MnA6m
         zTOZxUJnO5rTBAlQ5N553igdUvznmtlwRoSUnOlua81OkZu4D/soYe/NvSD2sF5QwpLw
         KZq5SiYDd/a0ncYOuvUVsWR9x42JUnQksEESeWY34xbE8N8yQy31W812XwePKjLElEGV
         QAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x3l4XNvjOw4u0UDeeZ1RDlU1MbBbtQ9ctu1Rse+ApZA=;
        fh=g0p1ndYCfyrv/nf/M8Ajq0kF3QDrl0I0PobA6yOYWxk=;
        b=VU5FZOfc928ziE1nQbQ+76oetUMyZWDj7GKPUAoY3Q/MKu04bMnlIH0grZR0cYtuem
         YELHq5qmtDke5pLSg0GPwtej72DSecfxB+U2b5CJdqu76EolRZe+f70d0dP5Lxm0fQMz
         VmUfE7Pf1ooivulknNLGHxjXTrOAy5eeRlRhr9QQkSAieQJfOyJ183+QpOL0JiIUwBh+
         8hJ5E7R/klACYFNYDnOtxshHJEpcBve43kAvXoFAYTYaNY4iE0rhMN4zk6sXg8Q4Q/ON
         +vVI6/cUW+fgGl2GL977X9cHTZrx2Gx6XUIc1nUGwIPc8WhpNGa3/n0ASVWd2Exz/lyC
         m0PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776411290; x=1777016090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3l4XNvjOw4u0UDeeZ1RDlU1MbBbtQ9ctu1Rse+ApZA=;
        b=N5X+1I18OMh55lqWwkJgK5N4u8HvWcCOKw9EnlvYJKjKjtY9/qt1xDTB7rJKxNsKVT
         01xHG/yOTUEMMhBqoea0C3Qxo1eJY6vTrQnjZ90oCq+QjREtYhUylxdTOAxImcZe02v2
         y1bBiUIAYXe06/yU1LlocjbwW9ywRY1o44S4R419O8Qc5D99Yy8RmbFhfbvH5ScYDKZt
         Er+EuJUNwJxN1iHitiNL52IdSpWlAWBlIivB3nbFQuM9pfJeDQezXiXC6e2cZuDrIjWn
         PTR/ZnHvmN9CrhVxdv91yMfd/qJwlEQM5xyrjiABLFfB+IX6M2e9E21K7z1XZABuAcKA
         E/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776411290; x=1777016090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3l4XNvjOw4u0UDeeZ1RDlU1MbBbtQ9ctu1Rse+ApZA=;
        b=HKRYgjcTbPDGOxSek917zuzAB2DQlWrKWc8Y+Mr8ILmf7y8pVHb37D3Fjv2UDvqzQ+
         5YsY1C5ljcs+A8TA96BLsLbooKzmhnWtKqH5+yJPDFlkBR3kre3EF/rgsjm14dANdGg1
         +73C3zln8K/om+2/wsFwoWYd6eEsIAROau2J2GoiK/Glm392n1Ima58xyHZYmrvfQ2Kz
         7Hc8xcfRQzLM6I5x4Gh0nI6CQF06WLB9lrE4cZJZB/Z4kdvFcbeONcRqlbOaeaWQ6MEQ
         OhyttvgdxwrvWrqTi+iLH9rJnILEC1zIpUTE5jFz1JD86nbxp0Ag5P+15wgCGYIYtwAS
         05yA==
X-Forwarded-Encrypted: i=1; AFNElJ+XUrwCpOPyW075cI2btoHsfFn/p4pwmYcyRz3VnyKK5DdwKDb+JR4LNUH8YtgCPy0p3jXbYWEY70U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxna6K8OiDa0bU6i3phOHt3pa+cGR9GuBRL9rFDH0NZF5o+UqMg
	nhTa2OCTptnd5NQEJE+W7jF5CP2yln9ooKeYp4FPtxv6h/6YoabTyExXGefaSn+En5Twb6p9VTy
	TfAY4Zj5/2FS3E0wM58wbOceLz0yA7eQ=
X-Gm-Gg: AeBDievJ2zfoqHL2+ZAgVA592pRoRHVHzUcBTXKNwjQsTl/eurSVL1UdnYFYibduIHr
	KshPXw1IOdkCOq9qxmxqpTW1/ANIgwCubUYgQ4uGb6xy0J+DxccLoTUYUdjyW5j7gBH1jPhR1B5
	bkcjiqDsnHfDjBKjyoRyd5AFuwtOUdPJ2EblI7pI0J2me+g5gIKBEAO7uhaz/zXvwi2+Ylzqpep
	lETkGyr/rn3Ws5UTKexs3gqZqgvYs8Pg0GnGzortnYCHNw2gPlS23IGJHesIFz9QVawYtS8SGVi
	4r+Q8HOb/mrbpBzHtYCFQQD6BQqRgBaOmVcQE4c9HFQbBra9Wt0m1KekkMyjS/BcO6ph+l3NJS8
	U+DV+Yeh6UHfocj1XOxgZJaYvKDWDEbv6T+c5+rsnhwxcJ+xsMFrjy8ZIUNiewmBPFdKsMXtjvI
	TmtwSASDvcgNc2kd7Q
X-Received: by 2002:a05:600d:13:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488fb7419c4mr17613455e9.8.1776411289757; Fri, 17 Apr 2026
 00:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416093240.1294-1-joshua.crofts1@gmail.com>
 <aeHXi8-zYZu-9NPr@ashevche-desk.local> <CALoEA-yhUTYzHUkOqAQ+nunUrH=DqzCzMS=hW5ZxO5M46ETa8Q@mail.gmail.com>
 <aeHgqpuSOxgqP6hK@ashevche-desk.local>
In-Reply-To: <aeHgqpuSOxgqP6hK@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 09:34:38 +0200
X-Gm-Features: AQROBzAZEowh8tkjWrzaYKJaPx5c-nm3OzhOrCpN_fpFRpku-iFB9z5uZv5Jfko
Message-ID: <CALoEA-yWpZa88nTRsTCVnaNFL9w8+pq53xKY7Nh+jLgEWZYTdQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: frequency: ad9834: clean up includes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 09:26, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Yes, that's why one still needs to understand more about headers in the Linux
> kernel to do such a "simple" change.

Yup, it's definitely a task that seems easy on the surface level (but
isn't). Also the concept of
kernel.h is truly a fun one.

> Oh, surprise surprise :-), thanks for pointing this out!

No problem, surprisingly one of the things that IWYU got right.

-- 
Kind regards

CJD
