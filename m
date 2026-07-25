Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38945039;
	Sat, 25 Jul 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016454; cv=none; b=ondMm44nBRuojZnzRmzkhIkoTfkXVtSmVAUhHuG5p4fOLX7d+L/B05sstw//+aXcMhVZpGqSv4YBC0NNwBrF1oGrXK4JCaWKL6BkjzZ1sMcUn/Chz0aGvXBht4RXSBKqlzII7zwyJCHCZbfLN+zELmNoKnBXL73idnDk2gC21ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016454; c=relaxed/simple;
	bh=5nzdStxuxCjKVHbZ46S61w7r3v87qGySonRUU4DFyLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inUjvgBBa08sXw9RsAyWtMQQKj4aLZMMMCRHTCLsPR4ao4Ajb82FRrFA0LH8Sybcq1Y0+MaviTg2M6WlxbBQkGV5iKOO3QmuyymN+w2V79v8rZAnrolYdn1tJ2p5IL13jWWwOMvW9/Sya3mwH47EhLAk1h+gRHNVnXIc2keDYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIfUzMvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIfUzMvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A41F000E9;
	Sat, 25 Jul 2026 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016452;
	bh=Jbh6XR1mONAR+A7P1P5GbYhGOzORcjEqhQotQxGKdVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cIfUzMvDNpQ6ZLoapUZqCwoRNzhztkBwhIWCn5TwcWbtM9Cupa6f3hzh6Jun2vL4g
	 pEJu0eexWtsB/pji6JD15Fb4s5x36axswXgAOHESKVmqoOdAdPVG+nKf03+1Y0w8DJ
	 jCyHii7DlYSXjgc3ur859gPAVXTDMnfsnCaFAtLBalLR1iSyuV1lPxTRUnVvOpH+eW
	 JDt506LgKFfFOjENUEolybqrAqwSuFWCMBfxLKsLWGbYl2MKn2mjb2mF5lmVMMXnvG
	 bTey+MVzk0d0fQZcJzTO9KwOHGvDVGFU12UbmLWM8wfxIY9bBiZ0fqCyojuotsGx89
	 Rxwe8uzhG2Aag==
Date: Sat, 25 Jul 2026 22:54:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
Message-ID: <20260725225407.1768a2f5@jic23-huawei>
In-Reply-To: <023a4c95-4dd5-4405-bc73-2171a2292f29@baylibre.com>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
	<20260725000439.5ad6f4d1@jic23-huawei>
	<20260725101208.06f60b70@systembl0wer>
	<023a4c95-4dd5-4405-bc73-2171a2292f29@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 10:41:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/25/26 3:12 AM, Joshua Crofts wrote:
> > On Sat, 25 Jul 2026 00:04:51 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> >> On Tue, 21 Jul 2026 20:24:38 +0200
> >> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >>  
> >>> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> >>> which communicates via I2C.
> >>>
> >>> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> >>> ---
> >>>  .../bindings/iio/dac/microchip,mcp47a1.yaml        | 56 ++++++++++++++++++++++
> >>>  MAINTAINERS                                        |  6 +++
> >>>  2 files changed, 62 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> >>> new file mode 100644
> >>> index 000000000000..3322fca03b3a
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml    
> >>  
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    i2c {
> >>> +          #address-cells = <1>;
> >>> +          #size-cells = <0>;
> >>> +
> >>> +          dac@2e {
> >>> +              compatible = "microchip,mcp47a1";
> >>> +              reg = <0x2e>;
> >>> +              vref-supply = <&vref_regulator>;
> >>> +              vdd-supply = <&vdd_regulator>;
> >>> +          };
> >>> +
> >>> +          dac@3e {
> >>> +              compatible = "microchip,mcp47a1";    
> >> Hi Joshua,
> >>
> >> What is the advantage of the second example?  I'd drop it.
> >>  
> > 
> > Hi Jonathan,
> > 
> > Per the datasheet, the MCP47A1 can have two different I2C slave
> > addresses (0x2e and 0x3e), which allows two DACs to share the
> > same bus, something I thought would be good to illustrate in the
> > example.

Given many i2c devices either come in a couple of variants or have
a pinstrap method to change their address, to me this looks like
an unnecessary level of detail.
> >   
> 
> I know we haven't done this much historically, but we could make
> that more obvious with this instead:
> 
>   reg:
>     items:
>       - enum: [0x2e, 0x3e]
> 
> Then the bindings validator would actually check for a valid
> address.
> 
Sure, there is some precedence. I did a quick grep and immediately
spotted:
Documentation/devicetree/bindings/regulator/adi,max77857.yaml

So, whilst I don't want to see a mass set of 'fixes' adding
limits on reg for available I2C addresses I'm fine with this style
in new bindings. 

Thanks,

Jonathan


