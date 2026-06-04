Received: from outbound6.mail.transip.nl (outbound6.mail.transip.nl [136.144.136.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE73B6BF2;
	Thu,  4 Jun 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555783; cv=none; b=MyelWv46bGH3Kg869srKQ2ZEGFGh4Nvxwq5a+YhBltcVRb4xup+3FkDTpCWHhVWae5Q62yi5NLE3vX1mLFPaDPS1CA1E0DGzRW4K1Sby3vhLxZro5byQ5eLEkETWtzTjBL9EB2pTzGcjuSYivjcbXNrMtZJZEpgbIAwM+JNRy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555783; c=relaxed/simple;
	bh=PxIQ8SEszgJEoiMscMeKAH0agZuwv8dFmRqzq3Xm5Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VK1Le9xaM6f0/T9wP56wa61OVClHG5A2/TvYT12spadjXMIchHDebJoacZpuSldMMsSVf8LRGMhW2Kzb8M43ER3ElUksnmaZ7B0/PdtPkTm9TkqdZRK1yRlDX5CFxiDdCVWBz6S06I04NSi2uDuGF+Yn3m4MyAbzq/+Z8BbK2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=pbkHP0IH; arc=none smtp.client-ip=136.144.136.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="pbkHP0IH"
Received: from submission3.mail.transip.nl (unknown [10.100.4.72])
	by outbound6.mail.transip.nl (Postfix) with ESMTP id 4gWFY26P1tzwLHK6;
	Thu,  4 Jun 2026 08:49:26 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission3.mail.transip.nl (Postfix) with ESMTPA id 4gWFY22Tndzf52bP;
	Thu,  4 Jun 2026 08:49:26 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v2 0/2] iio: light: isl29018: overflow fix + cover-glass gain via DT
Date: Thu,  4 Jun 2026 08:49:23 +0200
Message-ID: <20260604064925.3097108-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604054723.2983181-1-github.com@herrie.org>
References: <20260604054723.2983181-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission3.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780555766; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=2PRT3C5YIxjJJ43CY0SzIxFmJ0k57soJOLgG+jCIn/4=;
 b=pbkHP0IHQuPktENQYy5+s4KCA+dKzGPmNMS3Je4tsJTbCqwLMnDm61gk4QUsP1/6QKph1E
 gYGZP9lse5O1nzJVEYczL1/DWqIEz80l2DfWzC6WicBY9Pb2GlWHs5M/rU4KZq2VWkFM5t
 IeVZqu0G3sBm5Z1GLOt2BHfEkvvgKSWgExqzLJC9OmmgR8g+rQ2wfPWFnrW//BL5U39I8j
 1tBMrIGuyKILeOHfJ3pvnNh65Y6J5erR7JRO/hOZLtXYhF8R1oIIdPiKE6VzBIlVaADRs+
 snwYd73mlxKsREI0ewNHcd4JUHgUMGX0U+5Zej3Yoj6a+LAnxzgNzy9pW+4l1A==
X-Report-Abuse-To: abuse@transip.nl

v2: split into two patches after review feedback on v1.

PATCH 1/2 fixes a pre-existing 32-bit overflow in isl29018_read_lux()
that the reviewer correctly identified: lux_data * scale.uscale can
reach ~64 billion at full-scale 16-bit readings (65535 × 976562),
overflowing UINT_MAX before the /1000000 division.  A second overflow
occurs when the result is multiplied by calibscale and stored in the
signed int *lux.  Both are fixed by widening intermediate arithmetic to
u64 and clamping the output.

PATCH 2/2 is unchanged from v1: it adds the "isil,cover-comp-gain" DT
property to seed calibscale at probe time, following the precedent set
by tsl2563.c (amstaos,cover-comp-gain).  The default stays 1 so
existing systems are unaffected.  The overflow fix in patch 1 is a
natural prerequisite because patch 2 makes large calibscale values
straightforward to deploy from firmware.

A follow-up DTS patch enabling this for the HP TouchPad will be sent
separately to the ARM/DTS tree once the driver change is upstream.

Herman van Hazendonk (2):
  iio: light: isl29018: fix 32-bit overflow in isl29018_read_lux()
  iio: light: isl29018: support cover-glass gain compensation via DT

 .../bindings/iio/light/isl29018.yaml          | 13 ++++++++++++
 drivers/iio/light/isl29018.c                  | 20 ++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)


base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff
-- 
2.43.0

