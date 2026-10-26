Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980014;
	b=4dwWDnusbil2fAv+TVPYcbggvde6PVvPUTvVO+10MoWnF7wQGvd1e65ecTzffqT0OuNs
	 Bx2VBqSAqDqfQ41DgQ2efrtpQZEXx4Ax4GbDSpnJ1o3tI5Cy/rx8KDvBJUcKA+iqOm1pX
	 3lHhdwek/AHVxysXZcO7junb/SsrznQ2m+NPlXi4jHIYjaNhpPiFmEnvw1xpxA4eWanZo
	 /LRL9MP+1FkFNLNa6k2lts/AE8TU4aky3l46p583zniLuBqD/UhbhyYOWLxE1XtTA80KF
	 UPSdF68qJpM4HaX/FO8CLo4fZSWEa2BU+18U4e9bLCve03WwCRQw1ClZUNko+bRnZbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980014;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+TM8+YnuNl9Vt4dLLDn1RR/PQzmY6zFODPO/CLj7xWk=;
	b=Grv7CYGt7uOOyb+VWYqCiLX4DIrQP53+AF+4Hm4UhoWk4qP8LXKQvYUOtCDeM/OF+Fd4
	 ehDuC4Im26DkLhBEMUVNDz9HNO0Zy7JEFjBHx+xnGHJmfxziAqBjZNgjXuqHg7/GlaLiu
	 hu4GjqrIQy3fi/pLpZwJG0ui+L+BO8mHtZ8mfjiIP1IsAbHn8ojcCvDI+C7UqA9obnjYm
	 lZkgQ484cqqRlgxeFC1pVR6eIHYJ5tBAp7imrMexTS16OYxFILkWFHUHMkNH5UVuXuOlm
	 43/PDoEIJ6hmUnA480wseLPmBIaHmq7m8Oks3dM8dbXmB41g+hN0+MDsfRnQpSqdXsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMUPm3KI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF02606A31A;
	Mon, 26 Oct 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMUPm3KI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A75D1F01825;
	Mon, 26 Oct 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792980013;
	bh=+TM8+YnuNl9Vt4dLLDn1RR/PQzmY6zFODPO/CLj7xWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fMUPm3KIrrcRY0uJX5RbCqNAaiyEYNyHbENQCSPRwVhq4Td7d+aO8qKPu8lNEYjww
	 TcXODKldVWhN4Iw2Xs8ShBGVxsTliYjbTQSp7VOCn0rF5Yc8GSOZM9TuOImr2bCxhC
	 jLF2mpm+US0NA7wsX5m6esz/aHAZVHO3G6I42WPe36VyoEGNCSe51cgdwgfNS2whrn
	 sCv0qvIORsfmSVIsG+mrqE23ReBW9k++swHj4FBldViraczz4lZSmfJ1SEkg4NWbTQ
	 46XOGn1ah6IQv8m6WwiPQynoO+VOXjoLz07C8LkeEb7sgy54oMvN/FoyezaNtriGzf
	 fflFSjf4kKUig==
Date: Mon, 26 Oct 2026 02:00:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <broonie@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: Add spi-cs-composite property
Message-ID: <20261026020003.3f3fbe86@jic23-hlaptop>
In-Reply-To: <e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
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

On Tue, 20 Oct 2026 22:56:41 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Some setups combine several SPI devices into one logical device, with
> each chip on its own CS line. All of those CS lines must be asserted at
> the same time, so that one transfer reaches every chip.
> 
> Add the 'spi-cs-composite' boolean property. When it is set, every chip
> select listed in 'reg' is asserted together on each transfer.

To me it feels inevitable that we will see a device / combination of
devices that want groups of CS lines together and others independent.

Seems less likely we'll see more than one set of composite entrees.
Maybe this should be an array of values that match with specific
entrees in reg?

I'm not sure though.  Conor, Kryzsztof or Rob, any thoughts on this
or similar things that have arisen elsewhere?

The most general case would (subject to it not working) smell like

reg = < <0x1 0x4 0x5> <0x2> >

Where intent is that 1 4 and 5 are meant to switch together and
2 is separate.

How to do lookup on something like this is another question.

Jonathan


> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v4:
> * New patch. This has been included because without an explicit property,
>   every device with more than one 'reg' entry would have all its chip
>   selects asserted together. That breaks devices that use ancillary
>   devices for the extra CS lines, so the composite behavior is now opt-in.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 4894196c8f9c..456cb9095632 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -60,6 +60,14 @@ properties:
>        Delay in nanoseconds to be introduced by the controller after CS is
>        de-asserted.
>  
> +  spi-cs-composite:
> +    description: Some SPI devices can be aggregated into a single logical
> +      device by asserting all their chip selects simultaneously. When this
> +      property is present, all chip selects listed in the 'reg' property are
> +      asserted together on every transfer, treating the group as one composite
> +      device.
> +    type: boolean
> +
>    spi-rx-bus-width:
>      description:
>        Bus width to the SPI bus used for read transfers.

