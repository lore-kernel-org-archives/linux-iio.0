Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD62386541;
	Wed,  1 Jul 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930578; cv=none; b=GtWiDP77U6xk8wTX3hlDiMd24rbt4mNDCrmLEPlbX82d7nPlkY+/sS47lyj7FV2EvnhCFP9ESc1X7qOMcJS9GLKzDXciL5ipvN0gdsQMq5BW+eNhiQCIvhYJVlzLY6uopxpodAb77ENQaMU0tPRLIxdVpiIqvmjAkogSy7yufUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930578; c=relaxed/simple;
	bh=aenz1atAFGWjDaH1ic6mzES284MkOFNJLr08nNL+wDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs+y7XeGgSj13BFoOXjoMnBpNimo6pm7Aas8zG5j8Q9Ls/Ge64C7ew0Vtfx03X7zdvPH2+WEHLwDI7BtFAgOz1M92WnKI1qEdFzprnd3FE3RYWXLHYyccd7oKS4WvNjdO1DS0enXo2NfXkRQFNjh39d4RlWyClzs4F8y/NSC/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYkvCZdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYkvCZdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5FC1F00A3A;
	Wed,  1 Jul 2026 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930576;
	bh=oouf/dK+KVCQpIL5LxKtT/u/Z+E2ntQeaZfCAiSQ8EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VYkvCZduhCdySp7hXHzjgXIR7cuZyFtTKEveIl7wuCR8Uisy6nUQ0D+18L8KPP+Bm
	 zXy9qWlA79l62K19CEV7oach/0mgqjWFY5fsiZvmgWYdgbgXOpp70LjBpYVgrVwLWM
	 xoFCuzGmJrzEZrLYaA7W1wDnuKGHjOhhNEQsCm2p13YJxXEfjAX6YX0WmJrMJCRcrD
	 oibjmbB9SkkXkicl9IysYY72s5H06OzlgTjHIN5cNXjm1rYcWw3LlsaGBlNWV80DTi
	 sryYFJjyD/9wGMdnMIu4I1PwQJpjvPi+mYiU4TZeESzGnV2G19Stgtdz/mpADJuvmh
	 qYd75WqKxmwHA==
Date: Wed, 1 Jul 2026 19:29:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: rva333@protonmail.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 0/4] AUXADC driver for the MediaTek mt6323 PMIC
Message-ID: <20260701192931.1be293bd@jic23-huawei>
In-Reply-To: <3f914030-44e8-4f63-ae72-7fde7d843325@baylibre.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
	<3f914030-44e8-4f63-ae72-7fde7d843325@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 12:34:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/23/26 3:16 AM, Roman Vivchar via B4 Relay wrote:
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
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied patch 1 - with some hand editing due to another change
to that binding, and patch 2 to the testing branch of iio.git
which I'll push out as togreg once the bots have given it a clean
bill of health.

I'm assuming 3 will go via mfd and 4 via the soc tree.

Thanks,

Jonathan
