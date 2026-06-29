Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16B30EF64;
	Mon, 29 Jun 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774182; cv=none; b=Z72tO0lZ0OFc+WdIhgBPza0pSEv93+PS8wH/YbOkMUfRcpbXfSWCGcZNZPH0E1SdvN4EL1D41iP/O9eYG092S7HtH6XC5yFuF/lkziY5i4vW2wlTspBBMR8mOXhwZff9vcbdfFX+gapmcUEOjKE6W+W9lYelkpdAa87ztFzmsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774182; c=relaxed/simple;
	bh=AXsj8xOgfQkOAwSTH1lO9fmCzGiihIZdyRk6611S4Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM1SM/Kt16w+1ujkZiaXircKrs59/3aN3udqC53lERkDPbcJDKZXyVgqI7YBoWJn3X07xyOc0UtAiErQ4/jSrtXAdy2Zlfh2b/lFZ8gfsiMJgv1lxl+cMapH0r0jc9jt1kln1foIyKF3be4Q9EUay0/foUc30LsM0cPbrPbYs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM816DLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM816DLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B64D1F000E9;
	Mon, 29 Jun 2026 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774180;
	bh=5lUhUkELRNdYbAQv8NP6BaXWA6PeKuYJgzpd2sZuCiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YM816DLB7xiYIe2USPt1u7oXy/CdvZb2xTp7iYP0tytUUmHfE7KdZDtjF1R9fE+xh
	 J+rT306ZncZHL7Bk79EI+wi04JUo/FiMwHDaT6bOXS1gPXDJ9aNLvwrFCMXxn1tDws
	 6CrtRA1nh/ZRxpSXF9sAe1qLHKR3VIbu800BuSgbPhcfrkQsta9iiFi7ONqvfGrOFp
	 ATWvQvIsXi7KvGOuhaQCfPIpaiLFS66LCGmfnH16+kxeOKPqHBAc8cvOkW//+JnIOW
	 p3viW8X01m8ZIbGXVuYoRL2MLPdlu1duguOw1KNjd+ttAXG+8dEJJu5G6vItuPziyw
	 pljVbFXS4MytQ==
Date: Tue, 30 Jun 2026 00:02:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 2/5] Documentation: iio: add Open Sensor Fusion
 driver overview
Message-ID: <20260630000254.1d1cf422@jic23-huawei>
In-Reply-To: <20260628191337.937-3-kimjinseob88@gmail.com>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
	<20260628191337.937-3-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 04:13:34 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Document the Linux IIO mapping for Open Sensor Fusion devices.
> 
> The overview explains that sensor channels are discovered at runtime
> from mandatory capability reports. It also documents that OSF0 is a
> wire-format detail and that protocol_major and protocol_minor carry
> protocol compatibility information.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

One small thing inline.  Otherwise looks good to me!

Jonathan

> diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
> new file mode 100644
> index 000000000..832901f5e
> --- /dev/null
> +++ b/Documentation/iio/open-sensor-fusion.rst

> +Timestamps
> +----------
> +
> +OSF frames include a device-side ``timestamp_us`` field. Buffered IIO samples use
> +an IIO timestamp captured on the host when samples are pushed to IIO buffers.
> +The initial driver does not correlate the device timestamp with the host IIO
> +clock.

Really small thing but I would avoid talking about 'initial' driver.
It can cause confusion about when something is true and when it is not
as we may have multiple non 'initial' drivers before you get to changing
this handling. So just remove that word.

