Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BB48F836;
	Fri, 14 Aug 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730186; cv=none; b=PmsLXCMNyVLwBS24C0IAA9p2JCnw9mXF1JUsEYtJzU4XblSudoS04Dt/RQgGNkKKuZKOdfogYvP7uesJXseVip6UJV7BFc/uC2kFfeq4/6Uhnq1u91ry9BK2YYmjUODALzy8o8SdJSMMIk+Nnmfmk6W7FnACiRiv+2JLkrMu908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730186; c=relaxed/simple;
	bh=9F6/4+LVZS039CW1K11EVpB8WGuyfHGWXhiD7tNtlhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfOf0HneVXcFRz6vnZtsZ86wdPI4kvsffzxunWUaGSUFpkx2T3eRxs9ACf2gtc62dQ3yr+cDSeUsXD8saG9oeNzvMuZ5NrkVgEnGUjI2GEPrwK5Jl1g8UX8AvLAYpXDfdgI7WdzXDEBbt0C8hoCe45dMjsNf16K9Q4LYhWI0asA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m99jGczV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m99jGczV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98BE1F000E9;
	Fri, 14 Aug 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730185;
	bh=zwjVw72pw1VPHIy8OJg8YlbcLAGauykml2pF2uCqMeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m99jGczVquLdustHyXvNmlzJNXQP5aAjwoc96rDZzMsetpfbXOnb0TeUcKkSs0Vch
	 tYlVLbUPtJomqhYns5tOXNAAmJOymQ8lRnN3FHOXEU0MRGYH5oKRDshCOJbTsqpjFz
	 ewpZqJByubqGsK70Owrn8FFKejvUSt1ldBycf9FaGg7I6pCEA65fnTM3qUNHpH4fZh
	 ZmGzWvnEOKSk72LJBWJpMLlaDOvcqjVf8Hzql2wbT52hchpizmSaauU4LJPHBIWZIQ
	 VoXIZoCApdYAyrFFo3w4WjRuo06OXXmtN0db7Nw/JXQk+UtdMOem00xaFfC7za9shj
	 twfFLwjWbuGdg==
Date: Fri, 14 Aug 2026 12:56:24 -0500
From: Rob Herring <robh@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>,
	Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260814175624.GE1981719-robh@kernel.org>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
 <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
 <20260810155006.GA1815611-robh@kernel.org>
 <tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>

On Fri, Aug 14, 2026 at 06:18:55AM +0000, Esben Haabendal wrote:
> On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrote:
> 
> > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> > > without interrupt support.
> > >
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > sashiko issue should be addressed.
> 
> What about the suggestion about adding `proximity-near-level: false` to the condition. I am thinking something like this is more correct
> 
> properties:
>   proximity-near-level: false
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - liteon,ltr501
>               - liteon,ltr559
>     then:
>       properties:
>         proximity-near-level: true

That does not work. The if/then can only add restrictions, not relax 
them. It can do allowed->not-allowed, but not vice-versa as you have.

Rob
