Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058949;
	b=s9z+G6+QLv5yP/yU1rIxFhkeDU+F0IsCLECg4PD8L2xgE0g1RwY+N0b/AB22WBzHz/UH
	 T0YKsFDlbL+ywfzjHsdQQ2xNYJP75tqYu55nwYHKLRf/AvE7yzIHK9jjGpxkQastOVUnk
	 QfeenjzSRMx0seywiMSPbRzPowOQhWHmhotYBLk4/gohTl3NrXunWGpCRsZ+oj7XqIA0y
	 dHjrIZjOfM1E+Coef0tq+yu8d/3A170Vw1z28gJ/XMM4EEow7x+uBWG5iaSPgDmgMp2go
	 88RLezL2KKEOb6PIYavV7CX3qCFvp2SxDhx/2RUEXw8nhQw3WpXnyjz/zIE7uG4M+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058949;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tIDjMtKfk0aYNWuRHu1KyjYdYvIvGtewduZNxlyRCtA=;
	b=NYsSRhGdPj6onGg8FLeIdfeVKWb2k6dqixu8ON8xlCCk6WUPog+pNmYiwK7qv/yGHvYw
	 9Nwd/CKemWJjFfbcUT+SCX6dV0X+6mRq1z9xOX0txSZXed0BXKWh0yzGEGvtPpKNY07MA
	 gIMt9DvXvTKQHsskQOBHn3oNH2iCWmsoiG5zlu+rebJ5iJPbg9WmUrtuDZyivvhR1JWsr
	 Vec4gE0YcnKL62RtYftYN5y8YfG7WIgW4LizzzY40gddROyHJnR6/e+n3mbvtRn012em+
	 FQXFv8oEUhCeMmsF8W48tsFPkDB3iBJpMfuWCykz+YvCuE9pp8gkWx+SjBx3ezbx9qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYC75Fsl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D6606A326;
	Thu, 19 Nov 2026 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYC75Fsl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD4C1F000C5;
	Thu, 19 Nov 2026 03:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058949;
	bh=tIDjMtKfk0aYNWuRHu1KyjYdYvIvGtewduZNxlyRCtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gYC75Fslf6Mi91dsfzXmLKWTGi47DQ/fISexbIYh76BPBXaQZ5oPkBZynFVAkp+M+
	 pdymLkGRdsQ1G6To7eSzQEpSKx3kljD9oNlzBVRj4945mX3hfijD1QI+SwHDrjzlaX
	 WeAlV2To6M1Nh22/FJB+OPCGoaUfGQ5ompsdg25CliCSu7vRcknDrkwgHFlmZBoiVt
	 F+rA6BbY/qoagLFCW7ZdTCGf0U2FxpSoDjDDm0MqCNvBB5hi4sT0J/Y4cB8CAU8Yx0
	 ss8U0nyhrjYcsQZnATKK7RK3Fy/Erbv/pplV5QPikebv5J0A/oCrHv/dqKFDF44M/T
	 GrQEbHZER3Fzg==
Date: Thu, 19 Nov 2026 03:29:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power
 supply support
Message-ID: <20261119032903.4a0d3bf6@jic23-hlaptop>
In-Reply-To: <20261118-coyness-luminance-6d0c07e843b7@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
	<20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>
	<20261118-coyness-luminance-6d0c07e843b7@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 18:12:30 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Nov 17, 2026 at 08:08:35PM +0200, Roman Vivchar via B4 Relay wrote:
> > From: Roman Vivchar <rva333@protonmail.com>
> > 
> > On some boards, the chip shares a power rail with other components. If
> > that rail is turned off, the chip can't function.  
> 
> With these issues in mind, probably it should be made required, even
> though new required properties are an ABI break.

I raised the same on v1.  Seems it is used by various boards
in tree where we don't know which supply it is.  So whilst nice
to fix we might just be creating some painful build warnings.

Can go ahead and 'guess' I suppose or put a fixed supply on it
in the upstream dts.

Jonathan

> 
> > 
> > Add vdd-supply property to document the chip power supply.
> > 
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > index f655a570aac7..114cf87eb54d 100644
> > --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> > @@ -37,6 +37,8 @@ properties:
> >  
> >    proximity-near-level: true
> >  
> > +  vdd-supply: true
> > +
> >  required:
> >    - compatible
> >    - reg
> > 
> > -- 
> > 2.56.1
> > 
> >   

