Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942965;
	b=AGyKR6HAIKIFsO6KrKaD1ZYDp5MYU/38XflqHUkSlkMa6SsEdu7tF+/M11QajIkm/uy/
	 62MeitwJFcpBIuJHoapyntKpR8/mNVSimBT19CP5ckxZirTMNsOtVzw/WhVYzN18DXPFW
	 VQX4tjdI5Y2pILfburOnNI3onMD0+V/YA7Bv+Gu4U9fr5RlOaO2PR2k32bDqGeyOxtuVN
	 uWggNGehEbq7xGxTkpbNDqaH+FSlQo9nx8xh2biUir6vTHJ34ZUUMXEnr5W1W7Ftv0uFW
	 QVwoK02/pKFcJJniNMqAukummNxghJEffOfxUUlNo8oaJjfVlO9rxGAs7AdPWbPk9XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A5aBRlJ93oeuYRowBY8GTJ4iLcl9lwiHlzGZwaE2h2I=;
	b=pRaYD3h7Cqi/TR/nJNO/utlHy/QAIUJ+Mzk9STgSfWoMSwhZF3qZMk2dMdd/JKXhW52i
	 +FLF/cHkS53e9tbSM6cd9KErYDABam0JOIbG3qN1wraf51SGm4LGHXJ38zH+r8eoAeRs7
	 ekbji1vvU+yzO7rHV3hbNioPEhw76Azthr3jFRThOStrgorzFWcXQ5IAolPmtInERt8nG
	 pBS5Dm3YStlqrF9T0nF2qJUt4un+OpyR63iCy+4B7DHwlyQaGWUMlCvf5sTtQu6UEk3Ca
	 4ktF0SL5hN5jOh/VkTT+nWts0HC4TUy27oCkabailN3vaWGFLZnCixscXXDLs5WEX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ns0CJBEq;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B7606A32C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 19:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5B7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ns0CJBEq
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so331348eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794942964; x=1795547764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A5aBRlJ93oeuYRowBY8GTJ4iLcl9lwiHlzGZwaE2h2I=;
        b=ns0CJBEq7gPtyVx9ag1GU8YhnxjZRzm8TjF8YEtSbH++B1cLOdeCnpdEgyu/bHnvHS
         8HVE8U/657mc5jGn600jhcGr2ccqxQxLv+grCzxmPXat8eE4WarVWUhgmUEGCcYkOGCC
         j2hTJ2J0jddIBqMgmTCPUeg4WlmkBZan3gj1kTRznI0jfMsUcZuG5ow616I15juRI0LI
         3MmU26eMd7rbTKcbBlmV08x1bWJMkB4YXwgUBF0Ku9u1XcCSm8/+GNNSRsX2FxSPUXAr
         2PGo7SGxR3V8I1XysH3tebIUBDCAPd4iAZ444wE2nTdu25dTUuowgYeYTFkzG+xbD4o1
         hpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942964; x=1795547764;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5aBRlJ93oeuYRowBY8GTJ4iLcl9lwiHlzGZwaE2h2I=;
        b=uF3qnmJJabC32pxb3uJ9gj/OuqZ6xKuUGQy3R20Bkvv4sd7j2ipxTohR0IVrKZ48Vn
         /zVJX4ZOQPn2RoeBIAZavw5KkP+kqGr1LdCqrZKbgNBIqZVu5TVtfylx04xvdvBC3VMZ
         wAwcXhxDrRbloNnPTQ2cUVY9mp90V5YK4iUzmqoYhtcb654JfvYpvIiOv4GfLarxDOlX
         Fpux+DgP5jpV0o3CIl8TZgOH8KpWGhzq7cD7odBSQ/p7aRfdJKwrmh/nqdloFuSneYG0
         mk4zKGuwshSws4w5QJyyPFhmWSspAUoyRrG0h09i99CiFI3vOcmdPs31en4bYzPQcM0w
         AkdQ==
