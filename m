Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAF4F4D12;
	Mon, 28 Sep 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624092; cv=none; b=Q6APYz1Bu7hXi2B9V+jk+aWyb9v90ZwJKlp9EB6c4SClOsPLqqG7XFSVx5KTJpxna1CIcv1iHwptU4h9fhj5spHSco4kh+jm3snh69Mk17PTPp9Z/iN7JaWP63YdHMmF/y4hOeV54xGjGFurDzxg0Xki2s0EpoaQS35tddFLFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624092; c=relaxed/simple;
	bh=DB8WMXkG6C1Ol7NloRc8Tk3YSFGL/cSsvFyWddOJR/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYr9CSq9ibsDymCpE3+AKHegh6sqgZuscLCy14sYJo4wN1a0ojEdgkgI9cIWHnjYOihndKUlENaQarYSzBjwmtRsAxHCPm2ehiONahIehjoF2zvGFN/DOYKPC11wpkFaKqMNACQcsdAcuu6qWt/Vfksp4xnVzm8G5qn4HZSMgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDaEyohq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDaEyohq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFAB1F000FF;
	Mon, 28 Sep 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790624091;
	bh=FpxOKoiNxtb5wNwDbhqEbXBDadhI7NttewW4L/Ev6Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eDaEyohqvXgcRAMlSxll4wHNHtT8Lt8SFffw7o5gJfgOy0m7KeC2xVV6Pku4UtomT
	 ywSSndqpUhOmSNVFypbjul8fRDcn/eKaxLCeqeNvp/YO2+K5e5uRUoZAAY0ITWxcml
	 1I11asXsSvNsOLavbfIGV0QewNIBXq1AM12xzAKbavKXIvnQMsEKCVOLzJG8w4/uZb
	 GLf0pjgGBUv2uo0oqIYTJvGhPEJ9GMmFzTdxuyj7Bmt0gpKbctnuuXuqatDicJBz8I
	 bxrmY6Wxs+jEoWeXALkpAX3+0OtrcqPF7LA1PYJIJb+aRLhKm1OiKe0KECOMfh4hAB
	 Xp2RMZswhi0Eg==
Date: Mon, 28 Sep 2026 14:34:49 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arka Mondal <arka@arkamondal.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, arkamondalofficial@gmail.com
Subject: Re: [PATCH 4/5] dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to
 20 mA current range
Message-ID: <20260928193449.GA408126-robh@kernel.org>
References: <20260918122032.134947-1-arka@arkamondal.net>
 <20260918122032.134947-5-arka@arkamondal.net>
 <20260920193949.45606414@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920193949.45606414@jic23-hlaptop>

On Sun, Sep 20, 2026 at 07:39:49PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Sep 2026 21:20:31 +0900
> Arka Mondal <arka@arkamondal.net> wrote:
> 
> > adi,range-microamp gives the 4 mA to 20 mA range as <4 24000>. The
> > values are in microamps, so this reads as 4 uA to 24 mA. The original
> > text binding described <4 24000> as the "4 mA to 20 mA current range",
> > and the data sheet (Rev. B, Table 32) confirms range code 1010 is
> > 4 mA to 20 mA.
> > 
> > Add <4000 20000> and mark <4 24000> deprecated, so existing device
> > trees still validate.
> > 
> > Fixes: 777baca07ef1 ("dt-bindings: iio: dac: Add docs for AD5758 DAC")
> > Signed-off-by: Arka Mondal <arka@arkamondal.net>
> 
> DT reviewers.   Better to paper over a dt that is specifying the wrong
> range as this does (deprecated) or just make it obvious by failing
> the binding checks?  I'm thinking failing is better as gets any such
> dt fixed up faster.  I also suspect no one actually it this because the
> disconnect they should have seen when reading the datasheet and considering
> what they wanted should have meant they saw this bug!

No in tree .dts (for which I don't want more warnings), so I would just 
drop it.

Rob
