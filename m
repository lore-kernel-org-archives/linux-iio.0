Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913796;
	b=z0B4ufofha2hK5IvHupFen4Wt2YskJZV6ms9OkDTMCg83u986uRv/lL3BvMgsgtUCfv7
	 0JJwWdA4o3/MXuHz+0OFrAX7XmR3hafz8QLSd1rXwQC3SDQhg1Tc87pKz8uniEH/RokxX
	 CJW9C1icxVWhKO5v/Du4D6Yzi/2AYOLPvBAgx/t3J49oNzOiiMTB2aKDkTUbcxiJx9dDj
	 nG4Cpo7ev07foz5KviHnzCtqk8NN5MPlR7OjYhsnlQ1AjGRPl5eF74sdiKWHPBesRNS6a
	 cS4JLL2NXNdLm9SHSnPsmAkuiaL1ZANY/wyYjKNzfgLdXCLMyykEC4gHxNN73Ke3FjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
	b=qaZYSjvVhUBjGRSs/ELCdRA19EJCO6YHWbqJ+r0QoL5B06hwQEhd80adKOHT3bTW0CpO
	 +BL/tlGh6X/jExxoELcXeVhP/XEB1WNG3VTPXl/IiaUR1vjD0HD5EOoxLv5zJBB9OmY2n
	 0U6vsJEEYSN0UQRBcPBiy4KIq9fVHqEJp2sLXKWYK6MWw8lg8xw3xaQ4BXSRdUM0REfoq
	 +swR+E96Qvraj5Jek0bJoz8MVCs0hPQx5JnBHsxRjLilPedhzOrhI8mD/DWGKM/IPr8sh
	 ZyGz4D+5G7aQGgaamn5A7LNlgAgHXlOrf0CcLfWPVzGK74udKUD+1rN+hwNlV9E2fbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMREe3SG;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3102606A332
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3102606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMREe3SG
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so6632359eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 03:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913795; x=1795518595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
        b=PMREe3SGV7qkwfAfexg6hLXqIDQVT2NE+9apeRycnZWfK+un0+5zby9JX/IXIRYuX5
         waGPua0sJAQN+wOzn/dsHJitxLf+/PuDt0PNU9yT8Sx1WnITbRoQa1LY4LDyrNaVNsI8
         1h5dsSKFHyv6/bvU1bomDGinZ/KJE4+XOcBdCk73CvLvJfygYr+3StSQ7soCvBIGLmAu
         mFeitgVPOvvjSyJgBsns2LS9R2Mybd5FPKu3DzK/A1edRKySA28GAh64SeEJMulRA1ko
         0hGB+nI1i919xKAYIRECr3TIDraH3ApX2dC54IYHn3sT3+NDC/bc4ucLsPPPFKEdlnFj
         tMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913795; x=1795518595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
        b=S1P8Q1Hzk7FZjve56R9cxOvVl/XXe7gHVHnKikYYCycEQsYhNlw8Uc78XeUeWeu9/7
         3VvSg0sqonAm5rc1tr5SM+HIZo4P8lXZu0RRfY7zq8nT0BXXA0Jbk/S2sKYlLpG7ltka
         +fN7/EgSnmtNywWZ5TN8w3SpwRrcQo6UGVPp8n7c4oAc4aQmxkoIwOX1soV5TCi7HVBR
         zM+fd1d4tmn/C/KcDWdLFpM82EigS+FvdgMwsP4RJtLW41Tj6MNoft1MLNE2nv5871ZA
         1TRFXn7Qt+xeNrt6vjDb8FVEG+IJASiPVT/vKNQiqCoxPSViJ09dlDMYKIsfFNmfgCxZ
         1OEA==
X-Forwarded-Encrypted: i=1; AL+hErHHMIt8tirFIdDRA6+EQ3mAp74kQKMFyVyKocs7yevPfzrcIcCaK2GkWbNuJPl8Odd6wjj5mcIvhRQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8N5G3o0IOIWr4WA+Xc53RvI568YooAT8iquzWK33DNNP7/I7Po
	xfJHWcfw5PiIYoL0MV5kKqB42c3/sGyXx5jSwfVznlTvtGktwsYbbi7A
