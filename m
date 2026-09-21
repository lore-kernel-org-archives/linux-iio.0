Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEF1FC0;
	Mon, 21 Sep 2026 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951064; cv=none; b=iAejbQUv5nY5HIe5JWrncAjgTS1ZtuKlQOmk89RNl5E65y+yd9cEVdQs9WThCl/6Y9OTszCII+UeuL9NMfeZBXO+Z6j43iroHGGEXZgSH90e03Vc2SPmTl5dIoo0QHGAGYNSkHeWd7484oJOLRRSxq+GbOgKF6fhLAtL9gPvqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951064; c=relaxed/simple;
	bh=fEyJrD4fM1TOMN20zj8GkTWGs6QCJBjZpsC9mnQ7CpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAY9gvXldXp7yEnIw1kiG+YWr8tIiBe3Nc5150L3jadzeYt5Je3m65U6LrbAIUct74aAo5R5pwDX21i9Qz9Yvo35pj3c8OnxysnB7f3QbfLrMxdofhZ5Liskn1fHMnsDHneSKEnfu9n6S2vZoBVda8DWETEDied3ovLh41atQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLHdPv5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLHdPv5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605B41F000FF;
	Mon, 21 Sep 2026 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951063;
	bh=iA4yaejuCPHDfp6wPzf2OicNAH0GXVDOoCbUi0SH+co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LLHdPv5lS0JFWC/hBOcI+NzxBJRMe7wOqRzZjmyCHz05GwL3dXYA3auGUUsTVrKlL
	 r+IYQD3CnmTDM2mayGdURJOA6TEVWhHlhtDG+CtxlOSq3K0gFag426VIYOyGszhlug
	 SqKcKPrOYGSVcb4GTWGdOgiUn7TliLmf+3qliMLCiP1qvXvt+PzHSEbhCPYYFJoesH
	 2Ch/jtAWoRaJeD5KXe3XJWyxs7RRXncQznx0RBZvFy2iiDA3scrCfN5vlbKNgLKnLH
	 0BCTanU1OcU8PhYmWYSoPNzAhQZ1644uE8XCsq5qABtqRl0Ck3fZ4MmXmoQrVjHt7q
	 LZEf4vOXPdkDQ==
Date: Mon, 21 Sep 2026 01:37:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jananisunil.dev@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 00/17] iio: adc: Add AD7768/AD7768-4 ADC driver
 support
Message-ID: <20260921013732.6c5399e7@jic23-hlaptop>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:13:49 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
> sampling Sigma-Delta ADCs with automatic power mode selection.
> Changes in v8:
> - Introduce the DCLK divider helper in the core patch to avoid moving its
>   register-programming logic later in the series.
> - Document why register caching is not used 

Other than open question on regcache vs volatile registers
this series looks good to me now.  So let us get that resolved
nice and quickly.  If it turns out regcache can be used I don't mind
just tweaking that comment for now and taking a follow up patch to
turn regcache on when you have it ready.  

Jonathan

