Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E43B4E88
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930318; cv=none; b=aXecspuHg0d58lBCb1hON2XSSq66LWvrNZPLVfi+mVAxVgF3ggxzL3Wceb1nRmXDiGaBNDvUhIpGc9Q4d1dDKekQwIO6p4hSo6MvJFGESru5NNMSzpYx87+lD7C5EbPCmAsZTOzUeOqvEoExAzlU1AIZXSfT2zzlA8MxH177h4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930318; c=relaxed/simple;
	bh=w8I34koWGXYfCbCeFDqIjlEVYSltGox+hUqBJJhWou4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7m1n9Ao2KZt/JWPOmRIxqsF5bBfbqlxn0hYxpM7hkA53kP8gaozwkdKFqs44QpmGb46ekE78zAJs8kFLhmb5eVCe9YAX/gwvZ7ccF5oGwaDJ1fS6EN8nyiKuwjvRQS7xJH1xQ/kWWONPJLudVN+PFTLz7c3G1vm7tinvw+bSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4VIgqw2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4VIgqw2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso720807a91.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783930317; x=1784535117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ww8rjm+JZiZBaoDFPUpDnonQY3B9G9iGUaqmjxdFhqE=;
        b=R4VIgqw2TkNdRmTssq3E4bncW80BXRiEQS22YDHmEdUr6sVy38pPhwjZ/bh4ps6/MS
         hHCM9uD4oFl91gf+QcZXlKvAuVh2O3R0Fac7XAcHkleKKAgVwj4o97TXDksvrLmJCYMw
         0YqYy1XgnxH7m3k0y6YNQOBAFrJUToSsWZGMxWYFClc+LreUEHArpJcaA+uaG5Aik+cf
         B45Yz0QySs70X8TYOEnB3l8bZmBh0jU4DsWphsn0Cl21ps53XdyHRNHnoIatYACp8biq
         DNqEo9vU8+gWVt7tMdiB7CaiNZKzN/9/5AV0QjtPg6eLPoqFfeUl8odTnv/RdQ8Jgmse
         mhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930317; x=1784535117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ww8rjm+JZiZBaoDFPUpDnonQY3B9G9iGUaqmjxdFhqE=;
        b=HQPG7d7crjrg5PwxmWmm/sW4Nqy8sICP+7FZ1KTVS/kxJh58gUyUYP2Uox0P0mK0xM
         AlRL+l5QLANa7pvpDL248yErrBsQ1olnJNxgj8wso6laO8IjrRhn6KXqyB/er3Df5DGe
         AnFjOukBvHLe0DTwNSO7/K/L0EGAgwLffVonPnzhfncQY62qDtDpqdCuf9FL2fXzIefj
         m9OjQKulx6O/h8JqHxGp4jUPp6K1zTquN/FOTTpw1wiQbndZnIQc856gyYRPpZX6fj9C
         nrdDvhrJnJUbQq6AuAhlwVDBjpZAIJDM3g3iG3Cdm+ietqTHddXoLU8rwaPlnw7SSvwU
         P7KA==
X-Forwarded-Encrypted: i=1; AHgh+RpIabnl1IhR7zdu4PHy70qjyBdkYH+j3NFr1rYKgUHansYTEXMi6ZStE6XSsZGyfxH0ayu32tCVxnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYRdKon8ptMu4MSx56FYsK22SGBS5quOMoG5fwSY9SWXV2AES
	okXlJgkPLIp2fjv4bTmu2WS9qmFQiqApRlrdRolm6IoOFrS8eKUujiVa
X-Gm-Gg: AfdE7ck5UIZ/xa6DJeB+852d7+e5SmDWIv022ig+7bcBG6avolPQeKZ1Ee1Oq2Wlz5/
	iBu8PcEEaIv1AKgwvYzNsE72QfOjIp6O10BuZ8JZx+qskxE2ITU/ioxPYda/sUXkGl5EqHixFH0
	by7OXyBk4gZTN4tr+NH4P2x6QPQj5Cq1nqfvzmtK9CWyIomJafsHCEk22aBns7s9+nYRW/Q4ZY0
	uf836jwPxUQTYViE7IJFAovlmwH8E4kmv9U6obTqfz6HhXOgsVFr4HhdV+5d6ElotrNhQJf5Q4G
	tKG+3blxwl7oMBxVBxxK++ZZfgSueFm7kcU9ZbY06o5aPm2YSgqqRc7YZRa3ys/o7pcW7cUHoEZ
	/S4nbl/v1M57leMnLdfn1Md81MMTtp06W6I9vJfAWPmyIs3fYBW334jzUsL2nmw18V+L3Sej4dk
	UcPoPBsfm6tHheuNifVM2tzC7L0NHeFkyrw8SHwi3mYpwUXRSGqOdWAVW7Z0Ffjlx/d+Eex5QQm
	+8=
X-Received: by 2002:a17:90b:3c0f:b0:37f:f089:c81b with SMTP id 98e67ed59e1d1-38dc8071aeamr6520796a91.3.1783930316522;
        Mon, 13 Jul 2026 01:11:56 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e0e033de6sm269636a91.13.2026.07.13.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:11:55 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v2 0/2] iio: adc: Add Nuvoton MA35D1 EADC support
Date: Mon, 13 Jul 2026 16:11:25 +0800
Message-Id: <20260713081127.115197-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

This series adds devicetree binding and IIO driver support for the
Nuvoton MA35D1 Enhanced ADC controller.

The MA35D1 EADC controller supports external analog input channels,
fixed differential input pairs, an optional external reference voltage,
up to four end-of-conversion interrupts, an optional reset line, and an
ADC-to-memory DMA request.

This initial driver supports interrupt-driven direct raw reads and
triggered buffered capture. Buffered capture is paced by an external IIO
trigger and is limited to a single enabled voltage channel per scan in
this version. Multi-channel buffered scans and DMA support can be added
later.

The driver supports both single-ended external channels and the fixed
hardware differential input pairs. Differential conversions are reported
as signed two's complement values. The ADC scale is reported using either
the optional external vref-supply or the internal 1.6 V reference.

Changes in v2:
- Update the binding to allow up to four interrupt entries for ADINT0 to
  ADINT3.
- Add optional vref-supply, dmas, dma-names and resets properties to the
  binding.
- Keep diff-channels in the binding and restrict differential inputs to
  the fixed hardware pairs.
- Limit DT child channel nodes to external channels 0 to 7.
- Use regmap for register access.
- Add optional reset handling.
- Add optional external reference handling and IIO scale reporting.
- Use the internal 1.6 V reference when no vref-supply is present.
- Handle differential conversions as signed two's complement values.
- Use an external IIO trigger for buffered capture instead of a
  self-retriggering EOC loop.
- Limit buffered capture to a single enabled voltage channel per scan.
- Rework suspend and resume to save and restore the buffered capture
  state.
- Use devm_mutex_init() and scoped child-node iteration.
- Use the new scan_type.format field for buffered scan type metadata.
- Drop datasheet_name from channel setup.
- Address header, helper naming and cleanup comments from review.

Chi-Wen Weng (2):
  dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
  iio: adc: Add Nuvoton MA35D1 EADC driver

 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ma35d1_eadc.c                 | 740 ++++++++++++++++++
 4 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
 create mode 100644 drivers/iio/adc/ma35d1_eadc.c

-- 
2.25.1

