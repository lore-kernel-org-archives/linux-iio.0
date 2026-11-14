Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695479;
	b=sJNHmLflTk0OptfSbkveAHpRqh4SnSN9udRqsb53drk54EVF13zRDH3dVPzgC5DbZYSO
	 Hypaq8ipiJyq+Qmia0SnU4xgu2ZX+1R1kaDAEQkk8UsFpUGgDQOA3vxuiBw/lc7jiYCNr
	 f343Le/qqkjNI9Lf4WCbGMqZ3i/GF+t3V08NclG0q97hs6UNBueQoOuAhqvtY+JHA6A8l
	 mZfVra0VIMHgQXpBL8l2sFpe+MaGFWtMh6OBERxjO036tpCefl/1U9WYj6py50WAayfYt
	 fg2pMXxc/bUGbuSf81evbjlLIThKTpXHiV97/ubV6xXDAC8g2ipIQD8nMvph6Vs2qTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695479;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=herjo2M/VB3QMwRNmuR47LUbsbXEcH1i37Nf6fK3gQA=;
	b=OsrwVLstKKw3uJCneZgcEuOIrxntXrWra8gemxSgCZ1L37WsFEOrn2aCLyl77tAKe+rz
	 h+g8VoH73VkBhhKgoINgi8p4meIirqKZu/L36Jg3D56vVbud191TEd9LMfio2gFa6dj2y
	 c5TEr4O86yTWsWGe5jHQju4aSS5iufJ8lJQlGz6f2XgLrtJ5a8cT5RZdQReBOgZ8hgtwC
	 Du4mdI9KeQGQyuPWkzqg9eEZPou9N1MUut9QJpxq4AEDjMZsxps2eVa4pHuDt4S6llx9a
	 UXtIuRNGaZbhK+RM0y44/gH3gD/cFQVl00M2Bhnowss0hoZVnGes/6jw4SDSmp2za+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i4/vM+kJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A1606A32D;
	Sat, 14 Nov 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4/vM+kJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC671F000C4;
	Sat, 14 Nov 2026 22:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794695478;
	bh=herjo2M/VB3QMwRNmuR47LUbsbXEcH1i37Nf6fK3gQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i4/vM+kJ/eJ1OJO1L1PcrQHFmaeXgEKZkJBcuoivHcoNmP/lGMBt5oLRFCVVgQn4F
	 GtSZTvGoFH17kP6ItlxWj+R1aVzBoPzYTqeTpZ5L5MTmVK1RIqNEilyZP7i3hYbMov
	 zuaz7Sv+QfuALt6goSizO8ZhpxR3g2lE2Z/JSJ37HpHXV0AnOA/ZRAjBBfFgl3yEBh
	 ktMh0GqnjpBq8eEwCL+8zMzyhZbfuO67tFo9TQoWmQAO0dPW1woyP0MinMahVJtHhT
	 fOcc3Ffv8K7sHKpiw2ZVYMmbnT0hAXEmxtBZ8ZFo/RdCplCXlPdTOH4q40ePdTG5bb
	 FeFZE57+kSQ7g==
Date: Sat, 14 Nov 2026 22:31:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <20261114223111.7854d043@jic23-hlaptop>
In-Reply-To: <avEdFaY6xtzGaGTu@debian-BULLSEYE-live-builder-AMD64>
References: <20261105033120.387616-1-nichen@iscas.ac.cn>
	<avEdFaY6xtzGaGTu@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Nov 2026 22:08:37 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/05, Chen Ni wrote:
> > devm_mux_state_get() is called twice in a row. The second call's result
> > is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
> > checking, and then immediately overwritten by the first call's result.
> > 
> > Remove the duplicate call and check the return value before saving the
> > state.
> > 
> > Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > Reviewed-by: Joshua Crofts <crofts@kernel.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > ---  
> LGTM
> If still worth anything,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Even if it is too later to add to the git log, it is still useful
to have this here for future reference!  On this occasion I
have just updated the commit to add the tag.

Thanks,

Jonathan

> 
> Thanks,
> Marcelo

