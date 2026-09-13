Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFED3CF67F;
	Sun, 13 Sep 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341999; cv=none; b=GCaLWsbyZN/OzJSffJKdO6bdqdyaq9cNHDcvqluKWcFe7MXHZdVK/3Ez2sB3YtxqjjrwN7LqkcWZUkACCeG1WypfPccVY62ooLOX2lcWHMgqPoRQ7mdd2h1U3aHQGn4f0YNOBLcRMhV6cV1quV15bbRdjWBkF4P7F+UPBud2hdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341999; c=relaxed/simple;
	bh=dtY8TBgXrWbyWsSbk3y3O3Mxg6EuiP5FogQZgJPpGIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q238C/UfczsFrORnztAOvY0O3TaGJwUndn0p3Ft9+kZkeyatzgiv8pEvkDL5gW+KDkW2o6AC50R9Rs1zvcsCJS7Ab3lV15SXKo1TLMm3iyla+qtfx7bve+y33QR01UEsPTUyvt+j9L4htaJ7UVRGH87K4qh7GR74yt+9RJp2ARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+wpEibG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+wpEibG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B0C1F000FF;
	Sun, 13 Sep 2026 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341995;
	bh=hDAg5avo8MegHSSXersE/4sp8pgFElx2n4JqLzYvoaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T+wpEibGwQ1aGjdX4jH4a3gy3Zb8tgDpBiYAkT0zAVM9eVESaU0TF5Ve91PSpd4dN
	 d1bzB19TttLdk8OxsRDlSGrg2rSNnjRz4UcZWEwRhW6l2n3wCSNWTmcrzm0BgnSJiM
	 yXPabRMXKN/MoeV9TYdfHC3mINZOYjmoGTRUS5mAllk/N+1TwoVQSlQpu8dUzU1AN8
	 m4Yxq8QCneZq+Y2QNlZtJ/IYTQbNK6EPyx3oQK99Iqv6rrFch6cU1KvhOYZ1mah6Wd
	 yQjIXnOh5CG1Ub/+sVztNAmrlYy/kMrK595Gyxq0djMtWd90+D+c4nFeW3SLr3lWdQ
	 D/rIpwwXMNUEQ==
Date: Mon, 14 Sep 2026 00:26:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add support for AD3536R DAC
Message-ID: <20260914002629.1d43ab98@jic23-hlaptop>
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 14:19:08 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3536R is a 16-channel, 12-bit, buffered voltage output DAC with an
> on-chip 2.5V reference. It is the 12-bit variant of the AD3532R and
> shares the same register map, so support is folded into the existing
> ad3530r driver.
> 
> This series:
>  - adds the compatible string to the ad3530r binding
>  - adds an ad3530r driver chip_info entry and SPI/OF ID table entries
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad3532r.pdf
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Applied to the testing branch of iio.git so the bots can give it a shake.

I took the link above and added that as a datasheet tag on patch 2.

Thanks,

Jonathan

> ---
> Kim Seer Paller (2):
>       dt-bindings: iio: dac: ad3530r: add AD3536R
>       iio: dac: ad3530r: add support for AD3536R
> 
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml    | 15 ++++++++-------
>  drivers/iio/dac/Kconfig                             |  1 +
>  drivers/iio/dac/ad3530r.c                           | 21 +++++++++++++++++++++
>  3 files changed, 30 insertions(+), 7 deletions(-)
> ---
> base-commit: 42a9b823307844dc9f496df67d11ec3691317c67
> change-id: 20260909-iio-ad3536r-upstream-869cf331e140
> 
> Best regards,
> --  
> Kim Seer Paller <kimseer.paller@analog.com>
> 

