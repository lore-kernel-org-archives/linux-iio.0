Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981620;
	b=a1Z0QptYPwG9KpJV124ZXStBdiq2eaXlHHktYelP/4i6cT4ytnOy4CATm9490EGHkmzK
	 xRHCtqZcwPdR0irp8knxu2EfQo1LMJT7ApZ915YMjd+1SwlkokzcVij332XKyj+apkOSq
	 8pANwEpRtijXcwr2yZIgWHPX5Y/u48wHTk31Ss15EzPUtZ8/uCIh2Mc7TcT5c5tQy9OQj
	 mORn9dBo/s/ltZaqznl9LsCvSzq1Wwi3y7a317A5TeNbqcbN8w3pes0svX0MmeLHVPFe4
	 7Yo7jzBVJYEvlHXGyWvvs67GHJv0YtCR1HH2f0NlOaVOkiB4nkw0p4VZM+yRCl8eNZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7YpbjNJiXtl7VWMW5kqM9fpwI1qWlSV+AqrzB0k8n3Q=;
	b=f9Wf748p5bgJ8OvvAW8xZncN9J3LGcM+V6a5vMgcUxrPhhsAgYW9wThctyKyZXyGwOR9
	 I9pc9wEDjX54fjExoEjGok3vGW0A0KnsVTVWVqBnZl5rWLmd3tLrsPzBKLMsh/qXrN5WO
	 Uzi6Bi74yxFxkaUXsfIaZ1WW38KrrlbXehsJZAYiSikOjfnfNb57BZ549rZgcQqNwc8RA
	 tVN09TtX3Bp3R442AJGVxCRxRJ4gnevtbJrWOtabBOwLhPoHKhGgqM/AZ21BBPQcj5Eh3
	 1Zf0wuNcoqk1hIFltQzNHf5Wn0RZRMFhMe3QCwyEv34BdNGuooLQB3EBuM/UUJEhqEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjv4XIUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AF606A31A;
	Mon, 26 Oct 2026 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjv4XIUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF0B1F01825;
	Mon, 26 Oct 2026 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792981619;
	bh=7YpbjNJiXtl7VWMW5kqM9fpwI1qWlSV+AqrzB0k8n3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjv4XIUAjq+dW0GYJAIoz23OaY6hlWGuSnhi63MrawmCe5XV9yZhevRifTXWyajsg
	 DSF+GMqK82I0QuDP8qo/uJPmQjhXXKcD6B/nq5jRumpoqn+eu8SKubVX7ROwom8/XX
	 K1ukXXDJ5XRuwQA1vB4PfNdOLTfKHdkglLN9BprVxl9/Ex39Y5+0Y6v+oyjtW5GuVf
	 yDaS3acqBOx9NnSJbERolfiM+ZvLTspUWRJBo5ZfJ4R0ukSbthZ+una/6zGFJvqd5g
	 uHg/nkFLlKGGZky3ZSroKiU3qr1lEtB9bXBfs00pAvbAGQtfsc5UG4zJjxuJR06l6X
	 pU2659YCa2gtQ==
Date: Mon, 26 Oct 2026 02:26:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <broonie@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 9/9] iio: adc: ad7768-1: add support for multiple
 chip aggregation
Message-ID: <20261026022651.7e2464be@jic23-hlaptop>
In-Reply-To: <7afbafd67ad52b2342af30c278b8b001413221ee.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<7afbafd67ad52b2342af30c278b8b001413221ee.1792435248.git.Jonathan.Santos@analog.com>
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

On Tue, 20 Oct 2026 22:58:53 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The AD7768-1 family is a single-channel ADC, but it is designed to allow
> connecting multiple devices to the same SPI controller, each on a
> dedicated CS and data lane, clocked synchronously, and sharing SDO and
> SCLK. The number of aggregated devices is derived from the number of
> CS.

This is confusing enough I'd like a very explicit spec reference
and perhaps even some asci art showing how the devices are wired.

I can see one diagram in the spec and that is less than clear.


> 
> The DRDY pins are combined to trigger the data interrupt when all
> devices are ready, and since the synchronization pins are tied, they
> stay in synchrony.
> 
> To reflect the multidevice setup, IIO channels are dynamically set
> based on the number of devices. Restrict buffered capture to the
> all-channels scan mask, since all devices sample in lockstep. Register
> an ancillary SPI device per lane for individual direct reads, and enable
> SPI_MULTI_LANE_MODE_STRIPE in offload mode to interleave samples from all
> lanes into the DMA stream.
> 
> Since all devices must be in sync, all configurations that affect the
> sampling rate are unified, so they always have the same sampling
> frequency.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v4:
> * Fixed the st->offload_xfer.len calculation to account for multiple 
>   devices.
> * The number of aggregated devices is now defined by the number of CS
>   instead of number of lanes.
> * Used devm_bitmap_zalloc() and bitmap_set() for the masks allocation
>   and definition, as requested.
> 
> Changes in v3:
> * Modified channel mask allocation on ad7768_parse_aaf_gain() to get 
>   a static value, Since we assume the family is single channel. Added a 
>   comment explaining.
> 
> Changes in v2:
> * New patch.

