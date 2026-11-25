Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638161;
	b=4+Zqu4VdfgmbMJuwT/dQu52dEIOfZNJkIZ79Fmn1MUP5ViYQHLeeIg3oNtzf5ZlEx3Q4
	 r/dcSCUuXyIqcdNkE8/cSJQhE8Rgf/2NU+qRgRq9kl5myFBxk2cAYmPqUBs/1JZNam36e
	 d2Rr+QhMKLPu6dnzWoySXq9gfcHffG5w8S+p3jclbvXXVKwG4H/2J+WWjHzhF4mPloNaa
	 Cdeh2emSGYi0Ky5yTW6gNqC1uig4XKMRN54P496GZg8ZyEGHux5spdbIz+nuL2BBP80vA
	 KqumKwD3bP74vGVEGJrrpSe7912qaGxztzm6Bigfp+NYkBNC9TS33eMw0e5bXgU5VRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638161;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=1lkuKfWbZDWFuBg0A1hsuwCrSIaJ59LEhxzzatqQpNY=;
	b=jtPwKf4zzZ0m4mJ/MaCXCR0vQJtgVVaavV4lcQpLHFC0t58a3y1ECjwX2qs0k0QGa2oG
	 eur/JtXEwiaIQTBBiw8QonBeRDYD2tcDqR39mJ4688TIRLFiARw2a84CIspoub/i/WT1G
	 M0nWA86ICmrmZVwtyNTr4vYdK0NPdpJUZvWR58XkIqj/NOT8Hiz6qVxNwuTdd9rR2FDWW
	 OSFuZom2dNufKWP22IIad0CIFXGCvTsTUBlQlYHi2a5U8JyKxZUB+h2D4iOph2qqsDyFD
	 lFfA/9GtU64KsvSR2uVSFtVamyjrjQ4u8XO8qXUIpvE3F0rMK4UW2X1noJrFhTGmVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9F606A33A
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD9F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4cd576f2aso46978527b3.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638159; x=1796242959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lkuKfWbZDWFuBg0A1hsuwCrSIaJ59LEhxzzatqQpNY=;
        b=NSXA40C/PbBH3BZ+DhBUO9KcxY7NmlIoRY8b+dJm0oEw5NdmY5E+lR+CwgCl5OiAkQ
         1PoyM/iOWorDN1Ko5uR4e3ls2wTh9w0x/61iUQTx457eyhYbB3hjb7y/3QAG36OtKC/U
         REyzsHL9LhQ9Ek+XPvu3ahEg14W7E7RQztl7SiwpkCgzvh0e1dgBC9ikcFgBV2YED3Bt
         CLZyW12W9p1VWkJWguWefofyb9xx3SBIZ7DGTd8JA43BZHOd2cid8tf546cSJn49DeFR
         ak0BfVd4F1PU9MbSp51genKRPlqiBx3sktXPtiLP5FwTqbF6GYClf0O41kmuVH9x9e8o
         kvMw==
X-Gm-Message-State: APuU4Z/vpBEIDFA7GhSjL83OiEdJ7vq74wxGvg+DxpFNhqPix2ytVOgA
	xI9SOhmiZh1Un7OTpCw7NtQ77tdX+kHAV/+He2p1vid8IllWWUC/YGUR
X-Gm-Gg: AZFdTZftaXWNspkzy/YUa5pRwhT/nWL5RYJW382mX2GF5z95TCAd8i4MPyYeHT7D6mh
	Z8ySsX3+ls9GTslocMjp8v9icqXMRVPe/IUvWeHdw/3Znd2lfdM8wOBz0rFUwdDm6csMfx5oHjt
	NJDK3NgRRKu8sIzF2kvrRyQ91iLyrd4kgogA927CANioXKDZ1e56gYBfCFMbCa7YHg7lKOa2uwC
	1mO4TsDQl7YCoy318Zn7NOAT/QPwDFP6MDlm/Ly19gxakXrxLXoAJgySOpAp2iYkhobjCd9wVoq
	wM1LT6NpCZHus1gZs+2qPTUNwXyhNKKipPA+yIxCKmKGMs8Zw4vdpl2Dpu1z68jeDuOcw50jK4l
	wpEGtvh1Uugmw6SWxo1GpYnTfB0Tf3811LJfU+TYa2DuNA6grnAW5bxmDXA2goB7BnMDlwckGiq
	ScE1wkdtUCm37R6KvtXAoN7f7kw+EA04YdKLMju/S6OGQMmOW+JvNaw0PchwQKXl6MSl6TmDgUR
	GcDuDsL3yP1W0B/A+a6F6MzhmY3U+NA9P/POttxAAWajpsAmoPy3CXP0jBN6mOhjo1t0nV+A/49
	zrJU6pn8JPIK0V437qnFstR/U3UyRdL+KJurjgQGMwWaX8RHdsVZHJEhHRlPQW3FNshXJmU7fmi
	svr1JfN1Z2Z+xmxaVnLBTKmASoo3ZhhUziMO+kmSXCYITMg1yLRKjlTQyjuddUmxUoNsfmFz8Sb
	kvbx7IeHO+5+UUqmpJEJ4+8aLGbAiv6OE=
X-Received: by 2002:a05:690c:6b81:b0:8b4:c191:195 with SMTP id 00721157ae682-8b52051969bmr90063687b3.61.1795638159548;
        Wed, 25 Nov 2026 12:22:39 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:39 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 25 Nov 2026 15:22:32 -0500
Subject: [PATCH v2 5/6] iio: potentiometer: mcp4018: Move the scale divisor
 into the per-part config
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-iio-ad5246-v2-5-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The step is kohms / 127 for every MCP401x part. Keep the divisor in
struct mcp4018_cfg, so that parts with another step size can be added.
No functional change.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/mcp4018.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 6ca6cd7cbf71..75a63a01acef 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -26,6 +26,8 @@
 
 struct mcp4018_cfg {
 	int kohms;
+	/* Wiper position divisor: R = raw * kohms / div */
+	unsigned int div;
 };
 
 enum mcp4018_type {
@@ -36,10 +38,10 @@ enum mcp4018_type {
 };
 
 static const struct mcp4018_cfg mcp4018_cfg[] = {
-	[MCP4018_502] = { .kohms =   5, },
-	[MCP4018_103] = { .kohms =  10, },
-	[MCP4018_503] = { .kohms =  50, },
-	[MCP4018_104] = { .kohms = 100, },
+	[MCP4018_502] = { .kohms =   5, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_103] = { .kohms =  10, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_503] = { .kohms =  50, .div = MCP4018_WIPER_MAX, },
+	[MCP4018_104] = { .kohms = 100, .div = MCP4018_WIPER_MAX, },
 };
 
 struct mcp4018_data {
@@ -75,7 +77,7 @@ static int mcp4018_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = MCP4018_WIPER_MAX;
+		*val2 = data->cfg->div;
 		return IIO_VAL_FRACTIONAL;
 	}
 

-- 
Git-155)

