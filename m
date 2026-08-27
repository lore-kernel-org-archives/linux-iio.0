Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98F411F8B;
	Thu, 27 Aug 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822054; cv=none; b=NdFpyow/cmlfkbc7EHOU3eFDngP8rodcn3g1xDcVXQ0idKUg6jlp1xRYUPIcnSzAZeix9Fg3nHpEqCMTLj/HhYRODEU+ht0k8cCiuNd7gE9KFLYu1Aj+Dsme3r7s8WHwUrcxoTfvQE+KHSs33bHLjzMzF+Zca+lh0opdiqH4k/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822054; c=relaxed/simple;
	bh=1H7jJiy6pBcezk80GtTvIBe6Ej5Ee/8GQrt+JKZH3V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuINtDx+JLS1RQi2Dnpe/9DDZZdUDtyIXybEj0QJ234s6kI0T69T5Q+ze6INdwI5UvKxpBL5R7UxTFkM2IPuqcjTeRR2TjImWk7oonDYMiNzfQKbAKuGHt+bnQnOfODoUe1LssQTABIkrxbvsFucgAkixMn8Xf58BJDVt5YFXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxUw2I3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxUw2I3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDF31F000E9;
	Thu, 27 Aug 2026 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822048;
	bh=XJMCCQCa99Qt9iNwiG0ECbGzzcH7vIVg5plEC6uf1JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XxUw2I3Fo6ESeGCVoqCixg/LvtYDcaDlEmkYtdvP7a0b9NNHYV/1fD39rqQIfffnf
	 A0BK+XwGnnqDe4RDGkwQ0Mbc2PeV1uFkrksNoswrp5ADqCBYjiop/ocLXXlj1TGbpB
	 veHCxCiIKsNPBJfDhg/tughiksZgfvEtgmwmjfitv11MgG2E8+OKvsVAYo2yvcC62d
	 QsmwJn1XBavtSL4xJsSU8S6ocsQ3hmsFQsa3JPzUInmk/QpRb98ob2MlIZQnPc18vz
	 viTL3XDTWGINSnn56Rna9FKrRtrn2uWd/mOfZxnh2KKVStfwnWb3QrDqDdF8Xn0vGL
	 8Jg9cO/a2i+ng==
Date: Thu, 27 Aug 2026 11:14:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	siratul.islam@linux.dev, u.kleine-koenig@baylibre.com, linux@roeck-us.net, 
	joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: add adi,max40080
Message-ID: <20260827-robust-lion-of-recreation-31314d@quoll>
References: <20260818142928.8244-1-stefan.popa@analog.com>
 <20260818142928.8244-2-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818142928.8244-2-stefan.popa@analog.com>

On Tue, Aug 18, 2026 at 05:29:27PM +0300, Stefan Popa wrote:
> Add device tree bindings for the Analog Devices MAX40080 bidirectional
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../bindings/iio/adc/adi,max40080.yaml        | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