X-Forwarded-Encrypted: i=1; AL+hErE/3lVRhe48uYFnVLmipMkK9zrK8OgxunMvQQVOFD9g2rIaM66hZqP5Kwk1BRcDOifNuoa8iMNObCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XbbGa1PbfeMEYwiFxpWf0KCOx5sqmqrb0VntvB/wFMrCfyyMD
	pZYziycGasRsx5qtfgogYr1RYChEmFvb9Fiar8zzmZGLc4SQ+V/QLzXK
X-Gm-Gg: AYBFou0OmZZSSGZemwj5jQFyOyHA5CPZYFAlICZEiZAkja9NqT+uLAJ7rgSum8h2Fr7
	BHNQ3GZdSYyop0JKo0uNZrQtR1/fB6O+Feu9Hg5Lcw3LMdoMeBoufCjgDbQJbn5c+3iTd6TQLx4
	qiCZjzseFWz2oppyPCmSzssT8xt2xmtmcTAY9ULF5oDMo9KjKArllft2LSY+wUZNYqH9j+00PUO
	byaMG9YayOw1LkQQiwgKbULCjvBOcQo/czZn5ckDGTCgmWgLayxLGU7ZPRHai6IzMLk4D/Z5PQS
	Cg6IapLAL2t3g9upwVZN9/qwWAVDzfEfc4qgAa8q3pO5fG5DiA1+zYDNuyOCA2VxgpTKgo7UpDy
	dpnHEiYfZFHPx8Tm+lcbSbCUo61PPVZm1PVOhBjftahlS4JJuKoX4FdaSiRXYWWn8eIrCti0CUl
	d29Pr+d7eitrdudRHvWZ0nybAzczT2XpSwvbMm55/znMJxxppU1EnfUpwUWZvrl0Gx1uL0Lm6jd
	fgBRhsxdkxKOyazAy3skessRUCBGkRy8ax5EDWY9rTPhe18bTRNIQNq2qXLSJfgv8spVxHtV/fI
	EKXab2HsvqNRUWZOQ1x3Yg4SHb7jZn6luoEC3F3KeOJROCocAEcfLNOngCH7KXmucpgRPDjvxDC
	tBdhuetJ9/JK0UDDNSvVx/kZd43BxTTankVcoR+TXSbXn1mP85RzkrJQ2umBLftMu2U47UX09r+
	D85OGdpn9nAd7Z3SDmaYMUlwMKwJI01VAeuutBOQ7kVw==
X-Received: by 2002:a05:7300:e910:b0:380:f112:3cc9 with SMTP id 5a478bee46e88-382829b7e9amr331367eec.38.1794942964083;
        Tue, 17 Nov 2026 11:16:04 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm10019eec.8.2026.11.17.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:16:03 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: proximity: sx9324: reject negative hysteresis values
Date: Wed, 18 Nov 2026 00:45:57 +0530
Message-ID: <20261117191557.85244-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avymdpJluGiOnZEC@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com> <20261116205320.26070-4-kapoorarnav43@gmail.com> <avymdpJluGiOnZEC@ashevche-desk.local>
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

On Tue, Nov 17, 2026 at 09:09:42PM +0200, Andy Shevchenko wrote:
> As noticed earlier not all cases might have this issue, please elaborate if
> this is for 32- and 64-bit cases or only for the former.

Both. val is an unsigned int and pthresh an int, so in
"val >= pthresh >> 2" the right side is converted to unsigned int and
the comparison is done in 32 bits; long doesn't come into it. A
negative _val such as -1 becomes 0xffffffff, which is >= any threshold,
so it sets the largest hysteresis on 32-bit and 64-bit alike. I'll
spell that out in the v2 commit message.

> >  	unsigned int hyst, val = _val;
> >  	int ret, pthresh;
> >  
> > +	if (_val < 0)
> > +		return -EINVAL;
>
> Same (semantic) issue, you are checking variable after its use.

Agreed. In v2 the check comes first and val is assigned after it, here
and in 6/6. Your comments on 5/6 will get the same changes as 2/6.

Thanks,
Arnav
