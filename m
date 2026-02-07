Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A602D3EEA
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500622; cv=none; b=L3UsdL5ecRg1AIWGPpOghHoxVCR4CC/yYpSS9BsefWQKEvaNIPAAp1uaIg9CrD9APEtiLaNhPbC+UZQ2uC0949vfoic1/MRrP34toZ4bO3f/8wa4xxYAPmF1fMrurY1hoJnb2IXQGJRwjYQE4gRNdtlvwqJZ4i1VT7QBSv3oeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500622; c=relaxed/simple;
	bh=JDD4EJhBReKiD9GZ5f+ATqGcTM/Xl0P9Utm5aKsH3LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRSkkQGTn6ZhuJAk3lS1qVsMIL4/LzTc78gbREgt7/J+rYMxfS3+NRQH1AYVQNxDOLVwh+uEQ5CIAVy4J5qLWTjSOzNOVD5MqUXR17B5MXSUrcMDOyKMr1hBWvyHu3LYkeVtcjzSOHXiTLC1KbgkW9d/GItWnn3JeXs4+2BiLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrcUIVKB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrcUIVKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D065C116D0
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770500622;
	bh=JDD4EJhBReKiD9GZ5f+ATqGcTM/Xl0P9Utm5aKsH3LM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qrcUIVKBfgG7lc4P015rdTCxmX4sJqhlHILIW+JR3br4njf33TTrWFquofAMIfA3R
	 qXwxY6bJlPg1mZoSisYwq5wPycfiqqkbdZhcLNijfsMwxmYBHcwmvFMH+qt6TPt+fV
	 Cr7Mpm2NgWdXQ2VvrU2YKKr2pYun/MCrfqVHgKWAkLpoPFGBf6aS9SNwdwsMxbyB+p
	 vlpM0fMTZ+kG2ZSTJ9Lasb7xJ4JnYaMdZTksrMdFw2lSEabYlg4fIqS3IIV49RZuHl
	 JpQKPPV08g5xqQJGdpA25MD4eLlZPPzFdGa5G1cCluMsX9I2f1s6XK8ylLmhuHCl3d
	 FePbAvh2XtkYw==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64937edbc9eso1748346d50.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 13:43:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVouB2QwAVoUm+w027NZVzpMr4edQfCKUYM1qHqgU9D2AxKF3Ocpz4sPsVuGgS1vJzqgwNYnHm/H0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOjsz34xEZRPjRN99QVuUsw1iNYdrnJhMzIulmOg6GmXDSPyW
	wTzaFlahL9GAZN45gQf2mdFz8F2ndErR7go6W4IThvZ9m8D2UUB7JyYwWRdGYYnuhENO4tZSn5Z
	2M+OZrSAjMtbVfxb+nIRWAhQoWhYx4q4=
X-Received: by 2002:a53:d105:0:b0:649:bdfa:6338 with SMTP id
 956f58d0204a3-649f1e949a9mr4783566d50.35.1770500621941; Sat, 07 Feb 2026
 13:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770039759.git.antoniu.miclaus@analog.com> <3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
In-Reply-To: <3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 7 Feb 2026 22:43:30 +0100
X-Gmail-Original-Message-ID: <CAD++jLmokwGhd3m89uf7Xa3wVp-J0GcELRVWj2FR-x_wYEvdFw@mail.gmail.com>
X-Gm-Features: AZwV_QgTAFd0RbqTpPsyl0UP7kRpIzGAE4PDNyyjtmxjQlUnuA4ffqyMq8KlWrs
Message-ID: <CAD++jLmokwGhd3m89uf7Xa3wVp-J0GcELRVWj2FR-x_wYEvdFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: mpu3050-core: use pm_runtime_resume_and_get()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 3:57=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:

> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
> mpu3050_read_raw() and mpu3050_buffer_preenable(). Unlike
> pm_runtime_get_sync(), the usage count is not incremented on error.
>
> In preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
> fails since postdisable won't be called on preenable failure.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
