Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680722;
	b=0m9L64aD6dUq8mJIwtyujPTJy/osYT7SDKQaT1E1We+ssjMb/JgIfs7TV9wa6HY/yub2
	 gKitKbTpPO5mQWOKo9uqucn5tOES/CxkNg7Dp27SjrJYdUyFZOzjgQu1U3DpAu9bF2gw2
	 bM21SCyxMxLnzWPYzuQB8/7dSyFn+su9o8pBO0ZyiYDNEoELgBvpIo4yyvzbJnpw4cjxc
	 7NuHJ5wfhLKqNq687SdR6awaGYS/iaJeLA4YzkrOnoikpl7bhVsGz6cBQ+iNA8HBAFx2L
	 6Y8c9tq+F7rJ8HHQqS2CCVgiTKJQLxrYtbu5uOe9LDIYnS9z2FAg2GnyDSo0vByS0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
	b=Bo9Ka6d7saB4cwf3iAemj1e9Ql5Cncj7HtwT5if7BZbunAsE70nwSKzeBg5znxk49Nzc
	 eYdLUF3ZTUeh8LaUoAFtP9NSHj7lWToX7glQq6x1roLzAIxoI2mO0ZMCTPH3l8HYD98SI
	 e/0KaYS8UlNCbiF0ELh+nbBYKqdO9F/BWRI/gTOf2CelaHtQ/LLFmpwrn5hdLiJwg7SqO
	 81wdgsrXeqOaQfsiwQ/DY7OmUX0GsH/IA5xCEfqFAuwyaeYtjkX7zDOOmO0v0+/ZTwj2B
	 mxONet27Q8a+D4TZ0IdlPI+Bq4bsCqaisYqJfi2BCkzfGGSnA7yo2s2pxk87/IpwSwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbdbSX7w;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33C606A334
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 08:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB33C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbdbSX7w
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3816700a91.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 00:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680721; x=1796285521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
        b=BbdbSX7wwOQQL4prnHw0pE68+2q09ukaAXLRXVlrVhcC2deoQ3y8C8Y1C7zm4PYR/A
         Mr9vkicwYcpS/g2rcx4VkXLPC7CDXJGmahGx+LbrO4BTgZv/G0tZrQfQCgH5eKjf5xN7
         GXqhP4Fn7Ay1WVekMz2wMJdONbsI3Mw7YLYPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680721; x=1796285521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
        b=GERUNcA+8Gp1CeRfohEfjWjHBnWSuyZFr+sPDEUbVj7iCTLaOr6oB4mlZCSVQRcIwt
         nQgwR9Z3ByUzQTskSmxOKdpSla2fFlT+rsh3uZchV5i8QkmQj35D8N6mv2PR/GVf31vm
         WVAWH2phL1mYNRcJvFUq4GjumrxYxYT4UlshJOcNStZncx/A/pUfaAA7PTxJKFakOs1i
         WhE/AUeTHB5v/nmhOlLf+63aVyMqJaELQByfgUS/S91bKVs858A1ODPSjvRf/JKznrtl
         B1PH5xFL/ieI05uTC8VUSsJKvsUZN7zd+F7HPwUF2HQeBMaWFe2QQXcDJOsdJSxzQBLe
         Ldng==
X-Forwarded-Encrypted: i=1; AL+hErEXA5UuoAFGhIk3tyIDJG8CV0SLcvPjLWar1FeTAjUdchgOnf2OnTsw9hiJgoCqRFNheBu7cKG58YU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/am0g1WcHJCWh+fycUDLjw3DeGx8SBY9C4gmMk2ApArnI3k0Nl
	H6vr9OQBqp2/P4/76OgThBpweimi1/A35N7g3VZEpO7TS1VWU+i6CK4o1TQDE9PRHw==
