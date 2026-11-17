Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936389;
	b=aPM+M8Ow04ID/+cmx9svWmrvKb7O2CoBt2LxeqfihJ10JN9AiDg6MnMEnCTlfaOyfMte
	 Sd4CatMzMj2teP+gyYRnBrvL4JbwOehRcqhWG6EVkcj/Im1/afado+JwfmRoTDM5xjrnG
	 Tcl0a3qmrTzUswDVhFMZNeElAVxWRVljw/AbqEaUGrMLfC5Btcqohu+8HfGr06j4TFgsP
	 rsDXXkjTGZGzh4UXDWAkamLSqDTsACu9f/5HccBpR1pL8LH1HIFgEsjRwJkEDAsYVzldH
	 2AnW6KaySacRB9pnuppU+XFSAN5XQ/QgTub3BoQKiBYKySdghynq1hAmniZlxV+uB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
	b=eyOFmtZKMvenc1V3e2llFxLwln6ZVVK3x8D/a+xxtZwLg6gEqne3WubGdIwnNwpmyBk5
	 BAddDVVELsAMi44h4UqvPTPYVKnii+jl+hVm3DfPKs0erPjJU6h5auwSrnBE+tiTHAJJ/
	 Rol67k+M8meJpS+/DNPEy0GUBZX+dI0CTdEcZWKqpZxgjRItAMqSX+VTPvBDVI7CV3CNc
	 gRjoXybD5OYvu4wnH1+X7XwAo9MFQisddau2eert6VIjXueLreqz9pqBu5MA9HEhrPrUy
	 U6jWDreVpifD4z41pSjHji7Aof2VBz93mFCfrLoJeWnO59WkeM7SpW7LqGwe5b7kDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aw0y2bKS;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD1606A330
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BAD1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aw0y2bKS
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3b4944a0eso76294c88.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936388; x=1795541188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
        b=Aw0y2bKSmjz+HizsOZ8/Yw8i/5rgZp54UcB4X7lTBil4We0qmgDIZXhr85S/K/itdx
         OOSqfIMfxWVQCLTM5zlXpSE2mYbwJ+lVexBTP3DtEKysNRaQCfwnQlVMmgSujP34UhtC
         iqRBqHDgyfIsJCuX+n6Og8bl1vCdtHZX9PoUZ9gBtwOIYrIXBFNS9RbMMifZ5yaWvwdB
         wykEpAFmPPHzNJw3TfKAwCn3ynzXo0TLrDxQAZtAg2tR2uz7iKe8hsz0VPWLN4qya/ly
         lLvkYTLbnuu5CgNUZ/u4RoUe3Pzax/6o5FOTNou/N+sOzIliUHOk2221xP6ceKKzF1wb
         w6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936388; x=1795541188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzNmcmH6DQZPnhRJu7d5EWZ5XHOrbm2NPxIubtKTIT0=;
        b=auDoascuSNDt3TDBoCiYmVaJ87Y4NEakK+oTdeFhB3cfI2wsJbYBCpWBqbwrsGM3Ye
         T5Ft5eBM3lk2ggqB44Bb7Dd7d0PI3AMX3I2ovR3eWaY8ZdQhjiNDlCgma+VSULXaTMD+
         y01TBwsKA1OOWr96kUbnWjMlwaOPqs2hR42B5x86HNTW+SK6HynJHfByWV0EotlHavVT
         4fMvD5ujvdbc0lNxpS6BlQtneJyX26UPEH8XI3Bl2uNVbUEEROuCHa8j5Zg+D21y3h07
         gSneP4mz4uQT+ujtM43UJ8XI9UoS4jPq7um0Cyu8r8HWAY2gRNFWfD5BRkpX/yCZ4pDB
         HQmg==
X-Forwarded-Encrypted: i=1; AL+hErGWqajviId5p9Xg7qV2nAZudgZUWESG0gnSW8U9jNVZ36TiRPotd/KteLV3saXcsjqaAwpL/PKDWKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dZ3s/U/v2MMj0aBaQDKxLLyEGTYjfTAVGh3A49poDgY7WB0pa
	TgZlf4Cj4O4+o/nX6A+TlslY71cRxecV+PDHagCtvOxtV28RLDeXvoXN
X-Gm-Gg: AYBFou3eLtc1iwWNdqkAsNpYxQ+FsFA+fbM6IKk5vAk+fLrfFz73/Jkfu4yagBtTwkO
	vPViK5CykePt91LkpNienSDj2DxrKK3DI6iwhYGGrnO6W57tglEb2SvSkW2TnvnlBJ0yLFQnTQ+
	vi0OHnE4MGALONqouxAi2ywzvmLnXLYfK7T+Kx87bAG66/GvwXLs/kmaly5Pbf9FpmhLblelMFk
	Wt/E7LNP8/gmKqGXc6QT4W10IRnxRQEjcKUmtBRTTSwYmj+rqXyc7cJx81ZeBvoN5gcsPJerPO1
	d8tmD8aS6t0+zOETGP9HUgYWPSFIF4mE1ZyghRBs2BPmlRfYG4uqyxvGbWDAvntpuCFpFwwmLzW
	lu+vIfn92AaIJDj7Mp4YKDVtq43GofD5z+tgimIwPLtCRyOHP6Nxf1DXRWb9lCmNRX6Obau9WTY
	3sYgw+4XCDHWcWkfKtwcOgqmqyX23WSQSZ0/ed42Y1SBIn8auHGEbXmPGh25DCq4Cc2CuYX83A/
	IMtVCzaDC49mOxkKAx0zM3gzluQ1dCT/GgUDm+uY19T43ok8wBvMzYdQL5xBbwKcDbn/BL/8H4h
	KB+uGyDyoho4fLJrQEN8TPCVaX4dbYBKcd3jSRnf1LXAWu3PhKXWKELH6qqz7rfEuYMSErYc9AT
	w7Qe81J6S3SzljpZ3nV/FIxZQC/GuhiUdaABZjlcfHR/J3WsmPj+u232lebLvhODH4Lb/5oI6/9
	MmlS7uTr96zJXY4f0B86Caj9daRUZjeMcv3qZT2keKOC4=
X-Received: by 2002:a05:701b:204d:10b0:185:8c9f:de82 with SMTP id a92af1059eb24-1b543beb56dmr256212c88.33.1794936388092;
        Tue, 17 Nov 2026 09:26:28 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm14263079c88.0.2026.11.17.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:26:27 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: semtech: add myself as maintainer
Date: Tue, 17 Nov 2026 22:56:08 +0530
Message-ID: <20261117172612.25535-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117172612.25535-1-kapoorarnav43@gmail.com>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
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

