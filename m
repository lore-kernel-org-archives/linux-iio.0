Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245C3B14DC;
	Fri,  5 Jun 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664701; cv=none; b=DNFe3Bwijsp1KAuEiEqdLL0nJkkSX9gUocn12nDHaTcYVPVRF4N+uYCNRQtA3yLNK1h9ZIZDfDTRuV1N+d3ZiUpfIB/qdRiaLv5Q/lOTzqOQPhJiVD1e9b9aazdN+UIegKURZBFwEqAT5/JS9Ch3oebx+4QvTVZzPo7leLBfFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664701; c=relaxed/simple;
	bh=nkc7/V12WCqgo4mWTYWr3EB1MNEbN4G+00YZj7MrCQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYFv1nGg9shPiNU99/9oXe8R9iR86u9ilSteRt4GalzT2QmwEnEh+Y49f1DAvKLitEno3op0Lq7TQ6APXs6oxKmyk6IfiCLJ6buEhi0wf9KalJ6D/lBpkLV+gK9VumcaUUwmHD7PZTso1m9hVly4QgBdYtN3peqkQBqAIo4BrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHwsVi6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHwsVi6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD71F00898;
	Fri,  5 Jun 2026 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664699;
	bh=LmfcM+Szsu/Mr2EoU18oOGZQDuBSXg6hjYrOx2CQuzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BHwsVi6EmHTsAAuKfseFz/pa4Fom9zeQhCrx3rlG7IlbYr1y80VQp9Ec7WG3TeYCK
	 o8KLwdRDnenQw2xbjlgDkWnY46vGQm/ND71QbGDuXi0QTtn4uq+ZEBPYtzneFRfiZL
	 G0xugcjwhf6/dXdoslHHrG4IXpLbOS6Gjcgfn2sqkT2GUouMP/Ex3go+oPOho/K1Uk
	 nz7nU5MzKhrDQP/8suGzjuVL/b2qtubqMeovH7Y5Sn4ITCErwQQm8s1JVTzOc2qpg5
	 Zfv6v2a1jeVtCXgg3Jz06UEOqVQSbugkPKP3KStSWvvkMFoJqoHMW9j/QwKQwE+H8t
	 SOCeFac2CUFeA==
Date: Fri, 5 Jun 2026 14:04:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tomasborquez13@gmail.com, masneyb@onstation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: isl29018: add
 isil,cover-comp-gain
Message-ID: <20260605140449.1d7538ee@jic23-huawei>
In-Reply-To: <20260604-energy-lid-e7949164431a@spud>
References: <20260604100617.3486541-1-github.com@herrie.org>
	<20260604100617.3486541-3-github.com@herrie.org>
	<20260604-energy-lid-e7949164431a@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 18:01:08 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jun 04, 2026 at 12:06:16PM +0200, Herman van Hazendonk wrote:
> > Document the new optional property that seeds the ISL29018 calibration
> > scale factor at boot from firmware, allowing boards with tinted cover
> > glass to ship with correct luminance readings without a userspace helper.
> > 
> > The value is a positive integer (minimum 1, maximum 65535) that is
> > multiplied with the raw lux reading.  Userspace can still override it
> > at runtime through in_illuminance0_calibscale.
> > 
> > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> > ---
> >  .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.yaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > index 0ea278b07d1c..92ea2742bbd3 100644
> > --- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > @@ -34,6 +34,19 @@ properties:
> >    vcc-supply:
> >      description: Regulator that provides power to the sensor
> >  
> > +  isil,cover-comp-gain:
> > +    description: |
> > +      Multiplier applied to the ambient-light reading at startup to
> > +      compensate for optical loss in the board's cover glass. Boards
> > +      that mount the sensor under a tinted or coated window typically
> > +      need a value between a few and a few hundred.  

Is it useful to support decimal points on these values?  The userspace interface
does and you mention the 'right' answer might be only a few which means precision
at that range will be terrible - less of an issue if 100s!

Thanks

Jonathan



> 
> > The value seeds
> > +      in_illuminance0_calibscale, so it can still be retuned at
> > +      runtime through sysfs.  
> 
> Delete this, driver implementation stuff isn't relevant to the
> devicetree binding.
> 
> With that gone,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> pw-bot: changes-requested
> 
> Cheers,
> Conor.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 65535
> > +    default: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.43.0
> >   

