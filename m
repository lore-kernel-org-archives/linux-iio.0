Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17414A33E1
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871748; cv=none; b=n90xYCRQENwblR6lghSCwDV4igakJ6YW1gI8v0O+fgzz8iHqNTI1TDDGMoOVynXnq7/nwn4ONDO/Xf2866v8WSFNPDDoGZUzU299AzwrbNm+BfMD0PObFwJdMabxh1BAffZ9zGpK76KReUBQQMYxOp0CQstDDGdkW8hoOc954UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871748; c=relaxed/simple;
	bh=U2YoNQx/hGloZRC8McPJss1WdTnU2vgI7Fy7zmdhFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7foI77cr8GErAmbkuDfx5ojdpTz5TtxBFgWVve/IF4rOmWdx0y6GW2+8QDoH0OnWtlvHhhZAy1vmT+fPFiD0E67/fgK2re1RIqC6QHvxDyekw4gL335DZifD6Z3MQM5dR0p5AKlg7XS8boDkfae3K/WVUXtTrv8WJXm1wqRtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itB1cmNa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itB1cmNa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4957eefd361so1226465e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785871743; x=1786476543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=itB1cmNak3ayfAEubxJt8+o0mzp2yW8ZrJPi1XzprmpvZL85zQDYXOx+O4/CWrsf+r
         /62MJjT+FPcRWIjiRXJcnPoqAxr8FELx05VzepAbL+WiUfYkLcRzTN7D1IebQ98Ew+Kd
         exhy6rD0cAtzqILnMhCjrdP+C/5Qwdv0AuUUUy3jDi3PqJpKhUxKLSdOEW2dNyx8x216
         n+/KU2sb21fCGKBrBNKTubVtwst+KML9ZAmthljTgX2ftHLv794vEeNwVH4xA7rM3vcK
         uiOaPRx4wenaA95EnmIblzPKQaDfKG+BZSUSDpeut7qF4PCfzULanMbQrH+af5/21K1e
         6/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871743; x=1786476543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=qydZhFGbauLtwQKffR+TaKih8I5c4kqYvv1NeFjlxHv1bgLQDfFiqKc7UBYsETCRCN
         zOjN4qeoHaMXBuujzs8/KJt1e8L5V+XC4CD7vhokiuFWAUMzKYTO/jwV/meNKG1IuV5/
         EPJGuWuBftBb0TWIl+Iz3vei7CLIS6m5be7UG6UndJ2pmMRUU9BfH3fuMWaLHTmY1T+v
         VoCqm9MZMTCK6kJ2FtOspkublB0rpqfcfDUjkVzI4r41PqPqGm0UklN0jRLVFjXGmJBv
         XZojjsBpVHX+QV7ktU+a3JFsYSPh4L6IQXkykYs2n8ys58Imqox4Cd1qwxFHfKmqpVt/
         qZ9w==
X-Gm-Message-State: AOJu0YwtteWYMokJJuy7NRupwkO+MDe97jLnEud1Fs9gTza5WllZkVHy
	T1HutST6TZB0C6EkJ5x5g6qfYiw//lZAePlPXfGe0vqNSglY42Un6VZwRP7P0nYr
X-Gm-Gg: AR+sD12RI1RwSCUrl0PlxQTenGaKLnHWgYJmNolCWHYnZ38KBOd5/szgByK152/USq6
	qtx9ZU9n7Gw60PJPn+VRvjOU1QHjLVaGnl/rUkkh0zcRbgeLOvxR8+eAcvwG+NkzwoRBWwOlEiL
	7Nws9qaRqmVVvpfrWJKYhVOiHiJ4rHjC4AK8E2DJKiqfSLTDLzyaZUL5n4Xa7S8+I2tc9Pu7n0U
	CJStVJlEf69gq/tc2VsAT4+rPUsk2/gZ6nwoUKyZIt6VmUMNKzyYUnHM0/W/wuL8qV2gbl4suxN
	ApwFAuHFR0ZM1KlfzF/UaTsywe8xlpsEU4yPr05RV1C98oPyfaIlSMWJfFGgNifWC5p+ep3XLMR
	5OmqGA4m8TziY4fe2lIbOLlYpyHZlj4mz/NsSLY4JK+b7QPQGYfeuOpcIgjiN1AeWZs0ANYLW0G
	59CqdqpCMvPbCRGmGGINIerLn1Lz3zpsQI+4PE3KjnzSAjIU9yciOdTZJpAI00KB/RP/agmyJDZ
	sJklFZ2vuZZjZwMC9vxaSc=
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr7600625e9.5.1785871742982;
        Tue, 04 Aug 2026 12:29:02 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:68f0:30cb:8ca1:f965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf820sm8248745e9.0.2026.08.04.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:29:02 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 2/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Tue,  4 Aug 2026 21:28:39 +0200
Message-ID: <20260804192840.29121-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register layouts are the same as for ADS1100 but ADS1110 have different
data rates and have internal voltage reference that is always 2.048V.
Also correct order of ads so they will be sorted alphabetically.

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
index 970ccab15e1e..28c5e2dd0ad6 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+title: TI ADS1100 and similar single channel I2C Analog to Digital Converters
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
 
 description: |
-  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+  Datasheets:
+    - https://www.ti.com/lit/gpn/ads1000
+    - https://www.ti.com/lit/gpn/ads1100
+    - https://www.ti.com/lit/gpn/ads1110
 
 properties:
   compatible:
     enum:
-      - ti,ads1100
       - ti,ads1000
+      - ti,ads1100
+      - ti,ads1110
 
   reg:
     maxItems: 1
-- 
2.47.3

