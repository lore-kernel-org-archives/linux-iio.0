Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7F270ED8;
	Fri, 11 Apr 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407750; cv=none; b=qT2OWdGISjOg6EWYj1y2+tKZx0KyAX5kjLLZq9vh638TJw8fj3FzpsUzLItm7eIRnhxTcalITqZ2A6K9sztZhYEhrpupgw0l5ZpJjkv3QtF7wc9eu6JwQQPweKz/c89JO5ZIkgDnXYP/tu8786b+VT4ejnbv/1mIC1fnPNBte+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407750; c=relaxed/simple;
	bh=4LhuWPwYnwfWubXhz6GDcG0qgbNGIhb70Ts1afDJfkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdaObwEJHONlDpiEJwU7FgFD3uwR3wbCKvV2w3IEch73YabeJFAIxzxWYBZaxOK78L+SUZxkl221o5G7WsuLwEkwavHs+jqKLbbSenyr5NZuT3InskURHVOTcjY1HVtlIhPn7z/QNfo6SGz3Urxa7XNsf9E4Qr4wHPB0Lq9FRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEcN1fq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEcN1fq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F97C4CEE2;
	Fri, 11 Apr 2025 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744407749;
	bh=4LhuWPwYnwfWubXhz6GDcG0qgbNGIhb70Ts1afDJfkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEcN1fq82jCeBZFOGFHiuISct0oDIUZmoePG70z7ZwI5GG9XhijbHiD+zNSIcIvNF
	 EbpQk/qNEBGSYtC19XdVXsAS1Viyn49T0wgHPuOe1OTQMhRvH3h+FzsBfvkIhGRPL8
	 aLpBMZRP1W3j8+33S/sJwuf434I257FqclrcVPcSQMQKG8RL90nnOv/ZP7hdUWX6ML
	 GDC7cez5E4UjefOw62WOYTf/PxmiTtDGpSGLTLN2LUNmPIi4W690MAt5cYc5B5mImB
	 UYuWkSpgbZ9xTUrv/mI3KDj3IizfWexLgA2fi6QMLncTlHxCHpTedGgu6qgiiTvFhK
	 ZN0txlCgtb0aQ==
Date: Fri, 11 Apr 2025 16:42:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: conor+dt@kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] dt-bindings: iio: adc: add ad408x axi variant
Message-ID: <174440774809.4136857.15700052759218592081.robh@kernel.org>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
 <20250411123627.6114-7-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411123627.6114-7-antoniu.miclaus@analog.com>


On Fri, 11 Apr 2025 15:36:20 +0300, Antoniu Miclaus wrote:
> Add a new compatible and related bindings for the fpga-based
> AD408x AXI IP core, a variant of the generic AXI ADC IP.
> 
> The AXI AD408x IP is a very similar HDL (fpga) variant of the
> generic AXI ADC IP, intended to control ad408x familiy.
> 
> Although there are some particularities added for extended
> control of the ad408x devices such as the filter configuration,
> data capture synchronization procedure and number of lanes enabled.
> 
> Wildcard naming is used to match the naming of the published
> firmware.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - improve commit description.
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

