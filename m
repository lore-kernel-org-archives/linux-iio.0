Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CA218EB1;
	Fri, 12 Jun 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281095; cv=none; b=WzUtYXcitEgkHE4ICuJrxa18bGBiDKcrDF9jk77jOxStq6faalVAUGDGAQPOEMpve2l/Ga9IIFikeLPzyebvxyauTTi5Va3opjYu+bxpBPXKN1rw0EKP7ggxrtoH2r+88KHWzp9Uwwe6V0KK2SLWYcO2Ow+XMp9geNWNnF9KRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281095; c=relaxed/simple;
	bh=gcN/ebDW59Eb8scLHGRO1cBHAeg7AB0pQ62NF8tH3yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn5ApB1Vn0I5ZWnfxrYC4UyHHl3Ct2ITzgrho9uMK4oO8TgvgHK4OA3DMimp0VLJ8B4zKgeQzpZM+IfeZHZyxK/qgWOFDCBwIhll4lxjc6sBYXQz1NvidNdRO4DosnEdpYRga0cp1fNH+WksbOsM+xpPjeQMhluDM8nLAvFZWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY40Iw/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY40Iw/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F6D1F00A3A;
	Fri, 12 Jun 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281093;
	bh=t59SHBM/VnxNzq8RXGo9/WOt6b2EmmZZqsobTFLaZsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kY40Iw/jyhoBShnqbs4tO+X4bPSLaSNBb69NP2nyAtkQfCRIlfETj5U3LYjbg+7vd
	 VU237ntWsQSo9Yr3akENeHyUQqIe0/Ha3yMvGxa4Ce8xs1/0wFluWa9qeaB3apMACq
	 EhFaTb5EJ9SX/UnDWB8DEqZB6XBpPCwV+OeXZ31afkcTk5cKdIbnIH1CGVJa7QqVvr
	 VahhRTGopjjbqlvbKpb+/YQnt0T2uXMsCZ6JTWagTE6k/XtjrxtOr1nlBKaaXGotaB
	 1ry8eZqr7JMbWcYvHMchXhUmToBacgrwJXkgOLT1NhvZDmnrq9D/TbWcVOj6qLkSm+
	 eJjd8clEscl/g==
Date: Fri, 12 Jun 2026 11:18:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Johan Hovold <johan@kernel.org>, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <178128109241.1149158.14270432284406889754.robh@kernel.org>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-2-clamor95@gmail.com>


On Sat, 06 Jun 2026 07:57:25 +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> ---
>  .../leds/backlight/ti,lm3533-backlight.yaml   |  69 +++++++
>  .../bindings/leds/ti,lm3533-leds.yaml         |  67 +++++++
>  .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

