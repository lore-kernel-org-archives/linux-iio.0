Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B02386422;
	Thu,  2 Jul 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020008; cv=none; b=sEEJerScVv5QgXUczHVvKj2QnVnrHwX9ZprbSy0CroOq+pNAM7VuKLDjnb08Mz7G7u/LbY3Kp6hylPt2AtIV23x8dAnOjWaHTeoBBRcR/7neLi6cHdNzkim2HfP5lA5ltcQT5fF19XJbiX1cK1AUIDRV4sF/NyG7F4S8T0I5/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020008; c=relaxed/simple;
	bh=dWPFnbmyPkg3JCwJVoTRzevxIvjZ9EcK4ygGhkhxqmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihCT/RFBjgLhPRSl+ZMIeUUf9sVgRjn3ah/AysGA9DmocdyAIB/Q1C/G0wSnHX7SHDHQ4PqTeBnek7fm1NnOIJFzaXCHaWbwydxukLOhl2bMWAUZNMmzhPIzkfe/5gbhbLYsAwQ/PPfCp1DSN2VENYfjkb8Wf5U74myql/xQ5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXGMIhga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXGMIhga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4991F000E9;
	Thu,  2 Jul 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783020006;
	bh=gs9qM58OqZN4iUhDYB+L7Nz0T20De08FWpjNMp4Ecr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oXGMIhgaKZsnBRCKoPQVgaCY3eO7LdzVvLLS3Be02/6qXyd9jBtkDeUHJP5Y4Luda
	 T17W3qoWJ2RwzOvVNyjWQWVMoc1Qqy2GZ/PsuQCSYgjZVAHYz39ZYNwD61ushI6r49
	 UnvBBolQMzrDcO+itC9+N2mMBHbysePXFejqYBcw4mjCQ7YP4PPIyZym0T2/h7jGJ5
	 /0/Oov3Cv1aIdsIyQ6bQFPvRqdFFbHr2A5S4wYAr9jS8jNPfijGY6yTJaCK4S8+nRI
	 Zecnry2py6rcZ/Nz7fOWKurpe8NtXMlhAGr4ylqBewj4mRQTe1GxEZLubwlWEUEpiO
	 2UQUu/7v14eDQ==
Date: Thu, 2 Jul 2026 20:20:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] dt-bindings: iio: adc: Add reference-source
 property
Message-ID: <20260702202002.79c1be1b@jic23-huawei>
In-Reply-To: <baeb24dd-214f-4dc8-a300-22b932c4b4ae@baylibre.com>
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
	<20260622-new-channel-props-v2-1-aafd5369f253@gmail.com>
	<baeb24dd-214f-4dc8-a300-22b932c4b4ae@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 14:40:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/22/26 2:30 PM, Kurt Borja wrote:
> > Some ADCs have configurable voltage reference sources for each channel.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adc.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > index b9bc02b5b07a4c7..fdad6b8276c934c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > @@ -73,6 +73,19 @@ properties:
> >        device design and can interact with other characteristics such as
> >        settling time.
> >  
> > +  reference-source:  
> 
> Since this is an array, the name should be `reference-sources`.
> 
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    maxItems: 2
> > +    minItems: 1  
> 
> Maybe minItems here is OK, but I don't think we should put maxItems here.
> This way, it stays more flexible for other use cases.

I'm curious. What other usecases did you have in mind?

> 
> > +    description:
> > +      Indicates the voltage reference source or sources for this channel. Some
> > +      ADCs usually allow choosing between internal reference sources or a pair
> > +      of external pins.
> > +
> > +      If a single value is provided, it represents a single voltage reference
> > +      source. If two values are provided, the first one corresponds to the
> > +      positive source and the second to the negative source.
> > +
> >  anyOf:
> >    - oneOf:
> >        - required:
> >   
> 

