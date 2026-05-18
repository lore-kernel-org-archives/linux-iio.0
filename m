Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF92F7F12
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141766; cv=none; b=PDkDcMBdkv9/kM/7R0PhTMjiAJjOJKVDXWx9y2ZoRgbwYwEETBJgCnwx2SQk4SHUty2wT6kqeJFVZvcksDPpsqekXmHiZCwtIqCcXEJtPba24kurLf7gAqNH50bhRif3UOoSl1LrMERKHAelQQsCfRwd70r2IFb11JDamyAqG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141766; c=relaxed/simple;
	bh=Z5CmtTG5nugdJKWxji3kQim9emZIMVZ3uEpEgfiinmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAQQehRXPWDj5CMx1LclNd1UIlYBSztfZR7qURaUSxVssP+6iKYXeOTImwGFpT+OPeD9EHApTdmPFOwJbeDxJrNM3DW/g0Jfhn4pPYCptOABX2QTayh23P88iFTXOZrmS76H0X0GNvE7+9RsTrN4bJ1Dz1czlhlVfpSpKG970GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksiSqaxg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksiSqaxg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso2371358b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141764; x=1779746564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr8yQH7e/wAhaKceJuwttlGCTuxK+V52TPcaq/q0rs8=;
        b=ksiSqaxghg2d8hnZJhdK0yRp8RKIDe+zjwuJVMDiAD3vRirFw6tjq5ovtQ8rTOiqAf
         aDSuRaU69yGOSOEXiAFX4s0yIKbo2/zb5JoRIgbVWbYEdz5CDBSPDH/z/IXA1WmNmdQT
         sr1NFOlIfLr8Ebs2SnF+CdCXLBbGRAdJInHHkOsTxkSQ465t7aakqtlHuzj0SeJ+cs+T
         0cdYn5tyX54PGdeHIs8LbnMwroAQyyGiaCrJGi6sYQ6IAPgoiGmcO5Nnzw8p/TwoLMM7
         FwOcdg0LoDEheFvpnV/jDn7ypKv6+f3xkBvlIXk1KRaBHudb7eMGYoaNYdE5o0A/o3o0
         P9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141764; x=1779746564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mr8yQH7e/wAhaKceJuwttlGCTuxK+V52TPcaq/q0rs8=;
        b=rSAMTF+coidbgG2uJsYBQNKnxO9LFqVpe7SUW0RxFSHybFoK2cncSSIWfhPwZ9lsAJ
         pURAL20Nbz9sgqltNCfKBAiq5Wn7oPjIoctgXGq9W2akN6zSPKu8PJb1FiQOhKgoVA7i
         EyOUGqa/BKsVRW3gaQjIl3ObABtgMyv6INLk7F8bkzS3DNUJ5I5Agya8wBIeYbWjH4u/
         xJ/3+eAkhMAE7+UbueNb6EZRvbeIO8bWZlZ9QnktrnHtdt6AogA6pksHTzvpGYsI1pJI
         SjqYRmatMI77F27Rjl2xxhS1mLfBRZBQAse1GiPzQhLCm/RVMvZfGkuC7Sl85JqGLcHC
         PezA==
X-Gm-Message-State: AOJu0Yx1GpbgfrhqJikdYshO9+f5hr1Z5vOc2s/jc6hIj6RoanMpBIsE
	zLBY5phQROQNhPkx9JdCXEe5Bh53Cg0zbNshLk10266sL+DIZF5+7CVq
X-Gm-Gg: Acq92OEdxf68Ufy2qz+85dVkf9zb0IhmiWW0nZQPGOVXqzoxvZ3uTR3sazs12bqec7D
	2F2x34jXB/IZoM0xOBAxhRXSIuVrDFsNNLW2O4fNWhYoFlfngQ0Ldg1KOhA6Xdyw+03zs3hYfeI
	+tpEw3sJ7VWYwmoE3ZkMsISQK+BhclCf8AmD4XSVgUaIrgsDsIgoQPGsXsonIi61nhFIxFPDbde
	9/T4bdcKODefJZx+686xtrz5bLDp5hAP7q8zBKDWnvTXzineBytBJ+/BkkXQAAvCm5p152DdhRz
	slxsLez95eDePRqPaQQcXjXFxA6/h8gDF/6kqqkSSReBXHRL7xgArh1b5x55fLfydivF/fp5rO0
	+KeZ3aYlUmwFDcPo+9HuZ+7DUt4Xbqxfu7aYNy5mAZeB5Mkw6XAdc8yDFgoT0L0YEdRzBhh8Uuy
	2T53PkKY5DNq8/tfvB3abJYrQHpjAaFPfqiOGPLLE2TlTFnyIP4fMwvd7XCybg98c77j09iI94D
	B6rVqWOPJ72cemJ8SwUCiUwkIDA3vFm3xo7jCzkLVC3ZlL0wKbNPgBE1cp0baV9hBALNpA=
X-Received: by 2002:a05:6a00:3e22:b0:839:dd77:3501 with SMTP id d2e1a72fcca58-83f33c33546mr16660661b3a.1.1779141764388;
        Mon, 18 May 2026 15:02:44 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:02:43 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Tue, 19 May 2026 03:32:18 +0530
Message-ID: <20260518220228.63322-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional VSUP supply used by the HX711 on-chip regulator.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
No change from v8. Already applied to iio.git testing branch.
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..a8eaa1f18de5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,10 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0

