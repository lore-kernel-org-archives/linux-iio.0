Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D20DD51;
	Sun, 14 Jun 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457100; cv=none; b=rtNjHWOfFszEmF3Jx18aAf7iEMWOJKj3ygZngM9ohlrgbF5PvFtFtCNw3Zm1h3kV6DgJ3tP5xXN7EEp5nghW6HoyIMUpAqt55CGUDh4wz7+eJIUNj/5NADMYup1+Dm7n/PWHjKbqrJpH/Asc1daQUlQOv0yNqEWYQOAZv0dfDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457100; c=relaxed/simple;
	bh=/EocOuA0/trkp1XprG5IxQTBMRoCl+rKz2ahWR2n0wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlzoqxL8pfYT0I0fMo+BPwqvPXg6WIfQtxPpwmnoM7ICT42gCqE5dXvcx5KxnbbJd4JilndUlBPi+j22cGFmjk8s/ID6QuWu870+np2//wvLQNLr5f0/YfuhJ4xObSvMH0mu0yZPw1p+D118yA2HvyXmzf5PRmi05cEWzWPje4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJENZEyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJENZEyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D801F000E9;
	Sun, 14 Jun 2026 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457099;
	bh=DCdzVaLtfObb9ZWcY0NE9dFqLduRZkfGF/mOGT7kBic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WJENZEyZBWe3+949+6oiVJgtitZd3LYuAyoJFHmYSKCxnRwM/AMDYzq1nYrKbNSIT
	 LunA/Hb6tG5KJz1R4yC2F8D7z8/kBN0R5UlCPbDnS28MUXoWrwCyMAJX7KHOgRlILA
	 ePSPKMM4r1FP+kZiCA2L/17m1RX7huz+ImquUWSJRPNmbqVaBnn/bWk5SZV+wgcGOU
	 jr8LI5sF6WWXV/8FsEPx+u+f+H8hqc6xmTB5PrjISjG/YwZcLh/KMVZNOiVl51kLKI
	 aA/lN4/X21MWjDIuCjIana8E+k8ktTpCxbEPiiEdtDCc2HA0WX96IsfM2IkpbtuWyg
	 0BZSzL2SUMt1A==
Date: Sun, 14 Jun 2026 18:11:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Roman Vivchar <rva333@protonmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee
 Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260614181128.4c1b762a@jic23-huawei>
In-Reply-To: <aihqeLKHC3PP436t@black.igk.intel.com>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
	<20260609-mt6323-adc-v2-2-aa93a22309f9@protonmail.com>
	<aihbxowyAIlSeDjH@ashevche-desk.local>
	<hacDZbv1Whk_g8AMSfJqKHrgXfyVKt2o3_UGK-1k9jNRJyMxEFPztGhytHvHbc1x9j-F84I_ZuprmXWf2Azbtdqj2vnVal4PO1gG_DijYyA=@protonmail.com>
	<aihqeLKHC3PP436t@black.igk.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 21:33:12 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 09, 2026 at 07:15:42PM +0000, Roman Vivchar wrote:
> > On Tuesday, June 9th, 2026 at 9:30 PM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Jun 09, 2026 at 04:31:59PM +0300, Roman Vivchar via B4 Relay wrote:  
> 
> ...
> 
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		scoped_guard(mutex, &auxadc->lock) {  
> > >
> > > I'm wondering why we haven't moved to guard()() here  
> > 
> > The compiler would complain about 'cannot jump from switch statement'
> > due to default case.  

See the brackets Andy suggested.  That error is what you get without specifically
defining the scope.


> 
> I am not sure I follow. See the examples in the existing drivers. They are
> warning clean in that sense.
> 

