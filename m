Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987412;
	b=HUrsz3fPkJ4QlDkBfJzwnk9fRJmOSrkUSaMDy0qb9oLfui5HKQkaejs/FznFexBkpyKF
	 ZpBQDa6mcszLgrBRHX86jtqrmwyXIMyKuUM3v89XdGlnwc5/YJu40s9Bvo1oTHKRJt70U
	 rTZ1UnyD9x9b4LDcsYQt6dhN9cB9eSFXz2zDc6o3AX4SJS90OjA4uw46rIpw590tkIza/
	 Ij5hCz3TOCs4okCTPLt7bA1Ws5+L07uTyvafOLGNHI4IZ2cTuUhuvQb7IFswbAiNPJAyL
	 0RTntPiXrP+uKu5mKJuLBxAJM0ag5t8n9GY/rPhGtRJcShjm5/9HMCom7QAOrkA6Y+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987412;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=9nZUwM+lDwVrVHRdC3aa+iCPjYfbkBm1N4GWAtp0p/M=;
	b=iFdnNs4KdAtvPDF3gx6hvy674/KtAnnzwmpDViv36kY63W4kCidIGdXkMNO6Jzm5eTnn
	 ybXjEvLWrhH15R4QOTvxHDEOL7KfWql1dpz66z4PRHEbKJ0khQRgGz5Lwcg4mCRxgALoe
	 jmOexR6WcSUphDTd0RKkCLkER8DCEIbFLdQIqc7xFS4/tEr8H+Ukyw2AuyJHeWXzi9AdC
	 AMzUNbnj8OLdGF8AXCDIvEtjAOobeOzNo14tXxHGg6BjglAPE1NETvTe2YL1alwMUG1BX
	 S9IIrWln76VrsMr0ibwtW39BmMuz37WW+NxyJ5kr9ESL/aWCZPW/lGmWHWNp9M/hcFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oxjUqacP;
	arc=none smtp.remote-ip=95.215.58.76
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843C606A31C
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 07:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0843C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oxjUqacP
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8voNpajGjw36eplBkUBJPGaJ0qsleAPIWLEErTSOR/w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794987410; v=1; x=1795592210;
 b=oxjUqacPTSvEnSitbPsTGYPN4SreT5GN9MyxBlpnD5/HFjoDQjaZd/uOJFNEyzxDpy7E53Wz
 EIl7CPQBsjnU7CnNdOdvdRp7BMGla321M2lMrZcWhwatNAfVXSkGzrcC2s2kwLC4fyllNngzrUU
 6xdx56zFCQmh+kKRph7j9p9w=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8df0e8e88116f16b;
	Wed, 18 Nov 2026 07:36:50 +0000
X-Mizu-Trace-ID: 8df0e8e88116f16b
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a261f19fff18b074ed3e004c4896f2cf586b611.camel@linux.dev>
Subject: Re: [PATCH v2 1/1] iio: dac: ad5766: Convert GENMASK() to use
 static parameters
From: Siratul Islam <siratul.islam@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux@analog.com, 
	linux-iio@vger.kernel.org
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 18 Nov 2026 13:36:42 +0600
In-Reply-To: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
References: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 17:08 +0100, Andy Shevchenko wrote:
> There is no need to use run-time calculated masks in the code. Besides,
> GENMASK() over non-static parameters might lead compiler to generate
> much worse code.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> v2: fixed typo
>=20
> =C2=A0drivers/iio/dac/ad5766.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index 061b43fc0345..ba6c54e2c9ac 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -18,9 +18,9 @@
> =C2=A0
> =C2=A0#define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
> =C2=A0#define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
> -#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
> +#define AD5766_DITHER_SOURCE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
> =C2=A0#define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
> -#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
> +#define AD5766_DITHER_SCALE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
This could have remained unchanged?
> =C2=A0#define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
> =C2=A0#define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
> =C2=A0#define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)
