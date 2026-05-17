Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A610F1;
	Sun, 17 May 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028591; cv=none; b=HSKEhrkodhH8zdpCj+eiB6gEVPpwSbiM2OUjli/WMylYhPOlBiAYH+ozGvgxEqIuUotVvS26ZjpJ+J3OMjRKWxJxomLHbUw2WHSNAYbktezuTEyaZlc+CZ3IZtcI1ev3k1Ak9uil6/bm0/xbWywTSWG7AnVs9DUT91XwiribY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028591; c=relaxed/simple;
	bh=XRvg7yra7Kdd4sPS1leUSWBeRh5YL1wJwU716C5+mGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEHqrJNeXku9bU51f3Vugzr91d2sjdvf+4gZabaIZhk5TqBFGG1cGICTFQlWUtlmxxkY/pF4DqIWBFnvoDogYlR6VKfUepNEQBEVbh0Ixhxy80M5JA2egkkKgVjYDnt6tjM6DS0tExXVopxMojRF6aIq50Ylrh2QuEPEIF+SltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1yIrzoh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1yIrzoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F48C2BCB0;
	Sun, 17 May 2026 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779028591;
	bh=XRvg7yra7Kdd4sPS1leUSWBeRh5YL1wJwU716C5+mGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1yIrzohA36EB2tN71Hqse39pioPcC1WDtf0UXW9ygXF2DdE6HsMhnfkStcBlXepE
	 nRdbjlY4CSfSdIKuwyC2vn31qiAM6U12npuo37thiXDLqsiz8jlAJu7+RYgv3/sIx3
	 1crlwW9UoyVQ/Ugy45XpJk4upAq0VlGtMXIGyUPSeW8uKboDbCgh9RP+UAJ6XBsG9F
	 sTncYs81d+e7athfKDtCG5gCt57IWW7uWRXpdhGvFAge/R5VSWIetgDvUimfODOsgq
	 9/5r7IEXeFlJnqVcbYJjmydNdh4+8yizI8PiUgoyFzDN0SwqcXn/wEcBtrwkwF3DXF
	 ujLANXWovB7Jg==
Date: Sun, 17 May 2026 15:36:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: dac: ad5504: introduce local dev pointer
Message-ID: <20260517153621.55b3436d@jic23-huawei>
In-Reply-To: <20260509142047.30302-5-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
	<20260509142047.30302-5-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 15:20:42 +0100
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> Replace &spi->dev with a local dev pointer to shorten lines, fix
> alignment, and improve overall readability in the probe function.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
Applied this one to the testing branch of iio.git

Thanks,

Jonathan
