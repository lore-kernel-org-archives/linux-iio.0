Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40821272E56;
	Fri, 25 Sep 2026 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303645; cv=none; b=IhgkRp5qYW+OyRS0iHhjY0mECUnwu/pQ+5DOp1ESemz2JRD/zch9M2eHI8MC6Nv7kl4wZfCCp3FkqCVgPHFxj52qLk4UELAiq6XLPz2PCcPhQ2PRmsMc5QzPJjv0R/0wZ+frrvrK0/F+qk9nN+4XK4dpWaOeyUHuho6UHtfp0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303645; c=relaxed/simple;
	bh=TeeSQ9fFDyZAdqdO/I4zMXTqUaGGx6p5rjMz1ysnSxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFIfxFGNpiLv4mAAF72qyy3CpLdLO2RCPmlhy0TpKhaUtZIEVyoUPGrU/5K7TYnAlmrETn3BVhT7mNrWozZUfRrAvQ+zCIaxPlpQvcIkjlynZbyk8vJHStaQPVlgITrWsyeU1FsVpviUUD3mmu7WSxkzb0MtF5oJh6XVnl1jgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/3igz5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/3igz5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6941F000FF;
	Fri, 25 Sep 2026 02:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790303643;
	bh=h/+yYx+0xMAjB5zvAyeuWLKVfnSZn30lN+aJajSHPuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R/3igz5KqCXx0IyN79B84PgVi6Da34kpI6nuuwXdPjsezNH47U9mz97HH2Zsvd2Xb
	 wZlWZaua3y2JomIHHI3ZAVtfZnCl7oXf2ZjC4Ki3QqowCAYVNIsPJz12y4yA2ueZre
	 4U8hUTFayuf8ABUhuSSRtnCm9JTPine99vjeG5gor7dS9tF7Qhw5xFOFHsH15fJtS7
	 Nf6yrBChsZ4WiFdooLdEKZ0f3CkmKxJfHYquSek9xkLPCLCCSl/pwKWeAjM0lpcX2c
	 M7UdI2lpTGX1Gw2HBhw9maGbrAli2eoaVaP6V27KM3IEU46s3EZYmQRaW8O+n3cOJQ
	 bctVPiMTwYIQg==
Date: Fri, 25 Sep 2026 03:33:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: renesas,r9a09g077-adc: Drop
 unwired interrupts
Message-ID: <20260925033355.3137ea67@jic23-hlaptop>
In-Reply-To: <CAMuHMdUX9s1q6SdrgiMciGfHYAvCp1kFzGYL4pHf7PzzipEPUw@mail.gmail.com>
References: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20260921110144.44425-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<CAMuHMdUX9s1q6SdrgiMciGfHYAvCp1kFzGYL4pHf7PzzipEPUw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:30:47 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Prabhakar,
> 
> Thanks for your patch!
> 
> On Mon, 21 Sept 2026 at 13:01, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Remove the compare match and compare mismatch interrupts from the binding,
> > as these interrupts are not wired to the GIC on RZ/T2H and RZ/N2H SoCs
> > according to the hardware manual Rev. 1.30.  
> 
> These are indeed only wired to the DMAC and Event Link Controller.
> 
> >
> > While this change introduces an ABI break, the expected impact on existing
> > users is minimal, if any, since the interrupts are not wired to the GIC
> > and are not used by the driver.
> >
> > Fixes: 4d8d58987cb5 ("dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
I'll assume the dt maintainers won't mind me merging a patch that
drops stuff without a tag from them.
Applied to the testing branch of iio.git which basically means queued for 7.4

Thanks,
Jonathan

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

