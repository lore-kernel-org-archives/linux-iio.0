Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2D280037;
	Tue,  3 Mar 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520642; cv=none; b=sqAdfQ8P6GJU9YbLKZD3ft95WWV/4DYrcS9SaALiSrvCLO68A05L0nSjK3PMl7Ef/HsvY/sO9INFj7MiSrnj//6xKICFvDNT51nH/aNUCJhL6Di4gJglgC4aCqx6ckUPzYLgWqeRBmrskzjdWSpPMl/REpkr4sJTfv5x24nfTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520642; c=relaxed/simple;
	bh=rrwhtu7PBqmBRleUYdMdbpJJNhppCdBQ6Mm8hc/oz+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haqZI51k+HztqCcdTvmt3zzbtIa734DqhUEwzzMeszPgq9G35nurhgnvrYLQ1z4VugF4m7K3iFXBTr0ZR9x3g0qQ1bCUNJ9GH0EXSnwvckpzHvoFyPeKuZynvK2WpZI140IEGezeHefo7+uKFco1fr/YLQT6v+PkkCHsJ2NzEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkmHtYf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkmHtYf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5A8C116C6;
	Tue,  3 Mar 2026 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772520642;
	bh=rrwhtu7PBqmBRleUYdMdbpJJNhppCdBQ6Mm8hc/oz+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkmHtYf4fwI/dGBx6OtpgF25RLKr0mj2tUxaefFQcCnDNePTK3DeUbNM8w6rjsooB
	 3zUrfHF7QVfFdcqqS7XW8n9nasvsqgcx5JyBS3fs2tNm/QvYbqJ+u8AgUCp8Vw+O8w
	 PW9s/m60UICiG0PnFaexZ7HvUtFWE1UJswEk45UGEHzJm5W4+tSAiSmrW+gClz9Z8+
	 1stVeMf2sDX2DiDG5rS48xqth5fCSoEbnQ1gP2xPXw2rgw0fa9ne3Xg0Q1UdnNLjqD
	 Dlp9B4Yjzs5EZRZhSpvdCLZvXZJ5l1vgPzTy8FbIC8d1E94C9wLLtbhBJaX5uFlY/9
	 7Z4lLANk5+EbA==
Date: Tue, 3 Mar 2026 07:50:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, cosmin.tanislav@analog.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: ad4130: Add new supported
 parts
Message-ID: <20260303-rich-bobcat-of-dew-6d303b@quoll>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
 <0b290dbdfeada56bdb513b7a57994d84e971fb34.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b290dbdfeada56bdb513b7a57994d84e971fb34.1772078999.git.Jonathan.Santos@analog.com>

On Sat, Feb 28, 2026 at 09:38:43AM -0300, Jonathan Santos wrote:
> Extend driver support for AD4129-4/8, AD4130-4, and AD4131-4/8 ADC
> variants.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4130.yaml   | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

