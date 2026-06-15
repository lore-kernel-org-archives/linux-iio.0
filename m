Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802F3A6EF0;
	Mon, 15 Jun 2026 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501675; cv=none; b=bA6sHKwpMFX/0cazweIzEus+qQgCIBh3U5nYz7qG8nQqaQ7yPMeAQEj7fu3TvcVJL4MteJp5TP7cj1Lo2RKNwBezflF16mxsnVHud9FZ1N9dJLwLBT9EqVOsShfIxlwi7aqfoqQlzbcxatOsVPRBTp89Ie304qbuP1AulHako24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501675; c=relaxed/simple;
	bh=gz6/l0fXkcdM/dbGFOo+klHAC5CoFwOPed43QpQPJOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COfkhREc5pBH7rcr9IXLDGDoF5ruHgXKg8wCg3e0OqU4PJD4Uo0ketT+0In/jToyo2uyPMJuDcTWXvbvm7symuu9r0reAgzWRaqVaEpcFKfZ4mAtSbVwQlOrdO+baker6aYEpqV4YPNyne7vhwM+VJfxgx+N57CYxMJaEVlc1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEUoMAHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEUoMAHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FD31F000E9;
	Mon, 15 Jun 2026 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781501673;
	bh=p2KuLQe/7E0ZPoi/8l8aRNtishmv1ue1DbKBYRDqUpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEUoMAHMuVTje62FFnx5D960VtzJ/kOUnv/F7q9+0utpqVdTEPluVlTpa6SIChwcp
	 rt7FZmtuip1stbaXqHaK0RcFGovACwvnBl9xiZCtpbXukBOZDhvBIgup/TCKv6k6+F
	 6Y4JzQI00XvlU+wImdBxtgkOes0NB84wYgSvi6AZZuBawCiKuR9uVE6A56Iyg80Nyi
	 JSbw+du2JR9iCY/IXgifVdz2Qra4OGsKXqqvkhQOv3tn0c/BajDyiZRY4x5t2rPoB9
	 jGe7mkDTpNaCcwYDU8Govb/i1D/fkoYCxBr3axhwwgiX2Q66J9vNPx3isKYQIdgYQ/
	 KLe/t0r3aZCFQ==
Date: Mon, 15 Jun 2026 07:34:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	duje@dujemihanovic.xyz, jic23@kernel.org, jishnu.prakash@oss.qualcomm.com, 
	jorge.marques@analog.com, krzk+dt@kernel.org, linusw@kernel.org, 
	linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com, mazziesaccount@gmail.com, 
	mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org, 
	sakari.ailus@linux.intel.com, wens@kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: ti,ads1100: add support
 for ADS1110
Message-ID: <20260615-outgoing-chocolate-cat-63be5e@quoll>
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
 <20260613190957.654798-2-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613190957.654798-2-jakubszczudlo40@gmail.com>

On Sat, Jun 13, 2026 at 09:09:55PM +0200, Jakub Szczudlo wrote:
> Register layouts are the same as for ADS1100 but ADS1110 have different
> datarates and have internal voltage reference that is always 2.048V
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1100.yaml        | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

