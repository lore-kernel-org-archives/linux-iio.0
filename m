Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021650;
	b=Bm5bkr8g6Ohh724UfzhvVBogWUWuTpPEIcQfZrpQUKHRRDx95a7WgH34GKWmRgOMXsJ+
	 HLb7V5Po+cb614EWuIJ+hcxQG2e+uO8ERc3stzeDsYbFQ9WHco9RtHMYPIz9DAf7YYjHH
	 BkfbCsGF8ed8s/Ar/+qXSE/60/sDPiyVC3PaICJRb7MfF+x0i9FdDin6Y5RRr+1CH7IfS
	 +fxYJPmvc+1gWWAEr4LORK7r3muaMLy+k1GcSWkYVedxpmtWcprD21BT+uevK7/88pFay
	 nHAFdz72Gs0z2w2h0Or6gwGpcMIa3L415OzWEBcf2cgVo5OAM8wzqsLFz1gCLf7eoPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=82d5k5q10xlQuPzF6hB++osn7kDtgfy9QN6IoYLOy/k=;
	b=oQbkbVLA9TfAZ0LCWaSQe7ougpcC1wMvhsJi5Ir3XoWt2zFbpmBsKL/l5e+xuW02FRln
	 J0+kXu76jlCc4ZSRfLsPfCbi1FNk8E8dtX+cHjGkk0+Jb9MsOm8gbbJoo8TB580I0OmTg
	 WMEUiFobbs4QakG/5FU+Qz0PJ94frrp7Pzpjg6TBLMBnAXcCSokaSYucYaTf1xxUC6L8G
	 YvdAWHOglEyYdWraSUvB0mQQjqCpgnmnG7x9xoG9U2TyBye3GRCYPd9lktFvFM4vDl5HY
	 s0tClP11Lvqpwgf3rJP5M3O/HDPNi5FfroCTAS3170bSiIFfeBF6CHbYZtGj4m6iQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMngf8F4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D4606A326;
	Sat,  7 Nov 2026 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMngf8F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DADD1F0089F;
	Sat,  7 Nov 2026 03:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794021649;
	bh=82d5k5q10xlQuPzF6hB++osn7kDtgfy9QN6IoYLOy/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jMngf8F4QXzoCD778s1/OIeDwFBEm/hSSoTicSjz0dX5QsncRAXSyzTYKcDlVvYH5
	 xz3fI5urPgrnPiPfwcQtyXtCr9HpxyZ0H13lCfAmGts579emuq0gNaUX/KYpzYc/7J
	 gL1ww/yhDqV01NiQ9y6qd2fy/C/WGoTHe2WAmYIKXZlawPYWtxfZmmRQcb4A13JHJO
	 s5LADZGFCeku1X4HgAfHVlTkIQOqaZMmXpNIJll5mZaLTSg6Gm9WZdVjBRAnnQzlOu
	 N27BnaKgUZ8r+UF9bU002ZJmj7U0RPTAPQfEI31L5c0BYsS7I1VimLSfwKKgBfSC3x
	 PH8z+FYdabPDA==
Date: Sat, 7 Nov 2026 03:20:42 +0000
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: ltr501: Switch to read_avail() op
 from manual attribute registration
Message-ID: <20261107032042.0dd311fe@jic23-hlaptop>
In-Reply-To: <20261106091943.35783-2-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-2-clamor95@gmail.com>
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

On Fri,  6 Nov 2026 11:19:40 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Switch to the read_avail() operation from manual attribute group
> registration. This eliminates the need for per-chip attribute_group
> structures and related ltr501_chip_info iio_info entries.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Given you were quick off the mark on sashiko on v1, I guess
you already saw:
https://sashiko.dev/#/patchset/20261106091943.35783-1-clamor95%40gmail.com

It seems correct that you'll only get one attribute where there were two
before.  I suspect it's as simple as the mask should be set of
shared_by_type_available not shared_by_all for scale and shared_by_all
for only sampling frequency and integration time.

The current code is odd in having per type sampling_freq and integration
time as both apply to the light channel as well I think.  Not vital
to fix that though so I'd just split the mask to make it work for both
as it does today.

The current way the two Intensity channels is done is very odd.
The .info_mask_shared_by_type should be the same for both of them
(only one set of attrs will be created).
Ideally fix that as a precursor patch (don't label it as a fix
though as it's just a code consistency thing rather than actually
resulting in a change.)


> ---
>  drivers/iio/light/ltr501.c | 153 +++++++++++++------------------------
>  1 file changed, 52 insertions(+), 101 deletions(-)
> 

>  static const struct iio_info ltr501_info = {
>  	.read_raw = ltr501_read_raw,
>  	.write_raw = ltr501_write_raw,
> -	.attrs = &ltr501_attribute_group,
> -	.read_event_value	= &ltr501_read_event,
> -	.write_event_value	= &ltr501_write_event,
> -	.read_event_config	= &ltr501_read_event_config,
> -	.write_event_config	= &ltr501_write_event_config,
> -};
> -
> -static const struct iio_info ltr301_info_no_irq = {
> -	.read_raw = ltr501_read_raw,
> -	.write_raw = ltr501_write_raw,
> -	.attrs = &ltr301_attribute_group,
> -};
> -
> -static const struct iio_info ltr301_info = {
> -	.read_raw = ltr501_read_raw,
> -	.write_raw = ltr501_write_raw,
> -	.attrs = &ltr301_attribute_group,
> -	.read_event_value	= &ltr501_read_event,
> -	.write_event_value	= &ltr501_write_event,
> -	.read_event_config	= &ltr501_read_event_config,
> -	.write_event_config	= &ltr501_write_event_config,
> +	.read_avail = ltr501_read_avail,
> +	.read_event_value = &ltr501_read_event,
> +	.write_event_value = &ltr501_write_event,
> +	.read_event_config = &ltr501_read_event_config,
> +	.write_event_config = &ltr501_write_event_config,

I'd prefer a precursor patch tidying up the indent as that should make
the diff on this patch easier to read.


>  };

