Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795305370;
	b=j+58rH82l2lVoXsMOlQmvyUbJQNO9fJSpuxkE6N+BkTz2XAGR429LFRHwfyOTYMkeLe1
	 FJlM4lVP3U/LcnenfK+ptBUo7I7u/By6EjQcaqDQUt28fius5pLZjff/rP/7U/Ch/GgCc
	 n6SInOayZuSNPrtR5iKhQ0aM2a2GWv4yT00GI1iaDkDwbc8Y398i37L1eVMGXz0lZFGsy
	 g7wTXF3mzvTsnH5Vhx512cX5A+0MmWvWpDeFyGcJbFiXRgGEEx9qMI72zls3gPRzWcU1W
	 6HSHJYzEbePY7w5sUfBJHGBk4KZBYSoo0GT3OgynU92ABJ8rfx4MJJss5GhnjXLpEXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305370;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yugA/hpxPa9PPMqm+bYi6Gf+4noP3z0dciXI3mzgobQ=;
	b=dsgjPUYhrFYnWx3nW8tFc+8nf60qA2ZPbtrp2m8jwu1JUvj0K673DRJKN2uAXfTeDAu5
	 q1A5MIynqeN5/2Dk2P1fcAP+cst/qqJ7+DuTb5bdaBsVAwJ46wxUP8JAgxJyD3FDPGRdg
	 81VGQR8M95y1ywlnkx24h30zv8GACaxkbGYk6feAKV1u8/4zlXCrtdRglBLC7ITdVKN4W
	 JnYZ2WqIr/Mmd+83I3aXJ2pbmegU6lu/2asQtC9415GvSnc2FXFKR8rVszxZpO/ZNdOvR
	 pUTVHezc4rE9Aj4OCkU7hzZ55rtaMjuCrVNTsGNez6jI4qv8DlibbPdp+LpYVP8Ryqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3eWUBT1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57947606A320;
	Sat, 21 Nov 2026 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3eWUBT1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE81F000C0;
	Sat, 21 Nov 2026 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795305370;
	bh=yugA/hpxPa9PPMqm+bYi6Gf+4noP3z0dciXI3mzgobQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a3eWUBT1S4Rk/Vz1dKqOCH51xkD63zScM/huWV7vrW5dzG5FiIEcwXUnml4RWrSCn
	 wVgC5iSF+e9cy+TvFSFSKp1MX3KUm1mKgVG5+4kAdN3Q1gWrZ3tjk5nTNxjt4V/SS1
	 wZiwegcKtFB4e75D0SlwtEecTNbE0R4iPQmOU1DTbW10VTH+PmQdlAIDmwyKW7/3qg
	 3jDPfMMPkzCrwaVCPayKREHZfZSkB6YGnPMXCRKeRoZ2ilNZh8/bPiUoSD4Jluk5nN
	 ZSuee2XktArpyljXsXXihBY9yrGjZRmCVcoOleN3BDdlhDMxCJHdVq5mHMVgfAYTgX
	 B5mGYInSpLArQ==
Date: Sat, 21 Nov 2026 23:56:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "=?UTF-8?B?TsOtY29sYXM=?= F. R.
 A. Prado" <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/3] iio: adc: mt6359-auxadc: various fixes
Message-ID: <20261121235603.41ce1ec4@jic23-hlaptop>
In-Reply-To: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
References: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
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

On Tue, 17 Nov 2026 19:56:31 +0200
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> This patch series fixes various bugs in the mt6359 auxadc driver. For
> some reason, the driver had channel types for temperature or resistance,
> while the ADC can report only voltage. There were also issues with
> battery channel ready bit masking and scale calculation.
> 
> Changes were verified on the mt6358 (mt6768 platform). Compile-tested
> only for others.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Hi Roman,

The series looks fine to me, but as we have fairly active folk
who care about this driver (or at least did recently) I'm going
to wait a while for reviews to come in.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Clarify bit number in the patch 2 commit message (Jonathan)
> - Link to v1: https://patch.msgid.link/20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com
> 
> ---
> Roman Vivchar (3):
>       iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
>       iio: adc: mt6359-auxadc: mask conversion ready bit in mt6358_read_imp
>       iio: adc: mt6359-auxadc: fix scale calculation
> 
>  drivers/iio/adc/mt6359-auxadc.c | 88 ++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 46 deletions(-)
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> change-id: 20261103-6768-6358-fixes-fcdc79afae11
> 
> Best regards,
> --  
> rva3 <rva333@protonmail.com>
> 
> 

