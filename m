Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FA4119E5;
	Tue,  1 Sep 2026 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231722; cv=none; b=ptu5mby48ILChaRdWqfCcoqpksIOIj+OES+r717cbx9voB+/MDdL4ONyS4xg0n3jB0sGuzPvsnZ3fMzUUp33n4LC32y0eBeCQ28MeE8CLvlVWF0JMrce8XIIqBP/BknlwGE8VLLg56HyRRcOaqbU/cLPs4dmUylBWI876r61y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231722; c=relaxed/simple;
	bh=Sm4dyiUxS2inup09HhJdgSya9QU60DLWwOfASA9awpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r820UakYb8efhxkLx2oOKfQRKGjpQfaEgTnNXq7N0aY/2NWVaAOlTF3YK1A1w0yI51LhX96MMgAUgs+m59j9oFHVQFbpw2fO8i2+8G4O+CeOiL5KW3hIz+EXEHo9nTk+HKO9pJq8TNYhP8x9GBPpmJzQqJErbIFEmBUULMoGTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgkVclOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgkVclOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650A11F000E9;
	Tue,  1 Sep 2026 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788231717;
	bh=lGqX5A+ldPU+bBU/2ehh9RDbSoAXfA8C2PmzwkzeDVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VgkVclOn3NYKxL/t48kWZaIiWJpug12HMYCvW6lzSeiUg31MhCZ9c8MLrj3ltFW2g
	 eJ9tkviz1qnL3rIF3LS1FixjZ2BpUkrlQc6JZwsCTc/ngGNIi65tKxsCnjfbtgHmdh
	 SvL5nMNmxbGAILOSV+gjz0x+8JF4JEnovM0CDYWkYKyj6nPaxyxvRXZqflI24WDOM4
	 3Aw5uQulohaRCPY/gbQcm8IES3au6SQnJICgmQTjCq9W+L4l+iWTxpzCF27VyYsv+5
	 nHZMlzOKefC0eI1KZgwELY8y7wkNVut2zjj3fz4wNO8cBbg4qndxmUSz4mIPxrhqLh
	 NNK8bLJPEAtoQ==
Date: Tue, 1 Sep 2026 04:01:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20260901040151.67a3c90b@jic23-huawei>
In-Reply-To: <20260831-elude-steadfast-b8017ee226d0@spud>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
	<20260828-cartel-willow-9592e4e8b912@spud>
	<20260830025743.70dc65e4@jic23-huawei>
	<20260831-elude-steadfast-b8017ee226d0@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 17:24:08 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Aug 30, 2026 at 02:57:43AM +0100, Jonathan Cameron wrote:
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1    
> > > 
> > > clock doesn't appear mandatory, what does it do?
> > >   
> > > > +
> > > > +  '#io-channel-cells':
> > > > +    minimum: 1
> > > > +    maximum: 2    
> > > 
> > > What's the use case for actually setting this as a single cell? Kinda
> > > confused by it.  
> > 
> > Part dependent, but I think we should just make them both take the two
> > parameters and have the value of one of those fixed to 0 for some parts.
> > Probably easier to understand that way at least.  
> 
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads1263
> +    then:
> +      properties:
> +        '#io-channel-cells':
> +          minimum: 1
> +          maximum: 2
> 
> This in particular is what I question. Two different devices having
> different cells is fine, this one device allowing both? Nah. It should
> be fixed to 2. The ads1262 should probably have it fixed to 1, as the
> driver already does.

Ah. I missed that chunk!  Thanks

J
> 
> >   
> > > 
> > > Otherwise, quite frankly, the binding is too complicated for me! I'll
> > > have to leave it up to the IIO folks to cover whether what's being done
> > > is sane.  
> > 
> > I'm rely on David to take a look :)
> > 
> > To me it looks mostly fine but a few odd corners where I'm not sure
> > how things are supposed to work.
> > 
> > Jonathan
> >   
> > > 
> > > Cheers,
> > > Conor.
> > >   

