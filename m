Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD973E3165;
	Tue,  2 Jun 2026 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408153; cv=none; b=e5RBlwiWVsXlrirmgN9eTgPdMplT/fDlwU9imxPHEXWPitTYX5+8FotMmIBSMDCE3golgpwad4pG8XUpQoolPOS5qKnoOA4PPsRM2NkUVPeL3Pt/MGawivSoR+9ndNfyE1eMYQaFuI/2BdKjEeBnCPqNEVWoCPpniX5x5Pc5NdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408153; c=relaxed/simple;
	bh=Jxz7AiPZd+/zQM9BBDeTbCUyNUIlXYCv5RTkwcrq5a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPdwDxxljQDf+/XDCFjvauzlZf3zq7bQEfqxSQQQJLwVyZNRZGy1ps91MgptkWkwgPeD6N0WOCYqfWYe1YJ5TwsXw77Dd1dxFEaFrjTaYZy2/TdisPMdFkvQZBoeQyGhukzn3iBmK4XwNg9QwFesmOMXTmYtZBy5faE7v29/FWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhSTvcJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhSTvcJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A21F00893;
	Tue,  2 Jun 2026 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408152;
	bh=Jxz7AiPZd+/zQM9BBDeTbCUyNUIlXYCv5RTkwcrq5a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fhSTvcJp3Y4wVofTGFX+RijrcQQbKP2pMijXpaM6ocnQd6Ap1GYxt4H+9rkNFI1om
	 q9IkS5rnZ1VKqrIzacb8o9RrVYnXkgeEfPO0D2Hr5apbeU5COhOyU7N9Vtvbqtw2Sk
	 NgColEFOaeP5KkXKq91uCR14Pvckfi0NyDy5ojRk7siGla5f3aq398Z1U8A7ff2mUl
	 MuuyF68TWgPPFMm93qfC0Qlmhg6IiB+EY6vZmk0TjT9KqBa0rRXOKd8HLP055GSMH+
	 DMs1QoXpsTg1KXiFQ9beili4waQI3Kwoj+GI35uUb3LW67vBBp+nldG1MxWCSKO40y
	 jVquFADxvtkuQ==
Date: Tue, 2 Jun 2026 14:49:06 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 01/11] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <ah7fUhtIIEEMkJIt@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-2-clamor95@gmail.com>

On Mon, Jun 01, 2026 at 06:18:21PM +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight


Daniel.
