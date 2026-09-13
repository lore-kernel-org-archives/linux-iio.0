Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6003DCD9B;
	Sun, 13 Sep 2026 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338828; cv=none; b=rzG4BhQGSm16C6E+FLaYPHR08AmLs+xcsFVHMci7wLNHD8gwA9tnfDGeE5Hs7Acnx9OnpXrTLsEHghdb2GNlGlVVuorc15CoHwbYyO7RcpfZDNIl///pcHkQL1i1STanteRm1kN59uVNkfQX41GONcmQ9J2lPMcAD14ezBqZPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338828; c=relaxed/simple;
	bh=2gLF7Gnw1rArqxOw+bKzbeaqbXGUu2ietjorQ6xj3no=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9ohvvBYOaFjd1r4nbvB3XAWsyTMr2DffSqQZX7Zp7XDH+GJh4hONUOZPJXvFKCx3HeXeNAx7OVjdMF6ni6R9fcC/7tyYRfzSL50K8sajDaK3sZJTfXgHy0pd5Rf+2dNe4PuMaFgBWLSQRbkzL84LugsLQWoa4BbS/u23AZbbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5icPaet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5icPaet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B41F000FF;
	Sun, 13 Sep 2026 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338827;
	bh=2gLF7Gnw1rArqxOw+bKzbeaqbXGUu2ietjorQ6xj3no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l5icPaetqwOTMda5Rg9Ym+V8tts1owdI26bp6wKiz0V/JACnj5crrJNdB2C/e0NiO
	 ZDvQTVYDzmm+br9OLaxnCGBBPi+2vv9drig77Iq6C4HbY2uRULMnc4ZnpOLpc+uXwl
	 d17rbpvJHqugZjVwpnvs84gwEAw/2w7FX0XIO8xn+PCv4pIqqC9OrB0na+OZvC5Z23
	 t1Rf4yl1BlmEcMJmUBjBXmlA7hm+3D0qs/8kaeB9vxMPbYkaVTcaucNJ4NhgGIZNbw
	 5MM5nePJUBdso7hP3wfpR+9OnKm2Qz9Y02MJIqOgbTB+a/Y4WAqeTAQlpy0yhF7zFi
	 J7RJ27XESnv+w==
Date: Sun, 13 Sep 2026 23:33:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v10 0/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260913233342.2dbde277@jic23-hlaptop>
In-Reply-To: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
References: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 14:18:20 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These ambient light sensors with I2C interface provide two light
> channels (ALS and IR), high/low threshold alarms with configurable
> persistence, and a data ready signal.

Nice clean driver.

Applied to the testing branch of iio.git to let the bots poke
at it a little before I push it to a tree I'd rather not rebase.

Thanks

Jonathan

