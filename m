Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054330EF64
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659314; cv=pass; b=phWu7mvdtZjiwtF1arM1zmyBgJ8eUOFdZ48J6q/kZZexqEw9BcuNK7PSURkyfI6oRN1lHigUaalZLgrJBEweEVs56KoAdNIfTRH+puPTITGuq5N9eiZdVQJJJ6kYB1f6Llmeqd+/6zicKpV0JFyzjuh6fTb0krcx0Eaz6NKX1io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659314; c=relaxed/simple;
	bh=sYBvbEBkIwOd/cFJ0ohVVGXSfAs5HefbazkwELQiJEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYnHej7bRxkdauKYaUKeYeZO6E4yciuCUsX8Chze/HRzT8e6i50VE3AbSCabsEtZ3kiqDgVdawODG0t8ARN1yI4DV2ySl771RP2Gck7pPNQZPMA1kbnjbrDjSjbSX8R1zCe0s53tyZ2IYsX/oYU15NHZ1cPB3zX4PEvn9CrW2A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOHOFVat; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOHOFVat"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba60d78aff3so317181066b.2
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659311; cv=none;
        d=google.com; s=arc-20240605;
        b=asxJPSIeuWqysKwDtPW5hgTHmrhf1A8Y2pwznRCQp7mreWxP1LNiziuitLE4V+UOW2
         K2Usa8GfTtWMEQLqdZzZqamEubewnBxey+/X/d721DUerbq3AUrmeablBvmgz6WyVaxA
         7NSOAuItuc5pyNQIQvhZDNglsGJpyT1zx5YOHsTBdyclfjJH1iQ8PCnWHbpiYms008rc
         YQd9CN1lrrLYy/CTyPsL/Q2/geULvmpQf74jSSNuvawPG1faVy8rUg2U01bJ0oZXTGML
         dTK9OJ1oZG1EQ/18DNzru3Gee4a7DJ6NC+K059A3uMT8ILF8Kfw1saWi4x8Qqq5dAkHR
         qjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYBvbEBkIwOd/cFJ0ohVVGXSfAs5HefbazkwELQiJEc=;
        fh=8cLAZPsPDDuvmB1790DtV3H3JqrcNn0f/goPaftwCbk=;
        b=ALWZ14t/HYstVTvJEikg4HEM/nTph5sBbUFsB+9TRX07uoeswsSSFj3dsEj9K5G3UW
         LybSQMK8E+8b3Z9k6WhdIxGxE9FEw8kAUHOSJvNy+7OwSZwaFF0QSqi3DoXbJcZhhizU
         R1AGmCS5IZOreEnJHCtSev6emML69ft9zRAbvkWrM9fjaSxOu4eeJzR0yw1B+IMNoKDm
         e7UNrJpf5cz3fguYHVg/io73EArF1TocQvJxbK1wK/xfWUcmzFb1dFrgk4PMiCOvnlkO
         xmmVESTQ/Q0Ss7bQ3pQsw9JjEUsTC55IgQuwdFZunotPkG+cgqUR8UbloRpjzEJdggrG
         6NRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659311; x=1778264111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYBvbEBkIwOd/cFJ0ohVVGXSfAs5HefbazkwELQiJEc=;
        b=hOHOFVat01IegXVxXgX302VvSQcjz78LttB3Fcv4iml5duAGYg1oOaJg7Jpk4rRJhm
         TM0QUzoZ2UdK2zt9tE9elbS1piYXM2cy1xQmmMpktJLs2zYbMEYYYCpLlA6HxLLwin+A
         JBLgkCbjg/eSB60E0mqkRMGHEScZiDkRK3oWMImeIWd779mzvMnMpXQvclXXUcArrh/k
         7uOilGkt4nChg7oYemt4MRSCE5JwyHnRHL4JBLvm6Ihh1F14XFjdtnqAPzxWRo12wMr2
         1ve6HyBh/hFW1PzTz/Ncwi/id3BjzdNL0zvDssf6CF8oVhDe7UzhHYIysLEx7FvJsWJ0
         8Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659311; x=1778264111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYBvbEBkIwOd/cFJ0ohVVGXSfAs5HefbazkwELQiJEc=;
        b=Y1yqHudc2qWTddCN1FJQgMOQ+Qk/T5nJ0UwhOVz4Mk0kUzVMyMR+hDm6+/vwHOW/bg
         93hdqjh7G5nQ9tFh9KaEY0wTlPAR6oMHviDAWcIm60PcpqbNPF95CqgGm2hTAWXAKKBr
         mdRqtH7gR5rIbJYD0ssXwBYJ+dbFF2YiKU6oiDAUq489iMUi46ac0gefi+pNW+wOnVve
         4MjSYK4TqBlqH3rAF5ww481PwdBRzQSnat9kz2kSQua0eaLi7LCQ4OXBHEaiYJuw9QMn
         fKBQFQTkBu7pYcRQAQSHrutyneavfUpZ3QbTitLjUwItEw6MJV4eXjArj9tAWnKP0mPd
         icRA==
X-Forwarded-Encrypted: i=1; AFNElJ8hOIRMJacqXVUUG/Ffu/aUaR2oskRX9G6GOa5QKYgrdEB2CglYhdB9Ali5KnJ7HYJHd2N6mYB8Us0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnZIDuN8MtTTs8I8FCtTle0HJUBBfcp/O0aUpYzAW4A6IeJTY
	vtb5pLG1pG/7crYe9PCla1gSy1gWVkJ1I3lCNO5PYkHyKSaeCe3EyTX4nBZ/aHmhDT8Ge9gROre
	wiRHFyC9JjdWEbsdem9L5BDb07z65wEs=
X-Gm-Gg: AeBDievv5NR5v64FeeF2SrNtxF8n8IlYiVZ1OspYJBmdNUdBgfpdXjCr3RAjfmaSoY0
	0aX3bB93xMS5wll0Mc5IQF1H6w/syNO2GHTGMwINq4oioLdPpLqDHv5SzcxPn1JyLBQQ1GeiOVx
	QrGPMMC6dbrRiJZD1+fN+LAz+OAc8WkFQASOWTIBgKjt/4L3iH/16gU+DR/wHeS3f23Xv+7A6bq
	fVdiJw/Z1+VHdXChsaWWe06eR8KjKwxcJlwYVQZYNJFXlzMK9kDXVzkwZxehRH/nJG1jj/31/wi
	cQO4w1PJhV+gNVV0DZpsgEfHfQLHKWDzVkWLaKHum/IuHuALWy39DsziGM2KhBpeGw36PXOFK7A
	35QlaNiZO0G6NVwnbvVOGZUE3m2yR
X-Received: by 2002:a17:907:9455:b0:b9c:9594:e00 with SMTP id
 a640c23a62f3a-bbff9e28c78mr9418366b.1.1777659310903; Fri, 01 May 2026
 11:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
In-Reply-To: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:14:34 +0300
X-Gm-Features: AVHnY4LCc36T3N5B5vZiNS2wYA2CpaSqVSp4vMDfMYcHS_mtG1ToxwyXioi4pSE
Message-ID: <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:05=E2=80=AFPM Guilherme Dias
<guilhermeabreu200105@usp.br> wrote:
>
> Use guard(mutex) to automatically release the lock on scope exit,
> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
