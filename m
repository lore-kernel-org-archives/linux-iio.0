Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07380288505;
	Sun, 17 May 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021190; cv=none; b=qnb+nbfQ5/9SVcN9vT74OUXsML9ohATXE5yWFpr6tcKzEkd8pSZFGkyHmX1pe41v4x+EeS5Vkg4C8EhI63JYYI98eyoYPBTgaLrr16ARJRic+ctoq/3Hgt0V+/1JRnWGKHeV2tcEcY8l5WI6hJxTkcbedSD73elsQ5G3NAQQiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021190; c=relaxed/simple;
	bh=GWLg1MwaJuT6FxnQTSl9CM6MfpL41cD4qEr5UVrr6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8B2ifrNy1YdV4omBXqFrYOTdx8CPQib6yIOEYMVnfx7mpNIQ5+IaqnrITnj7RL+RSq+Jpm+79/LF8k7pJGWZwfxXRlK9at2PIFnoHcg5F1qWEty5a0H54hegh16Fxc92+DC+x900k79gMD7WNvTe7KvGcU/RJovcZwsNC202aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbV1TKBs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbV1TKBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB77C2BCB0;
	Sun, 17 May 2026 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779021189;
	bh=GWLg1MwaJuT6FxnQTSl9CM6MfpL41cD4qEr5UVrr6Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbV1TKBsOsHLJ0uOYkfw/yYndYuODuQjt+WR5oIPfljcBWFku939x6AjiYvHbwbRC
	 szJs6smdUYHkgYabV/ToHPsxr7HGVHkpczFqH+1HnRF8dzD3+Q4QCVJLCLt+tYos2+
	 tX4SVk4K3rSB1w8do+Zmf1l6iz/aMMQBtsD/C2ku6/TMtOIHDcDe3dXxlb+ZacfPUr
	 +yzi0qnPuGt8wZUhnx+DVl/8flD3LbSW1SLLPXsSsyoNwLlht++IyLDJ5CAybrRca6
	 Pq+8SCEJoHDpKFXcVg9ZWt/JWScghPxQtFx10VHMO4UOti4RE2OjgD3h/g+ajZ7t7z
	 pC+xwUuq4GCNQ==
Date: Sun, 17 May 2026 13:32:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 6/6] docs: iio: adc: ad4691: add driver
 documentation
Message-ID: <20260517133257.4c56a7f0@jic23-huawei>
In-Reply-To: <78d4bb1c-4c6d-4781-86ee-458579ac6990@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-6-eab27d852ac2@analog.com>
	<78d4bb1c-4c6d-4781-86ee-458579ac6990@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 13:18:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> > 
> > Add RST documentation for the AD4691 family ADC driver covering
> > supported devices, IIO channels, operating modes, oversampling,
> > reference voltage, LDO supply, reset, GP pins, SPI offload support,
> > and buffer data format.
> > 
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
FWIW I finished giving the series another look and mostly didn't have
anything to add to David's review!  So subject to further discussion
on the feedback (and maybe a day or two to see if others want to enter
the fray), looking forward to v12. Fingers crossed that's good to go.

Thanks,

Jonathan

