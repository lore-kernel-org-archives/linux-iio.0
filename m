Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664333;
	b=nbYeEupnFBz8pzHhONgb/iGDA3tdMjGRoYDg17xhCNsQqpgWhTQj3aDd4TbIqDBeo30I
	 W5UCCDM3S5FgUU3/iGUIh4GdL6Be4clRaaef/sC5iB3pSLce/X52Jno2pQ+DOFrtYrc+Y
	 H+b3n/5Gq4TiJz5KwvtYo0vJxN5scYSH+fmQVxfhtOqKKUfMdNQbxs0bdNfLBgqICJawN
	 WyWuetdQky55EbMCPrCV0mhy+s944hf4qeQx3bZbm6zl48La15l2I3Bc5ZtxIgqMHM5HE
	 HVEyjIZKLlkHNTtNdGJEMX+lYwdqNmLQo1lCEvycDXE29+TXFDqj2VVV+1PcEfJ4K4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664333;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pcaE8fNddoIS2qZliM8AEsozG9LhCyjYTML2R7kals4=;
	b=4N7fjbdhGxUvx26+HRRNFIdLLhQFdcxWLNpHuHuSA5zKLw1rI4j7ndwV3cgc9WOopBlJ
	 LQ1Em/dlEWfN1ZRDu3qz6IwrH8kZ/lgv5KLJYCbO3xQQAjpkzAcXzeH2xu22MdQ9jNURN
	 rCEXc84ovpmJi/6Bx+NzmwejhiiwnL1bNTIqzd5W69Uy8gTuO3Ge9pqylfv/vUGx45ows
	 9GFczU2ifxuKX5MJjnmWXC072I/+X9ZHjBHp9TI8tebZKlBSudDbzXWaP7J6375qgilLN
	 +pwsPe63PgCkR8fgy2VfWJ6PighOkA3heVVFIqEOH3h9V3Q/LjGLfF78NlEJOm7woEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lco0Bftd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15321606A31B;
	Thu, 22 Oct 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lco0Bftd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E5F1F000C1;
	Thu, 22 Oct 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664331;
	bh=pcaE8fNddoIS2qZliM8AEsozG9LhCyjYTML2R7kals4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lco0BftdGK0P/AUjFPQlbawm5c3lJlHrjktqYsfyKMYkDXwdmN/QHp0zplvP9l0eN
	 JulBj/OIObEIS00+wvjb4xQGdAZ84bqoc5KGMiqWrX91SgipHbVGfeEst2kz2QTlre
	 GiicAiXGCd785CigAo40BjDrz+LRbsMDZKIBI7gEqLg43gdokSyg+Ng+nR/oRv1L+5
	 2BOVXhaTlZj8gl8bZk/7CjvHana5ZTZeVPDXdP8hgtyRoxf/yNGTtVsz3NXTY/tefO
	 pLoZVst+TpGadDZorgejwbqu/JvcUT15m9v9t53lA0EC/NqxiPls1pz7aQeeAqJplj
	 yX4GY15vZHBWA==
Date: Thu, 22 Oct 2026 12:18:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: light: gp2ap002: add leda power
 supply
Message-ID: <20261022-favorite-bloodhound-of-faith-e3dbbd@quoll>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
 <20261020-iio-light-gp2ap002-v3-1-b7e0946c9e79@rudorff.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-iio-light-gp2ap002-v3-1-b7e0946c9e79@rudorff.com>

On Tue, Oct 20, 2026 at 01:35:38PM +0200, Christoph Rudorff wrote:
> According to datasheet page 8 "Recommended external circuit",
> it has tree pins that need power: vio, vdd and leda ("vled" !)
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---
>  Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

