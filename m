Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696841D102;
	Fri, 31 Jul 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508721; cv=none; b=RMjQclRYyYtrWQkKEKXf9AazjMlVyZKlxqiGuPjP7dTMI7QIQ00l5y35SzhbzQ2pzvDPlfx+yxaJTPzYlAwypXLuyPFi0njVftPBt0S6RIyl6oTVUUyZjzNe+BPGb74rdLfrMnv3CYIjVnWbkx2kk3HHWrQzHMWy1lifGSs18bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508721; c=relaxed/simple;
	bh=D0iGX09jG6t12uh/XUIoOftNpzULnzhpCSVFLV5Tlsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1dFxdVB9VqcVaMbce2wx6s3BayCTgVYuW2UWJ6H8tKYmbJJ4AodwXRHEFVs2HVVLgQTPTNVjvq1fdSNILAIzeb/hEpMSMOkDfnPj+hCtqzLdXroy/Oe3ombzmzcI7VJC1NS/B4MKylc+PsirDE5/lLTepZbENwE+0xByLz+N6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2OIJ/c2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2OIJ/c2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7AB1F000E9;
	Fri, 31 Jul 2026 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785508719;
	bh=JQiPASeI+iTk/iM+gPxiK5b1Sn7IYzuuwj7/KQy1pNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F2OIJ/c2wlmtSr+JDjj7YQ4RcoXEofmSmIDQB6qVzdbRBjw8aTCXQmBbdCMQlynu6
	 AYjO8hygFXtRNpgU3jNGD33VyI+U3oN4yqFn4OsPl5OiSX0hXTxfGt/kz5F57pJBEp
	 cKasEF5p9lIwGwdQnqJq1dalK7jw3oOScIcU5AK6mpHUjW5GAhNH4VqajksOzaKXdk
	 nR/NE4CRKGdaMEyOIgVxer3UlWLlwKNdracL7t+dg4U20T69/RRjeDlcQpwgdwg0Li
	 UMs8XMCbGNBysAeSgiEMEXwB7HPNZcKgHvHF+isJVxY0V1NQhisZtwrfUGcW5YBEmQ
	 jIUaIpfOeXXTg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpoNh-00000000XKw-0VDc;
	Fri, 31 Jul 2026 16:38:37 +0200
Date: Fri, 31 Jul 2026 16:38:37 +0200
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
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <amyzbWTFRpCxeHCY@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
 <akeEd0GcHSqScGIl@hovoldconsulting.com>
 <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>

On Tue, Jul 14, 2026 at 04:26:49PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:44 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > > directly.
> >
> > The commit message should explain why you think this is a good idea.
> >
> 
> Removing custom wrappers over standard regmap helpers is always a good
> idea, that is self explanatory.

No, and especially not if you're removing functionality.

> > Based on a quick look you lose the errnos that were logged on errors and
> > also the register debugging provided by those helpers.
> >
> 
> That is not true, regmap helpers will provide logging and you should
> not include debug stuff into the final submitted driver unless you
> have a extremely valid justification for this, debug logs should have
> been removed once the driver development was completed.

The regmap logging is a compile-time thing (added after the driver was
merged), and not equivalent to what the driver provides currently.

The driver also currently relies on these helpers for logging errnos.

Johan
