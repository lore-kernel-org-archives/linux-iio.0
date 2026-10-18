Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAD30EF8F;
	Sun, 18 Oct 2026 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358934; cv=none; b=LPUhY3iLqWcl/K3W9bxT69ix4xQ9sRihewzzAaCiOLqoAin3xRYlXwRIPksKMeBkwCYOhjkH2Ku2wbqapwRpvdorKFHugRgW9vCbjaj28zzBlLOFYtZlovq6FFpAz0MEKlVGsNzAL2zQMxuESevLKqF9yMc6cTbPzarmmXkbZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358934; c=relaxed/simple;
	bh=e5Q+ZyHgYBU13Zn6ZSiOcYSLg8z6Sf8+4EL4qcvhBgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Cer2D4FuXMuaXFxaOMVX2pcgW2W8ky8ZVQgqiEilLduagZ39anCf+GLEi5S0e3JuQHAs4zqfUQ8obDB5bgtDoxuaLeD1quVnFy0AquKAMycRTjxu3Ane6xidT7FTB1sOiDofmfblihtFep150tfBo8WicZgGBrWbFYG3vrko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVJrZDzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVJrZDzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DE01F000C4;
	Sun, 18 Oct 2026 21:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792358933;
	bh=pNq269S3aqqeQdTrcdt+nL50rcEjgdLiWPPFUWCSGCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GVJrZDzSVUMUjIA1mQPafwFPEfAv0znfdyl4PdU8gmDsMJnaD6ftCVC172ZCjOryV
	 HpgqRCp56mcxHfBrsnhbqT7ClSHzua7vjSiVsBxWrfNy9lUxg0ZiLp+3S9z3i0oWDx
	 MWZ2sp00IdVL6gZIbPgCysMSoHsxWrkh4ksOFgMmMz4AaqFj6sPWmeB4CqTvE6a1Va
	 LNACvxh0rY2eiLFzsmpRexqdd9m+aCTFyN68NE5C/bQBMPhke7Z6jF8eP98HiRnXwm
	 umjBjGsPJ64ADmS8SrKi0uXYKCl27XWFfIlD0NyWh4/6hrDF6zWcNGBeEa2a0D4/B2
	 T8ydoJpmqqzzw==
Date: Sun, 18 Oct 2026 22:28:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arka@arkamondal.net>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stefan
 Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 arkamondalofficial@gmail.com
Subject: Re: [PATCH v2 0/5] iio: dac: ad5758: fix the 4 mA to 20 mA current
 range
Message-ID: <20261018222845.2fab0b57@jic23-hlaptop>
In-Reply-To: <20261006153210.364862-1-arka@arkamondal.net>
References: <20261006153210.364862-1-arka@arkamondal.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 00:32:08 +0900
Arka Mondal <arka@arkamondal.net> wrote:

> These are patches 4 and 5 of the v1 series, with the deprecated
> <4 24000> value dropped as Rob Herring <robh@kernel.org> and
> Jonathan Cameron <jic23@kernel.org> asked. Patches 1 to 3 are already
> applied on togreg and are not resent.
> 
> The binding and the driver give the 4 mA to 20 mA range as <4 24000>,
> which is 4 uA to 24 mA. The data sheet (Rev. B, Table 32) and the
> original text binding say range code 1010 is 4 mA to 20 mA..
Applied to the fixes-togreg branch of iio.git. I'll rebase that on rc1
once available.

Thanks,

Jonathan

> 
> Changes since v1:
> - binding: replace <4 24000> with <4000 20000>, instead of adding the
>   correct pair and marking the old one deprecated.
> - driver: drop the mapping from <4 24000> to the corrected range.
> 
> A device tree that still has <4 24000> now fails the binding check, and
> probe stops with "range invalid".
> 
> Compile tested only; no relevant hardware available. The binding was
> checked with make dt_binding_check and with test device trees:
> <4000 20000> is accepted, <4 24000> is now rejected.
> 
> Link: https://lore.kernel.org/r/20260918122032.134947-1-arka@arkamondal.net
> 
> Arka Mondal (2):
>   dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA current range
>   iio: dac: ad5758: Fix the 4 mA to 20 mA current range
> 
>  Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 4 ++--
>  drivers/iio/dac/ad5758.c                                  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68

