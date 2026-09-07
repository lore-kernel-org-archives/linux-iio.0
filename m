Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD5368D4C;
	Mon,  7 Sep 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746638; cv=none; b=axrCRfJswtw0G8H6ixamVIe1nuUFRlTQCXO7zp9OyAwNXMV0CTF6f1bLiL4dySzQwxvd+m7UfFLI/fPkWhWpqeu/BFOcToqjVp6typ2YuVADPHo3HP1iBeDR7yJ5K39NxCj1VgVx7lAYO8AceFEor+StlY/nZTXs2rANBSdYja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746638; c=relaxed/simple;
	bh=NH8WM5baM1sUFc/WremnkzSni49JFz1TTKdqEzfDXkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmEknNLil1xWJ7n5Dz0uiJlWV5ef8T72nWfJm5Ha9i2DtCX3itp309HGGHUDI6z/bn+ps+rTX0eK9qA8HpqK49oBfTv75pHsk0yyfciZIk6gLqvyHFb1/ccXi1Nzg9Bj9N/fpIv2ihm+cbk0186Fednfr4EMomqn+Zye7FTKGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdNs0qSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdNs0qSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544951F00A3A;
	Mon,  7 Sep 2026 02:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746635;
	bh=NH8WM5baM1sUFc/WremnkzSni49JFz1TTKdqEzfDXkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LdNs0qSqIVeCBfymUo4DTGwD9DYam0iSnTQvknrnNU5sYfn32aGP82zkKsagx8vtD
	 8Ybeg+qyEt1/51PHcwWG1sfG2XAnVmC7jLuMNihjZB3ET2/4aJ0/GIEs6dah1Ymnhl
	 foMynWOjvhaDEBGrB59CQYxlO5Ab9DhBwZG2m90UkoAVIJ6OgyzGTHYCm3ESoDUhID
	 uJFyBMHh6EsXdPj27hE2U4QQLvbSshX7N8vZ3EEw+hGfxcZ3ShZh3zYhrResKwhzgF
	 UTuufTOiZm2N1DmAK8eLui0/U8LfS7A4uGLiq/ldaOWsyz1lo1pfHf9wDrL5tAiwcO
	 duUVzSgsP7yAg==
Date: Mon, 7 Sep 2026 03:03:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v8 0/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260907030350.5eacf496@jic23-huawei>
In-Reply-To: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Sep 2026 15:05:45 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These ambient light sensors with I2C interface provide two light
> channels (ALS and IR), high/low threshold alarms with configurable
> persistence, and a data ready signal.
Hi Javier,

I took a quick look through and don't have anything to add.
Hopefully that code reordering you are doing is simple and v9 will
the one to go in!

Thanks for persisting!

Jonathan
