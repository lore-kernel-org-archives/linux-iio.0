Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699623;
	b=hkWk8S+jMjk3Jc5rIgNo7EnZwgsWmqsGK3argK5ZOukEdz3WpnqSUHSNIkT/gekcW9Cr
	 oWgzrfjk6B2hMwviueLNPnKGgPVmeotYbaF4s6QsyP5myFX38UZTh+dShbdU8+iWtxGqe
	 1adbF1RmGCj70PbQjz/Ce7MSXi4KY5nExk8zVn24Aj2tlQYld+s416GDxs014gKPcvEoy
	 9vMRcuN1cpUN7PVj6fJOFyF8dFdwlFEt6Oo88ZadVD4pjpI2pMvglC/MjPLimvARWdeWw
	 nD7yiBHhDzfi9m17trme9nz8Mru+BTZn8xGQisayLEKS4mlgK0F7NFhCoV1a3P1hf9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699623;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wfcUpDzSwXKoKbTCOnqjWSSgIEhmUc2ooEiRsbctfSU=;
	b=m3OyeonH84Ogr2NbdeSJB4fZzoJ18hjPz3A8i1z2fdWKIRIRviRvR9bVkjxbgV7KodEL
	 jh6E6dnYG+ILuZYOOeiFE+yTb7gCsmD5C67BLnkzrvbKINV7jgpgXPvsIABQuqSrq3xrH
	 D+qp7Kh0LV756Uz1dkoXF397GXt2fkeIwlNhg/YA9qnuyAwQvtMXZndXssCclARUOndcQ
	 BrL1MVFocvQ0oazMlalrOSvY+00q/Agd0kM5ZAPRwyT/hR5Lr9K5XXetgWzdUxshl2bmG
	 fP/infr09eqhwmmYQCOLkYf1jDGzXz+mKLP7RYVRMR7XI6FNuC+kuOK53QQnv/OIbJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foLFqy4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65429606A321;
	Thu, 26 Nov 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foLFqy4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891201F000D4;
	Thu, 26 Nov 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699623;
	bh=wfcUpDzSwXKoKbTCOnqjWSSgIEhmUc2ooEiRsbctfSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=foLFqy4H2sNEPbvoYvXfhsH7iCXdzJORIlY6VAoUFv+v6EIFo/XFbOEcTK0rylaK2
	 NFfLpRcPXSE5zFbjGSmrWr40coHMZgrmVT6Q5K5arfa3pXzZrkDKsnZ1HfLdtcwhyZ
	 ZCP0ZupcJrT7i635/M0BmOopYJvs8xKfnxHd6njhskCglpqZn4VHAjcHEOV283+V1A
	 UJ6UkTSBRyRSXHHq5k2Wx/y+sKZuViwyJqZz/4G9+yS3hnfmvMyDDJstlIAjk1jWqB
	 SzaeFx7dx1cmBtkFAo0KkJSh5ZycsY9kKHYHb6yH/BotbpfT1uyEQu4H77wsikTrPP
	 3nab/DLlvzHcQ==
Message-ID: <511d9a1e-253c-4006-8a2e-3078c4aa9b64@kernel.org>
Date: Thu, 26 Nov 2026 14:26:59 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] iio: adc: Use guard(mutex) to manage locks
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 12:44, Vaibhav Chahar wrote:
> Convert mcp3564 and palmas_gpadc to use guard(mutex) instead of manual
> mutex_lock() and mutex_unlock() calls to simplify error handling paths.
> 
> Changes in v4:
> - mcp3564: Drop blank lines before `if (ret)` checks and add blank lines
>   after `guard(mutex)` in `mcp3564_read_raw()` to improve readibility.
> - palmas_gpadc: Move `palmas_gpadc_read_done()` inside
>   `palmas_gpadc_read_raw_locked()` and drop unused `ret` from
>   `palmas_gpadc_read_raw()`, moved conditional check inside
>   `case IIO_EV_INFO_VALUE:`.
> 
> Changes in v3:
> - mcp3564: Use of guard(mutex) across all paths. (Dropping __func__
>   from dev_dbg() calls will follow in a separate patch.)
> - palmas_gpadc: Make helper function palmas_gpadc_read_raw_locked() so
>   palmas_gpadc_read_done() always runs before unlocking safely.
> 
> Changes in v2:
> - Patch 1 (mcp3564): Wrap switch cases containing guard() in braces,
>   add blank lines around guard() calls, and clean up the commit message.
> - Patch 2 (palmas_gpadc): New patch converting palmas_gpadc calls to
>   guard(mutex).
> 
> Vaibhav Chahar (2):
>   iio: adc: mcp3564: Use guard() to manage mutex
>   iio: adc: palmas_gpadc: Use guard(mutex) to manage locks
> 

For the series,

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
