Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AE3B42D8;
	Wed, 15 Jul 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094777; cv=none; b=EtDG9e6adNbGxPNJr/xd2b3Af7Yw+Zf0b9bv7zLPQVlbQRrDKYPEsXE3906zmRgaZSPDxLqLFbQOh+ZN5QnxoDmeSnxZP6ZDRnN8F/+4thwxY8pPo4wiKQxSOnuM0ICOxBFBP6mlZeXohNg9imjKhfLqEmNSCCfVDEoXqvRLrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094777; c=relaxed/simple;
	bh=Bnf8Kr7M6RP7552nI4cVLguwiNl8bewgapBL8lss+Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK6bNBhQGRj9JaL2BI1031dZbx0o3gTDphcq8nFx7fOPUeF1FOzAVsMkaeQGum8oA1Vau3PbFaPQmGag/2T+SqU+k4HuYxY405tX/8D32YifrEUi3OvYV0XGycfOPVGtuaTPAgNolbKHNnWAYWoWl4ZCCHrP60aykkbyjNAAASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utt6IdhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utt6IdhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A794B1F000E9;
	Wed, 15 Jul 2026 05:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784094776;
	bh=BPqTWtMWRZnaTjMyesIoBK4WlRuWrOqcwpIjcyFXNQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Utt6IdhRDKg05d8s6Wqci+sxf2/QZusGgRUISuACOOqhymszH0lfpUwvJC/F8UkZA
	 YB0Rwz1EEn75kyk3gJq37yj4lKL/4+lYzI+RTmCSbiTZ/XO8A3m/xE0uMEVLt2X+NS
	 vOOkpj9JllYMX2gbWsTnbV8vshdOeVLQUC/weqySTW0+DOr/utgpnkBUFUVx2UNqKJ
	 78d9wG2nqwRvEKhfMHP3t4CprbGoLf+gweMtwzortCOuFmBggiaB5HM+bGQrJbihRf
	 OdJHv8V4RCjGRsSAh+Hy/Sys4OH9Iai41im21ic2KolMhv6YUlg8L1v9PPWU9+wm6w
	 YfzjDBfqfCdQg==
Date: Wed, 15 Jul 2026 07:52:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
Message-ID: <20260715-mottled-uncovered-mastodon-6c08be@quoll>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713215842.69097-3-macroalpha82@gmail.com>

On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Interrupts are almost never required for IIO devices per upstream
> maintainers. Remove interrupt as a required parameter for the
> devicetree binding.

That's an odd statement. We do require interrupts when the hardware
requires them. We do not require interrupts, not because we have such
policy, but because hardware does not require them.

Plus, we do require interrupts when software implementing ABI requires
them.

Above commit msg is simply inaccurate and misleading. Instead, please
use actual hardware arguments or how ABI is actually used. You must not
introduce changes to ABI just "because" while for example making that
ABI conflicting with existing implementation.

Best regards,
Krzysztof

