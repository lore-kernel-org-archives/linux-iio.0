Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085548;
	b=es3WcN5Gs9IDrfahp2nb2BnpYp4gq4l6JSjMCBByXbLI7+EdifaMb1vXXSSswZL4OSNh
	 9guiwfgJvlKlxENKeBoqO0teET891Q0yIwoq4LVN4vnX9FAQMVq93/px2PZZk6oQDxIz9
	 +bzruw2Jt8XmxC4O2kVZ2JNUhFuYC5B+maW+IftHTLAwFUMx3HY+5Wc41WlqRT6hoHy0+
	 hr1WPCwrzrXf5yTweYlGxiq4zTySV983NQ4/2R3+JiYB0B6UStdTN4BSYI53iIeHTe+dl
	 Njz2KQlndvrUj8A8fdVie/Z/IBE3IhgsKEcC+4kV/y1D8Qxa0ieg2QKLhMDdgCs27jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r6zRw0G3FSC7lmcRxa5ULpKgHtq8pUwUp6SpSOUOi0A=;
	b=NyD8pMhGl3UKuyKy5S0AhizbuCelp5/V/rZEtJr6WHtJ+xcDhQtZz79JsuhSpgt/sMNF
	 yAf8khF2sPPMuBdjGMdnauzhk9i4YQ+uztDDKTHj3XCbeZpQQwgf2gJkRTKdVtOQrsaeB
	 74Tnmw3iFJyyDN0cX26/4PkCQCNlywB0+Y64osOLbD1uTCsdSNqGqporZqFlXqX/Lruic
	 JqJxREWUXEO5QNanqwxKYWPhkSyDt8mAVJ1k/nvOHtzpGMGDtPQH9OmLGQl6QcEN/v3Ne
	 bB7KQ95wbX7ewjtWSZHjfnFXCt7ckwiC01FVXKMG4JUoPRmRZG6vpHx6OAak5+ZwvZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkBs8rpV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC624606A326;
	Sat,  7 Nov 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkBs8rpV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914ED1F0089F;
	Sat,  7 Nov 2026 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085547;
	bh=r6zRw0G3FSC7lmcRxa5ULpKgHtq8pUwUp6SpSOUOi0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SkBs8rpVVu7uYfXSDaVsow63p6IcHHClJGK+4/hWXYgNfaZfaqHAswQmMvP5tC5vQ
	 Eb8Y4fZG5B96uM26nDPCi18lFhPJZFqfN74g9qu3TuTq3GYTfcJ9b6AC94eEjIdZjO
	 mZlCxxhwpkbKEFMzMUHnZhsGd7B+2Xd1XqMt8m35JpqAlbQhHtV5rGoPzB3HbhiuSo
	 305/bDuYFIcW2XfBWoa28hFVaKmZV31WLcEOh5L6K0I+M/ZQ3pq1YyEWjugxmXDdiG
	 CW8gQp5mizNqx2m8sZgwt5Z6HvlctbNHd1ZxZ9WGV51Qb6rXFjJmimARsJv1HZls57
	 40USNaim7L0cQ==
Date: Sat, 7 Nov 2026 21:05:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Joshua Crofts <crofts@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261107210538.559bcd3a@jic23-hlaptop>
In-Reply-To: <ac9f57f7-cb96-4a2c-85c0-5369b3bb0a64@bootlin.com>
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
	<20261104125726.1754980-3-maxime.chevallier@bootlin.com>
	<20261104145641.000070f2@kernel.org>
	<ac9f57f7-cb96-4a2c-85c0-5369b3bb0a64@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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


> I'll also address the other comments in V4, thanks a lot for reviewing,
FWIW I took another look through and nothing to add, so should be good
for v4! :)

Jonathan
> 
> Maxime

