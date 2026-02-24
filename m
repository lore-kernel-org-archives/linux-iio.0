Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A1372B4A
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926957; cv=none; b=LzA3YtJEUzx5U/oW4hIRrlwmCd3/M5C7PhjkeuMmlnuucz2K92VtzcPtEF3X26JuoLmpxfYisRxe59tDXtM9oikZDESIl95+Tlhu75qIpq05sdwO3WPaQNceBy4a1DfsuejgPvYJ166xVcQr1H7KysGEllZijecuzrYBqLB4Bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926957; c=relaxed/simple;
	bh=mcrEMUpYLgDS4cmTytWnfnIPapSnrFXw3k3VZxS42zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlN5fYYQhpOs55u92nuqsp457obypzTK5S5J3Sue8L4vis6IyfmKL7/XCZSM4e6TOqcNPNNEF73BIJVHrUnISmpRD/590C2OnfWx2b8t8gzddQaVipEbSyK4hYYa/Z5ZTX/cV0SqkE8+4vPQhumllxSWTs60XOXcfQgR0ZctmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCoT1fX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCoT1fX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DFFC19424
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926957;
	bh=mcrEMUpYLgDS4cmTytWnfnIPapSnrFXw3k3VZxS42zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pCoT1fX7JEGUJwXIzfqbFfk2Ov/9P7TDKV8xstiZexIiyjkx3zLwQNCTlsBeWfWdl
	 /tFSxoUmf7x4lvWasyB8rPBy4UmguJWoizn3owE+9ZYRdxFebs0DYBjcv6UIBoNk1q
	 EV2BH6+8RVWJREM9tOTdAgfZu9OsvrHGKN183lFuachNphi7zFnsPZQJVDA3xO/3dg
	 NKmtMvB5S4CDJ+5GpCShreLnD2PEXCpmJsHb4+ScABnv2KGhM4QtQSiEZJ9VTwR5vg
	 I9JHJghG3FoT2/RO1Ug39kYKLpyclkupOkdsZbjXs7phxB7WEtpjsrQzQYTcEEcxp2
	 qH8Ae+1qXU4Cg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79853c0f5b9so10941727b3.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 01:55:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOF9sUWOeytNDgUdFpYf5GQEvT8SNRi4TUOPRP2uxRgqkUBX0MSR8XQmZl1Z5BBZJD2aczRyYbQBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwyikWE0iK/bLlkVlFFRiEGS1KpFeUhDUatN0vvHgctHQN087
	i6AkMKk94kgP/IHluaTOn4tR/pg1LxVCmJLEdKAxbMlpfmmPUEL8LMaqnRcw9ViIu+u4R6CjEJq
	XYDsLrRofHoXQgm/C3Bm409lttVSJ+Xw=
X-Received: by 2002:a05:690c:62c1:b0:794:fdb8:e131 with SMTP id
 00721157ae682-79828cd8debmr106540387b3.4.1771926956365; Tue, 24 Feb 2026
 01:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023511.274038-1-ethantidmore06@gmail.com> <20260224023511.274038-2-ethantidmore06@gmail.com>
In-Reply-To: <20260224023511.274038-2-ethantidmore06@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 10:55:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLnEc4+gGcnZ0_SUhHyv_=ugzgD+iWQeWT4rAjyfSRJePg@mail.gmail.com>
X-Gm-Features: AaiRm51ImkdzPvhhcUGJ5EBHR_OLW0qjf6-YhGIiJhZ_zsjCG0Gz0aIEwUxnB1E
Message-ID: <CAD++jLnEc4+gGcnZ0_SUhHyv_=ugzgD+iWQeWT4rAjyfSRJePg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: gyro: mpu3050: Fix incorrect free_irq() variable
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:35=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:

> The handler for the IRQ part of this driver is mpu3050->trig but,
> in the teardown free_irq() is called with handler mpu3050:
>
>         ret =3D request_threaded_irq(irq,
>                                    mpu3050_irq_handler,
>                                    mpu3050_irq_thread,
>                                    irq_trig,
>                                    mpu3050->trig->name,
>                                    mpu3050->trig);
>
> ...
>
> void mpu3050_common_remove(struct device *dev)
> {
>
> ...
>
>         if (mpu3050->irq)
>                 free_irq(mpu3050->irq, mpu3050);
>         iio_device_unregister(indio_dev);
>         mpu3050_power_down(mpu3050);
> }
>
> Use correct IRQ handler when calling free_irq().
>
> Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
