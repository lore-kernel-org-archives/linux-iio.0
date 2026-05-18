Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19E38228D
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134873; cv=none; b=Sye1cBPs3rHKtq6+vZDlj9OAJzUmyLa+AMZ9Rqq10oP70WYxr+sJLdLx+XAnt+AnfkjfWUTucKRfn0F6tY2k5dZUVNq/vXFD3bv+NzQNVDCYBvMnbA/PcyuIor2ymmI1vgoREimTzHXNNWenRhog0YEpCcJp30gisXRo8KzCkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134873; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY0lkhD/SdkawepJnniX8MloZ8yH9TvzUjE6iy5+/Qkwjaiuveuze+NEt7Sy6+zWninugJqbLmPq55hDgWkAzwLXJeTx5ANN+DaN4o3oDEg+5X7RMQWxzihX72i9PlD52n9vN+F6SPLkEFniEx0nes6IAwyGM8NWPNXlMoyt9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDaIuxJF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDaIuxJF"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69b4f7d66e2so646517eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134871; x=1779739671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=JDaIuxJFK+zYos5xVmOVsg9JobL1xkeVa1raweC39aqdFHlkeysXi3rYfYxMinLz3Y
         rGLCO57FE+Ozmh30gZ81UCS+MGtiW4cxPvoKKLoOR0Ov7EA009PuJuSIz34olHNQ9TzG
         6/qo3Ui0dZ0OyvQ70XR7JjopCE4y3Bivo3VcA39SLJtvB9+r1OfsyPLz+aIx/8JjqX9i
         EPjTeah04oarhyy7LRA0GSGNHDQrFobTC800qPp8+GLbwg29yoIco9PkI+oyM2/xpPKW
         oUEl2pwk2OEcTNQl67a/kQ5fWT4H9UyD5lmef5G+HZakrvW5wsWmAGUWQEn1Qs5Iqacz
         iPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134871; x=1779739671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=JfsRuhpiPRN5aak2t5qcv+Z3YSP1P9NqIvdrDHBeDc4LuPHr37mx+TR1J5k3bPH0ZK
         mV/qQk945P7JqKUGsqX395a8Y1yjrFY89irQIIDp/lkeHgnU4/QGqABwDPb5YExvfrzP
         HPUAq4fF1t8a36zsdpBEMcmoVEAAsz+DLwEb66K5N8EfAoUrirUbNiroOf3PaNNWuS0E
         490p+40Ekr4CeltX4UH++js7a5uaO6WdY6KeMGx6g0ZwoclQmWqKjQEQ6IMWZxZxF1t9
         IqXoix/VsoOdBpkB7EFrvrdrffEx8mNYyt6Pt2OmkavU/s/pKu62YAFYEGnHz+8b4D8m
         9rQA==
X-Gm-Message-State: AOJu0Yw9flkDtHsA4Nec3E+PiE3xKzXa5+qK76B3JXeE/fMUZeNec/Pg
	Pbu9jz1iIqx7omvPcygz3uGcUyCruYpcXE+6m3AECl/VcKplrrWcM40P0+Dd6x1t
X-Gm-Gg: Acq92OF5CRee3Pgi5NG6CGZ4YEkasdt1Xiu437kRYsF91ommu6ZIfjQMXP/YxSKXlRI
	0kDOSVj9J5caOr0N+s6UwiD4Cz8WenARa2O1ScnTiREnY1Zvo/PejH4ARbLDKijDkaK7rnkILd1
	8GfsmD/hUdlM6IX9hoHiOBwGu9EqLGQHnzSvEq9AiB0kcRTS2e/eW793jS4dRJdFUap2YRNiR7i
	rUllvXYgn6LxhCPYxP+TP2/znjJlDCtdp7NhoiYQOV2T4AK6p485RSWTpHiuG+grA7S6NJ4xLnV
	hbBpd1pV5Q9zKNiUOY/YF4od91hjHZBb06F7Fsv2PWU/cVewNAl0Lg1KX7pzCtW6DP5IkIgdh2S
	7KCPmc5rY+FUYH59Bgm2mpIn9KfTRJ56p0Y4nfUhczRAOM5655rSFKLX2lR7Gi85ZC7ZcnK9k1z
	w+J4fagHrhgYyh0BeNIerJ
X-Received: by 2002:a05:6820:221e:b0:694:a362:e3ba with SMTP id 006d021491bc7-69c955c7f57mr9560119eaf.48.1779134871241;
        Mon, 18 May 2026 13:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0462e85esm6113360eaf.6.2026.05.18.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:07:50 -0700 (PDT)
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
Subject: [PATCH V8 01/10] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Mon, 18 May 2026 15:05:16 -0500
Message-ID: <20260518200526.458421-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518200526.458421-1-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
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

