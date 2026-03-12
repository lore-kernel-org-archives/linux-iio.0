Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67156368947
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316401; cv=none; b=MwRF9q5Ytn8NvDiSzK7ayiJzmawnrB53Ix8tmqtRBGGyE9jexWVF3f7DFPgaJMYRcDO0NBPoXLebvBib6cVkoikSwFYiOTMjg4fSwYZGQWA1aD4Nv6AEMZl6VqxO8TzWR2fkRLWN0tKfFznluXHI1sVJHoQ5TR+QpIc1zHwUzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316401; c=relaxed/simple;
	bh=J+U5drShINo5+0B3DYDVjx3TPOFOzJe4Hqp6zGMExds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dMhaTOmcFq5lqzuh2YHYoBEqjzRsqQ7PKDv3PVC/9ieWFlxg62xV7BGz2gSJ2mTZyRQSgxt592iaQJgbRm90fGNrtR/HUNnM9N2kIXurG08np2K898rGCPpP/eUDY2IfaO6+41WZ+geAGknYQsrgkKrL+7daU3T8JbZ1aWcANiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lbtg1hK3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbtg1hK3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439cb5af25bso975017f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773316399; x=1773921199; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44LXRHinVhycilszR/4yNd78RLiYQ/Nblg4COhfoEQc=;
        b=Lbtg1hK3yB3gYJ56R5yPo3Tx9k2eZYG8+itJUNHVDWUJUXTDBu0kzBHMQqaureLXVj
         qxNOepIhvFJrhr1W6ECWaS18js0pWx3Pa+6tMb6EHuY1RR6glc4uhuhrTT62hJptXQD7
         E3CzztCMcd0AC46SSWKREQxHRjVWAwp0eZqclmqvY9vUhs1BSzmzysIQbOweXvdGs2iQ
         8mrzW5gptAhciyV2B6lPdb5AXdTw9R1jR/C10oikQZC/NMdQQliwskkXGD6Ng+v/NJoy
         dJjcoH07vL9XdLuGI5Oqyb1SOH5hni1V/nnss9KX71lUd76R94FNL19e8eU5ayciAXX+
         VlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316399; x=1773921199;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44LXRHinVhycilszR/4yNd78RLiYQ/Nblg4COhfoEQc=;
        b=dIrJsLLX7BQZ9qSs2jR7le/b0rDLr54/oQ+xaPQNbMQzQO+EsF06YGY7zjv6NCJEL3
         SQn2M325FPt1zHBXwi+i99TeAJUsVTW541stx923n3fMzd4Yi03YHmbmRjFXS05QbR4N
         jM1NjkyyURkOZaIQTvdhoYTPh679q7hodQU4dFbeY67hbGgju47ihCRA6LTXmmmTws+X
         iJUPjDVFJmYCiVpSQ7uq1Re30IarCPb1OGpxoFmFKdizyQfdgFchjmA0taveNN443kW1
         KHIWlN3qNUPPFBJMsmJxNBefMAPNECHfC9C5KpR0Wie5AinsHEr/AEPAnPEDltPZGuK7
         ivbg==
X-Gm-Message-State: AOJu0YzOXeWlF4EbM59+KJuL04QA47zLFLgRCZ6wwG/qRuj6L/2nNUdG
	X1EuZ6ZlX6+gTv1uf/n5Aq2CLo2m3HmVgZ6PyMYycSCk0BTZxWXykYVB
X-Gm-Gg: ATEYQzxMQwWpHkwQr5dFr/SxzYkV7SWbbKIH1JoNVPEREzBhwI3ynpz3E6SoZmhREVd
	NnwujH3Xx0O7xR4PRrX9B82am87Q2x8P4wn1Ea4vaVcBycTuktqEzuTKnK8YIZ0Vz9ovkiUzoZ4
	2SCCIQn+u/+64g6CaR4gueaMjFoutQlhHNOt2PCnuf1Zf3UD5yWXTi5k7pASM8tk5mH3Due9ONu
	odTeeDFICQDvdep4AKS7agm4SblCYbGk7S74CIB91Wsu7pE5GOMZcKxtALTL1cfmFb0TX5b1vs5
	xeUWLHFk/MNLse8sUqS/Xe4k0xFu25WdaAezlheUSw5AxLwsnleAh9ue0tl+OMZwSi/3/Og+4i4
	070UW651l2xzYD4Vv5/cWVI0aKfvGcsVmFmpCcUuYEjuLNQZCsk3PNbi0+LKfmpJFVzIBfNd2gF
	0hvk1lcK/4M11WWKibR91gq3SIIw==
X-Received: by 2002:a05:6000:186b:b0:439:b046:2044 with SMTP id ffacd0b85a97d-439f81f2334mr11880791f8f.12.1773316398625;
        Thu, 12 Mar 2026 04:53:18 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7044960f8f.31.2026.03.12.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:53:18 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v2 0/3] iio: light: vcnl4000: add regulator support
Date: Thu, 12 Mar 2026 13:53:11 +0200
Message-Id: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQrCMBBEf6Xs2cim1VA8+R+lh3TdtgttIokGp
 eTfjQVvHt8w82aDyEE4wqXaIHCSKN4VqA8V0GzdxEpuhaHG2mCjUSVyywkRVeDpudiHD1ENNOq
 htaiJDZTlPfAor93a9YVniaX33k+S/qY/n/7rS1qhMmYojZb4bJrrtFpZjuRX6HPOH0D/Ida2A
 AAA
X-Change-ID: 20260310-vcnl4000-regulators-bcf1b8a01ce6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

This patch series introduces support for voltage supply, I2C and cathode
regulators. This fixes an issue where if a regulator is shared between
the proximity sensor and some other device, and the other device is
powered off, the proximity sensor would be powered off as well.

One of the commits includes a Reported-by: tag without a Closes: tag -
the report was done outside of LKML.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v2:
- Removed double quotes in includes.
- Reordered includes alphabetically.
- Enabled regulators before the mutex is initialized.
- Replaced direct usage of &client->dev with a variable.
- Link to v1: https://lore.kernel.org/r/20260311-vcnl4000-regulators-v1-0-66b6038ce563@gmail.com

---
Erikas Bitovtas (3):
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: add support for regulators
      iio: light: vcnl4000: move client->dev in probe into a variable

 .../bindings/iio/light/vishay,vcnl4000.yaml        |  7 ++++
 drivers/iio/light/vcnl4000.c                       | 41 +++++++++++++---------
 2 files changed, 32 insertions(+), 16 deletions(-)
---
base-commit: f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

