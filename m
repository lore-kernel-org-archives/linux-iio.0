Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3002FFDE1;
	Wed, 11 Mar 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234278; cv=none; b=oJvuhESoXgUk+p5MiOmr28h5xKyVMXHNFcUYr3thND2iavfB0375oz/GsRFS+sapK7rOCTaYJ7Q8ydrTvky/WK6XJc5m+A8lrz+nNizd5iuHNi+OHwotSXcLRNJ2KYuhgLEzVf1k/8g9NNEs5golk/u1+B/peLdCifXpEqb2S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234278; c=relaxed/simple;
	bh=8o/nRfc4LXRembuRgqC+qmKlYNBcimO62f4HGENnZ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax5KDvtTVdmKpXEI/wrTRpWvNOnGHc5akYHOBpDlkzL+8GKb113wOlVl7CgS/+6s8Vtm++Fo2XjYqVzB13Lj/97XkjvfHD9PMLOgkxx9Q6PIFVtAK52xeCnzgLvfNugwpLsx7W6Bdg+aD6psWwqwkqemTtTZKRVaGlpSy8h+Y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkP+0bSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkP+0bSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A370C4CEF7;
	Wed, 11 Mar 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234277;
	bh=8o/nRfc4LXRembuRgqC+qmKlYNBcimO62f4HGENnZ0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkP+0bSJUtLRxoJLIZlB0t+c58PI7JxJVjY817K89N1uGFEiiccuwwIwkRniy8iSu
	 E1+CNqgyQ2VTdLSBbbJGgo/g2txueqwI5bQNmymwqfJkpWDnn9qLapBQYJHxOBwKUB
	 P6m5AYRgiDdAm2y8jnucvzMQiklxBorP5LB0uef6aRdrP1G6rCGUlEJ/XQ1onpYdSE
	 nAHMeFua3X+19GiyUlEMN4LANKpQQ4W6JEJFItarVbwv07NpN9N8B6jn/ZCNXQ9+kR
	 F5IWEv89RDUIe0NAZanemmy1u8WWZw5r5aqN+x0WO+HFZLUk58DlacKzBZY7JrDik5
	 bLpK14V4/NEOg==
Date: Wed, 11 Mar 2026 14:04:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David =?utf-8?Q?Marinovi=C4=87?= <david.marinovic@pupin.rs>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	michael.hennerich@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: ltc2632: add LTC2654
 compatible strings
Message-ID: <20260311-sassy-successful-earwig-afbd8e@quoll>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <4915e1023c72d2681b0c4ae028ec609e@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4915e1023c72d2681b0c4ae028ec609e@pupin.rs>

On Tue, Mar 10, 2026 at 04:32:05PM +0100, David Marinovi=C4=87 wrote:
> Add DT compatible strings for the LTC2654 DAC family variants
> supported by the ltc2632 driver.
>=20
> Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
> ---
>  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml        | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/d=
evicetree/bindings/submitting-patches.rst#L46

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

