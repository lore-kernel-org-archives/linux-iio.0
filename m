Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377865;
	b=ZfrX33+DMumW7Cxp7wfQ3/IMJJcsO1A20pZAXtoUJK59nueyNfpDRDezgpuhHEJqSdyx
	 S+XWVwOclwU2qA1wpLQ1qZYkF5Nt7Np1QVojhAjFLwRCr44Xz6D41SyTeqxvP7HD7CYd9
	 14Xc5EgvIjhDE6KuqnSert/KmL9/ec8DiTMpJRD6NzeC75P7GoUmlopC9YCVl8cpbW+JT
	 Xb4mJwOlEDMn5HQDwIoQvIfEU8yiGarBclxTX5oQXiSMAo/RsBj3BdNwH7WHa+qDNctnG
	 wp3+WHXShAbALQAfp1Rl6FLZ5Lv26L8OjkU93UeZe3FAdvzQdiI7IUZnxWWMH+8V0Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377865;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5Mz4K7gymEdqf9l1yYbzgLqQdD4NiB9ApnjseA2qTmY=;
	b=TWdotdEz7KxFUPxohgDna85ULRFegvHYVX16b/NQILECw/ST2HPyE3mmT8NpZEC+2XK7
	 1ICJefEOSqTJPPirOb9LqLwO3Lq2Dn89tfBm4nlaYvfaG093jYISFVVOZ7T4EsS5Q2q5d
	 zfvpl/SIlkglawN1PO6Xkj3lXT3Ms6zt5reML9xg8bH/oXzEF2omPQ0MNc0Tlc5ODemY7
	 hGZUgn7r54TYUOCgcJPeB4qs6IrPsG8HReywProBw4LdnWw4H+aZuSPtHAplEV/l840s4
	 PKbiyd3JtuWbSmwegLIrEbM+cordWgox9FRCztzNvrtjAvJslWPSr0MofCo4m6mMz6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8zWKkYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66218606A31A;
	Sun, 22 Nov 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8zWKkYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A671F000CA;
	Sun, 22 Nov 2026 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377864;
	bh=5Mz4K7gymEdqf9l1yYbzgLqQdD4NiB9ApnjseA2qTmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a8zWKkYTydXHHuNXj6GrWI8Mz1i1vUneegJ0FXhSl4bbeg/Suvp2l5O1T21OzHe/I
	 xUdkDBXs1ekkin/gsRId1Ch4DMKZvMkUn2e0xNjoqAwKgyvq0YvY5NQr+s0HlIjRtX
	 3unyetIwVuPB23POai5HT7mJD45nB+kcz95Ida7db5DTiOZ5B6lo0BVOfD47zAD/of
	 +kylmidY4K2pveUnXQ/0R7lFlFeKQr16iVJsEDNyFWhEPx8KkQEovF8NHDebfjQDh0
	 qWUXhn7kB0FJRl94fMB5YCIx++ku0OgfnDVxVgCxo+MRsnrnWumM0qYec4/nBGGIgN
	 9gec/TvVr/V3g==
Date: Sun, 22 Nov 2026 20:04:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v5 0/4] iio: light: ltr501: Add LTR-659PS-01 prox sensor
 support
Message-ID: <20261122200418.3402abb6@jic23-hlaptop>
In-Reply-To: <20261122080753.36349-1-clamor95@gmail.com>
References: <20261122080753.36349-1-clamor95@gmail.com>
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

On Sun, 22 Nov 2026 10:07:49 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
> nearly identical to the LTR-559ALS-01, but omits all elements related to
> ambient light sensing.
> 
This seems to address Arnav's review on v4 and looks good to me.

So given I might not get back to the tree for a few days I'll apply it now
and we can let the bots have fun with it.  Still time for additional review
feedback though whilst that is going on.

Applied to the testing branch of iio.git.

Note sashiko warning is because you don't have a based on in this cover
letter with appropriate precursor for the export.

Thanks,

Jonathan

> ---
> Changes in v2:
> - set IIO_PROXIMITY channel to scan_index 2 since driver will not handle other
>   id properly
> - add IIO_CHAN_INFO_SAMP_FREQ for IIO_PROXIMITY channel
> - isolate missed ALS register calls
> - add commit to use read_avail operation
> - convert to use modern chip info match
> 
> Changes in v3:
> - LTR501_INTENSITY_CHANNEL macro adjusted to set predefined info_mask_shared_by_type,
>   info_mask_shared_by_type_available and info_mask_shared_by_all_available
> - added info_mask_separate_available and info_mask_shared_by_all_available to
>   proximity channel
> - fixed IIO_CHAN_INFO_SCALE for IIO_INTENSITY since table has -1 entries
> - fixed indio_dev->name asignment
> - dropped ltr501_has_als_support helper
> - fixed channel finding in ltr501_trigger_handler
> - isolated more accesses to ALS registers if no_als_support is enabled
> 
> Changes in v4:
> - adjusted intensity scale passing
> - int_time and samp_freq converted into 2d arrays
> - for_each_set_bit() + iio_find_channel_from_si() > iio_for_each_active_channel()
> 
> Changes in v5
> - fixed als_gain_tbl_len calculation
> - restored use of iio_find_channel_from_si()
> 
> This patchset requires change[1] exporting iio_find_channel_from_si() since else
> building as module will fail
> 
> [1] https://lore.kernel.org/lkml/20261115083049.46840-1-clamor95@gmail.com/
> ---
> 
> Svyatoslav Ryhel (4):
>   iio: light: ltr501: Switch to read_avail() op from manual attribute
>     registration
>   iio: light: ltr501: Switch to modern match mechanism
>   dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
>   iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
> 
>  .../bindings/iio/light/liteon,ltr501.yaml     |   1 +
>  drivers/iio/light/ltr501.c                    | 427 +++++++++---------
>  2 files changed, 211 insertions(+), 217 deletions(-)
> 

