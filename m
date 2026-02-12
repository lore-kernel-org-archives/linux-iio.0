Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306E3EBF1F;
	Thu, 12 Feb 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895434; cv=none; b=MBuhNXd/BI2axaq3iWJekwvIZnmMpeQxcqL87lQqU8DI4UqdcQytL0NlW/Gu97ZEvkrFKbBFSAJf5hPdKvNsNQr8j5ITjiaHQzHVsuwAW9q0OJw+dnH5eC+tIYLX1Ul9vjoddTwFqHr6OuFtXVGZkDvQUaTdlW5bjkyRDX+DYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895434; c=relaxed/simple;
	bh=JyK0lZLmGQ264Rlfkk4jx1myHY26esARI6O6rir+WUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeE9U9FbjM+kPMOI9q3PyawAv6zyTBx//+l5G6FtsUcXwjTahMwRLdF2tdqHRAJj7FDLEabLrjSq2RJDnD0SFeztgtZTUY74l/SjU5PYTvjDOlxlsqdXMxqwDbAznBqr0iErkKxRrat+WBYMM1RFQWksInEwncYBVu0/ybG0IDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zyfs4Kw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zyfs4Kw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C06C4CEF7;
	Thu, 12 Feb 2026 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770895433;
	bh=JyK0lZLmGQ264Rlfkk4jx1myHY26esARI6O6rir+WUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zyfs4Kw2DZRiC/IFXXnWZNhhoWCd19PX5zN+eqSrK8nnywrVtBHZDBTbjwFeYZpuD
	 4eOTJy4ln1JyLS6MrODhKvNNcDXYrz7LS1AzGdRMe/BtjORKDeWeAwVm7mi8AgYjab
	 Htd/9jFvSvUZZUygBt/B0pvnKQp4QVWonNacFDM3X67nF0Uuvfu7dNp55IaYweU0WW
	 SAb3kPx5fncGFHBLD3q3xxWGBsBx4mFm/1bVr4nOoXigYloMioFpkBXispGXmKncj5
	 swWKwJ0W8eoiPpRBmSd7xpMUhpaV1f4m06fCfRXoScfOfy9NduEQJG4mycO3uccGr9
	 rCzLDmkaWoB0w==
Date: Thu, 12 Feb 2026 12:23:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
Message-ID: <20260212-spiffy-true-porpoise-5a9e86@quoll>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-3-2b28fce5d09e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212-upstream-20260219-v2-3-2b28fce5d09e@gmail.com>

On Thu, Feb 12, 2026 at 02:26:54PM +0800, Yasin Lee wrote:
> Allow specifying the firmware file name via device tree.

Nothing improved here. So again: Why do we want to allow it? Why a
device needs a firmware now but before it did not need? What changed?

You already got these questions.


Best regards,
Krzysztof

