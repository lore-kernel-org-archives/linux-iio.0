Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272228726E;
	Tue, 22 Sep 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036034; cv=none; b=VYfL8Lg/4pSUdrXacVM+IWtPSe7OjOQd+WI9npDL0LYJUCfDBIJA7GEH6vh1eggkkta3HOjD7dvQMB12qctJKo4bRWsrrs0tJbHY89DspvVeOk/f7aMfcsg+1uYCqYi//7h/pRX4amS1VnzSzfVQZNFKu2BV+jalpkYPpip6Bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036034; c=relaxed/simple;
	bh=EjV9dfHR2y7DqcxoV4cR9MIh6oreQRkK5gMDxJTWYus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJKOtujZ/y2k5GjB39DylOocCO+jvBDjD7pnPo+Ap8GyYjl+l5491vp4quJrj68n/1JENSEAZEz9nJb6kav+ZGfi2DHZ3LgoCLJ39I4hGpWXqTlgKxxm8khPQe0eQz6pubvE3Z4tw+JXhnPj4+JG9GRj+Xj5LTs3hepgCapbrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnXnzWIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnXnzWIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932DB1F00898;
	Tue, 22 Sep 2026 00:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790036021;
	bh=RmkLO6VWEOj6U21HO13TxLisuarthLMORrQkVWFvFJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bnXnzWINCxRnonXQCHU5sXqtlxUISGd7GxjvEHhB6cY3ImR6m0fsys/kmmCDl48LT
	 BT84i84S4whbQC1AdJMD5L2lvSKEgAjEnaJK7fIyddcuRgddKPxPsSAsSZBbEfbLL4
	 8LDKMPwQ8qZGrKp5JOF4WVhYtXKT0CWd/vqDvCtlbHf/ZHsKp39EqCcgNwdGNFHIEr
	 RUynKX24N7LU50F+iAePbbXVz6VrvX2enR6IkrVwHLPdXNi33u17QRB+WxpxN/XypA
	 1hdLWGdqGcbU2FqvjhnoCzSwi/6EkFJXbrfoy2pVnTmzWeKdt0Wd3vyG5sAd4rKYNy
	 kZPA2bhtGaV1Q==
Date: Tue, 22 Sep 2026 01:13:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Michael Walle <mwalle@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 00/17] iio: adc: Add AD7768/AD7768-4 ADC driver
 support
Message-ID: <20260922011336.3a52aa05@jic23-hlaptop>
In-Reply-To: <457da50e-a633-4508-a8e9-7e000933623c@gmail.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
	<20260921013732.6c5399e7@jic23-hlaptop>
	<457da50e-a633-4508-a8e9-7e000933623c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 10:46:41 +0200
Janani Sunil <jananisunil.dev@gmail.com> wrote:

> On 9/21/26 02:37, Jonathan Cameron wrote:
> > On Wed, 16 Sep 2026 13:13:49 +0200
> > Janani Sunil <janani.sunil@analog.com> wrote:
> >  
> >> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> >> sampling Sigma-Delta ADCs with automatic power mode selection.
> >> Changes in v8:
> >> - Introduce the DCLK divider helper in the core patch to avoid moving its
> >>    register-programming logic later in the series.
> >> - Document why register caching is not used  
> > Other than open question on regcache vs volatile registers
> > this series looks good to me now.  So let us get that resolved
> > nice and quickly.  If it turns out regcache can be used I don't mind
> > just tweaking that comment for now and taking a follow up patch to
> > turn regcache on when you have it ready.
> >
> > Jonathan  
> 
> volatile_reg would handle the live GPIO and status registers. I will remove the regcache sentence from the comments, leaving just the SPI framing explanation. I'll look at enabling regcache in a separate patch.

I was in process of taking this series and applying that tweak
so you could build on top and found something curious.
The ad7768-1 driver. However, I asked claude to tell me if they
were similar and indeed it provided a bunch of evidence
to support your statement that they aren't that close.
So fair enough and someone should talk to your chip naming
department :)  Applied to the testing branch of iio.git for
the bots to take a look.

Thanks,

Jonathan


> 
> Best Regards,
> Jan
> 

