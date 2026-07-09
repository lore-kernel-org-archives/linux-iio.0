Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0C3B6366;
	Thu,  9 Jul 2026 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641268; cv=none; b=WNnVVVr6NVIVM/I3SDVfrXINsj5S3mFg0zI5kydMQ0tMcNe8MyWmq5evkCJSadPsvI46E6YcNmtNtDUeOZ/WFSMLu4Xd1nTjv89zsXT15xCrBhllGuoJOk8X1dbClSHA/zjPQP96CaeklEfaxOj70apCpKygv8exRu4PpPn1RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641268; c=relaxed/simple;
	bh=Gl1x0hCdLbSZUorx17YfA8wJHQYAG7Q+sEOIzGZu8Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO9Tqcb3sCQTDe5h56CaNkuARr/tez88KyIkD7RPHtcBvWysKOlGXKOwomeM4o2AJzUZKDmiT2i949GGGpYks8vVKd6mIiCrhR8K6n636cWDhzStDj634NGBuK7uJry96nKcL2f7tLV93KGmuPbNsyHqFhS+PHz6s3KLeNvoGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M542QeCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M542QeCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92631F000E9;
	Thu,  9 Jul 2026 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783641267;
	bh=nwdYdybpiL0XEa9EfKFkDvxx2HxR0uRQFmPGoHruEz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M542QeCelKml3h1uJ1XQYp8QugIw2+NHmc5YUtO2rJlhu+SKAIbICvHidvONUVA1K
	 tbsI4a8OlL/atikHfUw6LQ5c3/Ow7MjFrcFYKs3OnJHZIUDPC7m99u49AZk/6TZ7p6
	 wSRZg+HlmkamLa/ImDnEtj0Za9bfiFJBVJBVeqAdkhCnjW7zLZgBFS5kJ5DKcn09AP
	 X8jqdwTP7Iy32zMtQCb2WIpSeumTRekRduA+/0uRNs5o+tLdWcZs1vGuvNVl937+Ot
	 FAktRLc36OCabsEIBtc1xAJwitwWsXh3LorqR4o15dix145vZyFx0q7Ko8GZLheZxt
	 K075RmpfscQcw==
Date: Fri, 10 Jul 2026 00:54:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Message-ID: <20260710005424.5c559b5a@jic23-huawei>
In-Reply-To: <f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
	<f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 13:33:46 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> On 7/9/26 12:52, Roman Vivchar via B4 Relay wrote:
> > This series adds support for the 15-bit AUXADC hardware block found on
> > the MediaTek mt6323 PMIC.
> > 
> > The previous version of the series for all AUXADC, EFUSE and thermal
> > drivers was split after Krzysztof's comment [1].
> > 
> > Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> > mt6323.
> > 
> > [1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6
> > 
> > Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>  
> 
> Whole series is
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Cheers,
> Angelo

As noted on discussion of previous version. I picked up the IIO side of things already
so I'm assuming nothing else for me to do here.  Shout if not!

Thanks,

Jonathan

