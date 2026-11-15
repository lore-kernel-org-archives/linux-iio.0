Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731876;
	b=mu0qxl3M//H/jEVsYJJBu2DT0vJRkjGcfJYneVn35qahCOalV75E2+nlsWOsrteXlKTr
	 dMQ6h6ZNPwvNeD2BVyY/hcr6J+4A788DiPiFnsmvXLjqZ548oUeUO9WgkBZF8OVr0FMtl
	 gMJ6llS9pjP/kK8xRsoTgJMrDCLBm3qh9/XbX/sGNEFMB9LIjuuXBSujaAu6v9tqWpS3Z
	 P+lM8xW0sOpe2AKb7fWBmsMXZV2/hqky1rhmKmiVHkTByO3bIKUVifqKTBVWNM0CvNM6r
	 GYjqT3eM5r8A6F03zNVVYfsmdF79CdJoD5NCZ3dT4VQBtiHsAITTEaxHvZncoRfUwug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ux5NGbtqF+gagUInPGtsI7+EDxIceF6FofSlZy2J8g8=;
	b=hwdl8lPei2buMuTFJB8FuSbFeYWwrPSux4rYBZfXBOIuPBQ9NwDP2SzCIBC/6WpY+Xl7
	 aYT4Lktl+dZx0capUGT6MBThXTCvTiEwHKACaeGx9DaBoRbTuEP9s/VcAURL2gahIVNcZ
	 E05wXafsnYhvoTbh0n+SOiuxhtOqy+kLagYYdBuIVuAdAtOeEZFUZtFko/jqL7Hkf+1Kj
	 W6DQV18e8iLmQYleOHGwpTClPCOR7OgOIBQnvpwlUyM67gJItebU7T3wLJWY78mUOMlWU
	 FUtDJBfZAKEbh4Kfn9MxGISozZQX3DZBtQK7qdwml5tjIaY6bFRWTzOCeDoKHPvn3Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zB5gkDW1;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10818606A323
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 08:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10818606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zB5gkDW1
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d21051042so427870166b.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 00:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794731874; x=1795336674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ux5NGbtqF+gagUInPGtsI7+EDxIceF6FofSlZy2J8g8=;
        b=zB5gkDW1BqXh1JNvLccWrWrGO3i5x3t/XGqujrE9aStiElStX+CTSJLCXROTO01pkX
         leRQ8gKHYsQUQqYjgcBGYqxVVnmO0t2Eq6WtTqBGFpBMcL0344Xr4SqRkrX0BeHr8p6w
         V1IKWXxIc4YKyfdS0U4kmaqQovnl9QZN2WWSEl43ISd5+P9aqjEYKV6+aaRCeCzdkM4z
         4ea/tVNnxTyBzZ8MntZTwqHaY0qdZ7C2L3/7a+VL/zkTIEsS//Q3S2gWY7Yhol/Vwnoc
         r/EoCDlXpFauYAQLNdoLdb8kG7Suk10lneEhlTKgY8qt+cN2wTGrLw+PRkeQS412oB69
         v8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731874; x=1795336674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ux5NGbtqF+gagUInPGtsI7+EDxIceF6FofSlZy2J8g8=;
        b=xVKM5d28ttmWooiTV/ipnQzn80CxvIseghVcHRZAHEpA7Cvs3SRZgiHA5/ylobIZVi
         ERnmkmRKwMbBlamprMJV98iA3rbq3CvO5sWOpeerZJtQ4q8mMa6mZCfduStyW3L3pziS
         vnXlJn8DqYoEsM062NTc9LAMdUtLjTmIrb9zsVEtFd0HicC6BPSCMDTTotNMC08+gCt3
         PEgWB1YJjQD70D57VLzIpDUYgkVOJAAqY1m8paleyEgmdGa3rn9FTQiVeotYQ7LdZBzS
         jJxEmPcSpU75J7jNfK+8jaKBahKNarimhtSD45HvpQUwj3U6ITzLM1awZUBf6JNdtDX/
         n/yw==
