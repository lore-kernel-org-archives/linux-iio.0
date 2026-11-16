Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856927;
	b=wcYXS5nz6asmWTsN91IWK3qpOGdQnKBLM+9z0xLjQeFVWTiHL5Kuvm2Yj1ShHSFkdIgb
	 afnDoUxLYeb1S+Se7byhpU7Z/8CwOT0O3H8t+WDTuiZXwzI8hWe7vPYJE6OPWU8ves1Nf
	 QRuV9fVU2sOnMaxXcX8Tc7DJsrBPn6fpbl0XPjmEjWUyi1RiKkhbsmBEhwkFJRrmElrHK
	 mBcENufXbTQFVbDuk1EefzpizS7oUgwCUpvkV5nSU8QD+SIl294vl2v0tenko1VsHj3UT
	 Tq6YKLjBroBpKMNDd3ul71+Dzub2V4NK65kvntNRDtxSpALghCdQqomQRHXqVfVzygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EweSUMm4/P5BAq0haWY7BiMzFOHYazFTSCELjkONQrs=;
	b=TJCPSPhohpYgeIEb+yUThpBRlRs5bVeely9BUhFCQ3zKHfFj/hZwKOAE6EDLs9HurUfm
	 m6HzwN2ARRxsvQbRFEL+3Lo0Qhe4Pb5IRBlHr3LtvBcaAVHJRU9gBrbBoQwe2nfsQOksL
	 ICveNqkB+bnCC89IUrSY8xersjL5nrjOzPOqRddMUCfsSquawAsUz8soXkJpcQTj402f0
	 CpKP2aTKMeBTuP1hiUdlocvOKWm6RWxRh8uT9ujCJO1fwRAn87CMmndiAsihyvVfy/D+a
	 sMxxPWKHByp+Rwxa/vsVz74cvGsS3EvP5gFbovj9sI0i/lmRsz7OZdWoonWDYu4OvMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nRMS7S/+";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB67606A31C
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 19:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB67606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRMS7S/+
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4530559c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794856926; x=1795461726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EweSUMm4/P5BAq0haWY7BiMzFOHYazFTSCELjkONQrs=;
        b=nRMS7S/+s2Is0hyBZzp0u0FXGwf3uGVRM53Rnx6JBxjL18C39IVe8tfqvxRbjadSNK
         WUioEZPqrBNefjqg6vGnQg89ClP/bpuUyPvN9pF6ydLpc9SmQDEvwH75UlY4CUUq3jFN
         piaRj6AKYi5LkOXB+e5Dbz2l8jO4vvVkIw+WO/YJacySO2wPyu9IYH6/ZYim+TXEAVji
         YMoZqDc0ll/DLm8VfyP3YG5x9wbKxYJWKQJyKKSa03bADwy2nHK+ZNuP6Tp3vBlKXO8c
         qJKNqWqw+l3KUbclJP4S/YG3mCssdy2kOT75XLkYFx1XLfoUPFyJTGQuNEapvB6eIiJZ
         Tlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856926; x=1795461726;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EweSUMm4/P5BAq0haWY7BiMzFOHYazFTSCELjkONQrs=;
        b=kTvRnOKd4eg0fD/JerBVafQsQhFgg2bcEYwXe1O+8h6zh26H8m/asr8FEMzhOB488Y
         Z9bdpaIvlaRd3Gn25yB4QHsvftv2VwKpQHukbNgAgccYZZ6d6694ZkhAZOox33ECZjoi
         GDT6fYb3IYIVaD7D0nRFEDEgqAc/AY/s2NzHEhhCLhWEY8g5oztoRBfs1/CZGWPkB6vu
         tx/2voP1kM7USSRszQ6gFW2uUgLm+NPsYlGnhAejSpBflT6IENPptt4OCh3vmZUmGpLV
         YKuA8z5RyIUW14/Exx1QxaHWITp/6wDo/295hMkjG2yNcsTDj+sHYd3SZj0z8XHiEPPp
         QJpA==
X-Forwarded-Encrypted: i=1; AL+hErHCNXqXFV4iXeaBtNYJsRnMcGAvIsUBEshwpHDDmsgoy4+xGNogYB96mDO+lCSq3XB3kMCT2L+w9Bc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bM1K+fV8rLHod+QvczJhRSAeLiEMQTioZDjBgXC5MpwpLsE09
	GfNHFxY/ohGcSbycKYm97S0BlHx+2Z0IDV6/FD0l263o7VGoE3wcMFZe
