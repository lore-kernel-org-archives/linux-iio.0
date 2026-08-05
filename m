Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9833E2ADF;
	Wed,  5 Aug 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914094; cv=none; b=QTMBkrHvFNqmqDNTGvuaHwdKuXA9J0r8PBkHejeyoFRvyfODNefCNLM+2CN7d5d1VA1aAuGAOB33KMLD1GwnOi2DOYmTni4T7dUkn0HpM3mj7l7HgzvmmRNEm8npl2aWfZQMIAX6atk7A312aGryHhIjVfpoNjxPBXQnNG/SHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914094; c=relaxed/simple;
	bh=ssM9MKOYyuVYPqqiGRn8U2MWo9xMV2ixhSA1WhimwfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Zrhy1GMf526jNoFmk/Id6GCmyKimvp7ZJ/gCUm7Cg7H80h3qoIwBE+YsEOx8wrj1567ZPRSVPM/1kAclRElzhlWaQ99iP9g/7TInntR1oDdOfywDye2qsTXTwWzjGQAm6pGPACLK1KnyLFCz99X/x60Q49MyhSGj+2ds+kck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0kHlPMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0kHlPMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B31F000E9;
	Wed,  5 Aug 2026 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914092;
	bh=6uZdiddsVAtutp0JT2hzpsF+lhy0Wg5FIYSeZr+hLtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d0kHlPMTac0pbrrWygq1ZmsLGfqSPLdkTdnRcqPBgSWT1MnOz30oKvgnfp7mIjGhz
	 i+U5Jyw/zISr/lXuyz6DhkGBNAxeFHEWMQ5BIF4SfvhQ/zo3p+4L9+vyuuox+qagSE
	 8ZzLON74I4lF9zdKb1LaaTB0NYqglINnHWrIl0XLGBaCQJRaimjQMfKoxW5RfQyV8X
	 h64irNtzgF/qBp6TnB6ZWldqusOTRMU9cjpEWo3jG0gqqSk3TREj70O0g/ZelQVMrg
	 p3bLsR85gsNr7ilVl4wGhxFpw40tMWxGRZGZpqQ8ug3Cr4Ca2m4WcvjFg043esQc6r
	 Hk+5Q+GdhIuXA==
Date: Wed, 5 Aug 2026 09:14:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: light: ltr501: Sort compatible
 enum array
Message-ID: <20260805-honored-gabby-camel-ecefac@quoll>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-1-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-1-c6b768c7c745@geanix.com>

On Tue, Aug 04, 2026 at 07:02:12PM +0200, Esben Haabendal wrote:
> Restore alphabetical sorting of the properties.compatible.enum array.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

