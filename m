Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B339446D
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118547; cv=none; b=MIB2tv4zbx4dRp6n3QDppMCkr6btqa7iXv+b56lPuOPs9o1MmvNEEBpW594C0cIP0XAT/PHSmk8cMETI9VcfB7e7tTfApcR2ZuhP33lp15VP3vRx4clGVfv6xvuWzuVULerUktC2kKVP6qvw4il7UnDxtEtSkwiwurvcpgRRV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118547; c=relaxed/simple;
	bh=+w1rC+mpVbHnFvDMty2x703c1zlUyKXTmejR9ax7iWc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzXVyOXX16F9c50cXR9BtlWR0Q2IMw1hQRNHk/5z08+4mI/ist9apm/Y4kToOoG/4Bn72v/BqmGer1a7HFND2FwAtK4HT7V4LJ2C2dLbogr4c172V5uW7Q7H0xPhneIO8yxOS8nM/d1v15im4klkL5+B7hjYMjBhfcY9g9OYU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PmT89unY; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PmT89unY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782118541; x=1782377741;
	bh=ulknbwjivmGI/MXrpf35wmT6de1IQNcSkyhCiH9zN2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PmT89unYJ8xsBmx3Bi1o/7cstCQsqiKiX6elOXSu+jbcgnDrkqkQ5wCpVtuiPsYyp
	 MDblQPgoG/I+9yCPzKKUm1tV3qAZAHi38EXhiTUQ5p6/2vtakKaKxKCTxwl50XVbYF
	 1IvjiTM5eGDIa3sZtgzPJ/jONPPuMetS+7otSn8vJc+S/gbmc4x70tJnmTgmZhaY+B
	 AGxqXMEcAfBvm+lAyUJ/yXNmqyGm51KmcjER9ZiKaXLb4pqX9JQvN22Kxdt+cPw94+
	 GSUGjfUO0PK+2ts39nRg0pvYEgA/9PHoheiiJKNVj6GyWrRBujSHMv9HsT4uIiP6Rl
	 jAZsW/HXMKjfw==
Date: Mon, 22 Jun 2026 08:55:34 +0000
To: Jonathan Cameron <jic23@kernel.org>, Remi Buisson <remi.buisson@tdk.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_icm45600: clamp the device-reported FIFO sample count
Message-ID: <20260622085527.67500-1-hexlabsecurity@proton.me>
In-Reply-To: <20260621190804.04894168@jic23-huawei>
References: <20260616-b4-disp-76e3f743-v3-1-c20930aaf1cb@proton.me> <20260621190804.04894168@jic23-huawei>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 62a4da5d82d84b2bd73a69a535a6d5800ca15f93
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-21, Jonathan Cameron wrote:
> So could we just do this instead?
>     st->fifo.count =3D min(fifo_nb * packet_size, INV_ICM45600_FIFO_SIZE_=
MAX);

Yes, cleaner -- and safe here: fifo_nb isn't used past that line (the read,=
 the
one-by-one fallback and the decode loop all bound on st->fifo.count), so
clamping the byte count is enough. fifo_nb is size_t and packet_size ssize_=
t, so
the multiply is 64-bit with no narrowing before the min. v4 will use it.

> can we actually use the define in the allocation in _core.c

Will do. It's devm_kzalloc(dev, 8192, ...) today and INV_ICM45600_FIFO_SIZE=
_MAX
is SZ_8K, so it's a no-op rename that ties the allocation to the clamp; fol=
ded
into the same patch with a changelog note.

v4 shortly.

Bryam

