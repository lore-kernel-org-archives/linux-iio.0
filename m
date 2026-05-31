Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5B367B68;
	Sun, 31 May 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222543; cv=none; b=iufVWmamp6oxh6JTJu7+DtvgBfUDWFyls0VYLPmz29rUOVRvI81L2aaBPJ1reRzuItmQ4YPXv47gD7KHHBB/XO+zdr2YthR68rMDRr7da3N3L7cJgs100HjA1yhEIw29Z+AfNB5CzobP6V3tvGa8Ugd9ofEd08uf7R9q/4JalHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222543; c=relaxed/simple;
	bh=fFfEnenGpqiMy8RY+LmtZSJSbyW0b9y6Cx19k5YA61E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZXlY1c3a2lIR/Ut4ZUicBeNo2rxzWvFw4g7RnG8k6t9CAc+3NVFKY/FJOjES+iVa8RYN8L96P/64COs3LGCdOxa4h8pbs0PRUdnYA2ubVytiDS8YBaal1NZ1iaNd+gPVmfoXDc18us1Qgb1epVb5I+GWPFIAhpO2OV4BT0NZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQPKatSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQPKatSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2171F00893;
	Sun, 31 May 2026 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222541;
	bh=nZDppJ+4L0BDYGs3LsrW8E/P6Se2lkRuz5HgqiQzPS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OQPKatSjoAOJzIzh3MWkDrzAFv+TPRxCcQq9BVsxlLqgoxiDJxuKA7RSL8qmsyQRd
	 o4thwBMn37smPt2kS2jBUXP3ddTPpEtl0ngyFh5ewXfUBtP7smv8kQiqeSnjwQ2WvT
	 4Almt11Y7It7RTDXyR2pVOoWqfU/H+g9l2wBi9cw0KRj4ngJmqwBSiiwpJ1UHEWJVc
	 zu6La/XgYkCg/ZXqqTeJleo6+Bo8NBzDz2z5FPF5t3khIssFIHHxJlkcxjdMKmYQsy
	 /B2Mfw4YSX0wQ+z9kpKzOPbq8UTpQ47sNQSb7NA+vnR8MOSaRaWCx6QsJkGb3ZCcVm
	 2Wcy2znjCmD2Q==
Date: Sun, 31 May 2026 11:15:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v14 0/6] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Message-ID: <20260531111528.32697d1f@jic23-huawei>
In-Reply-To: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
References: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 13:14:59 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> This series adds support for the Analog Devices AD4691 family of
> high-speed, low-power multichannel successive approximation register
> (SAR) ADCs with an SPI-compatible serial interface.
> 
Unfortunately I failed to notice I'd actually picked up a version
of this about a month ago, but more issues came out after that.

Whilst I don't like doing this, to avoid a messy history I've rebased
the main iio tree to drop that earlier version.  Hopefully not too many
people base their work on the togreg branch of iio.git!

Sparse is giving the same warnings I pointed out on v8, but I still
believe they are false positives. 

drivers/iio/adc/ad4691.c: note: in included file:
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsigned long
./include/linux/bitmap.h:845:55: warning: shift too big (64) for type unsigned long


Applied with that tweak called out in the earlier patch to the testing
branch of iio.git

Thanks, 
Jonathan
