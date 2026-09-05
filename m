Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA791B142D;
	Sat,  5 Sep 2026 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573380; cv=none; b=R5wL+47UvRSqrb8YdLHs+WA65yQMFY1wHqdsjll2RQo8TfHLOph4YGPIjmiKa9yysH5QWmM0RMEMJv3bAY6N8z4n3NLVS46SzXMfq8Wc2hAciY8IW041RstxS7domuLGef2XBcH1qW4zGrdkkZSxk7faD0D5oiZy37sFhCC7pHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573380; c=relaxed/simple;
	bh=vhswVRchz9WH88bkqnv5kfKXkN6R3/67IKTUvMhtY4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwD+jgR/n2GL9yc4wtLWEjNJ/kKIeH5LXV9hgzhmIPsWfZagjYQxqQTO/0pPDJbS3yBjrng2I4XJwz7UIUqdZ6LJDJK3wTVETWAgESc2Qy2dYD7SbftTDdEXgEiFPDbzNYqwaL3Aei2K1FYC6vFAmAKm+dim3m/YdCQe6NXWF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCG00rMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCG00rMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A251F00A3D;
	Sat,  5 Sep 2026 01:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573379;
	bh=9UT0/F6y1764sFTGutF3RASzJlnuZnOnI0rCKZlWCdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nCG00rMn0xvXQh6GX6ZktENkfIhD32qkjzsYZxo6KHJ4kzL1oGa4G0FVZLqx+/f6s
	 rkhvdProYIGTF/a9OH6QGIPsWmaIZLn+Gpo0tHv92bn4H3PVa8xFWawwxlIzdEtxc7
	 kZj3jAMHkmHvcApCc8PWrA8mpHmCIxM5NxUtMjAoFIYG6zNHfxGEIUV4FP22tORgii
	 i6Q74srbLiQAveAQxJendd4TfugSnXV1LMGAuOKPquqImUF9Wr84mFAq8K8avGL9Ew
	 pgQ0PwXPVyvAxdcMkJ2WSedj2iUrvvq7TxT99LGU2up+hdIQvTff7rJp0MUNFRsBp5
	 LMyLZH01T/NDg==
Date: Sat, 5 Sep 2026 02:56:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
Message-ID: <20260905025612.09363f51@jic23-huawei>
In-Reply-To: <61d64649-603d-4a55-a789-babe655a2de8@baylibre.com>
References: <60dc58c6-dfe2-4377-9a73-f65cda56179c@baylibre.com>
	<20260903151939.5117-1-flaviu.nistor@gmail.com>
	<61d64649-603d-4a55-a789-babe655a2de8@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 10:30:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/3/26 10:19 AM, Flaviu Nistor wrote:
> > On Wed, Sep 2, 2026 at 9:31 PM, David Lechner wrote:  
> >> On 9/2/26 12:22 PM, Flaviu Nistor wrote:  
> >>> Add support for an optional label property per channel similar to other adc
> >>> chips. This allows assigning distinct names for each channel which can
> >>> match the schematic signal name.
> >>>
> >>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> >>> index 718f633c6e04..777a75c21d7f 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> >>> @@ -66,6 +66,11 @@ patternProperties:
> >>>            - minimum: 0
> >>>              maximum: 7
> >>>  
> >>> +      label:
> >>> +        $ref: /schemas/types.yaml#/definitions/string
> >>> +        description:
> >>> +          A descriptive name for this channel, like "vcc_ram" or "CH3".
> >>> +  
> >>
> >> Apparently this chip has quite old dt-bindings. Normally, we would have
> >> included adc.yaml to get this and other channel properties.

Quite a lot of bindings predate that generalization work :(

> >>
> >> And we would have used diff-channels and single-channel from that to
> >> describe which pins are associated with which channel rather than having
> >> a magic number for reg. And the ti,datarate looks suspicious as sampling
> >> frequency is usually we control at runtime.
> >>
> >> Anyway, none of that is really relevant to this patch. We'll see what
> >> Jonathan says about using adc.yaml here vs. adding a label property.

Given it's only a single property and label is pretty universal
I'm fine with just adding it here without the reference to adc.yaml.

DT binding reviewers may disagree however!

J

> >>  
> > 
> > Thanks for your feedback. I can also use:
> > 
> > $ref: adc.yaml
> > unevaluatedProperties: false
> > 
> > and move additionalProperties: false at the end of patternProperties block.  
> 
> It can't have both unevaluatedProperties and additionalProperties (hopefully
> the dt_binding_check would catch that).
> 
> > Any other idea?
> > 
> > Best regards,
> > Flaviu Nistor
> >   
> >>>        ti,gain:
> >>>          $ref: /schemas/types.yaml#/definitions/uint32
> >>>          minimum: 0
> >>> @@ -125,6 +130,7 @@ examples:
> >>>                  reg = <4>;
> >>>                  ti,gain = <3>;
> >>>                  ti,datarate = <5>;
> >>> +                label = "CH3";
> >>>              };
> >>>          };
> >>>      };  
> 