X-Gm-Gg: AZFdTZdDv9vjXiHkuCy3njR/EXybTfgw99QgO9S94hunw5K3ZnSwB/S+7kUX3WqcVuo
	va5LIHxXUrjVRI8tqrT5NmcdU5LMvSkxZnv8UJPuwIYxSdC1JM8dPjIG4KRCmW+P/kqnH4ZjWdB
	8NaJTVmLjDAmcGaHnKz41HD6LtOd/ZA4xRX1YRuw2xQvVAJsrQpuZERzK0lMMVtwr9cFywGxV/s
	0V4qNol1YOzpLhs0C1cd7qS1MxCs4xeB7BFrwxQgv9UWz2xEdcqbb78G5iTK9Wd/TVYaiQUP6Xh
	DHFFMVzzLKXgCQhFTNxkI8mB/DNcW3rSaF2oBDRKMCkkY4MJu0eSoiGsk2GQuBoLUuryk7ZBCkb
	+S/mo1XMXB+QOdGE2htStwRYz8rzCwo6ZTZ+qXRjNEGEd/eW+pj+lTq7p/n8VQqHtV1xApnIpyi
	A8hX+Fj5MYoY8c+QWc92geGpUV1ibelC/BwxbZ8AQLhn9XU6ch3QXYzqSnwvEkaQT06NSL+V4yy
	DCjk/r+9YGfYUTkQZQCXvwNU94itjiL5jHk1QZVNjAuOtb7wfK5k1Ax9IRwuKpQhaAmRg0pMvbV
	j02VoA7x6kDD+8fSWUZs8fnB+2HN+9NXZm5qCotdVI9ll2bM1tLwRLZIqVo8
X-Received: by 2002:a17:90b:4a4f:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3b41c8e0c68mr13193599a91.7.1795680720910;
        Thu, 26 Nov 2026 00:12:00 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405ec698dsm34037852a91.14.2026.11.26.00.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:00 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] iio: adc: rzt2h: Make POWER_SEQUENCING dependency optional
Date: Thu, 26 Nov 2026 16:11:52 +0800
Message-ID: <20261126081155.501493-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

Hi folks,

This is v2 of making the POWER_SEQUENCING dependency for RZT2H_ADC optional.

Changes since v1:
- Added blank lines before return statements in patch 1 (Bartosz)
- Collected Biju's Reviewed-by tag on patch 1
- Link to v1:
  https://lore.kernel.org/all/20261123113755.3033436-1-wenst@chromium.org/

Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
in the IIO tree added power sequencing support to the rzt2h_adc driver
and made rzt2h_adc select POWER_SEQUENCING. When combined with the
in-flight USB core power sequencing integration [1], this introduces a
recursive Kconfig dependency:

	error: recursive dependency detected!
		symbol USB depends on POWER_SEQUENCING
		symbol POWER_SEQUENCING is selected by RZT2H_ADC
		symbol RZT2H_ADC depends on IIO
		symbol IIO is implied by HID_MCP2221
		symbol HID_MCP2221 depends on USB_HID
		symbol USB_HID depends on USB

Since RZ/T2H and RZ/N2H do not use a power sequencer, rzt2h_adc does not
strictly require POWER_SEQUENCING at build time and can use an optional
dependency instead. However, rzt2h_adc calls pwrseq_{enable,disable}()
unconditionally in its runtime PM callbacks with adc->pwrseq == NULL on
RZ/T2H and RZ/N2H, whereas the !CONFIG_POWER_SEQUENCING stubs currently
return -ENOSYS even for a NULL descriptor.

Patch 1 aligns the pwrseq_{enable,disable}() stubs with the core
implementation so they act as no-ops (returning 0) when desc is NULL.

Patch 2 switches rzt2h_adc from selecting POWER_SEQUENCING to an
optional dependency on it.

Patch 2 relies on patch 1 at runtime when POWER_SEQUENCING=n on RZ/T2H
and RZ/N2H. On v1, Bartosz noted he would "prefer to pick up patch 1/2
and provide an immutable branch to the IIO subsystem".


Thanks
ChenYu

[1] https://lore.kernel.org/all/20260916075745.3549953-1-wenst@chromium.org/


Chen-Yu Tsai (2):
  power: sequencing: Allow desc=NULL in enable/disable stub functions
  iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it

 drivers/iio/adc/Kconfig         | 2 +-
 include/linux/pwrseq/consumer.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.56.1.839.g22a8290db9-goog

