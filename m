Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56713A1CE0;
	Sat,  7 Mar 2026 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889194; cv=none; b=ZFCUIt5biztcuMZu+hbvqQj9yy9QBbSwg5e0KTVapkLMWCTJhyZc1QAwPPFXOFzV4hJ94DRHFvGB+G1fjyYahuLs78ozl/CwAh/XF5gc0/IGs8/prKs+WRnGEjwu26OoOXKC1V1ZZjSS+i2pwoFN1lIqFUACENanv9/ZBQYTIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889194; c=relaxed/simple;
	bh=6F3IQUZ9kGrgjLHewcu+TLHHVj6wQ1EtsvruLGle5HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ3GiEP4cpAr0Cbbj+Ev5B/QNk2JA+EzrUE/5fgVQiUGx70kmX1oCk2c1iFJUBsRHw2OGn/U8AjBQgsYjhQwNl15sPpNAvRfdLjY0BH71wsNxxzHYDjuGcy2Aqe5Yhv3SOjQ7nF23EoiWTVdQwFbVUqCXr8H94MU0/S3EJ9sGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL+TkF+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL+TkF+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC592C19422;
	Sat,  7 Mar 2026 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889194;
	bh=6F3IQUZ9kGrgjLHewcu+TLHHVj6wQ1EtsvruLGle5HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DL+TkF+P7hIVCgBAAJVaW+Hf3k0bkGuLug81wjF7cM2vt9mo6ra6Wr+Ppq+mhs3Pg
	 dgAp9YFMXSSrlRAoJ9++GahFUiH6Dt5JzhD7oKa2r6w1hEiLgqNpAoUHGwxoMFSooj
	 cFNXwCQFb3br6bqG/qQXRlIZ7rFJkSGLC2/TFLutjacfQn6J4iWa5Uc05A2KEeXehy
	 V91cDfE021KCmWR+1QuTuxekk6uGR/xngjvvCjtjyWdr/WUSkc2q55esMTvvXeoYVJ
	 TrFXNdTdU/YBhuqdkuXF95HOnX277iPImgDBYv8dA+3gVU1PtVwWJ2WJEfxK6adt6b
	 +mONHy6SfoM1A==
Date: Sat, 7 Mar 2026 13:13:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Eugen Hristev <eugen.hristev@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91)
 SoC support), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: no devm for nvmem_cell_get
Message-ID: <20260307131306.4684bfbc@jic23-huawei>
In-Reply-To: <20260304041843.7709-1-rosenp@gmail.com>
References: <20260304041843.7709-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 20:18:43 -0800
Rosen Penev <rosenp@gmail.com> wrote:

> There is absolutely no reason to pospone cleanup of this post driver
> removal. Just do it immediately.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Applied.

Thanks,

J
