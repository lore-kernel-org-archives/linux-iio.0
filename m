Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4E43B3E8;
	Fri, 31 Jul 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511118; cv=none; b=eAj+mo1wLmlNE8Pj8IsFA8Czq7YXiDJYIsKsPuSXavuMRYpwyIsSvfblmPE2caYtfaFxyeI1P3YHy/DAbDxJhdScB91jT9wdMbdm6eZ6gMhDwKbZKMV8K931k1a2omSCXe+hxjN8CBKuSusIj2FREkV8SbtL0YizPwmlMUnDYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511118; c=relaxed/simple;
	bh=0uVvrQ89R8BlVUlNFDw6jDJshkM3MaZnteng3LyjVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1bafr7smBklLYy72MvesI9TUiDqSOuZ0penYaMETnflI3aJrCgwgfds5c3Sp9oijDg0r4NLWopzCu1DZE7j2h57AfJsRa+344kFRXEk+8PjlTs7WTr3L3+dx0jyrjndKGZCSU0x2dyEJMrNBWycjaEW2oUE2LGvH80oLWOICYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkodmYSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkodmYSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EE1F000E9;
	Fri, 31 Jul 2026 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785511117;
	bh=8VpTkr4DQGJg1eGBe9qqD14xMAfZLna6BfxP2pjcrGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CkodmYSsbMWGnK2GEAqRlirwlKGlzq+ALm3zzV809VZbenZ8mVIryF8if3+OXUDXT
	 uJ8K83V1p5Gpy+mBXoY/jA2Ls/hws66H8Nz1EhxCkFeDJ5GG2uyXUdxO1IVDRjgbgy
	 8dKCxbmfnBasSFp+hk6R+YxwLlrqs3Bb0rs81+S/4qbL7/UIaipQxMmilWa7S/0REE
	 pTEtpv7zWWbyganScFBvmsA3r+hkZASk6cCELviljCZcX6fQrSdRLUOWV1pY7m8MaN
	 kQ8QayPde2gHPSki6rRMRfdP7kwHi6vKxQu7sFo4cA+sEaaQg6+Vmo37n37jjNQvrX
	 P0fFhEY2y4dqg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpp0M-00000000YMu-2PuH;
	Fri, 31 Jul 2026 17:18:34 +0200
Date: Fri, 31 Jul 2026 17:18:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 00/14] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <amy8ygTAV49s2C4z@hovoldconsulting.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>

On Fri, Jul 31, 2026 at 02:36:18PM +0300, Svyatoslav Ryhel wrote:
> Convert LM3533 to OF bindings, add missing VIN supply, add support for
> setting mapping mode and LED sources based on device tree. 
> 
> ---

> Changes in v6:
> 
> - expanded commit message in OF conversion commit
> - restored original comment regarding PWM mode of ALS
> - switched to FIELD_PREP macro in core for helper flattening

You seem to have ignored many issues pointed out in v5 so please go back
and review those comments again.

Johan
