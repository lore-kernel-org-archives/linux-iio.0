Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265288;
	b=B0ukzn7k7I/RPJF25/U3ejPEQenoeRYWfm8duI8+4oLLF6+gmmSZB13lrsnSlC6pYZfb
	 YkBZIcPJXU4wIJM+LXHwF89lTxY4+NYegecGJZHphvJnepW/OqUx1fY2VDuXuU0aAzg/s
	 w3nHiTR90/GYSToZhA7wd+vHTuVHITd0rqsLwZHnTR/DpE6hzOkQtX8ZNpmjNvSUBSNfE
	 wyF2FS8s6FnVtjn1OKPUKT9E46X3VaBwRlxnARnb4htvgOnr0SeueNYi0EXBLgXXAoJSn
	 mD1xG6AvK0TFXpXk7AMr3ppIVOA7Adjc1YK58rJkmK+i3fqvk8F4yZhitdwAtII2Jig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265288;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5GhBcleH2N/xa0I356d+yJ9h754DmagFocrUOOqzJns=;
	b=m4jpmI7KMXf3LMzO4LmTSHm95ZASSvWqGeCOG6ot7vBh2n8YuhHvXPpY6DHelT4+80kV
	 1hDE/0e3S/CwZ5CFvU2uY0UYhtMAQU4Eio4qBMvR2M7+FvCDmpir4yJyfpnfgmDbNNzGD
	 kbqQH/l2Y7A5nTr4zkTCvO9ll3kcGnZbAVVICXM+NhCltXJlOCvTAgpR0AjEWOPmq5UV5
	 giKbEfyi3tzmujsFSB+UTXO7C4eyOluzJguEkxRWuiSgWmCt+TO6E5Ubqzpwcf2EpqsQP
	 eS2VJ8RABJS5nyCTcq74CG+s9hPSGfFJAAiv+kj5OAOiHDeVhv307Qbv9o62FjHZWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrXAXfrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB71606A31C;
	Mon,  9 Nov 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrXAXfrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574531F0089F;
	Mon,  9 Nov 2026 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265288;
	bh=5GhBcleH2N/xa0I356d+yJ9h754DmagFocrUOOqzJns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QrXAXfrgAXf7URlJPE9O/A09xLcMxIz2gh/UJpY1zg6dk7MEBbLPvGrCztV/FGWzz
	 AnuITH/uxzezeuhgGewSL79SeoD5Tqf2JLrn40u40LI9HVB/PiX15KN+x5Nwva38M/
	 PbZTwzJOrEqSbUAVdIoLF9W+n1FRjDTNOfiZZcl8b+4541ohvEg6Y88xZfb6j5NRJT
	 9Dzm1kR9qKyCxq1BVerl4xdapmd2ZnnoKxQDtrpv714KLHW9u0nha4Hl3PNdgUEz3v
	 CSaEivkxl/69Tpya3OGWThOSm6VflF7asmfNI2t0NXQsC1Wt6OzChROCmb1VoPXFWG
	 sV6p27cOvBU9g==
Date: Tue, 10 Nov 2026 00:01:08 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <20261110000108.2f3ce0a5@systembl0wer>
In-Reply-To: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
References: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Mon,  9 Nov 2026 17:35:17 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> From: zhujun <zhujun2@cmss.chinamobile.com>
> 
> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.
> 
> Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")
> ---
> Validation: x86-64 and i386 driver objects built with W=1.
> Source-extracted boundary tests passed on 32-bit and 64-bit;
> the corresponding test fails on the base revision. I/O is mocked.
> No physical sensor hardware or booted-kernel test was available.
> OpenAI Codex assisted analysis, code, tests and changelog drafting.

> The human submitter must review and add their Signed-off-by.

Just noticed this sentence... I guess this was copied 1:1 from Codex...

-- 
Joshua Crofts
