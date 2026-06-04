Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [136.144.136.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20230DEA6;
	Thu,  4 Jun 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567592; cv=none; b=rGkEkm1YkqKe2uoWgsj8eGKYSz2BkjHj+iRHkyE3SP4pRpD7xhlvlcvNE0Ky9FoCk0ULZ+aKChl5aPyAVGDFOqFWxJufm3yRH9OfSqLzl8J7lunfCXMylkVFpp33UfAo0rlFtB0wqYSZaIEFTJfoTPGO5RqCrEHIAg5kk/6tjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567592; c=relaxed/simple;
	bh=SLpU7aN2a9faFe1mhShSSdbVwUGdtGHAq78J9+XZRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fl+wb24SjX9oE6oFBknYHoqgFUDWOec3WA7V+QIWeIOJHa93Ojrs16vCfL+CKMBrNOpspgI2SnaLjX3wDr3OPdI0+AFmpwUZOaRjo+c8b+O/1V4h/vqF6COgi//uksnOi4xKh8KcbDbuofDNPysanQ7KZPvKqm6TwnYKwGLCMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=q4xlIROe; arc=none smtp.client-ip=136.144.136.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="q4xlIROe"
Received: from submission11.mail.transip.nl (unknown [10.103.8.162])
	by outbound7.mail.transip.nl (Postfix) with ESMTP id 4gWKwB5njBzQvvWV;
	Thu,  4 Jun 2026 12:06:18 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission11.mail.transip.nl (Postfix) with ESMTPA id 4gWKwB0z49z3R3nyw;
	Thu,  4 Jun 2026 12:06:18 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tomasborquez13@gmail.com,
	masneyb@onstation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v3 0/3] iio: light: isl29018: overflow/precision fix + cover-glass gain via DT
Date: Thu,  4 Jun 2026 12:06:14 +0200
Message-ID: <20260604100617.3486541-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission11.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780567578; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=br/W1kxa5o4a9978W2FJuQnhzfuBESTeaxzezoAI9Dk=;
 b=q4xlIROeMywnO7yJ5l/DVqsXZTQdNb3vQ/qK3pj2Z24Zc0wORcL4ZZegXHBsSj2ICxQJ7I
 W/HF4fGrm1qmWDPnwi9hspBWCHUM5EveTNvVKSQvsIooQyJjVVuzSRSEYMtEBplVQsWkuT
 ePAv1Mma0alABHkkciNzaTRzA8K0CMo77ihMAScQp2SgWDrn5Xl9TOJc7RDvfqAbbZNM12
 +aiOqeLRj21a9I2hout3iJhfKW/PhRlZCIj6Xt0TXS5DbSR2X2Aj2x5Ghf/DvYwrVP1k/G
 chk8W+r3qiefJJAHREom63yyO7YA1nFZWZ4aCm+yV3x/rtvzxSPW0yfPohNTLg==
X-Report-Abuse-To: abuse@transip.nl

v3:
 - Split the DT binding into its own commit per maintainer feedback
   on v2 (binding must precede the driver patch that consumes the
   new property).  The series is now 3 patches in dependency order:
   precision fix -> binding -> driver.

 - PATCH 1/3: tighten the precision fix.  v2 widened the intermediate
   arithmetic to u64 but still discarded the sub-lux remainder before
   applying calibscale, which collapsed to zero on low ranges with
   large cover-glass gain.  v3 keeps the remainder via div_u64_rem()
   so even small counts contribute.  Switching from '/' and '%' on
   u64 to div_u64()/div_u64_rem() also restores the ARM32 build,
   which v2 broke with __aeabi_uldivmod.

 - PATCH 3/3 (driver) addresses Andy's review of v2:
     * hoist 'struct device *dev = &client->dev;' so subsequent
       device_property_*() and devm_*() calls are uniform;
     * guard the property read with device_property_present() and
       surface the failure with dev_err_probe(), rather than silently
       falling back when device_property_read_u32() returns -EINVAL
       on a malformed value;
     * the silent fallback (calibscale = 1) only applies when the
       property is genuinely absent, which matches the tsl2563.c
       precedent.

PATCH 2/3 is the new standalone binding commit; the schema, default,
and rationale are unchanged from v2.

A follow-up DTS patch enabling this for the HP TouchPad will be sent
separately to the ARM/DTS tree once the driver change is upstream.

Herman van Hazendonk (3):
  iio: light: isl29018: fix overflow and precision in
    isl29018_read_lux()
  dt-bindings: iio: light: isl29018: add isil,cover-comp-gain
  iio: light: isl29018: support cover-glass gain compensation via DT

 .../bindings/iio/light/isl29018.yaml          | 13 ++++++++
 drivers/iio/light/isl29018.c                  | 31 ++++++++++++++-----
 2 files changed, 37 insertions(+), 7 deletions(-)


base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff
-- 
2.43.0

