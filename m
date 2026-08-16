Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F718B0A;
	Sun, 16 Aug 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909072; cv=none; b=fCkmGuIzk40QKmAF3c1tF2wAszuv0LzRGnL/ZReDrQ7l048IjIr+GJyud6wxcVzt9QMBMW9t3sXCKxCn2mowMnybvHKl1QSj1Hldw9n85B6H1+MqESTMHMwVZ2/km/uXYJZTZHx4ueNltu8wc7Y5S7ui+w6qaDOGRixwhClpYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909072; c=relaxed/simple;
	bh=Eg9Sf4COen7JWhleH49GrvobeHCRC5kLGWVb52OzegI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKRLM5SBZ/R88Gz6pGO8hKHS1VQywBTitY+jeKRsvQhN7AnJURriO8uQVb/9i8CNrX7OqefDgayXvqKJe0m8vAtZyYaSaJtj1dkFijESRurcGZf/uWlQQEAF3Jz/tHftNKqINCq+L86Cbe6q2/t21msZGOGTzHDIQGCPJags0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr6Pyz6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr6Pyz6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B729D1F000E9;
	Sun, 16 Aug 2026 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786909070;
	bh=kTNJtD70ZYPLMNbPu0S7+qzngDVI764ksoslrLSai94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mr6Pyz6DgW5XT2QmBU6bzBy2vPT4rm3yPOGdaniJMOKvFaTguh5xlmv9upmrIXbBA
	 7RT+/kyeRylMhv0lYGrDyYSVaejwOId5XrEP0egV4ZmTKNozFY7cCPVi2qSTWUGBb+
	 I5gpy0rASTRe0+Gu+wl3+ArwJgZkB0EcguciZdlzeuWDqCTEly41M8VaVxSxfBM2cF
	 WgxyI4uNWpoDdqjCm1AHOQ0zmQFT2joecBhPQxFzvGaBIG2tMCOMM1/e1k1jh0DB86
	 655Ra2LXp2WK9OlcKIwQ2abr+7ZRdUFDQNyuI/n/PrNtr7pDqy06IiHXOrIHGzWffk
	 pt0N4PrV1sH4w==
Date: Sun, 16 Aug 2026 20:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 07/14] iio: adc: ad7768: Add calibration controls
Message-ID: <20260816203743.12f675d3@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-7-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-7-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:57:00 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Expose the per-channel offset and gain calibration registers through the
> IIO calibbias and calibscale attributes.
> 
> Use bulk regmap operations and unaligned big-endian helpers to transfer
> the three register bytes.
No real need to add this detail to the commit description.

Otherwise, from a quick look this patch is fine.

thanks,

Jonathan

> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  drivers/iio/adc/ad7768.c | 119 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 108 insertions(+), 11 deletions(-)

