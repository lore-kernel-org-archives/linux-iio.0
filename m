Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E839EF01
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495143; cv=pass; b=l1rRwQwBhAOrn4n03S+Ih9HtLYbqNsl9ZJuJwYhz9JPgHfLOWpIgW56LU4Elorzr5IXzQW3seUBcfSfu+TW4B7NQtXQBoA9U+BfvIEyR2+/oY6jS2VRETmNUmIABSYn0z6T6qjjRF57AMn+hwJnY+1lAeJFWL8GeIG2nv2gKGFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495143; c=relaxed/simple;
	bh=tOQgNb6dvZmK9HwTpb9f2rDWmTYx+OT5yimfI5U4CQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrBmrmrCHCpuqdMCQIQ0cQV4CiCSC0HtWK1KZ37+wUmT+DSj2mllWcx0P/CSWZDRScv0n7suzU1TX1g2YtJlCVgPkN7GBgSv3eo3AW0Fih1BktVe5kwYUk3Y/pemhcHUL1dVbFCnnPhNrU91d+AMGK/ZbtglAPFxZ3c6ywXTgxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keQF5P2L; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keQF5P2L"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b23713eac9so2244597b3.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777495141; cv=none;
        d=google.com; s=arc-20240605;
        b=UYgvE4x1S7YzAId+BHn+j6tqX2BA/eXL56cyJP8yvo/me45KHcXq1tlVBCsNFkzUkx
         DdBYH1OmjrR1WGXg+dHaJtcj/Y06X9+0DANHEoIqHa//btjO1uXjQwOa5FzDWR65hRY9
         2PG5ACVio9UbJkgn5+wC8tUp3h0zBYtjhhV0CxkMaoTavfJQB5I9YXF2H0x/2WiRPfEF
         8QGS6jprshaQ3koZOMbkY90GK5qzH/wcDdw8r9RHrfqPxJGToZj46YC86kVIBUwyE3Fk
         IRs8N5p/ga7tfFb8MkR8BPBpuKbf1OeElGQufrYbj5MHsmIwvaU4Ty9MUWKDtmI+3kPY
         L5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOQgNb6dvZmK9HwTpb9f2rDWmTYx+OT5yimfI5U4CQo=;
        fh=EQQE3wMbWxcrXGzIFMI3LUHkYT08QQSMBfSMhz89HEU=;
        b=Gx6deQmSW8mKZwDXZ+Cnr+HrNq1u3ZYtpDqvc8i2RHXHAkx+/m/70Oi23/3jnjxZ9c
         g/QrFsGBzb2M9SkcjkDBpE4e8KBL9QKuByaRmMEGKxATIPazs1GswGE4U1Ac+FjpaHTj
         k1jgaqap+MTxi4Q2qRipO74FIIS/S39Li1ZJCPCJIYAPg+0ZQVFEnNkZ8fe8YIXiN6g6
         t+9COccRmPsGQX7KNkQjx+egWf638XWWTF6DN50Xjh59ewCSKte30O9p8pKnlRVv7NPo
         7Qu+A/jSuuFjrOQKoXTReB69l6IRvAHD4izuSNpRMiiwF6qsjJZsETRyazZCf4napLbb
         9K/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777495141; x=1778099941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOQgNb6dvZmK9HwTpb9f2rDWmTYx+OT5yimfI5U4CQo=;
        b=keQF5P2LXOJDBFLxDyRgitM/eHMB1XyBsTX2n6E2xZ3Obb6JCdGQeYHbqI7idenJOL
         kA1pPWe950cPMwOhlfrVj/A1BK0An7cl3f0FBnlxENORYW9p9zc2YzmzU5n/MSlIrf7t
         tQ1lffBV35AnJSUs903u8RzjEbFAlHJfKUub4WZlcIMbWi5saz6sAP4LI8I1iceb7L29
         Alw6LD3lr1bZIrdgrSK+Hpby26bOMzVEvP7ElCsbiuCOBtKQ+4mdjQAr2TjmwA6nP5kW
         nY6TSFUbtIgHMUZJAXuotDiMPRhbGz5XnYitGKe8wV2AVRL4EM79wVcJJMkhD1qtD4qC
         y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495141; x=1778099941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOQgNb6dvZmK9HwTpb9f2rDWmTYx+OT5yimfI5U4CQo=;
        b=d6OWnalcm94NyPuL426PXUbzRwdFdxoEuvsnziHftzP02FfgdbM1s2TCGR3+ClRqbq
         zSAppOPMMXEn8Yyu39ffW01oS4chOcYaFNmujPfHzbYU0VYDJaiRi4okm9gBucKB9ged
         b3SSZobQMa5yDfQs8Y0e25YIewGbKG0sBqhNtwMqQBU+Mp2yKraTQqC1Dag4uCwVgYQm
         NGCnH9uWRK2aUhbdLJX3fafqJXBESio6JrwLUS14tRk0EpvKOyFM8JF3NdwSt468C+Zv
         eveuyQpAcY95gXVWAvVHgS2fyFs+/2uMwxb6pzBe8zrk+Y3q46wlWlCj0BTcy112Unxn
         BHcw==
