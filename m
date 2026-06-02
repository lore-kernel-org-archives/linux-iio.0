Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2733E5EF7;
	Tue,  2 Jun 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408190; cv=none; b=nK5/oUrajBgVwhUGpOgbph00bXc2bAOi+cgl1np6JoqatUz19LxfoPaWN5bP4Ug8zWmfBGom6AynBOVUBROBsvGfDZPPiMuJE+9KvmSneScTKC2jn0X8paGn255A/if72w2n/pSReQ8JJJzXVC8h5sfHzaWNx+mx/nLzEojULnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408190; c=relaxed/simple;
	bh=nh6orATTER2LQH2juaJU4rl+QXg92RNv3CyQNlwKgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNpYGSENyAFfPbdcb+aEHL/plb1vJwFPwkOuHVcmMOgVxP/2JCwz09bQb001ERvAUpwLrJJmlDv/iJb9q2glp/UsS7n3NNp54zBgE+es3l+Uq8gBqrUJP6/2Gm9MrESTVRIDtAGOsfAtUeijuw0rlhxUKoMlDoGnP52BT+vArS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEJI2xOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEJI2xOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDAC1F00893;
	Tue,  2 Jun 2026 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408189;
	bh=nh6orATTER2LQH2juaJU4rl+QXg92RNv3CyQNlwKgn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEJI2xOFqnRLERO0ZNuHUIYwJdVwH4ta5GeKsFF/KGRoqlfx1++HpzfKt3943x7La
	 4M6EpxKIbvVnno7qCZCfmPK2G4dr3IrnyJ0M8HLwam3nKmSDSKGvXeO5l2ehjCk8fa
	 r3sJcldIWcfMsunLNyb4/rPmQCFmBO3Cz+STMIXWzuMrHbOfDlg9+6REQT7yHijXpA
	 84YdOWoDOWzpyxHoHzFqfpZQ2mumgjpBlRlaZQWjdOBJJQaKVgJzArS7JZn+5TZLfA
	 1rMFjj7QAt5/Gt41bxHIUUEoZEt94Ggf8DdYzXLdjLHocRzYev9+tIc0XTTodAAOls
	 dfOuWDXGhWssg==
Date: Tue, 2 Jun 2026 14:49:43 +0100
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
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
Message-ID: <ah7fd6hEtcTb5URS@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-6-clamor95@gmail.com>

On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight


Daniel.
