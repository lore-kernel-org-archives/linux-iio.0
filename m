Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170036F8EC
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706308; cv=none; b=XLaRQYy6Tr9hnZEDYk+XIwRHWsxFN5yfJ6Niso/u+cSAV2OitAmwyOdK8xeq0fHntcUqDmhzrAchCxer6l4S9pPuvCcd+jtFo7JuIF6ZbU6P7DYm92VKbkjqYXF1spuQ171bKBGc82Oj6tbsJv6bcD/Peo7jwdGpifd2FAmNcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706308; c=relaxed/simple;
	bh=QtSgviyssTBIh+gpFF5oWYlI+wnUX6VDGWmwQj4nPj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE354tfWwoKRCUK5VtMfoWh7ZsNwxg60wAdPG5/DOr5Dir2XeH7q35xOWpK0zrXca9pQWE14jv4oBn35qQCIAD1XxgHn8zZufwkRJ9/RzVj/vTqKjnm3oXJVUdV0ndQOB7Rn1bnK1Lw8Av1HRa3WLM0y+HeGUPqF4YnnN2kpDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/fU6hsW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/fU6hsW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso4932549a91.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706307; x=1780311107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK5p5D62bxTBsAn+SEu49ocLQ2IY7s+ZtWdqBWFj84c=;
        b=m/fU6hsWYm8YZJ38EllPAKS6N9wrzCKLL9FncPvNMDRUTA5cL3mz3BLwgI6bnjUJi/
         De5Jj2P4ERqTBOjOUG9NzTnlfgkD3oWLDEeGh7dFW+dxY+w8fEWcTytqPPuIl2kw+Ff4
         MbFjzK2oyNYlakFJo5yOtgmdMkzzHai6vTBtHEo6eP14Tcz1cENVt+1FI3K2vos/WdU/
         VAoSNfQbV9P+kqxKefpmS7bdaD+mtxxx8AFt36ipjXP13Bse7jJ6e/BJ95CAIZ8kyVRf
         Jd82+CUiCqCvPYpzMQbOPWh4N2zlEVkyh1eQI3mQZwv3mWCGalC5B4aOWew5O53P+re6
         B/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706307; x=1780311107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gK5p5D62bxTBsAn+SEu49ocLQ2IY7s+ZtWdqBWFj84c=;
        b=XRaL4NPiyrMXKIoqil5KX1xaEkucamCVD+aVyA/xMBoU3ktdFeml+K8xLnZ/en1OO5
         OJVm0cGgMcdAbqrSJPO3b9G+IK59mJEzRfZi1vc9XFBrpQkukr4k+Wrx4ACdtvkpbHRY
         dRnEGXnIJRNOb+1Z5bIht2ABjJtonXnHisGwB6q3ZMHdFL7NnSkVNAZQt3ckAYQsO/lE
         rRh3iC5QEJo3Z7l9vQ99Wr5gwmlu20g0dVTYn4KvAYi1imqGAb/2O8n7S7ZzBnqCEGMn
         PNv5zXQy3ySRbhg7lHG4fWCyD6q8o9kxwuCNtqqFnuJukotJ4OjzdZA8HMJg6z9EVlcY
         1Dsw==
X-Gm-Message-State: AOJu0YynasJK52pIyNaAz499vFg8wCG76GtLZ5RPHEC62mFEEVpUu6EC
	RowXy4lAFHEu4OZbjCEfjPHm8TOMquFYws1vjcPdr95+JyGCseDvNjWVA4iCew/S
X-Gm-Gg: Acq92OHA0zDERAaYJMA6Ze3OWYrmHSS4SS2eMd0fOK8uau/OL2osQ1cBPh1Ponf+kIk
	G7nXnKstgyntWVQEA23vrb1VH+XCuLFlc34OoL35pkIOcIre5i/jTwkrUXitOiwUjGGYlhPRy6E
	bYnXH4gQz17oIDMHgth6B7EBRLQdMHfghAviyj+pRsuqWE4Mg5Rswku/apkNb/uC5zxpWOQlI39
	M4whPbbP9UX7v8B0wRBZej1xXjC9S5gxgShaxByRIzRGc+xFSLD2TfUOigOnQRfEYWZY7qYenhr
	Inmi/z+wkbDCFnxLLJKv+oBst5SCpS/jCiXgr4RtoFEWpNOalwVW2ciKN+jCLS8cAtWMBrvyAy4
	Zhr5stzDkvBSuoHupP7J8xhiq0P0n63q/JpUqP/JDRXNCyWLmE/w+LqmpFa1dg9I+1ENwSEIjRg
	q4zyAvJqtDlQUo5gUhEQ8DhNTGSjnC5FWQXEv8BFXSuz9c9JmREw7YHCkg+dnpZjPf4wpKVmhbC
	v4lf5xv7yKm9XyOdQZTtybwmdpor4IhoyLr1vUpS08SbnwwliWi4ewtCDhT8TM=
X-Received: by 2002:a17:90b:4d0f:b0:36a:6a4c:17dd with SMTP id 98e67ed59e1d1-36a6a4c19a2mr14431253a91.27.1779706306855;
        Mon, 25 May 2026 03:51:46 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:51:45 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Mon, 25 May 2026 16:21:18 +0530
Message-ID: <20260525105127.180156-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
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
 .../devicetree/bindings/iio/adc/avia-hx711.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..0baf620e9057 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,19 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). On the HX711, DVDD is a
+      board-supplied digital rail; it was missing from the original
+      binding. On the HX710B, DVDD must be greater than or equal to
+      AVDD; when DVDD is a battery rail and AVDD is a regulated supply,
+      one channel monitors the DVDD-AVDD difference for battery level
+      detection.
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0