X-Gm-Gg: AYBFou3C8Lsx2U9SfLJSo9TvJy4znzk6rSe3lUzmBG1wYXbmQGvrJeSpopLYLSRXVDc
	W3vgHC5cyOPvI2qrrarktsyQ3fDyC0vPemxpC0g2FyrhqtHLRK+lPYw9zyTCW/kuWIE9gQ+WOOe
	y8VmBxUxr/Pr6kHZZfWFqyaOagLEikHW9HhtjAj3zwKuGGFrUqnRiKGTJrUYQFF2oXeRk2aqtG4
	bWW0bZf+Ec/685G/Lbj+KmTLZ5h/d10XiYIRfTaJzh0jZbD8ti9Oz4f/wbjcKS5nYn3zXpsPNJq
	I5/FQqeLZc2bt1z8+d8VhU6cOBvmV2XoiD/tRX+YJ6uvW8mElXGPNBoNigbVZOpJWQqL6l9xmEg
	olr8nWSHiFy+4mRCBW4+jdWabFrQ/2/amtWMzSLnuBM/CCCubOGhp4A15zdRD3xbR+KVQHJkk7X
	vtgyjYKHpE681dkr216kTAiD9Or9bb/0XWQa1C620OQKGxHjl/AiunUaEqGwcs7h0PrOeIZmShU
	xEjxrbHH7fGcuBkmpmLeGSZPxw09layPrIEFuQaQBQTDAckdCh6d6iP1RcEKTkScorDyYAuFdMG
	NiYC7eqt63hSKn79K1J+qGMmnp1lxOm6qLA4Ij+AyaEZOuE5rB6xOKFIyE7A3Yqzj14RgnNtfXm
	dTPlHl+CIJ21iIQ2E5RhAvHbWKgx21F9+GmfIjsF6yyuNvV/TtRu+UznQuTuUZrJPwxqPtX7ZkG
	F/vqS9f1sZdnJcwzPvbq4Xdoad9RSK2YQ+HSDXxLw6TgMJ+tQ+B+ZjVX30kLN3psg=
X-Received: by 2002:a05:693c:41cf:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-37967506841mr13060710eec.29.1794913794818;
        Tue, 17 Nov 2026 03:09:54 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-381a55555dbsm5560475eec.10.2026.11.17.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:09:54 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: proximity: semtech: add myself as maintainer
Date: Tue, 17 Nov 2026 16:39:34 +0530
Message-ID: <20261117110939.214932-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117110939.214932-1-kapoorarnav43@gmail.com>
References: <20261117110939.214932-1-kapoorarnav43@gmail.com>
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

I'm adding a reviewer entry for the Semtech SX9xxx proximity drivers to
MAINTAINERS. Add myself to the maintainers of their bindings as well,
so changes to them reach me.

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 .../devicetree/bindings/iio/proximity/semtech,sx9310.yaml        | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml        | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9360.yaml        | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9500.yaml        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index 775555d147bf..39059215cdd9 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -8,6 +8,7 @@ title: Semtech's SX9310 capacitive proximity sensor
 
 maintainers:
   - Daniel Campello <campello@chromium.org>
+  - Arnav Kapoor <kapoorarnav43@gmail.com>
 
 description: |
   Semtech's SX9310/SX9311 capacitive proximity/button solution.
diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index 8fed45ee557b..301d502f210e 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -9,6 +9,7 @@ title: Semtech's SX9324 capacitive proximity sensor
 maintainers:
   - Gwendal Grignou <gwendal@chromium.org>
   - Daniel Campello <campello@chromium.org>
+  - Arnav Kapoor <kapoorarnav43@gmail.com>
 
 description: |
   Semtech's SX9324 proximity sensor.
diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
index ad0bb44f41b6..2ac8bab30cdb 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -9,6 +9,7 @@ title: Semtech's SX9360 capacitive proximity sensor
 maintainers:
   - Gwendal Grignou <gwendal@chromium.org>
   - Daniel Campello <campello@chromium.org>
+  - Arnav Kapoor <kapoorarnav43@gmail.com>
 
 description: |
   Semtech's SX9360 proximity sensor.
diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
index 66dd01506859..cf05d1b0b1f3 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
@@ -8,6 +8,7 @@ title: Semtech's SX9500 capacitive proximity button device
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
+  - Arnav Kapoor <kapoorarnav43@gmail.com>
 
 properties:
   compatible:
-- 
2.53.0