X-Gm-Gg: AYBFou1eOGj6eilzdFCA32skVeWKN4WJnJMTzng9BqtWxOT5PsHzhYKz6B7rsS1HNv+
	Q3wYDXUi29umKs/3WxuQjQ2GnAPMiUHvEbd/0fMqQyzkdkuJopYkskvxuAweNabzWG1ZMnyJJjJ
	rnilfm1kl1Y1pzi2q5dG32+Ud0F132SRit4JAndTsbA/mziPQsY7bVsyUFEfZE/K0aADe/bMO1V
	Axkyu6/uEENZ8tu0myRZpGN/WDQGeRypl41ON9h8i7n1tp5Do+xQ59iXek969e+1d831ZXi5iYU
	UUBPVlpTu1Akgd2kuDs3IyBMwUngcL9/2Qn+OuNT6N29NEfSlhX2e3NYLZYz7dgQVwP+tMhznFZ
	PHwmqySNdiJXjJZRz4OJeyq7oLz7dKqQzqaFE39IPzLYNxYELxmSYOUB5X/KmvMjfTMv0/Fkns4
	NmNCy9UtZ9RFV/Q485t0XUs415ESuCrYPbb/jJRNDgo1mRoq7JPfnWz4VoFRkBthH18mxfmYHXw
	Y4YGtANWgC/9oi/1j9yYrkyAE4+M7tGhy84H7fmYdquD0buctBuxLh8zyHAppyf0Jm/qjy7kCAY
	v4lY0K65VQDS+bAbZM/xGHfiLWFo+ZJxvWd0KAUioqZONc9Lvc/wdL5nQm0Yf3PQKSdYUiedkFM
	1QPIoNCR2j9d3thAXsXMdIY11AwlFdBzdEV7s6UZ4zziiW2GSF/RBD9aK6ksx9xiC7HdoupEzpK
	OVTHsOJM37mQNt89puSNFcXzolOE6iKjdqlNY/+HS42g==
X-Received: by 2002:a05:7301:d189:b0:36f:a651:d649 with SMTP id 5a478bee46e88-37964b08e64mr11776840eec.4.1794856925787;
        Mon, 16 Nov 2026 11:22:05 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm34908993eec.22.2026.11.16.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:22:05 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
Date: Tue, 17 Nov 2026 00:51:56 +0530
Message-ID: <20261116192156.33333-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115083741.62140-5-clamor95@gmail.com>
References: <20261115083741.62140-1-clamor95@gmail.com> <20261115083741.62140-5-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Nov 15, 2026 at 10:37:41AM +0200, Svyatoslav Ryhel wrote:
> -	if (test_bit(0, indio_dev->active_scan_mask) ||
> -	    test_bit(1, indio_dev->active_scan_mask))
> -		mask |= LTR501_STATUS_ALS_RDY;
> -	if (test_bit(2, indio_dev->active_scan_mask))
> -		mask |= LTR501_STATUS_PS_RDY;
> +	iio_for_each_active_channel(indio_dev, chan_idx) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[chan_idx];

iio_for_each_active_channel() walks the bits of active_scan_mask, so
chan_idx is a scan index, not an index into indio_dev->channels[].
The two only match when every channel before it has scan_index ==
array position. That holds for ltr659_channels[], but not for
ltr501_channels[] (also used by ltr559) or ltr301_channels[]: entry 0
there is LTR501_LIGHT_CHANNEL() with .scan_index = -1, so scan bit N
maps to channels[N + 1].

On ltr501/ltr559 that gives:

  scan bit 0 (intensity_both)  -> channels[0], IIO_LIGHT: no RDY bit set
  scan bit 1 (intensity_ir)    -> channels[1], IIO_INTENSITY: ALS_RDY (ok)
  scan bit 2 (proximity)       -> channels[2], IIO_INTENSITY: ALS_RDY
  scan bit 3 (timestamp)       -> channels[3], IIO_PROXIMITY: PS_RDY

So a proximity-only buffer waits for ALS_RDY and never reads PS (the
"if (mask & LTR501_STATUS_PS_RDY)" block is skipped), and pushes
zeros; intensity_both alone gives mask == 0 and also pushes zeros;
and enabling the timestamp makes an ALS-only capture wait for PS_RDY
as well. On ltr301 bit 0 is likewise lost.

> +		if (chan->type == IIO_INTENSITY)
> +			mask |= LTR501_STATUS_ALS_RDY;
> +
> +		if (chan->type == IIO_PROXIMITY)
> +			mask |= LTR501_STATUS_PS_RDY;
> +	}

This is what iio_find_channel_from_si() is for, as Jonathan suggested
on v3. With the export patch you sent separately, something like

	iio_for_each_active_channel(indio_dev, scan_idx) {
		const struct iio_chan_spec *chan =
			iio_find_channel_from_si(indio_dev, scan_idx);
		...
	}

(it also returns the timestamp channel, which matches neither type)
would keep the type-based check working for all four chips. Since
this patch is the export's only user, it is probably best to fold the
export into this series.

Thanks,
Arnav
