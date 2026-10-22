Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627314;
	b=Yu6/mYatArbwsKbAKwOiFhDisPE8t5q9ygfl790nEJJPlZvqe16Gs0bxeP/YzTPzXHMI
	 zr9mleNjePfuPgP7sLEYNLDXrdw2ooSrO664CLRdlH82r4lTYCXmAc111dxEznwtZD+JY
	 snAq03SfZ+P8/cLCA5Xcrfls/V9YQubvKzpyMwgOPreuPVrXvm9rbOTCXfbsmUYTUhg6p
	 Abhmsfm7r0SDvU8ZuV3tSRovN3cHfpKOLMWG2v2VrgEMGp9vpEsvTJEjKfp+NA1SHf8E9
	 Vmogtz+S/+ZyRdP0X+flroG0a0e43uPL95nZYIK95phS3PMnvVpDaIOyMX4N1sCf+3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
	b=SCXp/IPx05MRFI/NnYgi+jBaSxYE4JHZRx7XLDUb5dglRYM7gX+CG9hXr9+vy3ZzGwop
	 /G/Ubb2AxLs4qtn+++jVa6OwRQT1nxlXZjOycHGZKAyJuaYl/RyUCm60Gj97QhP4Ayz1I
	 jyxChZBruTbPZYxKyUA9g6mIkQFQCpmQbxjL+4TGW+bQ7ihezm+eOqLWOqIxqjg5LoaVU
	 hDUGDPmD2iOD4Aw8E864dPmNTOhjIV4ZcYE2oxzjDoZQByo1M8l6h5ARwJ1RnmZv+rhJd
	 xO1js++x1HRF+xKP2Sgv2KdSbRBvjzHgBx7+XQHILoTKke6Ex927q+SocQz4rPFGi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZhgsrPKU;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6F60A4AF4
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D6F60A4AF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZhgsrPKU
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35c76e9614aso2321481eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627313; x=1793232113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
        b=ZhgsrPKU4LMXrrq+6Elpeq2DpLIdDfd/eNM9DRANdago8lMKwnsdDh0mSLtOw+1A+B
         ic3OJYarLxbxRtaozaAXYSLAh2ZnILBpZuCBVWvUoH5hUHeCY+PKP6+auDMbJvtYuHOZ
         IuK87XGlpA3OKuVwA6bLP4v9MpH7QRvqZ0RJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627313; x=1793232113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
        b=jk3apfI+ky9RS0aUTE6YKaM11RkyNOfz02S58xECYMP6TM4td3APP6hjmWigFMCUbb
         VFqEQJtOkkDAiGnGvpaxVOrc2vXUV19/gc4BuMIfaK9HaZnYUzdy1X2QQuTkUUUEiR+s
         gVAW+HLjwFgagAlLtuQC1xa+ImEPpNoOoWc0MpzBnvNrZxDMzwMmFRoqmD1mGcKpR2Y9
         ZNf/Di7Kd9zDTN0KP5asNfEkwh2dB5WJn5OEVZFaPtGp2uEa84bbX9cDmZ6TTNTn0i5V
         ftX5XFbPE+tETKR9S33ftitPfDY94ZxxE1lnEcHgaK6wmsYimoy/DWjMN68xcvN7iIsZ
         8c1w==
X-Forwarded-Encrypted: i=1; AKwUvByhhwb37Wlh2/9c4sDBXRL1cbdhDtBacyXUKgzWf/Hq8pwgZElyrESDuI7XXh3cK0kb6iXcPPTSgEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC2UycF8zf+k1wdX4jyaXa/yEcrX6QO/L9YVvbs1Sj0N1OT47x
	rtiRH5IQ7chAaMMjPYzJjlwn5FKAa5yHvey2deondNkp5mct3A5Q+IRAzOa5/w8vwg==
X-Gm-Gg: AYBFou2ZiLl57rqQUYRkA/2LLue6E/MCbB7XhIAjgVluBEqdGQopoFb60+fyjbNZYuX
	okrD8tIfNGxJCc98PDb03EoBgAzOPRKuyzWR2uKucUczWP3Eebggw5xaR+1GZ+rDH+r9RrN609N
	XNEyl5ldA6efp/Ynh9cYpqY3v1KPkKmZKj25CzYAvxwJ5u5UkD9HCpWCFf9EWzxBr5Sn/tLLfpa
	JQELIVd+jEHjORQDTT7Om9PDxRttg1ZFdTgdM79EpkQ6RqSFfT+Qsej7SAggxCSdQu/u4HR/ivJ
	5Fq4HymZObPZbptwfe75vMcoEXc8lnutjfm2nptGTphc/6/VL1ZP1JhxOR4HU55BDgLWuP1bprv
	isBKGJClR+ZSv5IY5lPyPFCH1YED5Qu6w5c59eJad7sRsOaJLNvqfHjKPSEWbRve0yJH627HBw+
	e0Zdn2eIBN6wSCG1YW92hdr+OtrH48ygkOPFVsVnQ6x2vEvDb0Sk/3GQ9hYatAV3qUbVHhTCozF
	3vWoumsosbBxAnRpO7lUXJUz6gcQ6/3U800ugnKBsQvAxr5PSWMjlFtTE7eae6ic8Rb94+Onxnd
	aHe5zRMu5rZ6RWcVuTrijW9iIoW+xxJFtEnqEvIH
X-Received: by 2002:a05:7301:4005:b0:368:536e:c8b9 with SMTP id 5a478bee46e88-368536eda38mr2638548eec.26.1792627312863;
        Wed, 21 Oct 2026 17:01:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc8c6dsm12073378eec.12.2026.10.21.17.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:51 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:01:50 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <atlSbgGb0kEEYhao@google.com>
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
 <20261018211807.66bfea0d@jic23-hlaptop>
 <ataTYER7XM_MEYKL@google.com>
 <20261021194951.7b65c2eb@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021194951.7b65c2eb@jic23-hlaptop>

On Wed, Oct 21, 2026 at 07:49:51PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 15:02:08 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > Also, unless you'd prefer otherwise, I plan to wait a bit more to send
> > v2, since the merge window only just opened, and some of this series
> > will just be a RESEND. I'd prefer maximizing the chance that the
> > recipients will actually notice the patches, by submitting outside that
> > window.
> > 
> > (OTOH, the bulk of these changes are in IIO, so I can just make IIO its
> > own series if that helps things along.)
> 
> I'd split out an IIO series but take your time as no particular rush
> given these won't merge until next time around.

OK, I've sent out an IIO-specific v2. I'll resend non-IIO separately
later on.

Brian
