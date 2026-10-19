Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A83515CB;
	Mon, 19 Oct 2026 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376233; cv=none; b=N+ROQIc9iB6lbzGBOb729zuNm14BakIKdCIod9RMuOw/WW0goDSnmHQgROBgnFZ4xs+HQ9WGMQlR1SP0G7MPgqSEwNuet+w382/dmRHpO7xLRnR3sIySyww7a8j3JxG4BuT7bLB26QSjPt5nu/W+5STge7B7rBs6yhqsVN17Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376233; c=relaxed/simple;
	bh=JBDexEjVkF4HcZ5xyK5okwNP+jA7IkDtihlK3ONAP7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQe48fvFWlktADMszyn41JUOlntpujcyYP7JX3KXVvG7VNhIMgowh/ktPArzZiD/fIciY5PpDXUSfx8Rl8nLEIU5QiDfNPyB6C0cMM2AAFWfbwJzpfcqvX2l5BmSKfH7sUrvFNfXxIPAOdlHP3pXHl9Jaa4esupzyvu2QIrRKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWEFV8Zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEFV8Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1721F000C4;
	Mon, 19 Oct 2026 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376232;
	bh=jvtTMjda2t5otk3q4T/RwoeADaBqu1tfq5HYrbuA/+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IWEFV8ZzOx9LcJpVBKLGI3Oc99YXx6zLYgh1hGeL3JHLecKbfycsgRPsG9JAEgQT2
	 vKkcM1SHNWIvGgH5S6YE6ibMzXnH0tmmE/xTmJBhaN0YIhvl/v+elWEIdceWdX366t
	 I4i/1Le79LCeA2VQSyymOX3Tyi/lsq/cfkKL89mQ4UqfcoVeIKPHCkcSjCOc/7zmnn
	 Mmf6C9NCrw7qUNlvLYDNxhzWKcKcCDdMrtwo3hQOgXe8iXWIK1BOiZ2zm0qRI/nMJA
	 LhiJibcl//Ye4yQDC4r4PYIY90+Cm22EHeCA6ImvZbMCJiK/RSKWoTy3sYOeW53L+S
	 fJxw46JG38IJQ==
Date: Mon, 19 Oct 2026 03:17:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: adc: ad4080: add support for AD4886
Message-ID: <20261019031706.53b3057e@jic23-hlaptop>
In-Reply-To: <20260928104806.9330-1-antoniu.miclaus@analog.com>
References: <20260928104806.9330-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 13:48:04 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4886, a dual-channel, 14-bit, 40 MSPS SAR ADC in
> the AD4080 family. The AD4886 is the dual-channel variant of the AD4086
> and, like the AD4885, has two independent ADC channels, each with its
> own SPI configuration interface, so the part requires two chip selects
> and two io-backends. It differs from the AD4885 in resolution and
> therefore uses the same maximum LVDS conversion clock count as the
> AD4086.
> 
> The first patch adds the devicetree binding compatible string; the
> second adds the driver support (chip ID, channel spec, chip info and
> device-table entries).
> 
Applied.
Thanks,

> Antoniu Miclaus (2):
>   dt-bindings: iio: adc: ad4080: add AD4886 support
>   iio: adc: ad4080: add support for AD4886
> 
>  .../bindings/iio/adc/adi,ad4080.yaml           |  2 ++
>  drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> 
> base-commit: 873ba60d7f2e52a171845ca290cf366878864b1e

