Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D2425CE1
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575249; cv=pass; b=P8x7zjxkLnQpo2xsZMMeDtd3022UFv6YQh3jZtP7h7j+NkvkRDaOZ/yLi5tEbyKCXt9W35iiCttgN6V16LAsCJnpOB/W5sC2sJqCdFqPGtVi2lXWm4DhY3j8/qOa8BysRw/Mnp+kCcs/9TppifEbe0cjy4OicxoZ27VibDBin4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575249; c=relaxed/simple;
	bh=hVAGzyHSt5KhlybpXWwaDZg5zPRQ2ygUdYah+Ynq7Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXrzdjlMNTaCxK+69CZCJBrSWTnkcDjIhZZv6jQZnGs2xxnZMQvWC6SJYd5xRHCm2wCUkJdNetVjeIdgAw6vsVAdDK4larkF8Vysmm4gRE44LEprEN7WcD9ASveW248unHHvQbOxfH8ZcTP8J8RN++BRdUPb9GlgjWargeb7rJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+Vx0i5Y; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Vx0i5Y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490af320e2aso7798885e9.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 05:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780575247; cv=none;
        d=google.com; s=arc-20240605;
        b=bLYukmufCE8491z21kY5bLE6Av9aMoDuz5zElc9rk+bXOAMi/j7mldSlnM5zpVcuew
         By3JULNV08RHkQzoRxxaKgPy1zMeAfjThP8h0Cr8hlGS1EPP+YzngKU5jHU43eu0KaYd
         MxONL9nSydW3/EN7sOpAE+eyxb7heOeoCy+bMMNMa8qPhCtcIpgPQ3bR1/51p2m3fy10
         ErC9gvpOEPOLVqdF2aZ0KztEZo83ZAlQ31NDhLqGRNTpL1WdLiuSHBoUEPIySkSNe0ZJ
         VqBnZi8erPv73pPXR+T/o3SMYaagBNMKw+p7q3AUOCaYeqa8QD0Q8od86XMSKRJ8T01a
         u02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVAGzyHSt5KhlybpXWwaDZg5zPRQ2ygUdYah+Ynq7Hg=;
        fh=qupqY2qiH4N3Q8o02XoGGX4kiZ8lDiJgA0LpGZ852gc=;
        b=E8XveoZgwHKw40gAWaV3eXMmg2vSTnD16i7fb0lGG874UpIR4Tm/Wdn4oj5aHX6zYo
         josYaI52EsA9mvr0RWoTz7gPvMDIZPoqcEDK4Y5b0DGwmWwLk9p17Tk4XcqxuAasqMdy
         nAeQA6cCNsjtK6aVCwCw8pfm/lsAtgFXirQAxbLwPatD/2tQYZ5pw2pfHskSB/SJXs28
         lDV/XYiGGmIR/lStKoUhkFG5ahMuHP1ZF7TQUFzLk22JIg17rYmxnIsrzGVyiumRDeeN
         Df+EW5ZwUb8f2Au33KY8YVWq+P6He8iuZ5ZbVTtE7ZokArxCItkra3EFFwt/fgvkMQp+
         38Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780575247; x=1781180047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVAGzyHSt5KhlybpXWwaDZg5zPRQ2ygUdYah+Ynq7Hg=;
        b=R+Vx0i5YHjNtpZiucDBeLCI01YEUU/RwGZIxuFpfoRm3FFU0SfPV8oiott9oQN5tgj
         d7K5YOI07aTSgaq2vX4Mb+3PdGndtNy4be11G+sewutUfjIP2y0FEnYkQQtaCXzyK88S
         L7pWFGdCaBnfZyfDvtqG/Akfl39CnkHCuuRwdIfmXghUFD8MsgviUsxHDOXRPKq8tIM9
         XMCxoo9SO4dWGQgB1woq/Ige1S2LYMMQz4pk0pfJJp/3khbP6fUxsS4E3kKzO7YQYvqn
         oYo4DGvEhJvv0cgVm+MwH+aIaWX/3OPfqoX5XQ6cOtUnKNI7Q5QM6BO7DjKA/YtJEJFH
         +NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575247; x=1781180047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hVAGzyHSt5KhlybpXWwaDZg5zPRQ2ygUdYah+Ynq7Hg=;
        b=NeT3XY+qFyisZZm+LkoD4fwL5xYJqy7bQBFHRl5RSZOB7ecL9LUzTkMOvyKiBU4AxR
         cDUJbiakdzx6rXRA7T2rIelrVEANhR452toLyp8P+lzcbRPTn6VE7I9rcb+uqIyQebyt
         ST4WdB9gu2LDTLF8zCDYsQWqczre5SIhWWr9esWbgFaRN4vjUrHPJASlzwj4Jr+Epx7A
         PUFTULSjCxtJzQzXifoWyxQP6gxkpTAcIkTvd/66HSqKjbfhBWCCZ+9Hc0CebT0l7MYW
         5GudQZ8WRjLXp6ZBqYgewqTKFhDTKXtUKhDAotJVxb5Hc2yz/edALrWliPyeNMXe5DMl
         vrdA==
