Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3619005E
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078087; cv=none; b=iooxcXFRW2UBShslTYAihoF3013EBtg2BPCvYISJLMZBJy1wT1W+BAwwNPXJTl9dHwqlGkFIBd62Thk1escNvb2dvn48on0AA4CCIClqYn1040r02EbM2dmrZug1cITC6cgC+Md+UKbyfo5OLuv2Bgnt7GdIUdUkdjAn+heyDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078087; c=relaxed/simple;
	bh=jqvJXerUPglWYMAGruz69G1Jp0kiMqpsh3y5LX/Qe6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryWDc9f5jVFF1NmW2OER/ayuxEzhc8tmffn5liqp9D3n9O7K9xBogTjbunXtw+/r+vFHwNLrM0rxGJCE0QEMrRouWI+OqhW6WZ/7/1GO28V34We6+hZEvRBYTcSRyM+G5uuJuTu1D0dMf2sf2DYmzlwDMRWHHuUhzK+xJIFDsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkjuqCuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkjuqCuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3701C19421
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770078086;
	bh=jqvJXerUPglWYMAGruz69G1Jp0kiMqpsh3y5LX/Qe6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FkjuqCujLcVS2ILx9tAHFqgqtaPjIuMJoXwctoGWiVerIbX8p6gn607zu4zqzucqG
	 n0wmLzAei4Op48zgQ+FpypeGVX40eC+Y1QYwqvmh2lQBysXpxCRXBv6Dq4mQUU3NQk
	 bMgQo3+3nXZkGZ8dTaTgQLvdzVYyPIsGLascZ3QFtgQ1Bho/Agp4mjSTR1dH5p3568
	 gj67dZVop050SXBIrgjgIOm/M72uUlQvYc+M/jAaktADJbCvlqexqskH12Y3Ukg1oj
	 6JZnYwJ6rkpNhn0i58liUhh0BU0LD/gHe699HHknMmrN+iYJ1qbBNEZf7L82Mp85Z8
	 E8yxpA9IU+R5A==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79088484065so46797507b3.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 16:21:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD0bTm/ikj9WJbHO0dvuxrETHRGea0iROcfOj8iwyqcGjGpzue2GpijjOclQrfZvJTDxCwdT9u2qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkpjhNWhTwyPdIBuxDcmoK9WsWmgrV3/Jdmp/EXHay6ZuUqwb
	i1O5sH5BBx7fksEOte4HZ35L+3uYhQOlg+JHzSG3npLpTeITwdptvftUGXxo6nGg1gb9nAWfI2C
	/XHTPOsqYT5/10ZUZ7bNON4rxJ6gp5w0=
X-Received: by 2002:a05:690c:690d:b0:794:e463:d090 with SMTP id
 00721157ae682-794e463db11mr60125587b3.58.1770078085989; Mon, 02 Feb 2026
 16:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130153227.213413-1-antoniu.miclaus@analog.com> <20260130153227.213413-2-antoniu.miclaus@analog.com>
In-Reply-To: <20260130153227.213413-2-antoniu.miclaus@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 01:21:15 +0100
X-Gmail-Original-Message-ID: <CAD++jL=+bbuLs=xWS_PmwyLkLy3CoW=PYJKb=0QiY3mPxpQWGw@mail.gmail.com>
X-Gm-Features: AZwV_QhJtdulCiCzU2uYlFi8R20mOlGiUuzBRMnLB5bSaS3jVGsRM9dUU-Cr-zU
Message-ID: <CAD++jL=+bbuLs=xWS_PmwyLkLy3CoW=PYJKb=0QiY3mPxpQWGw@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050-core: use pm_runtime_resume_and_get()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:34=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:

> Use pm_runtime_resume_and_get() in mpu3050_read_raw() and
> mpu3050_buffer_preenable(), adding proper error handling. In
> preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
> fails since postdisable won't be called on preenable failure.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
