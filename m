Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642C3749F4
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424571; cv=none; b=f1ifuMiyvTSBprvENf/IvFCBCKgIAMjI1blp2aP9TSSB3fF3A9UeWhu5YXWo8RAiIPCgBfWcwmsTMMWRG9APaEH8WlNWR0Ak4dBCapLnX5mvetm7B7p2Vg65LkixdwRbuB0WvbgWZehGEW/TlCApVRUHhfQXkcqD+h7lNhazJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424571; c=relaxed/simple;
	bh=VWy85LEfrVWzy8r8aFhzYed+srWyhaQYH2vSfHYqpZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4Rrc98yI/6jEXoU8lyEi/dE9q0H9cvHBJ8cI6LK10wAceR1jHV7YM8XIJX+kR/+kjv9VGRzEAUoNoFXTCS7B1lnbh3UTTkC0dQOg6F0KE93Wi33+aCXx/6Fuv1K8t1P52b6TR87N2GsabU/f02a69MtA5Qs0WSV15cVb8xtNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RmZ3K8BI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RmZ3K8BI"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e1f777bcaso201822eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424569; x=1783029369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FynzaPS+sv8vCcJukNIoA2douKl6UjmHADWDXV8MsxQ=;
        b=RmZ3K8BIOEu0q/cVp3DYt0GDZxir2PB0jdg1MOtKUBQ9c9PT0zmH4FUhcmOkI9YhO6
         cCPU5HVwYRxaU6Kyh6HayWRcZM2dCD/vgIFHFEKyoPhCFXgAjKfjb0yWrZRo/+Dd2Iap
         lSU7HTBA0LN8iCG1W1Xtdss5N2OEOk2MBhhZmYfdLNrFWeQngPtg84O4uH76egXmc0vT
         R7yHteHL0XrzgFX98YP0H+w/XpiRG7CPRm6Pac01glx6+1QKwza2I5D54Zcjg9hAva3U
         qan87E4OJazb6/gkq1znM2cfPRZiAIm05kBWurkVqWC2YkuNyMnC59CqQNtike+6BKPK
         Be3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424569; x=1783029369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FynzaPS+sv8vCcJukNIoA2douKl6UjmHADWDXV8MsxQ=;
        b=l4g+vbAbRY9OFKGR6cp96ASn7d49kaLcH4QK+xfGPkxWdtDL9qDEhAZDIKMBH21L0q
         z726qujpZFm/EaCipB8GMzP/ARdBbORVC0BALeN+kQhfxtF+7pm620mGAwYOwHCa/hd8
         c43iO3mTWAw0EGFuzVqgcb4BkBUtNfc9EJr5aDAF5MmSgfmwX3Wk2UNNgHzVImrZffGF
         Jywih5Sq/raiA0Vua6GFDVMKtOcEx2KvTesqHzDR/g93IzUnwlOFiErTxgT5Zi7gyLDn
         rT21Ge/cBdpQH6v8/Dk+KM66c/lfuONp5d5ApnOwQl+5lkSdYiPR3gXgj2BdqdaPlCnW
         +n3g==
X-Forwarded-Encrypted: i=1; AFNElJ8hGUVIH3sDvjBH0rRFhdVbFukQjodWBvgEJR/fjw0oxris7c4ky67FmUdoTNLRJ54JlEA9WOe8EJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMqBCraYAbQ0K0DPkeXF/Z9uIYNWLiJlNV2cpMCzhltiTkDPp
	ZXdjyOg8DkT+A+NcuwFWsGMuFwTW+MZSaKqu+4EYPpQJbXd9eg4WsnzpZJZaBMpE4Rc=
X-Gm-Gg: AfdE7clAlTVIyqMF1IVUk88FLxk/FVG8BBytd3qE/KrexOFXvZJwKFtl57XiWFZizgn
	d1NvRvt+L+lHDf6PG1LFMaKHiR2zqcqhLH3AiDeIcE6u+yxx6lSCbIs4qPvkhiDTk7XB3pqZyt2
	fh198nu/tN+Nf5xOUh0QUUgBTQXZY7Zhf5nkPji1CoIhPFD4M173i73PX9lgECPd+wPspI0P67e
	APoy0s8jvQ4s4qLs89X8A3/cDRYik5ZyhzMFebTqcc7tsfH1bs0BOlQIs6UH+ovLZ5Ksg3cB8LV
	MPc6ruCENzOXqywcibhU+TDJPAUnePI8NJmD1Yf1KG1WosKbjuathPRFAAp/xoxbJ4IDXsneknZ
	XZhb0e22Iyg4ePmmH1y37fVIWfVcTsi3X34ao7ioP7gtw0xCBKY8O+uwkwXUlXMs8Opp5HuGtyY
	dK7N/iWbGBz+64bLasIQ==
X-Received: by 2002:a05:6820:1528:b0:69e:8976:77c8 with SMTP id 006d021491bc7-6a1343e02bbmr2899530eaf.23.1782424569670;
        Thu, 25 Jun 2026 14:56:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:04 -0500
Subject: [PATCH v2 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-2-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2mTtWfiW3vF0hopNPC35EMHNjfzB200e+sm1z35kVJw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPIwKTAEhZS9OyTk8cgEew61qspOHWajEbM6
 lcSG9DwiIuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2jyAAKCRDCzCAB/wGP
 wJNxB/91x05mFt6bX7/+Y18WroHy8wg7MvwQ85cMaQTswqBRE2quSnYvJcCdsu3YIAFw5LJ+JE6
 pDMgDJOFnHwg6yf5zE24n05r+3pfqVsynaCbI4mjBABm4dugWeMRI2Jag4OO+xf1eLtMU+egh7N
 go6iUOeA0yhmVSuApsxoWGA+hW4SrFwpP1S/bM/FT05qSpYVsbmtXraiD+rL5ca692WhmyT29Xu
 OJjqp3H/Q8IPSo0aVtBJGFUH43zpO4DRgkdQSnuuhLYos4Bjw3TuUFVspR0Lw9NMCCHJtq651p+
 I/5UaCMVfi2znSdgdCVWpskA4geiGCdKrhx6nVQ+NA5y+gbz
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate current sources that provide excitation current to
resistive temperature devices (RTDs), thermistors, diodes and other
resistive sensors that require constant current biasing.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes (compared to Kurt's RFC v2):
* Make units nanoamps instead of microamps to fit known devices.
* Drop bit about allowing single value for multiple channels.
* Add bit about semantics of the array index.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 12800737d4fb..860601ec5334 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -81,6 +81,26 @@ properties:
       ADCs usually allow choosing between internal reference sources or a pair
       of external pins.
 
+  excitation-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the mux configuration of the excitation current
+      sources.
+
+  excitation-current-nanoamp:
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the current configuration of the excitation current
+      sources. The index in the array corresponds to the same index in the
+      excitation-channels array.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

