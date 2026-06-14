Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19E846A;
	Sun, 14 Jun 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781449823; cv=none; b=gBXutq+jxYy9FyJeKs7/Dzvqhw0I0JP5Q4r+VPcgeK/GOhh0agZp1iVDHT6S35G9tFcWOkwvXiCSpIEPnzTX56RqLIztkgYv77Ms7ATQp9Po4SiqvS4nZf/cgTcIUV9EkF2oFiQ4IWNazxNR3FchErj23rAc71rF+VJQ4udRKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781449823; c=relaxed/simple;
	bh=NCa/ZsJVGyicY5gi2u4/vQP7kCFQ2b+IXd9up52RIr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIe8fu4gLB7jMro/Jv7blXinBdS636uq7XLEIsYegehaybU/ousvvRbmiKkVuY9JOZJuXIJTL7GQUaX/0aH+XWphnY2xxKw8bQWkakqfUrQE4R6dKT+9ICB1ab9TiZULgoBnPTIoKc3HCuex5xOThtmDbesHjRaXamZSY3DWvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARerImIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARerImIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCDB1F000E9;
	Sun, 14 Jun 2026 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781449821;
	bh=HZDTltsK69KIMH2XKO+Sm1vGznFlapQnrREMcVbGLX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ARerImIOBURHE+RO3iKVQeLewDm6uQ3Ygdngnry9kbeIZ5uhRW7hevT222+jkwJxZ
	 GJYl5I+P3jeuHml+sbUoToh4EjcFjbooQk9WVVCcSSUJ8g39XC6TBt2SZeFjIEslLK
	 2Fw6IPtgM/xTGGJxI+ZsCVXp7i6uW22d6sWgStEvSWadWPQZjSKQ/Wraez2bJFHNBY
	 TDKBqsUABC7vT5eipB4h80BAJScaoayIdyJvp+AiIC7izqdu7HKmllcXetzleDeWBD
	 Vm4PhmioMXJRPghjRNj+1I1Nh/OpyrKSKnqdhfkAbZCRkGp8IcNlGcDUYiJoc2Cov7
	 LPw4sxo/tGkTw==
Date: Sun, 14 Jun 2026 16:10:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260614161011.7f7946f1@jic23-huawei>
In-Reply-To: <4e4ef1ae-62e7-4639-914c-19f49930be02@kernel.org>
References: <20260611132700.671322-1-wafgo01@gmail.com>
	<20260611132700.671322-5-wafgo01@gmail.com>
	<e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org>
	<20260612184729.795e0e84@jic23-huawei>
	<4e4ef1ae-62e7-4639-914c-19f49930be02@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 09:51:13 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 12/06/2026 19:47, Jonathan Cameron wrote:
> > On Thu, 11 Jun 2026 16:01:12 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On 11/06/2026 15:27, Wadim Mueller wrote:  
> >>> +
> >>> +static const struct of_device_id slf3s_of_match[] = {
> >>> +	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
> >>> +	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
> >>> +	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },    
> >>
> >> You should have only 1300f here and detect the variants. That was my
> >> point when I suggested to use the fallback.
> >>  
> > 
> > I'm lost. How does that work?  They cannot fallback to that part because
> > it relies on in driver detection of the fact that they are incompatible.
> >   
> 
> I am lost too. Then why were they made compatible in the binding?
> 
> Entire discussion was that these are FULLY compatible due to variant
> detection. That was the entire point of discussing more generic
> fallback. Using specific fallback does not change that - it is the same
> concept.
> 
> If devices are not detectable, why were we discussing any compatibility?

They are detectable, but the feature set is not, so to me there is zero valid
in a generic fallback, we have to update the driver every time a new part comes
along. (i.e. I agree with Conor's reply to the previous version thread).
A specific fallback to a completely compatible part would be fine as there
would be sufficient info to not need the ID lookup.

The case in the binding for this version is the worst of all options because
it implies it is valid to fallback to something that gives a false impression
of being specific when it's relying on ID matching to say actually it's something
else.

So definitely not
+  compatible:
+    oneOf:
+      - const: sensirion,slf3s-1300f
+      - items:
+          - enum:
+              - sensirion,slf3s-0600f
+              - sensirion,slf3s-4000b
+          - const: sensirion,slf3s-1300f
+

Falling back to slf3s is better than this, but I'd rather not have a fallback
at all, thus allowing correct fallback to the parts listed here in future.

Jonathan


> 
> Best regards,
> Krzysztof

