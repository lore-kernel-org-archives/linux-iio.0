Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E857385D7E;
	Sun, 13 Sep 2026 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337581; cv=none; b=eP0ukIcIrGxU2+NyIAsheIrVGp+2NLozokA+LjBcH2JZc2XxlI0B5h3aubH3Z8g25whpP1jgtZLBPxPnUHlYLxtCWnPqkNwQwOTL2LtyQnoA/hb9vY7rJ1myDuKAoeU9mqtissa1SMAy9Og/leulCEIyl1yBD9tRyqvb53A7J1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337581; c=relaxed/simple;
	bh=0rbFvorL0Du/euB+4vx4r86cYkWnhaRhySS7yjK4Vcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF8QoD04gxPYgugKHmSA100Ou9qv82BFFINvHuBgrQFkrpQEJLJBqrt7VEQvTX708gs7WpNijASCoIiRfvc6h261MLqIEss7rAYOewba3tTtQQ69dicCvuHg4olnGboypOwwOLm0n3+3L3YdRboBiTNQTsSi3bsM+qqOBi/zdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqDEiZtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqDEiZtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C31F000FF;
	Sun, 13 Sep 2026 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337580;
	bh=JsD2EE4lsoHYAQP6NY5gIjFuae5qmCmIRSey9o/2VII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UqDEiZtEjon6I5Kp6ooo0AjXeMpHUi1fjoMP8mQlQS4OoktXKCU1qdJQLbh9R8lIh
	 0H30wHy/1VeNojPIYGwLl27DbKpKGaVm75wMm96PN1/A9/uGwsIEH+i+DTVck2f6BD
	 3LqYVNkruTN52HmG9oLZpAqCzyhoPmNuIhSfb6GdlEgHW+tsLS/RBzvY4hZ1xxHxVP
	 FpgL38Madf6ss4DcQW6j+F/+ncZvQAxeDN1QqUg4NihG86dcfK4gcd2QwVO57bUaOJ
	 5VbmprCY28nOtoIGmdKfJUNJIA9K+ciYk4sCzBJ1J2weqOt/L7gB6jjP5JwnHSTQK7
	 UBjYV6u/D2OzA==
Date: Sun, 13 Sep 2026 23:12:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau <radu.sabau@analog.com>, Salih Erim
 <salih.erim@amd.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: ade9000: add ADE9430 support
Message-ID: <20260913231253.5b6f0ae2@jic23-hlaptop>
In-Reply-To: <20260907101623.8730-1-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 13:16:17 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9430 is a polyphase energy metering device from the same family as
> the ADE9000. It is register-compatible with the ADE9000 but omits the
> on-chip dip/swell detection and has no on-chip digital integrator; it
> relies on an external analog integrator for Rogowski coil current sensors.
> 
> This series adds ADE9430 support to the existing ade9000 driver, reusing
> the dip/swell-less channel table introduced for the ADE9078 and adding a
> matching chip_info for the ADE9430 full-scale codes. A has_digital_integrator
> flag in chip_info gates the DICOEFF register write so it is skipped on the
> ADE9430.
> 
> Patch 1 is a standalone fix included with this series because it corrects
> the ADE9000 full-scale RMS/PCF codes to the same family-A values the
> ADE9430 uses. It carries a Fixes: tag and Cc: stable and can be applied
> independently of the rest of the series.

Make sure to check what sashiko called out.
https://sashiko.dev/#/patchset/20260907101623.8730-1-antoniu.miclaus%40analog.com

I'm not going to look at all on a v1 :)
> 
> Antoniu Miclaus (4):
>   iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
>   dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
>   iio: adc: ade9000: add support for ADE9430
>   docs: iio: ade9000: document ADE9430 support
> 
>  .../bindings/iio/adc/adi,ade9000.yaml         | 22 +++++++-----
>  Documentation/iio/ade9000.rst                 | 36 ++++++++++---------
>  drivers/iio/adc/Kconfig                       |  1 +
>  drivers/iio/adc/ade9000.c                     | 29 +++++++++++++--
>  4 files changed, 59 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 26bdafb3bdf58436579a1f6f0ef1ddb9011015ea

