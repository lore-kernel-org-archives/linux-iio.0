Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530720;
	b=IcIdRfLiRmESUOKsCn7zvXinJ8xLIxzkJSvRygU9+/g5snkHS/UGBmtBATpio9gwcoi6
	 7+CFCaAv7YJr2Uq5QwErz5HfunPNY74kQ4sNm5VKHEqlQ8TrRKMelyAU5EkssLboo7PkM
	 7A8/3/pzf5OZG9O4suZIalMHVSC1JmoHpvlCvXWN8/K5sghk7YRyY2Wqvq384t/xDY0bx
	 hpTZll6nLmcSPca6J8S5bZ8zeU7FZb9tP2qvg+CJxwh1lDqir0aEPHwgRUFE5gs+a9LKs
	 jyOmIRMZ7mGnqOcAqAV3lGiYlVUfP/muQ2SQVbV78tJPplpfTsi270fOJVhf4EkiCug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BCy9FbfGCagGcVT1iVy5/qKWXuDsXeyd+T20CrEKRK8=;
	b=01I5QE7m5EtTuitnBrcIjm13ZOsO98od1PbDVtrn628wCBotuiho7K/HU4ly11LSzBox
	 lRPKF3Ny/LdzLwaMwEf7AmISVZuaACBJtzcvaj2zKp/zbPKT9boTHD/jqIOUlwCidmt1u
	 QuA4iblo7BAzHU2GzMQApMUFfF7/NR0KrosTp5RkTTYGnJ+fb/gagu7oGo0rhF9mtwv92
	 Kd5SWJf7KIBQgDPunVJLdHfY+5aM3JE4GTbaO0gtQF3Q1w6VbC8fGsTYcj88S5Cn7ASXK
	 jmhGso+G825zv8gkb4KNa99lyu0gSRI/OdxMgaXbJgJEe4oiG5evC1uksu6cNHtm4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNEdPM2u;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C53606A327
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 10:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C53606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNEdPM2u
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so20645671fa.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530719; x=1794135519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCy9FbfGCagGcVT1iVy5/qKWXuDsXeyd+T20CrEKRK8=;
        b=YNEdPM2u04IwdWEarcCFuNlfrKyRUs/D6adKObe+2aN3T/8nBD4AVauHGs/N8j012i
         MsSZL+iI9NYmPDIkHfqr5G7EN+OpTTLsCMZjGtUQkjpJ9Ehjmp+R097kNUEqPB6SHXCM
         cSZggvawxPPjo++eI9Dgjgtm5uDZ4wmYC+WvWXhpVU61qS1EGuy9eF5vcM8LSm5hgpq1
         IyT9AsX0ySZO/bPbg8MfuZ8Jarr4ebvAEr/BszZAewg4CUesPizMeRKaAdbp25nTiX7O
         E31W8Jvq6U5MoBDuGNEXfGOG71gS1GHSk69RPGXFQrPrMKyxg1h3v8mYLRJ49FTmOEUa
         6Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530719; x=1794135519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCy9FbfGCagGcVT1iVy5/qKWXuDsXeyd+T20CrEKRK8=;
        b=faqXsy6Do9nxNUzzEAp5H8pguQXn6trhm6hVa/RhvYeVeaER2L+/zWjdKd96t2AbDn
         QDvBN8COWCsvFWeU9ZmqKauynvHXDlRC5v/LFJG5hrwUr2Y9FNh23WGTKN43e0XdvsIe
         ixYTtaOx5menGsqqKs3X8VZLFWVWy5fSMllwxPoBVF6JAmsw+rMayMaoPcOXE25dZ+c9
         OIvzYM3ZG+/spVoenFHCCuif+uQzPWlVLlKooPLUoZ2OZvWyU57T++yLe+EgOBjDG9zm
         GzfT1DVj9tT/RUnq/GxqZf7t2r6LyKK5kU6fT+kNZq1wFd8beB/jFMJwstZWRVYCkcRf
         iBZw==
X-Forwarded-Encrypted: i=1; AKwUvBwyJOrncLqRgODuWd8hAPchw8EBROU6uhBXOUxO7+H9FW35VsAkzmmybslKCI2opnfZi+Y0e326bOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpiTpCTtr0GyWohyXCuDmwPMP2zpZPlHWja6rhnMBE3ZJjyqLS
	0kjS57MMpb8ga+tuy15Wua9MgXbaZeudZ9L54wsys/lKuuX6Iqz/k549
X-Gm-Gg: AYBFou0zTS+iDgvQNuyZXubK7mILWeiurQsyfm4MpMxfsYKWn+siubvpZOp43Idzlf6
	QhOjmBbSWIll04/zzEsB6CtsXtoufT2xcTq0MHewAjzSEAACD1epGxijXzkrOIlNfYrRLVm4iME
	wzUEFq5k52xrDbA5ozvv6j+f5cstRNagT9OLCvGZkpobzP2sDX2S7SgC64cNHSK33TMZQ1KS7w5
	t/mnuF0JBLgmpIaokgw/gso8eki50zOCOhW8NOmIkn7pLzPSuzFAZfk61E/1oAQpFu1AtiEFpMB
	Wphp7WsP7afwMcI+qqyLJa4xLpX+C7pYO3dqvhtiRd/mZ+qdbdnbHgUeUqAkccQ6X0S9eSgqJ0V
	TPgbLWtfwe/SqUMjeXrjOIh6MbfVYjBJvq9M2k40SskZcVRp3WwB7hUvAp/5IdAMncumYMWXYlK
	0t16aZimq1LdOGdI2IOwZh2OBftY2VE+Dklz+9XsUTg4rha6qMkQiE3KcpLt5g13G0MaCEOmHtw
	ZsY9QSijlfmmoKi9CScoePED4qWEHg29EEXovGpH+Gwi0yZlsRBgIM2bm7Dk5S+LRHJfOgyLGj2
	FhBfb2+CEd63HlHiulx/TA3qLpx4x5yP2Spcp6uMcklHrqAZCSxeuzbHPuJGiTXiBG4cQNeRrYp
	o411ogHuxopCB9jze86T14TEpMBC28rih7mDn5w==
X-Received: by 2002:a05:651c:1474:b0:3ac:330c:518c with SMTP id 38308e7fff4ca-3acb7a827f8mr15638971fa.19.1793530718404;
        Sun, 01 Nov 2026 02:58:38 -0800 (PST)
Received: from yantra.. (nekmmqtbv463r5fvgny-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5462:a993:5223:791e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbf1b726sm16613131fa.32.2026.11.01.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:58:38 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 0/9] iio: enable context analysis for all drivers
Date: Sun,  1 Nov 2026 12:58:32 +0200
Message-ID: <20261101105832.55605-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101033018.05897c08@jic23-hlaptop>
References: <20261027124954.110697-1-zoone.rupert@gmail.com> <20261101033018.05897c08@jic23-hlaptop>
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

On Sun, 01 Nov 2026 03:30:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> Please take a look and check I didn't mess it up.

Diff is fine. Built drivers/iio with clang 23 allmodconfig: no
warnings, and a dropped unlock is still caught.

Subject line got lost though. It should be "iio: enable context
analysis for all drivers".

CONTEXT_ANALYSIS_dps310.o := y in pressure/Makefile can go now too.
I can send a follow-up.

Jinseob Kim's Tested-by didn't make it in:
https://lore.kernel.org/linux-iio/CALMSew+nhZp9BoqS5tOgFdiVy13U1r2f4UQa9Sd5zc9pSt_YcA@mail.gmail.com/

Rupesh
