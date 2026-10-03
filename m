Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CD38D3ED
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003942; cv=none; b=SduWRP++0aalXnuQHmvc9qRNn9tS3e0PZhva/1g+9MIDU2hogLixos/dpI7VoQKKBE6yi9fOOzApJlg7jX/kORsduiEAg8RLZuMgBw2gl1O/5KCPGkvId0qPtEagYkfIgbgwktFcFQx6KbiZeF4dneP3zpryVAr5lmjeUAHG/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003942; c=relaxed/simple;
	bh=1n3hNLNA8piD8V4+ptQPNN8L/VyoZDHbBd+gVifAf3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgvIInH7txg3dECTLeAtuISPhIMh3fL6NLDSlB25A1satoCv2HGA08JL/Y4LrPmar0fGd/kI8nH1mkrXE3DOT21aqiDrf1q5Isc/PAsMUdfORxcu9NzcuMrXu8mf5P0oaQLoDY6eeUwZIR3xncbkvE6dJROPEl/4K+yiOthUKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk1FUyKO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk1FUyKO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a49623b865so87348a91.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003941; x=1791608741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6LkvQ8Kd/cKQAlxyeidVUPpFg7ou+cK3PrsLKZpAcY=;
        b=Tk1FUyKO6GKXHLmUBaZNdYaoE7VmXVjEiMrnRJRWTCBboJ2oIJS78fj6tXEh0RAcSr
         kdAYctGmL1u1mPYIdLcFL+trD/JPPd1Cf59C676ykK9m9jmZpCYp/NaJh9Vf1JJEWAMi
         TMoGeMc/ediXMU2/enRViU3KPNrkhec8nY6Ni3VfftIRs6i9qiQVH+s+pCKYuZcNiMC/
         IwfzlJ2sn9SP2qwxQAvinUif8ynFJTJGxA/zjiOi/GLC6Er5cJCcWj7P95e85CpiadK6
         cWlxs3vSI6XOnVDcMBI6sgDcM7q96P1ajvkjxVgaIkaQaZtq3Y89uWkbTf3/eHexw2hc
         I+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003941; x=1791608741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6LkvQ8Kd/cKQAlxyeidVUPpFg7ou+cK3PrsLKZpAcY=;
        b=GYEB1PliHNkunPfLeRq53ACAaVUUYmz2Kki6sR3Amd7M0ZH6OPda2yEunxPPgYkMZL
         HBAv+ANYC3YiYJG2s4FKtKtT0jQUMyies5smW79buKuPOrOAgabn7sWFUjv7VHDJLBU7
         bI9JhsfdLEhmzT77LhUBmzcMIX2FMnil3xFVdV/Qh46De6PpT4OWGXMQW4e3KrZn6/uq
         M6/k2w3rY8H1GWuKchtAk9l37iig7FpycJloW13n+HbmMiRa0OZWBr2G9FwXn8TUwiJx
         rW1Ur4AkSH+slZfqTCYbV1b++YBVjfUOZ6yUrEyDR2ZKx+Tetmm4wnnwbGq/MCm2XoQ6
         mFHA==
X-Forwarded-Encrypted: i=1; AKwUvByhETyTyixYyvKSgWSYGkAmVONY9D0i2QU2WwkwR/doL9spw5tOky3OMQXsVceAmAtYQBUh01i0v/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzyI6PVr3TwKo7YKxVr7YuJEairHgrjcJSF7+QaZl6GEHS4C6Z
	30c0BQnl++3L388zj94pbXRow7Uw1JvBkekhdzxBwglkv2m6uPikfAxj
X-Gm-Gg: AYBFou3igYCueTvMkdqomrHpxgsqFn9y1EBhMpeBs1pCfHw9GN4eMTaUBu+90rAwHzy
	FlbBox7v8VWPprVawXcsg7cmzHz62bdzevZVhlZ5BtYNH3l5ct0jSdx609fB6QT36INYiicg0nR
	jm+HklrgRn570OEradIZjStbeNS3oS2E9TSiaV8aEIAkfwDGRY2S6WaDjuwBMaLLb4mYIB5ZeIJ
	c1tH12HIuAJ1+9me0keFqYW50agZbsu+hhvTy7dzHQ7sVfM4WNugCkUwkqrHxCHYFLzj/DPslie
	jVJkDNnS8eyS2LrRuZQ95d7yXcHxqKTFaUsnIHyCAZJ8pJ7mdiaQyqvybRJEeHtW34iPCX8FY3b
	grKzFEOfirAba1AoiH7OwztsV5WG2wsio37Pc2ovf0w5IG0YLFZ5+YcSa1fbFV6touZGL+UmW1+
	hMIf/66h/6P6QnUCvbeioVwjfMAzh+2j1xKbN5N4n/+qF5BmcPZkfNGCI8HeNMb2TvML6uGxH29
	eRriTauHzAE28m9djmC1g==
X-Received: by 2002:a17:90b:1d43:b0:39d:fcbe:fe04 with SMTP id 98e67ed59e1d1-3a78675860emr1077468a91.2.1791003940820;
        Fri, 02 Oct 2026 22:05:40 -0700 (PDT)
Received: from l (ec2-13-230-214-216.ap-northeast-1.compute.amazonaws.com. [13.230.214.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a869esm1650442a91.2.2026.10.02.22.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:05:40 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>
Subject: [PATCH 0/2] iio: proximity: Add Vishay VCNL36829 driver
Date: Sat,  3 Oct 2026 13:04:51 +0800
Message-ID: <20261003050453.413700-1-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

This series adds support for the Vishay VCNL36829, an I2C proximity
sensor with an integrated VCSEL emitter.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver, which exposes the proximity reading and
a configurable integration time.

Tested on Orange Pi Zero 2W.

Liu Yufei (2):
  dt-bindings: iio: proximity: Add Vishay VCNL36829
  iio: proximity: Add driver for Vishay VCNL36829

 .../iio/proximity/vishay,vcnl36829.yaml       |  55 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl36829.c             | 278 ++++++++++++++++++
 5 files changed, 351 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
 create mode 100644 drivers/iio/proximity/vcnl36829.c


base-commit: 52c36105f76e96b638152a42e735f2e7767ed946
-- 
2.53.0

