Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5C3BED75;
	Wed, 24 Jun 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313755; cv=none; b=AbqoQRS2IYel7HqAFop9/3dEu5w4fKK1FeQrXD1OcsZZb3GLxIXY8gPKt94qRdX13aldHEreUMGYF3ZneQcPFBiR+ho32DbeuaodCgs1S/un+omtxpzN/vw/96O1V9cxLkC5M4JzL6RHFwcLoEdLi53HbMADFnGUyqAVqO2UZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313755; c=relaxed/simple;
	bh=Q4STcZBn9jDOBlIWOz1TFM8jYawhcoN9Oj9kUsFELAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwBO+cpEI5S+wZZ711sB4FuP8sRbdxRZZSD52bayuX6oxaC/X28zdj6UOCjOY9N3UosFaW/rXAPZu6RZmCn0rhCc6hxHH7vmN+uo8r6VxLd4c8IeCpBays7wGb0NaEHYGmk/h/jvGypLaYnlZ2ZdivN2HgY19OEDSpaIlr0fCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgLhsE1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgLhsE1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D611F000E9;
	Wed, 24 Jun 2026 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313753;
	bh=A6ImJfiFT1rjKG/4L8x7j/qD6P8AeigTAHUIZIXRv6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MgLhsE1gVbNojleBdNPQso/54fAa900HQVb6C2i352kKJBD+mbDuOoG8lqyVvKXlN
	 sTNXFni5jLj40pPpjYNpJxQV0eOSSRpQaZlad4S4T/I+TKrfMf2LKxFoSW7qVlahF5
	 mlekdG3hvEJannXNh1q6YnKkn9PFfygAuLReAWAmf8G/2V2TL/qT+RoVbr9H99IWkf
	 pf3snnjeEWbTEpFTictqgszYkVhpn4IVg1Ommzo7sC1V5xQiLJyKVArELxc1zyuNaX
	 ApRLHmkwUdgrZ2AJyfkeBJbedDheuEDcJkczcRGoZtk/I59YSpKb7HrXoJUSKVAYTt
	 qLNtp1eK0M2DQ==
Date: Wed, 24 Jun 2026 16:09:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: me@herrie.org
Cc: github.com@herrie.org, Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Denis Ciocca <denis.ciocca@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Denis Ciocca
 <denis.ciocca@st.com>, Linus Walleij <linusw@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: magnetometer: st_magn: honour
 st,fullscale-milligauss DT property
Message-ID: <20260624160901.189ee5bf@jic23-huawei>
In-Reply-To: <edcf262b530a88ee602fa07edc8382ac@herrie.org>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
	<20260616-submit-iio-lsm303dlh-magn-fixes-v2-3-063edcf74e60@herrie.org>
	<20260623202916.5f5d520e@jic23-huawei>
	<ajrjRdEkZAho8h1E@ashevche-desk.local>
	<edcf262b530a88ee602fa07edc8382ac@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 06:18:45 +0200
me@herrie.org wrote:

> On 2026-06-23 21:49, Andy Shevchenko wrote:
> > On Tue, Jun 23, 2026 at 08:29:16PM +0100, Jonathan Cameron wrote:  
> >> On Tue, 16 Jun 2026 15:02:06 +0200
> >> Herman van Hazendonk <github.com@herrie.org> wrote:
> >>   
> >> > The ST magnetometer core's common probe hardcodes fs_avl[0] -- the
> >> > highest-sensitivity full-scale supported by the chip -- as the
> >> > starting range. For the LSM303DLH that is +/-1.3 G; for the
> >> > LSM303DLHC and LSM303DLM it is +/-2 G; for the LIS3MDL it is +/-4 G.
> >> >
> >> > That is the right default for "minimal noise floor at a desk", but
> >> > it leaves no margin for boards that pick up appreciable DC bias from
> >> > nearby PCB structures. On the HP TouchPad (apq8060 / tenderloin) the
> >> > LSM303DLH magnetometer is mounted close enough to the surrounding
> >> > power planes that X reads back as the chip's 0xF000 overflow
> >> > sentinel (== -4096 raw, the value the chip publishes when the ADC
> >> > saturates) on every sample at the chip-default range, while Y and Z
> >> > fall well within the +/-1.3 G window.
> >> >
> >> > Parse the st,fullscale-milligauss device-tree property (documented
> >> > separately in dt-bindings/iio/st,st-sensors.yaml) in the
> >> > magnetometer common probe to select the initial fs_avl entry by its
> >> > mg value. The DT binding pins the accepted value set per compatible
> >> > via allOf/if-then enum clauses, so a malformed mg value fails
> >> > dt_binding_check rather than reaching the driver. Sensors with a
> >> > fixed full-scale (fs.addr == 0: LSM303AGR, LIS2MDL, IIS2MDC) have no
> >> > register to switch and the property is rejected outright for them
> >> > in the binding; the parse block is additionally gated on fs.addr as
> >> > defence in depth against stale DTBs.
> >> >
> >> > Per-sensor mg ranges are listed in st_magn_sensors_settings[]. For
> >> > LSM303DLH and LSM303DLHC/DLM the valid values are 1300, 1900, 2500,
> >> > 4000, 4700, 5600 and 8100; for LIS3MDL, LSM9DS1-magn and LSM303C-magn
> >> > they are 4000, 8000, 12000, 16000.
> >> >
> >> > Empirical scale sweep on the HP TouchPad confirmed that on this
> >> > board any fs_avl >= 1 produces non-saturated X readings:
> >> >
> >> >     scale (0.001 G/LSB)  | X raw    Y raw    Z raw
> >> >     --------------------+-------------------------------
> >> >             1.100        | -4096    44       46    (X saturated)
> >> >             0.855        |  -547    37       37    (clean)
> >> >             0.670        |  -433    94      103    (clean)
> >> >             0.450        |  -266    44       71    (clean)
> >> >             0.400        |  -235    34       65    (clean)
> >> >             0.330        |  -196    27       56    (clean)
> >> >             0.230        |  -145    15       40    (clean)
> >> >
> >> > 2500 mg is the natural choice for tenderloin: comfortably outside
> >> > the saturation regime while keeping useful precision for compass
> >> > applications.
> >> >
> >> > Assisted-by: Claude:claude-opus-4-7 sparse smatch clang-analyzer coccinelle checkpatch
> >> > Assisted-by: Sashiko:claude-opus-4-7  
> >> Hmm. First time I remember seeing Sashiko credited like this. Seems 
> >> like pretty much
> >> every patch series of any complexity would end up crediting sashiko.
> >> Out of curiosity were you just looking at reports, or were you running 
> >> it locally to
> >> help with development?  
> > 
> > I believe it's the second one, because LKML version uses Gemini (as far 
> > as I
> > understand the case). At least that's why I haven't commented on this 
> > tag.  
> I have the whole toolchain running locally to avoid too many submissions 
> and
> feedback from Sashiko with Gemini after submitting. For small drivers I 
> can run
> Gemini locally as well, usually stick with Claude Opus 4.7 since that's 
> what I
> have a subscription for. For very complicated and large drivers Claude 
> Opus
> tends to time out even with 1 or 2 hour, so I fall back to Claude Haiku 
> 4.5
> (which catches quite a few things, but is not as thorough as Opus or 
> Gemini).
> 
> Seeing Sashiko tends to provide different feedback on different rounds, 
> I try
> to only submit when Sashiko and all others are clean.
> 
> Hope this clarifies!
Thank!  I loose track of all these models :)  So the summary is very
useful. I've been meaning to get a similar flow in place myself for
checking local stuff (not that I'm doing any development at the moment)

Jonathan

> 
> Herman