X-Gm-Message-State: AOJu0YxtxsrLkzrQPvuX+N3bPDaglTw8pNuYm3SQvUz1IW8lVl08uFMf
	ma7K77fRxgELditBPXrgcnDR6K4o1eFsTzwofQEKOY1WJ9zH6YLEDBuL2tK3OeuqxMd3i/t+IvO
	mjcHMMZ+ofC67ts3YM0X8DNAapnlW+MY=
X-Gm-Gg: Acq92OGC8nqHgWQjSg+K6wzKDzEUh+cwyj99cpglyjpKZATOowBsm6UXfxv50Ys4wNM
	18JaKiiYwVYyuqG6QjpiHkYD4USODn1ljUoDFUrTUcnTQXkj648UTxcArBLZKpN7c12I595rTNY
	rJWllf93Mm21RZjMhhQheN7DURUJjAHTpZDFJ/o1H1zTucLTjIotqoeDoNqdY1VVkvFVdWskhrW
	Qp/W2c8URuMgnsyEsLGBZU//HvuN4Aym8gXcZge5f2bUoZD1IQ48IIhU7556P4/88/YJ9QYDUuT
	sMN6dxEvA1qTZZ9+JTeI0UvFT03sx32QSjdPHRQWBABFCPzuVMV+K+Iq4iueh0AqGfkrYDYtRRw
	w7Ma1jJWhUw30GM96lEva3X/MDqkF80Ia/pB9O2U+uwCYdH19jdF8Cm8cAFKf/fQ8K0K+klNezS
	XcztkM9+7sOv7Jsh5P2/WOKPz4t6U=
X-Received: by 2002:a05:600c:1f83:b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-490b60de2e9mr131328315e9.31.1780575246692; Thu, 04 Jun 2026
 05:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604120201.116925-1-vo.kratky@seznam.cz> <20260604120201.116925-2-vo.kratky@seznam.cz>
In-Reply-To: <20260604120201.116925-2-vo.kratky@seznam.cz>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 14:13:56 +0200
X-Gm-Features: AVVi8CfJLFKPcrrPyV8IISD1sl7MvoQAa11R430J4pCOm9Mhj4Pc3ab6MtZ810o
Message-ID: <CALoEA-zSroEAxiN1L81+JERksLC2Oba=u9ya6j4--gcwpn6m0w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] iio: accel: change from %ld to %pe for PTR_ERR() printing
To: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lucas Stankus <lucas.p.stankus@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 at 14:11, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@sezna=
m.cz> wrote:
>
> Replace numeric PTR_ERR() logging with the %pe format specifier
> so that error values are printed in a more readable form.
>
> This change was identified using a Coccinelle semantic patch.
>
> No functional change intended.
>
> Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
> ---

Thanks for the change, but in the future, please slow down! Let the current
version sit for at least 24 hours before sending a new version so that
everyone has an opportunity to review it.

--=20
Kind regards

CJD
