Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794990254;
	b=LO6TLvmdQIebYwgT0HRCBpDyVx7Sek6YdFiAtfpCtJuRW87sbdVdmhoeA+PqbtDROsS7
	 ESi121vQkuZRXOJ4/fKC2z0W4gLun/DhC1nH6DCjk2Yt/ugk5pbCBBRYvYlzARvq22Tx1
	 GK711p5v/ajdDYW+I+/sZ1FCn2qxzpErm1lo7TQN//UANh8wZhDOUIUe28h7JhdaVy5Nm
	 tBjtT7u52miyo0SpeNiLALPZUIrw5wy7DBMKKKL5NJ2OzAwafJcaxz8HJtEDdw1rffjnA
	 sOlUglW70C9wKgaELnFbvbRaWq8/geNpFMlAYq7jfhVpd8BP2y0XIQ5GJ4eonBw9VRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990254;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5SIPC7LEvw9cKS1/QkmNF/qFLthCTzsMpI2OYxkD1gA=;
	b=bAyGvLk6SUgkGtaRgMl1rXvTtQDgRmeeNCEHNQ77Q/lC37G+WypIrWrBkPTbszjOz41S
	 PjXirhTl7yLEHjKyvZRpXQAZ+DJwc2k9wdgdARdsoE3GVTD3vqMhqewio0qOlt2Mwrw5t
	 3S+H1AuTraoL4s7ojpTjy6GZg4CNgjFUCEM7yEVWyHRsOr6fF70ZzbujGAEZAwhTJCy/Z
	 dENkA+j4QD0dF4MLYMHsXSx2y67pYIRiVeFep5E3orBqe0nlgwZvBsWu0RKcqmefEppzx
	 0dE/aNBc0QIOktPSJJJOn0ShEJLmNZZWYq0mdljbcWDemJxq33thvqyl3rVumiNveww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kai+5sLd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873C606A31C
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kai+5sLd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794990253;
	b=n6ffbIQrf/0diZ5JlOmQCTFMoEOA88SCBQ1jcFkSaGiyX/4NAruPGINVZ8QRcR9bNLUQ
	 bZKva8EHEtwNPGGalUZefE1OLPNpF66AnAPZ/IZEmcDzHAZtCrBkSeMlM3w3lZ9eKpmkl
	 lJg4jzj39whei0GDq7pdkZPZZ33jK8aHyjjJPCiIt+Xh15+6m6Nr6E7HySPKbHwhyp6Tc
	 IthRbj3IpAb+9yWtAQ2fiBayCSKJ65bW81tbHjA9oMumv/wEtHKS4PzGMWtaS/r0OEl6i
	 2UxYTRsyL1nYFKjorq2Jg8tse3Ahm9ZrE0APB0LkCD/ZKFkoaQPPzVazxMpM2Ml0L3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794990253;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5SIPC7LEvw9cKS1/QkmNF/qFLthCTzsMpI2OYxkD1gA=;
	b=FEvLfeYfM9zZuNiJVw9GGMgppaM6W9V48k/CDC0DXHkKO5bZ3LbtI/nWdJxhguD8bZZ9
	 SGqbPeZd0zTy1pECPwHL7b1uRXUbKSlCWcYBRgeEMMkGu+Gj4QNgv/HJMz+G0g2oidFyP
	 2KGLrxyY3exI1YTEQ0YQhjdT7B0CYBZX85i3z53zKrjm/yJd0YTe75ui2BbR4gI+aV5Ng
	 JeYP087oRxsKykood/4dLfJwUhbUgFymNKVkhZ1gN8eZrXeMeghDqMTGEN+EjYQBGEGL4
	 RW+yGDYE3NMfObvisX4gRyf1e5HvDuSmsgpNUoBLDs6s/eFHH9nF2cwE/XfSfeUSkzw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id AFB2C1F000C5;
	Wed, 18 Nov 2026 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990253;
	bh=5SIPC7LEvw9cKS1/QkmNF/qFLthCTzsMpI2OYxkD1gA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kai+5sLdglj0o915p1UiMQYd/+z5PzD8yvxnLMHMeYXH24wkp7XCnR1vwnemvawWD
	 RR510InOn0fBxsjZsjGzS1IEBfRd/OQcs2kTyhj7t2KhGGJ3oPEcpJUN7JBLFexBwj
	 xbk1V9aK4p56nUaeckpBcinSlU+mYiKQjmw6pnrcuHxGv9LCOT4f+fq1e2TaaldNrb
	 4ooArNEXaoRTwtvDtB6sGp6+8enddk7V7xecs8zyNhsVT0mUymr1Py2Q2orWWW3QbI
	 URx/gdS+7WJBkJsPeHx8D761fRcQMZ/fSL4rmKVfHK/7og2dIIAE6sWwhYf+i57c3C
	 cMo0J+paZlCBw==
Date: Wed, 18 Nov 2026 09:24:00 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Kurt Borja
 <kuurtb@gmail.com>, linux-iio@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: light: opt4060: Remove dead code
Message-ID: <20261118092400.00005465@kernel.org>
In-Reply-To: <20261117091006.1452131-1-andriy.shevchenko@linux.intel.com>
References: <20261117091006.1452131-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 10:10:06 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The struct opt4060_channel_factor data type was never used. Remove it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
