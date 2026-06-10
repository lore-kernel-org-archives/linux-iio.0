Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE333B42C2;
	Wed, 10 Jun 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082511; cv=none; b=f83PO/OHFyR6XNfv2sTlPBl2w+3HABSnTHlJtnAiDkS+JqbGgTtVuV7QM6sBE7lBCvedyAh2exq0rWZ1prCYL3AZ4hnL3fAklR67Aj8SkWaXa8JnyjKYSobejNNlzRe7DlNbxXkvIv8IQQw66IvTZQG/uFIaJ3XFMBglUCHlfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082511; c=relaxed/simple;
	bh=ezeZsPXsUVcDhDnJgi/uFETrQWIXZzeLvUAPUnR7Mzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4hapt5Lye54iDI6i6jgs3XtiNlMWnTQ0oOL0SHPihXydbbI+o2kD7EbgaNndJ8ObbAlGsFp8H+UwF9nrBLdl5Cr0gRCfxdNxPYyMu26EXaGGRjyZnzadZQb5i4ojpd0QCYLFJ28UMLlauMGY81SWoxWDtrIUthfS1AFcXjNC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNzXA9VB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNzXA9VB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024701F00893;
	Wed, 10 Jun 2026 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082510;
	bh=tTpz8iqHF3H3Yug8T8Vzfo42mwEk2ZfCcVHBFX+ynBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UNzXA9VByJ1yuHHMFNZtFPK1GRqidtDda/sboA7B0fC2Z3P0P6y4FPQCrLvPanP+v
	 BA5vYMePsWaJnWZBzL4H28WBcyapaLSLAzFPfjlf2+MZ30M2vBaVEjwOjc8YteVnJI
	 J8KyTzWLVSINm7lFb3S5D3nSB5QIvo4z+OBiwCboyVOdtCoPsTknAeLZNDQcW/zWAa
	 IG8dnLerA74mL/UFIShnZYQXDIQMyYwG+ZxxeTMBOPXAzLG0a1E4O0sPryRm/2apKg
	 rwK8KQcbXRD1o8J2xPidpzzFw2q3EA6O0dOg4NtO9GiV8NlJ/hs+nmF8jwnNTlp5iR
	 QrLs4adMxXAVg==
Date: Wed, 10 Jun 2026 11:08:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duzsynski <tduszyns@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: plantower,pms7003: Add myself as
 maintainer
Message-ID: <20260610-imperial-glittering-pudu-ddfdab@quoll>
References: <20260609160326.45123-1-m32285159@gmail.com>
 <20260609160326.45123-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609160326.45123-2-m32285159@gmail.com>

On Tue, Jun 09, 2026 at 11:03:25AM -0500, Maxwell Doose wrote:
> Tomasz's entry is no longer valid, as he is not active anymore. Add
> myself as maintainer to replace his entry.

Last replies are from Feb 2026, so not that far away. I fail to see the
context behind that change.

Anyway, it's like fourth patch from you doing the same. It's even more
confusing seeing this done file by file.

Maybe you just want to add yourself as co-maintainer?

> 
> Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
> Cc: Tomasz Duzsynski <tduszyns@gmail.com>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  .../devicetree/bindings/iio/chemical/plantower,pms7003.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Best regards,
Krzysztof