X-Forwarded-Encrypted: i=1; AFNElJ9CSCeRbdvY0l//qwZjifyM4YrcdXpmRNgs5+kahBU+h1H5pIg7Kt+G2qfQxHLfWL3HKiYvQBU2Mow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoSGg0HYJegGI+pfkjWtbLJwULSe+Q7JASUHpWezb4HtezVJA
	QudStihWFD/ZS5mG5UQdH73jdnj54t8gEvTZwB51crJ8EebKUoYOPd5cGnjqSj6gNhgH6YkY7ui
	i/DQjCXz5xczrwP+sz/X5ZE4KcHjTaCU=
X-Gm-Gg: AeBDiesd86h/S73DnZ7Zro+FlVyKg8NuWdTyIt9kiJ4Acmu4aYCnYDz5s9pItwdEjsS
	PBpWjAIbw4voMydY2uvnTLP6DVBbbzuzy6g3r11cw15xeb6JCR4W05n8i96goPirFVdeDE/3WG+
	wbyvAnyr/9jVHBgxLZj4MWDWGRxvILjm8A21jEG2/RCunBIOUEt71SsW35z/RMwkeW4HN3srkBE
	PPLRJ7GHzdC4kyn4hgNKDs1UZLkxWPQ38ITNJtp5NBHOcLoNEQx1IMFGKpjBQBkux8gBcw4dNHA
	zhAjRgD9gH9RRgNIwhfiaRkLrKJc6EVMJrWkXnPu3wUcsjZXJKDe
X-Received: by 2002:a05:690c:e3c2:b0:7b4:e6dd:e9e0 with SMTP id
 00721157ae682-7bd52951e64mr3458777b3.26.1777495141302; Wed, 29 Apr 2026
 13:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428222600.91322-1-m32285159@gmail.com> <20260429114154.290e588d@jic23-huawei>
 <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com>
 <afJNRnuQGnnQPA4w@ashevche-desk.local> <CAKqfh0EF-uBdsyS0K5E8=t0YB-LQ9DvNALmKPWBTVczM7OXBUg@mail.gmail.com>
 <afJYHTv7Sz4hJLNa@ashevche-desk.local>
In-Reply-To: <afJYHTv7Sz4hJLNa@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 15:38:50 -0500
X-Gm-Features: AVHnY4KnYKo9CkvTf1S8Ubx0g-2fzU2vsm-yEoraGbdusyk0zoFgJzlJe9kg8fI
Message-ID: <CAKqfh0GaFR-CPXYBwRDpCoxrHjWZqJyjdTegh34ZsTajT-b51w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, songqiang1304521@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 2:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Still the locking wrapper that takes function as a parameter doesn't smel=
l good
> to me. The reason is the same, hiding important details of critical secti=
on,
> decreases readability. Also long term maintenance might suffer if one nee=
ds to
> alter that piece of code.
>

Good point.

best regards,
maxwell






> --
> With Best Regards,
> Andy Shevchenko
>
>
