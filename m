Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700048;
	b=jPdyZaE3aezo5Xq2zy86Kb8xhECGZQimrPi3h0SFOvySiw5G3kt+toqkOnce3CMZ87hM
	 syNOdXif1fdJ9lfekTJPXQKq+LJBrRmCPWC3Ol8V/OeFb51FDMRoYp2kOvX+o2XaY0im4
	 7EXKqpffyZhXw3ixj0r6YJKiOql8lTszB/w9hBeVco+xvq64GrLkEr4gnr0wBXV2ddke+
	 b8tOFcc7DqbJnvHUl9lMnDgu79VY6IiVMWl57fV7tkHdH/zWa6MvJ1WHorE3I7Df4+Ef6
	 dD5zvj8eKTpr6RdguhTR7kEcFg1kER85AwtoV6+R3hd+oOB/8LmbHAHZWU1XlpdsSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700048;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B96VGZcu900Nv0SlXMMOtbkcIVeui4LKgSgUnRjLmmg=;
	b=3lDiQfY2tptjDAnSEz0C6dQzaB5SARNo+HWs+rWaMk3PbUdI7ckqKECqYU7nrRQhbGKM
	 L80BHJkm/2+UoHMRHDDH7GKnCnT5zByoD5dly0ilsbn8BXfc1qWUtqcmvEOILoP02KBI8
	 MZJbzIN5uFXN9v6CFTCxaQgnpCaLZd/WuDGdMlSrw76E/kjycTerPe+nn4O5OlpyEdsW6
	 b39mcBT12aExGdKtye/C5JMmdUy0P/u/wLZwEb6nnSHG/UYrmB2cpBImvW1dR0ALdkY74
	 bbph2Df6pAqC1L9GzRNtFPe6E/zHv5uH07j+aHnRzlMHBD6GOpE2bic/qWEnILKY1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMbIPA7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E916606A321;
	Thu, 26 Nov 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMbIPA7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428E81F00A01;
	Thu, 26 Nov 2026 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700048;
	bh=B96VGZcu900Nv0SlXMMOtbkcIVeui4LKgSgUnRjLmmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QMbIPA7bSsIFFtFVWSKg5SYHz2xDxQou8ABczafM/P0Logl1XxXdCJ4zfgUg7EG6A
	 bgJ1a/7DbhU8AkBunbpTlagy1fn6VrVsoI9La0KCXWvVyUTFYpIIKdb3A7Qo7PZutt
	 ZyidAdulI6yCpOqJemlZ4HsKXH2Nw04gWRTGQvLwUqd6WjOskng2l0wJXCiiLXINDG
	 nPrfoZ8fhe3WSK2bJHmUMBao3EkylBkSi/0ETPTe4B7l0y2fH+Hv1Yu0/kDRfIlvtv
	 Sgc2VmFN9U1BOwsLIEiXOlFe5l9z1Hr1wTmF3x0Y9nI6FhDGdzTRhVsAzH8wnT9l8W
	 sXrY1G/dbqF+Q==
Message-ID: <6d598970-107f-4ec9-919f-13ce99f3ed0f@kernel.org>
Date: Thu, 26 Nov 2026 14:34:04 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] iio: imu: adis16475: Use the reset timeouts of the
 ADIS1657x
To: radu.sabau@analog.com, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, linux-kernel@vger.kernel.org
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
 <20261123-adis-fifo-v1-1-f6ad9e493e19@analog.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123-adis-fifo-v1-1-f6ad9e493e19@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 14:25, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> The ADIS1657x variants share the timeouts of the ADIS1647x parts, which
> wait 200 ms after a reset. The ADIS1657x datasheets give a longer
> recovery: about 275 ms after a hardware reset, 241 ms after a software
> reset and 282 ms from power on.
> 
> Reading the product ID right after the shorter wait returns 0 on an
> ADIS16577-2, so the warning about a product ID mismatch is printed, and
> the registers written while the part is still starting up are lost. This
> includes the FIFO control bits written at probe (watermark pin polarity
> and enable, and the overflow behaviour), so the watermark pin is never
> driven and the FIFO does not behave as configured.
> 
> Give the ADIS1657x variants their own timeouts, a bit above the typical
> values from the datasheet.
> 
> Fixes: f95920baa066 ("drivers: iio: imu: Add support for adis1657x family")
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
