Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B3399890;
	Mon,  8 Jun 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906387; cv=none; b=QPkiOmqARVOxQ+up/YZP+ND5Yft2278/33/+zbZ7Nxo29Yg4UApq/uVT9uaZahrRi1f3BzWzyxnUu8nDbDpr7wxa9+TgTMIu13Xp5atAahNYQfxrh6yo4X4WAI0Dr59jFTWRHUp1hNXELsYg79b4AjWMiynbfYE/z2zugUCSCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906387; c=relaxed/simple;
	bh=EpqygyKwWPRfEZl4jN+KZ+X0dTSOfzX66E6C7Tflutw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoTLOPlSGjsMNS+DA5BTd94bEN5k2u7l/42Jilsmz9X4Rf+EwsXCFNkglXsye1oAZ5TAEG6AV2oaoRc053aiIrcVAlaFjI64DXy7Esb3NWle2Hptu0xLtThWTSzuuYTTJXn48HMLBy3RrHJeOuWdFDgR0sHv84ZKEDwEUhURt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5we14pj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5we14pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BC81F00893;
	Mon,  8 Jun 2026 08:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906386;
	bh=lBiSpDFzyBw8SygSkG6XdPiQe6O+eZO6fnGKehZ4MpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5we14pjqyeMk8wsOAC7I12XYcSFzztcu6yOz3xlrTZMXwJIN4Gz7qfh3kP0ADJiN
	 i1b/c1F8C4QQ6HyFgXXHZ35qDxIiSZJG/1/SAOTOOxtaoyFMBxez64AWh1n67VHsur
	 +fG8UGHMpvTck0nAgtidlt9T8S60bB9lIYOukoCGciH6g+6phyLsv0TkqmwANK9EZI
	 /usyfU1sLRcYpNJc7Zs9bG1xK+28i+m4cB1LPTpWbahRUtSzo1Icc0+lSC98gjdil/
	 wzUnFLh/c/XkjfZ2wxz1BhR/JrK/UmWQPlibPp7Y6o0mNOQGuvKfwvnW8fiG2PsV6K
	 sjsRU38QPQWng==
Date: Mon, 8 Jun 2026 10:13:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: isl29018: support cover-glass gain
 compensation via DT
Message-ID: <20260608-speedy-gaur-of-joviality-180ffc@quoll>
References: <20260604054723.2983181-1-github.com@herrie.org>
 <20260604064925.3097108-1-github.com@herrie.org>
 <20260604064925.3097108-3-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604064925.3097108-3-github.com@herrie.org>

On Thu, Jun 04, 2026 at 08:49:25AM +0200, Herman van Hazendonk wrote:
> Boards that mount the sensor under a tinted or coated cover glass need
> to compensate for the optical loss before downstream consumers can map
> the reading onto a useful lux range. The driver already exposes a
> runtime knob through in_illuminance0_calibscale, but every user has to
> re-apply it after every reboot (or rely on a board-specific udev rule),
> and a power-of-two cover gain like 100x is a hardware constant of the
> board rather than a policy choice that belongs in userspace.
> 
> Add an "isil,cover-comp-gain" device-tree property that seeds calibscale
> at probe, mirroring the pattern tsl2563.c already uses for the same
> class of problem (amstaos,cover-comp-gain). The default stays 1 so
> existing systems are unaffected, and userspace can still re-tune via
> the sysfs attribute afterwards.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++++++++
>  drivers/iio/light/isl29018.c                        |  9 +++++++++
>  2 files changed, 22 insertions(+)

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

