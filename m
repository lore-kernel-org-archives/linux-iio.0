Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198C4086A;
	Sun, 18 Oct 2026 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287097; cv=none; b=PfnG3MeLBhgLeDDDtZsli0oJvoRQAt4YKcMKGVH93UheBjbkgTFiJBRA9Bt+VJ1RrIuXNJDq8sSvSbAgdB018poY9dkaGs1+MS2bWZv8nRSuRtHaR4vr1FdJ4ydtdy6t6dRvFw7Fy3M+mLj9l4s+oAgfj+wvwXUPckJA1G6hDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287097; c=relaxed/simple;
	bh=hRt8sBNSPwOTr+woCubM8BaalhBsOAcDcpNpihftG3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEOB64zHMqT3JBq5puxeJnWuAOwk6Cs4yGROBkD6K35h7gDIZdmKy2iUDwBcJWqS8SB1eTI4JIjOPtP6WlJTuPXxvcZLuRdCMnPyI5LEmXuruP5M02WrLOpVZR2ZpY3wFVVTlh++5ZB5saWki9juvT1dXh8XmbNMCjW14Vx7cPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFKKnbAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFKKnbAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E341F000C4;
	Sun, 18 Oct 2026 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287096;
	bh=sDUOupXKKKGrRJsOGVdw+mmXAeUFJ/Dqwat4MWVwTy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fFKKnbAx2ysTjRAEm9zjyRMonc68JC3cy4Kt1FtSnZOrCW1kyjm/gs7cAHgrtnFgg
	 3egAd1CcE83IE4Kq3TgtUBnSfX9eqDOFuqKNjaEVp6Ah2waFXfylRETTX377d6sHdu
	 kZdmIljfKXQSVd1fFMNjDlh+HU5DP7TbmxLanIjPRHXC7FpI0ZO5cWGk5wUqrFif1E
	 MCUMGbULEBcaJkqLgq6EwHjWNqGR4JqM7jri/8qyYNZrHPeUL2zPsM4cEOCVATlR07
	 qYi1uBRp2gMXQQyM5jsRtCj32O1oJBBA89m0Sk1G8ilXaPP0bKa/WHzya3Prga333b
	 sTuXFiJMDEH/Q==
Date: Sun, 18 Oct 2026 02:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/10] iio: adc: Add TI ADS126X ADC family support
Message-ID: <20261018023129.3abeb679@jic23-hlaptop>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 03:52:39 -0300
Kurt Borja <kuurtb@gmail.com> wrote:

> Hi all,
> 
> I apologize for the long delays between versions. This month has been
> very busy at university plus some personal stuff. I expect to have more
> time now, so development should be faster. Thanks for your patience!
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

I took another look through and it looks good.  However, give
the sheer scale of the driver I'll leave it a little longer before
applying in case anyone else plans to give it another look.
As normal, if anyone has it on their list but is snowed under
just reply to the thread and I'll let it sit longer.

Thanks,

Jonathan

