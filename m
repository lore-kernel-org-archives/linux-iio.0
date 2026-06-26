Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA43FAE10
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490496; cv=none; b=cTA7jkXRZS02Oq979ouQOGb4YWAEhRfwE9M/to6Z12ELMLXyem4uNxty/Isr28ni8vtHsvfdLe331yRMlREXe0XtftSSQw+UbpR9T6VBN89AUu2A9T8QZZ9I7MOz4ETO56d25rLAlL23852LmvZj4ytY0+m8tlmhZgxG5apttWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490496; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH8Z5W7yRk5cNwv08QolACHWMVju5hWNgOWVWjviJQPDCD+8p6Gj3bdJp3b47y62piXyFBqI7ZSccz7SQVk9ewanZb4XTc/IOrBatMWqksuIvH05y3VtYLbI9C3EWD+SltgmxElUTSgJOjQRqbP/VRp62xlmf1D2zAwDxXHgCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwDcyTsa; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwDcyTsa"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e93c3f1717so489664a34.2
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490494; x=1783095294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=kwDcyTsa8B1IcVYILAhM6lbaMoB7zMZ3olKLM6qA0HiFjULeHQUv9hD61W/jBDQip4
         gxj25WJt5/NXpLUmCoMKDFUwF+vYKexw/Gc697DCzegyxqozmffaXgjEY82rmtlCKCQ+
         L6NppCNZ6GuQSioKS1ZzaFe3myz+iOSR/pqCOLcg1YQoPURf+obhVKqNJz003ncPpUcO
         jadlKeqP0ex5iFTKegoB/9eThRvi1lqOFcr3mE0T5/uvSVtRR17wq5TIysBzL9tCPRRL
         2VSqIw3Ds6UqjxFWgkR+EVeguN6lJaED/AdMD8fFf2BPMWvi7pf9i4NIYMgcA0E+iOGv
         HKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490494; x=1783095294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=e0bz5/wOLrJWqWonoK6IiKFOa4op+QJfRr3Jbjq+XQNxXrfY9zOWqUVHBItn0hXwsv
         L1fZiFS8Frr6r+/AfouL/M7D9P4qUp6o7NsT7hqwG38m+8QYULV1sj4uPBiocg2n9kLc
         G2+kEd+6fBbo28Oxz5ED84zzeWYuKjyoQfXCjvd6pp10nmbg2+TlmhzSnp3XlkSMf6Ei
         XFDyQaPtCJTbXFgE36Bm3hkhyFCp13mii3sGQYUac1kFsXwbb0sltex9+KLdJlxqyzvI
         fqCA4pqgPP+UyQdk79Z07DXeGFt31NTd/pjD6osNaRkydocGCElDSrQ+NwV0mgH7dI8l
         7Bcg==
X-Gm-Message-State: AOJu0YzOoeADOBAlerHFjeB9Ge8dqcCaIec9NEJOUWNFDBH6Uhk5Yv40
	MzQXnX5ne4wn6r7ZoMyvSgoRNxXYyRuZy3j6xze3mu6s/4w5Sf5FAkJkW0bArZZC
X-Gm-Gg: AfdE7cnW/bnYvkEQi4upo4TQbv2eB0ihTv85RzaevZ5yPrGiTJqt3loUpGhEBLugq1H
	RLl6xxPGM303cizJHhjtSNvv+oXgib2997yYDDSF42pFboRx8vuCHqlr2NkTs7IeDZGjuws+/oc
	MGH5ciJMMfWSVSEir9ySCTemSQILsK2vEoh4SinyZmIhjxzi6yAeE90pOkb/bBFM04vyFoiINMb
	IrjCGhd2Ne0BkKaYwn7mea3N8rbxFC2+hSOHON14SimmDbn6Cvq2N0ct0vSR/4v6wlvEIWHKPcn
	AxdYEJtuLRm+mtIJIiPQ2qdzF7n9iv2guavVlByglv3n3T9RB+PdU4Ey9214fI939x155dFuS3x
	VGijCIuYMG3+InBQsAOBBflRgSweVDnU32CTAvXgbwSbpibW5HDh5ctVJ1y6T4OlQHMO8Mipuxc
	SlXhtwsP4VuMsmu2cXIun2eA==
X-Received: by 2002:a05:6830:6619:b0:7e9:b4cf:683f with SMTP id 46e09a7af769-7e9b4cf6aaamr670407a34.31.1782490494196;
        Fri, 26 Jun 2026 09:14:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa579235sm1970211a34.1.2026.06.26.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:14:53 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V15 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix
Date: Fri, 26 Jun 2026 11:12:22 -0500
Message-ID: <20260626161230.93069-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626161230.93069-1-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