X-Gm-Message-State: APuU4Z/kWNa2Lx955QMQY3IS3eUHUDJTc+YFOOT4lzed6ROFAxPNi0Fr
	OrdZ2Fm+32BPMBVG3Bnzzfqms8zn2Offd88AV+sEngOL6+3C8KOur5pr
X-Gm-Gg: AYBFou0Aj6Vf8+SH10a3FtxMerFLlB/nstMbXSE3q0GR9Sd+42OkuXJA76GDY2dDyYK
	HS3J4fj3xGI1iAS7VhnVQ9Bjt50kDiekm6nf9H0jTVH1mh2MLIkbJQhkhCfEFbshYQf3m3H2D5T
	ct8dimlDaecqcph5JljazwcF7ikQVlyHaOhD/yDtSiP4km7wjABZE4QqCQEVKnpW6MDNsDn99nc
	wZN+g6q/7aO9evimkllUBP4Fj46HqWYGF48YEgNjX0WZmUOOHmcJBPchBjCHX9LwSpYPOo7h+ZG
	a7crxFBwUNaGk+Q3aAIW5Og+TUeXFtJFA0OVWP0xS595YIMv3bYvvMjZChWP+eJ2vJ5Y13Bty+w
	ZxNRhHly6Zg8JYUpTfgfK/W28BNCNeo1nu+YBnxzb5wk7sXeyvJdzBTxt+5oHinSLl1vzhrq/uW
	jEIUj1/bhfd7JTPTd64RL3DyCDsqs7WUc8X2MR3ojhoxjsNbDGg35Idc02kpARDH/rWJersctoh
	x8i1PjkUmLwdjfuE4o7qP8LqucftfT6FHc+/YDqPOMX7s6XV9t7VjPp6aYlfWDC8YYM1TQTYBZT
	7hUdbTa9U+30LZAKjvJ5ey2m3UR774lhjTsdoDlFzVFbUcBPjfXGLBbdUIBKeOiM2ltJcEiL7RU
	gSEW5aANjotP7k7OLdCJ3eMnEU/32uCU=
X-Received: by 2002:a17:906:c14f:b0:c50:5a51:632f with SMTP id a640c23a62f3a-c50963ce147mr624639366b.39.1794731874281;
        Sun, 15 Nov 2026 00:37:54 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5ad9esm284815666b.2.2026.11.15.00.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:37:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] iio: light: ltr501: Add LTR-659PS-01 prox sensor support
Date: Sun, 15 Nov 2026 10:37:37 +0200
Message-ID: <20261115083741.62140-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing.

---
Changes in v2:
- set IIO_PROXIMITY channel to scan_index 2 since driver will not handle other
  id properly
- add IIO_CHAN_INFO_SAMP_FREQ for IIO_PROXIMITY channel
- isolate missed ALS register calls
- add commit to use read_avail operation
- convert to use modern chip info match

Changes in v3:
- LTR501_INTENSITY_CHANNEL macro adjusted to set predefined info_mask_shared_by_type,
  info_mask_shared_by_type_available and info_mask_shared_by_all_available
- added info_mask_separate_available and info_mask_shared_by_all_available to
  proximity channel
- fixed IIO_CHAN_INFO_SCALE for IIO_INTENSITY since table has -1 entries
- fixed indio_dev->name asignment
- dropped ltr501_has_als_support helper
- fixed channel finding in ltr501_trigger_handler
- isolated more accesses to ALS registers if no_als_support is enabled

Changes in v4:
- adjusted intensity scale passing
- int_time and samp_freq converted into 2d arrays
- for_each_set_bit() + iio_find_channel_from_si() > iio_for_each_active_channel()
---

Svyatoslav Ryhel (4):
  iio: light: ltr501: Switch to read_avail() op from manual attribute
    registration
  iio: light: ltr501: Switch to modern match mechanism
  dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
  iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor

 .../bindings/iio/light/liteon,ltr501.yaml     |   1 +
 drivers/iio/light/ltr501.c                    | 425 +++++++++---------
 2 files changed, 209 insertions(+), 217 deletions(-)

-- 
2.53.0

