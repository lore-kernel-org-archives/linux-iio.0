Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85336411FA6
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968915; cv=none; b=nJn7hyH4ETZDdhY9ERJvV/9n0yO0xR/jl0BsFvq7oLUzAmlq7usPduBHIX4M5zHu3BqBbATmKN9OkP2SAoXv3nqp3jzS+csSSfxnG3jTGtetMmwI9priF4Gsg60HFHbe+/v7WbE0uybdHHNMlI2lOxQuHd8OithujI4kS0Bj7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968915; c=relaxed/simple;
	bh=Zt1xTQdLJQOgy/fdRdaUx7lLkryqhPrYe31zRc2wTeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUjPljMBST0jIGOOJKywGGMj5fe8GJOKFmaXwRySgaT0azwim75mHEuVCriNvXfQV2N8i/ymCAp7mfDBlGw5Dc1p2EnLVv/QK6AYdRrJ7ldVyQIIj3OnPU++CE4GukcRf36weHN1QxIT6gEXlZPlNuzYzgTcc6WTPs6VanjNBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7313U+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7313U+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB261F000E9
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968914;
	bh=Zt1xTQdLJQOgy/fdRdaUx7lLkryqhPrYe31zRc2wTeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O7313U+yolCza2TXDNn+xwGyv5C5JfLq8zO6uKetXG07dDiHbV9T+ebu3H8DNQ6Tw
	 wACEuM9mOAiE0ASzIjfTrxKH4JW9cLIetpqLhETYmD7iV7VXtGIZ7O+LSqhUEAikSv
	 38OMYm1Tjgr9QWmPlviRv4McEZ0fRblNgdvhMM4qWJM0YpVmI1G2zA4ExuBMBm5EAq
	 zlyDQ4zVXvwS41n4MvOCTkRKeV27huxVkFkjrZiKkfEay8GkBqg38boYPnLAF5xmTZ
	 7jD6NSfySAREMB2b4A4vH+1yONXGojIv1ki11EulunnBXxI1DYNBvkGFzaOboZZJzi
	 wCOkhscd3pPDw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39f75e1e9d9so21345511fa.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRdaQSx3NCgoX3pHBauFBX1GYf2OYqRfv/B7NQIt8XrLYq3gs8AEXPGEYDnTmrWUXLcz39D6mPyC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOi4JS0t/qpW0YT64CBkE0IsGugq7lcVuq2g/5Lir7bvPhd8Z1
	0uJjBQNxcd9ef8xwigXehm2FnIbtGJIrK0wrWV7XlrRDu4dFEFnDozZdeMU+fgiy9o27zX3VdgP
	RSwqWQE0UjunPcmQ1qnd0RFXduT8KDKA=
X-Received: by 2002:a05:6512:1304:b0:5b2:a31c:378e with SMTP id
 2adb3069b0e04-5b45919019emr3279826e87.52.1786968912868; Mon, 17 Aug 2026
 05:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815175728.99541-1-yashsuthar983@gmail.com> <20260815175728.99541-2-yashsuthar983@gmail.com>
In-Reply-To: <20260815175728.99541-2-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:15:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbuTK3exnhxpQqctZk01CkK3ezHFkMMWfBEq-DaiLGBg@mail.gmail.com>
X-Gm-Features: AcwNN1Uc5FSv2HjaqzmN2qLE9QB1Y4BrWc8lHyvn3PkKhVk8ZAQuPZGys0AMBt4
Message-ID: <CAD++jLmbuTK3exnhxpQqctZk01CkK3ezHFkMMWfBEq-DaiLGBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: use aligned scan buffer for
 both trigger and fifo
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, andriy.shevchenko@intel.com, grondon@gmail.com, 
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 7:57=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.co=
m> wrote:

> Drop buffer as duplicate and s16 is not correct we needed __le16 as littl=
e
> endian, keep scan at the end of the bmc150_accel_data struct with
> IIO_DMA_MINALIGN, and use it for both paths.
>
> Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
