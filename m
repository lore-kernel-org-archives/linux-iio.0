Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CA2D8364;
	Sat,  7 Feb 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770461606; cv=none; b=MJT2LPgxsJN1GC5OyZlIFylJHmg3wYME7oG1Qforf6jReazqRoAYQnX/r2UBHXmyFrbKI4RHbQphQD2U7lUz9vDAsWHOzKZLbBTM8KgakzPoEG0yz/8jNtUl3kWTUSupbGQqOQ/j9alQ71a2jlmPVDuTqjEiRZ/+fK6bvp6ywaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770461606; c=relaxed/simple;
	bh=pIlz/dsjKPapAcYg2qU+hLr1hUvshMxjeLKpUjnWBfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0GWHsziYZntdUfB6Zf7JNuiXRwj6F6NQLiZfpRpd6rc7LDbwb72vOlPzOsRFdrTblctv/wBWRllbZGIIOZqVuvPCTNh8G3/jORYej+MrMTWI7fQBxKdTWo7uztRrJrZuLjW1NhZ3oeNVCN3UmFMJKlKtXsHKv2KFaT5uoSZTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXSyoX6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXSyoX6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E0EC116D0;
	Sat,  7 Feb 2026 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770461606;
	bh=pIlz/dsjKPapAcYg2qU+hLr1hUvshMxjeLKpUjnWBfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXSyoX6yRh7jpXp4MCr+3JI3loYbpx+MxlloQxyUVsIBEdMf1oXAgFhSmSXhufEow
	 RlBIXnR5GABdbpEVoBuZS4xoTfjOe19SVHJAo42KhjxoCSD+IRaYfsGzXPgiODToFg
	 A1vciMiYHx70ZuV4tPkXWLajROpCVg377ktwVAAunyw0VX3TZwYZq+SHimwCrR2kZB
	 liOChn/KDKZIPBGa9xqC4LRokK+rCjuV4dksKg5RYOCIBaNsSLefBwwVNQRNwtZNTn
	 uJPHZ3RyBHvV6AAdi8dmtbT6bzorDTR8FTIYAo5CWwqJpj049o0Ft1h50JR/laWiP6
	 W8tEXGARBEYbw==
Date: Sat, 7 Feb 2026 11:53:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4088
Message-ID: <20260207-mottled-vivacious-catfish-db68cc@quoll>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
 <e54e91756662ea44b4f86d4be97743ee40df3f56.1770382796.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e54e91756662ea44b4f86d4be97743ee40df3f56.1770382796.git.antoniu.miclaus@analog.com>

On Fri, Feb 06, 2026 at 03:08:24PM +0200, Antoniu Miclaus wrote:
> Add device tree binding support for the AD4088 14-bit SAR ADC.
> Add adi,ad4088 to the compatible enum.
> 
> A fallback compatible string to adi,ad4080 is not appropriate as the
> AD4088 has a different LVDS CNV clock count maximum (8 vs 7), requiring
> different driver configuration.

And here one more exact copy-paste. So third commit, same text, same one
liner.

Best regards,
Krzysztof

