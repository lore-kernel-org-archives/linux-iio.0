Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC903939B3
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734608; cv=none; b=TCWr6Sdne2h2CllUedcJVNQOLuTkJY5HEWdQwHrPeHACvFRg99ozU/JQ0RaVtYpW48+pxOLCFkLFawrSoVuYv7lzbC57BUB9Yl1LXuoDy8LZgh8s9GQum5nibTfFMrxX9RXeuutE9YTi7LsjSOWtqk8qjK+gcf8KYk2vbyItX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734608; c=relaxed/simple;
	bh=AwpUgBzE27P3UMhRNvadII3Q4oufX6g3hHFnm5BdOOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1vVHCIcMdpBZPvr+budk+NxLC+dYbl2eh9RSzSAjdXDt9zS4q8luV16PuCmglktQFT/itWbv8Y2K+A8OX7TANzENlotsnXNDSS02QMv0Z9cCjCGHPgQqp49Pn4vvkAOd2M0JUfo1waYP4yDNm/As5vzbEnbCt507nk46Dr0mv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sh6+a1VK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sh6+a1VK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso48100895e9.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773734605; x=1774339405; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwpUgBzE27P3UMhRNvadII3Q4oufX6g3hHFnm5BdOOg=;
        b=sh6+a1VK2O6FM8cgOdvxQd/x3Z/v/ZiaZ8riBSVW+Dhy6dfDF/54VNWWKfN8Hywyos
         sxfc8AEPPidr/zm9C8o4sn6M0fsx8/IG0B16aohX7fyeYSjVO+NZgbf0A33J1cVk7+aq
         UXPcgnYBpcqV56L4nppLBtkgeW73oIIv3PYr7e7Vy7CBWUe2pXcNxdtORNvRs3BRT16i
         louGvAAVkLPyL2HJsSynhraFHKDrGGbRxYk0hvT0Lg77WDCnQBUv/8k+JdbYwU3Mp0wz
         hM2/lotfEJAjNCQl32RQhhaMo0brxaOMQ3TowOWKmAWZbAlxDaNzyMrVc6qRRD5id9ot
         riaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773734605; x=1774339405;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwpUgBzE27P3UMhRNvadII3Q4oufX6g3hHFnm5BdOOg=;
        b=bSyqbpzncn5uLb+82oDTxl+BlrBTZh5sC42bzoFtgJY4YZsjraL7CpnPqR6FSs4viW
         zoePshNzDUKrrXKLv8D0TiadP3QaC+k27Equ7vTPJMxiNOEi2A3RW9L0Jrsul8TQmp85
         b/fm13hWhiO53ftws57DUpnWmL49gk28nsBJvd3LQ2F8WOcZqhxtfJ74XZFhR0wb9bhr
         H7fyT1QyNyis5J8VJlfZt3s/9FzCx5oaJLWFGDVBypAzHeOBOVb1/BFX0aBoba+LfNWd
         vW9A2Cf9YwPHSG9xnfe0BkrgcxbyvQiAwOK1QIXzA65EnpT/5uylM2Zkjm0EZAu08QB6
         Hc4Q==
X-Gm-Message-State: AOJu0YyuklXfkpBEVe7PZUSIS7GbISMk0Qwp3yDX3lnh8f4imwDZ96Ve
	tHR0I2+320X4l1g6dVx74QSqVjNqtg1W3VnGtjBbyKwBxk8rn34zyLo+6frgtA0xQuY=
X-Gm-Gg: ATEYQzx44q6mkMoFt8YSyyrbNJI27+jUFwr7AuiVfDVC9Q/xdp63hsXJrFbLGTs6NbE
	MDr6nbMvqmgztt2mDNoCgDhbPMX6cUvv4SZIq1wFYWhe0esYQ5Mqnh5anu+Xhz2uy691CA1H/a6
	x6cWjALETOqg4VBlt6G4dxAqp4tSQSKXz+MqIPkLz7bKuFY9mHdzpJTNZ5vJW3DBoVGAylCR3KO
	DElp64bI7RXAzVVaOarzupMq2MlkRHp8eOn99W0G4lp2Eh7Boq/f6s8mEogHasgmRe9GFwgbEiv
	AN7ELWSxyY1X/ZbwgdqzkriWM6j0+RQ7Bh6SFhhtU+Kr3A8Ao8xE4KrMURTB5GwkTkp6XKKiH+w
	cIvuz566XToSnJ3y/fIq5MSHyS4V9E9ydyJ2qTgTPPR2vqL8W7sUEPxEJbZJKGI3DjSNjshXd07
	HeamiOCSE=
X-Received: by 2002:a05:600c:1e8c:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4855670b73cmr257690325e9.24.1773734604563;
        Tue, 17 Mar 2026 01:03:24 -0700 (PDT)
Received: from [10.128.148.212] ([151.47.69.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm51723671f8f.24.2026.03.17.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:03:24 -0700 (PDT)
Message-ID: <7ec90ee310c6d765090ec39b96f76155b66a773a.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] iio: add IIO_DECLARE_QUATERNION() macro
From: Francesco Lavra <flavra@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Date: Tue, 17 Mar 2026 09:03:21 +0100
In-Reply-To: <b050ce49-9880-4d87-8e52-09705e7166bc@baylibre.com>
References: 
	<20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
	 <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
	 <7f000ea5-1a41-4da8-aad5-04aa875fa4bc@baylibre.com>
	 <0b9ac137f52c2c279e07b2d1d8f7379ca9631cef.camel@baylibre.com>
	 <b050ce49-9880-4d87-8e52-09705e7166bc@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-16 at 14:56 -0500, David Lechner wrote:
...
> > As for the alignment, according to your patch at [1], when the repeat
> > number is not a power of two, it is (will be) rounded up to the next
> > power
> > of two (and this is consistent with what the lsm6dsx driver expects),
> > so
> > the alignment will be 8 bytes.
>=20
> I think you are referring to the 8-byte alignment for the timestamp?
>=20
> Patch [1] should make a difference when the timestamp is not enabled
> in a buffered read though.
>=20
> When the timestamp is enabled, the buffer is going to be 16 bytes per
> sample no matter what because of the 8-byte alignment of the timestamp.
>=20
> But if the timestamp is not enabled, then for 16-bit storagebits and
> repeat of 3, before the patch, the buffer would only be 6 bytes per
> sample, but after the patch would be 8 bytes per sample. This doesn't
> make a difference in the driver itself, but does make a difference to
> userspace that is reading the buffer.

I was referring to alignment in general, regardless of the timestamp being
enabled. From my understanding, the computed storage size is also used for
alignment. Anyway, yes, after [1] the storage size for the quaternion scan
element will be 8 bytes, with the last 2 bytes of each sample zeroed out.

>=20
> > [1]
> > https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-=
v2-4-d1d48fbadbbf@baylibre.com/
