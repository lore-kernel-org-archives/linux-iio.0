Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766137417C
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927035; cv=none; b=Si93Er4lfQl0oXwNBqaw8w5BDpx1WfxO+tDVRAjWuk62H8S4fbIkwAm8VAHtgpqMfjFqQVA/K26OLlmF/bNyOAYEneMX+OYWVhuzdEmMg5lFu0SjB0L/7psbDal7k9UJ9NwO6SNWzf3KQ6WYG97b78YZR9/bwlSKhXOU5jvQNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927035; c=relaxed/simple;
	bh=UFZkqG+vdF7K+/lJOuL/h1xxWWbEWxx4t2yrjugjwlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRpdpX5ERargi6eSrtw4MkKM/PgDAJbzrSaYzmfopo1TCKu2FjBzUlCZ2tgCbY6zSZ5jrP+CId5n+lP7Of7dum++r9Ex40Vxj5XKToNvD/aS9z35Huz3N2jsosZKqNdRpZjSCcf9vmrYepLF5jCToiLIBGkSXGZfscUGf1qtdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+8AbZzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+8AbZzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF750C116D0
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927034;
	bh=UFZkqG+vdF7K+/lJOuL/h1xxWWbEWxx4t2yrjugjwlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o+8AbZzNfti66CNnkIu7IoSIhjDnNFigYcbuIlvV3wn2OHQRoGQZLQ/2xhkGCo0cS
	 NB1WGrSGs+9dtLkI4sUIx9nIp8BBF6QQsHwXZjI9EJcoeIEYARRU0sZhyCTMEpAHxv
	 R65Sp/nzXrSc61yf5Gbd0JL85Tn8+9qyS1t3q1PAKjs8fX+ZZMhMyVbRGRx/gDFAg7
	 xIP1tJZ39DZrO4pT6faVp+8T9WBSihkAwFbPG+e2C2O8KSSUdBhup75x61nhWdTBIl
	 0hiKMHKEYpQsRaoKM+6yaspu4CnqXRMtMPEIalKlo7p6PdnTP4wpzVFGhDWj5o0RuT
	 uA9rjKMSHu/Uw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7964f1405a0so53085687b3.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 01:57:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4JLTmxJ6GcgKga3vlwfd4WlADMgZ2c9FYmOT+rdsM8/8eHHMdzUEXy3ZueRZz9z90LOtYQvRXBWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qvZ5GiMuFbEAX50P/D/RWHHNC1mIPP/s+gIl9N+Hwmc66ATE
	kh3uP6F8SxKaMp1LJ+stqvNyS8T3zP92SSQU41il3/GRREr7NO5GI4cG2wAsYgdRxTVHa0BavVr
	of+UMXuTxbtM5iJvuti9/H+0UGI+yF1k=
X-Received: by 2002:a05:690c:18:b0:797:a162:f7df with SMTP id
 00721157ae682-7982902b154mr109459917b3.46.1771927034190; Tue, 24 Feb 2026
 01:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023511.274038-1-ethantidmore06@gmail.com> <20260224023511.274038-5-ethantidmore06@gmail.com>
In-Reply-To: <20260224023511.274038-5-ethantidmore06@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 10:57:03 +0100
X-Gmail-Original-Message-ID: <CAD++jL=C_gHisZk5FCb_qPsRcqiamxp3FzoqV3UhCf1+0tJ7oA@mail.gmail.com>
X-Gm-Features: AaiRm53X3GblnLLQo2UXst7qJs8Djsbwpnu6kjYOtAP0br7nK1aemlZJf-GOX6k
Message-ID: <CAD++jL=C_gHisZk5FCb_qPsRcqiamxp3FzoqV3UhCf1+0tJ7oA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:35=E2=80=AFAM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:

> The function free_irq() is placed after iio_triggered_buffer_cleanup()
> which breaks LIFO because the IRQ was setup after
> iio_triggered_buffer_setup().
>
> Place free_irq() in correct location.
>
> Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
