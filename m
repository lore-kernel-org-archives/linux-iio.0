Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433888;
	b=XfxHwlQH1VLWXg1oJ5hP7lmtlplv34WTeCzWBQ8hagMK/t7lmP+mMEp409wDikWx5L45
	 R8pmgH5VhccocEiz8hK1if18VG8K6zuNx5qDxMqZZnLA36tdymwl53IyzDMRJX1k5RFr7
	 twxUKuyVRGfPA+VbCn5swHAe5THD7O9jjd2QXqo4nTAp1XVVu5DRt2XgKI7SjCKpS3S6G
	 E4c/ILP22QrfLk+AVGBctg24RwymfmSKl3GD87Z2NmVUVDVSMKg9Y5tUP4hjom5VdHwXh
	 DirHnU8me4z6F7i5Pg024aznEbbin6sv0Gy7E2973JW2IaIvpCzJPDpJkxjaUl1Zgag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
	b=i+Nw3yfK0jihL9BVpCgzw6FYauzwEgLLS5Ito7oL+dZ/uYazToJgH3QZk31YrAcrBIjq
	 UKd1vNidiLjEuMZh1Zf3nYjS9Bo7QyzXxHAiGP7Yb870p/U6AdcbWoy86LImDGhHRlC5J
	 461Xy8/2WuY9bIwoMfd+E+oQ3Bu2AQIE/yMSks0DCzA/hcU3j9lJxhs++skA+V2ZZgZA1
	 TuOPenW5Q28u6Ad0Qq04kJ9aLlUiT/IjOC2d00q6ASYqOfv4YVXXE9ApK9gKL3ZwGknng
	 o2AiDhmSIYRD8OHELDSCF1433+Ftd5068hXBA+7avGLdmBKlwDAqo5lTfBXvYhwM81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jbwLwmRe;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106B606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D106B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jbwLwmRe
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2237000a91.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433887; x=1796038687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
        b=jbwLwmReAKQaVzUeDss8ILk/irYQPtopTRHAEKOe0NAE1MqbTcPOn5e3Oumo6x/hs2
         Xg6czQO/GvobpeNaiQhKfpfd2fdafZIofzRqva571GhAf1MctcvfdDrAmDmsY+//qlui
         rlFPW3Q4x/V/wd2l3OApWrJ864LrtLJaL9wOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433887; x=1796038687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
        b=mvabh0oceW12nj0eF+T4fqlao9HkkY0zmbBnfpyW3MuB8XwYylJeej1FCprvlFpLM3
         Z5g/u0VnmE4/nnyNlT0wABZQASshyvQugvp9SpgWSfISeRz2ujZRwa237PX7qyn2c0hF
         9T6vlL8GmKmG+WWc9oVy1Z1TkVEDu7Vn9ARlg0stbMtXD3JgRmd+LsJr9720mJmOAx/d
         LNaiRiRc5B31Cl/1GwBYYPNTTdPC4W8WU0tCh0srHNRherdJUYeMtD9oHXr7stoApn7A
         8TH0x40Rivj9OIrYCJsfpJPAbyF1gpPpJ6rZ4ye/7Ur2cOp7kt1GhWkS6gwIErgmM0y5
         f1sw==
X-Forwarded-Encrypted: i=1; AL+hErG7JLUrxkIUDYggsetMjpIHHVJSvpeg8eeUmOPKtOPJI8sqDfhdJtRN8UIXjoqAqzXviOi2m05N57M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Nfigj26Or5u3ZiWYBp7KwxZR7u76hYKL9xT60/HPEpFlss8Ja
	whf8FmgOSJZXN6Pmo+hzQf5AnbKw5gFF8bGbaTD6/E+DXDuq1Fv96HYPnFOf+tiCrw==
X-Gm-Gg: AZFdTZfqnI9l3sqA+2TRG4tkhojJEZj+2Rtiaqwh3tjHKQ7m/oDBLjEXMn7pmlBgRZE
	jtWzWh++kuZUMSfP3OYR/dxtYPcbHl4LB4JJnzkoCSFsg/hN1PmWsPAcf4KCFcBlqJ8h9Mr6bmW
	K81euRfk5gb6CE7nbuIzj3p4ImJiumDbF+Gj6yltLQZ2jucHIkzO2S6fgnOTV0euGgSxUjhZyWo
	Le3F07YIKJMfusGOK1/dYKsnwCD9ldXvliahptyu0Yc5w1FMode/fnd0zYbqiL9P60voZhF1TX0
	Ydo5cVKUiR7X5RiEEM6mttpUHEzao7AZieKzPVw7m+urQshkc3W2N2mKPSAJB3f/Sq5PLEalMMY
	gHp/ZG8NYilOMh5UfbEr0As9EF8sxEBvtslt2tnRv6ME/boUArVQM4vjnvjBbBWxxQxdEo18hwm
	xNb4q0j23yAX3RmR/tTBwmn2DZ+f0L5aKRbnkba9wZnLv2kg3H00J2U0KmytFrx90Fk6Ygh5vW5
	gtPLGi9LnkmxMvnZuFu/wVqHm1wtwy8ysRqpFOi/478PHNyhwBsFod18MyyXvgJnVJvJepSJwpV
	EuEgvIpWCmAtEZn/MugMq3nTwQNZ5A7yZG7qDcWR148fiXfUQ2zEGPgtZ1fa
X-Received: by 2002:a17:90b:3a45:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b41c8fed61mr10151391a91.20.1795433887289;
        Mon, 23 Nov 2026 03:38:07 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405ffa98esm20358101a91.17.2026.11.23.03.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:06 -0800 (PST)
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
Subject: [PATCH 0/2] iio: adc: rzt2h: Make POWER_SEQUENCING dependency optional
Date: Mon, 23 Nov 2026 19:37:52 +0800
Message-ID: <20261123113755.3033436-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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
and RZ/N2H, so both patches should ideally go in together via the IIO
tree with Bartosz's Acked-by, or via an immutable branch from the
pwrseq tree.


Thanks
ChenYu

P.S. This cover letter was drafted by LLM. I think it did an OK job.
The patches I wrote myself.

[1] https://lore.kernel.org/all/20260916075745.3549953-1-wenst@chromium.org/


Chen-Yu Tsai (2):
  power: sequencing: Allow desc=NULL in enable/disable stub functions
  iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it

 drivers/iio/adc/Kconfig         | 2 +-
 include/linux/pwrseq/consumer.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.56.1.831.g720f3f5937-goog

