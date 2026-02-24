Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81036606E
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927018; cv=none; b=nWFNZVKDuTy0VlTdcdsbuzOuAg5SwIGb9w0S7BP98Hbk5TM8jvK6wS6ZxAPhBi75ZJ19FpNfQFgu3Mwb8Y2mK2vW1TSXBUPas0mP/4y4gNinKqFfh1eJL9wh+M1OL2JrVugKgkqNvWvb7nArqEpV+sFGP7fRKJxuMFM8LnCGmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927018; c=relaxed/simple;
	bh=v88Uh4gTF7Y/QElrcqCZkRk3SczVAmb+bWUEBl/GCaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZFXcgWBhPNu6F1Md3B+Jpnd34Yff0hVKRQy+jNtrwGJ+PXM/N9gY0C7+yjGTwhNZHgRUpIOkTJowZl44d2sCF4QDqS01iGxIZWfhuEzcIhXVJ88oihqU8H7NNQV8a/YPB1aDNe72Oh/hje0Pf/Hk9SP6yOE/dVvIDfFE8e7XYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpH9rb2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpH9rb2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF3C4AF09
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927017;
	bh=v88Uh4gTF7Y/QElrcqCZkRk3SczVAmb+bWUEBl/GCaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BpH9rb2GLXyVQJNeTVePNTNMV+TTAANKNAeaX9qjKDau4OV8m/CuxYrs3S+irUdfh
	 rtpy2UaoyAkmdvzHX8G3Tbn/uc+l9UpY3+xkd7aXUY9yJC73SjlcLRMi+5SV9kopbM
	 MugcAFu3dNIL+6LLJQHbdC6CAE7cqkAccX0prnGg1Vxy5RdHyc/SMsXvAmAWJ0+zSH
	 WWCDpF9Gl7WmDyXLhTnyFA0d9i9IlvORqbaNupEwRLDFll3XxlzNu4nmf72IoYIyvk
	 tQENK0jir0RMrkM51388PqswAZ4baHQD1VLP+bZcBbwT/xc9wbmEiJQHFpbSgFcaQm
	 KIC1hV5C0hbQg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794719afcd4so54445927b3.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 01:56:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8IVdZiGpsfTH1C8v75VUPrsJCzttgnI2VVidJ5QW8phfys6umjbNgzpL5iy0hePcbKX/wpthZGBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RpAb2/Fco4b1Tj+yzdIw43hyTPLexRDN+KeK85U2MKQbNpiU
	2edqjtWYFtrHPsstxRVLOT1YUMYNK5AA9sF4gWG8AIIAsj0OCJ9la3M7dZbByqyXtw4ugA957Np
	h2Y4pXm1NOjimBEfYlHH9WSaPC9AyOiQ=
X-Received: by 2002:a05:690c:c0b:b0:796:6efa:fdac with SMTP id
 00721157ae682-79828f3dc48mr122898697b3.27.1771927017031; Tue, 24 Feb 2026
 01:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023511.274038-1-ethantidmore06@gmail.com> <20260224023511.274038-4-ethantidmore06@gmail.com>
In-Reply-To: <20260224023511.274038-4-ethantidmore06@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 10:56:44 +0100
X-Gmail-Original-Message-ID: <CAD++jLmJy=QHBd4aPJOsxD5kgiY4vS1dZFDi2y=_+ANcqmr5zA@mail.gmail.com>
X-Gm-Features: AaiRm53kIZUKvTgwT-NlsRS2ZYA5A9oAdzvNfyFmuordH0Gis3AMax2-ZM2VuW0
Message-ID: <CAD++jLmJy=QHBd4aPJOsxD5kgiY4vS1dZFDi2y=_+ANcqmr5zA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: gyro: mpu3050: Move iio_device_register() to
 correct location
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:35=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:

> iio_device_register() should be at the end of the probe function to
> prevent race conditions.
>
> Place iio_device_register() at end of probe function and place
> iio_device_unregister() accordingly.
>
> Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
