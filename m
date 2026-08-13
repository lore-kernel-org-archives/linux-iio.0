Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF073DA5B2;
	Thu, 13 Aug 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648857; cv=none; b=i61vS0TuI7/Tg3GQWnJlWWktM3QqQ15hMUYHAvG2YOfJWHVv/mz6C5bzbKrDQdGGT/pb+tm1bQLX+rJm7atD6iUGbkEnhGPwcLKGgKVcOJIhpmm2qdjfj5iJ23ozPH2CCkH1Qy0IZztIlq7mEId9CJL0ga3S6iNNM6gmSspcLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648857; c=relaxed/simple;
	bh=QNt8/Qde7vjEN7KPOKBC8DQ2+43/aZN5rweVSiyuBQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoFwY5+OsHhwfIPOnoSfrZnTCvhSQKq567B3XAIZj5N9Unh2Zbgv4jiZv112d38f11tK7hQtqvfPCqdmMF1a4GY3HpNWrS2KL/QdUSqT5ARJkTfyZhaehuDTsTe1yKXsVG+c9fakpK0Yoh+APccI4DqAKe9jxP2XYio5QcmbDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzVW4Ser; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzVW4Ser"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F631F000E9;
	Thu, 13 Aug 2026 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786648853;
	bh=X3bOKhCn8kLtXC55lbTCgNBqcSIXk5aW/+YdyX+riek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzVW4SerxkqOk87jlhAXm9am4SrcPo+e8ip0RYFsHUmzvetGRWa95zNcQz6TPzI4s
	 G4bS5tkSmpggqlTwIRBYGOMKcZaXr04U/8L2p97Tg2n3YzhF9Bs7+upUIrxPLE8stW
	 8kMmlSkZ1oJ13eAO8memBO7iah+48KxsTWJZG0fVUfp8+fzNIxVA8XQBuiFEZ4OByX
	 dKl6+0bXkZqU8AS/tfilJR+NHizkfMw/PCgXZNVIQiqraaRIY3+VdP1PpybG8SNAen
	 s7mVkIP1chDV2ArgxVO79qdsNDekNOK7PoZzvJVuqFQZo9QseQl1pUSPsBtwjBZLEj
	 gfyyH2TudmNMA==
Date: Thu, 13 Aug 2026 14:20:52 -0500
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
Message-ID: <20260813192052.GB1981719-robh@kernel.org>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
 <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
 <lLSnPCriXSWAjaV4ogTOt4280Fj7hoZxBDkJC70ETVjxbUYNhCi8Ii6pDv-7YQ5SKb_Hz4Aj4JwtYPGwPH6WwA==@protonmail.internalid>
 <20260810155006.GA1815611-robh@kernel.org>
 <871pc3y0id.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pc3y0id.fsf@geanix.com>

On Wed, Aug 12, 2026 at 02:41:14PM +0200, Esben Haabendal wrote:
> "Rob Herring" <robh@kernel.org> writes:
> 
> > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
> >> LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> >> without interrupt support.
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> ---
> >>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> > sashiko issue should be addressed.
> 
> I will.
> 
> I guess it is best to add the new conditional statement under allOf, but
> as we already have an allOf block at the top, I would have to add it
> under that, which would place this new conditional statement related to
> specific compatible strings before the list of those compatible strings.
> 
> It should work fine, but it looks a bit odd to me.
> 
> I could also add it directly  as an if statement, but that would only
> work as long as it is the only top level if statement, so that looks
> like a bad idea.
> 
> Should I just stick it to the existing allOf list?

You can move the allOf to the end.

Rob
