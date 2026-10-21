Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589093;
	b=bU7GPT2PDkMWKenYRRt5pJKDnNimB/O+r6wGBjyVROA9y8csp0ZIexrgf3+5E4P3z5U6
	 Vb2zmmhLZpe8A/LLARybdfclMginRTYJRlfGJcGTeMvRWcw7q6/1iTEFmjNXNaJ2nOV6D
	 zkZqetjJ8davAS1wRuj6yAF0vqCK1A5oeXgEYNx/teVqC0NfIphhieRz17ta/qg6uwcC2
	 PJalSYy/IsIXqR+d2YZcd+hWP0iddlJJmVxVZvL28wXFZa6TeZAdn8csHYNTRoo3eNXSG
	 fuvCfwy7kbrbZd0POt4KG+hzemhFbMzq9UVSHWhWKcAKbz/ncTYAl8uAGgEAND7qwZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DfLg15d2NsC8WG4F+8NUyIDwq+mbAzZvSv8g7DgQuf0=;
	b=DWHhJflAUUZXE7NE/2UdD33GpE+6+Fy9SE2X0WNzy8xuFbePqc5EmnN3eOGTS3dWGygI
	 GbT3pOKaEn7wohAPGNoyoopo3VWnFplfYe5omudAdBtyiY29J50ZrDlkYmPQpQ43HdX/2
	 rX3Z7yQwDJy2yRCc6va2FoIod55dMhJU3meQtGQaA19Qu4exFEzQkLLRqvRvEhNGFT/G0
	 1bCBYQTEF9vFS5ST9alOU0J2Eom79IP71eerTZlqFLOSixeiAVO+bpGREj3EHJ/EoezAc
	 D7glk/NzxVSyaIyBeqK2O6Xh3OZ+F26LV/QR+RPulYN0fcqgFntp5xPajn3/SaebUzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DFN1tklU;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA24606A321
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 13:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA24606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DFN1tklU
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c423b145922so87235966b.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792589092; x=1793193892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfLg15d2NsC8WG4F+8NUyIDwq+mbAzZvSv8g7DgQuf0=;
        b=DFN1tklUulxevp5e23DDQwk12D6ac5gehXefCmPIk3ujm87X145Iltk3nXTTJy10Co
         18aFMXxMs0ITa744yyaA8coIk8ixafXJoH+P2cxkRvVolGZtNXcjQJah39i86ygQ6vDa
         +99t2ShsDmh/tvedHar6FjFJfigremGZZVxAJDG4o5coiF6bAcm6M6xs4ybCKGtgClnL
         l5OOZx+SjoAEToexQ1PuerbtVhpUdLGXFFshGdvMRUly8FwJwMta5oyLxtSTvLLGsP3X
         lt+BLgsYkcghrABTaGAGNrvkqd8/1EUZqnrVutMlXxygBFmBdiNYwNo5pnLVhrScVieF
         RAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589092; x=1793193892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DfLg15d2NsC8WG4F+8NUyIDwq+mbAzZvSv8g7DgQuf0=;
        b=eDgvBWh+x2Tit+juySwxTNhKQ761mPPS/+1NCVyL+r+/+t5IgL92ZJzX1ltJG1p4wp
         RjH88JH3trDFpLE//tpbNqXwTVChXFCvbV0VGQZSAncMAGwSC739cAZ9qM6DyfVu8O/J
         o+XJ4hkytyyC3DEL0S7aw5kCgu0YaP5Axso8vZH67lSlbZewgXczzoYK90sQcNd7rVUI
         UEsNDL4kbuCHRPfmRYcST2uNW2qXaG0KwbourRDAyGuAbLiceKPAQ9v2D66vwgbFnl3t
         Kyuz7fkOwQMQLvXtUCsJLM0FFuefG6F+PyvJNJEZBrpd6kkoiP7sBtN2o2gbdHbTzD8K
         jdUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwXAQo1bKN5dnTVV9r2/TVpprk+BtSWHQ+1/AWi7qWUILVpU7Ko0H7uiTxmoJngLvk4v0DpTdnfCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0I5hhJwDYhyIT0/JDGMgSDh6neRaIl/isKC4oJZcxjylyfG8Q
	5Bjg2p1CM5YeNJT3Vnt8YShMjNRVKhvLUw6wXe2FLQtuQBfdfW5BQ3B/
X-Gm-Gg: AYBFou0q46k1zc1O4YdeWXy9ndsvNl2eh7WrkZQbw7rmJE0IuMZ3Hx9V/Xpi06SAYHO
	bKzbjePH9N4NY3YCbfwVWGsKZbszIAfn22zQHT8Tlwbf63UY4FCSlZQ9bhEpWAB38ASwd4whXTD
	dB6UvlolM0TmQL81yND7zxY4twH8eZaED1i/QXkUoRtgOp0nGYVNV/yGzM3ZovvLtAylV+t3fVY
	onURq10dWTI3GrJmUr25ohCS9GSGxHY5bGFU7MyWc9ZZcMia5qZwqQuznA6UzxcHc0CjGBMpyH7
	TS8EN/UlfPYBZGs4wVX0Zl60FRFenECHif3eIe3832GwO1ccpHwXd4mtwVC02jsqa5Rw+/e9uDW
	u3DFwQ0FQ8/Fan+Nyr+2VaeWHM6BKOxyc0Fsyb2k16FzGfM5A0TWY3aWL252FcLDIkYMiFunGSq
	Rm33Giz5Ifpn6uwjJ8S/Q1xh+DYjFZ+fx5wgMKAnjjvkdAXn0aVcwNZ6PMS47s0wM3VvBqIDyUE
	WOA15EkrC0yoCWGOl0qlYLKPMfuK+lKaDHGIlbwTIakQV8REmh0dp/LXrqIVDFTBOHVwWlODi+/
	vjs53D98IVI3Nez1wzMy+E2dQLM/+okp3kqBbwBwhp2O+DCs2vWbug26Ympafo5bQGHJq87X5ov
	mZpTzFsuF
X-Received: by 2002:a17:907:608d:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46797af00bmr188075166b.40.1792589091580;
        Wed, 21 Oct 2026 06:24:51 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a592333sm1418266b.46.2026.10.21.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:24:50 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Date: Wed, 21 Oct 2026 16:24:09 +0300
Message-ID: <20261021132409.3742735-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019141646.49599-1-zoone.rupert@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com> <20261019141646.49599-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026, Rupesh Majhi wrote:
> Tested-by: Rupesh Majhi <zoone.rupert@gmail.com>

Thanks for testing on a real DPS310!

Paulius
