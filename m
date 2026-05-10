Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFB31714C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442617; cv=none; b=G0NCPntono4o/LpxT9wKh1Wx/r1Z5k6TwMOui0qh4DF1BGubgeP02Jy81PUBhyZoNk9TUjjweYVEcxv707vcKD/trOJqaaGGPpMcVbp/c7hX2XvdL6TU3LoZ2YDcK4Is/BPCsUaAFO8wRZD4lhlVw1Nfj8Iq0esPcU6RhhOzXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442617; c=relaxed/simple;
	bh=9STMCiEcQygyJc7CSDMCOsAD6GSfrDVZtYpT9m5OWMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUtOCKdWWRAD3ZhgSVyJYb/iI972kVB4fCEUONGn5Gwz6bx/aHW/R+BtFLBL7By5nJsBKSVNd9y5vMEDzc+YutmYez/EyaHwT3ZaNGoquBxZNy5SyV0sPDKHozWJSKenxT6LsOxEVtAEKI/6FTbKH704dARTPoxn4ECj/x3HT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwgMelQY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwgMelQY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba928852a5so23466485ad.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442616; x=1779047416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOolxxVKA/S7akHh6l/gIw1iUq8tQWrXL9QU7Cp8/+I=;
        b=gwgMelQYOvQ0IKjZqOeDVvswaayFkfPeOi0MqT5F/Y94l9MxyrsWS1gV8dclc50djk
         qmku3o1onthNujTSF1KLu8ZHGj8wnvwEh4aVos27rpG4wZCDXrA86K+L3E4HhLU1C9kp
         BmD7216UCTW1IbrpMcO94YFqE/uiYvGklWXUoZmnjKNGM0MNTR41G94aehMgSbz0CIeE
         vlj/RY5oHb763PmNSauBhgE8aL+LgMuiGbXHVyy/7SRFCjME5Mvh8heLJQcnngidZUlU
         Ag0Mgg02BcrATUikEGhxmXNKOi+xRdv19u253G12NniD4Ho9ABb0bKfUku8JlAMr87ko
         RaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442616; x=1779047416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOolxxVKA/S7akHh6l/gIw1iUq8tQWrXL9QU7Cp8/+I=;
        b=dBA1kXpFZReTV1475Xh5mNr9hCyRkDK/Lf5FaUnPAcneGIIZEKLX/jGX80z8Yksc9g
         QTHLsJAPeQPNWgdn1MrBP9RRCLJvH+601MQn9g4nsBwH3gclIzJEYDXdhs8sq7vNS5Dz
         3fe5wTchGa4FgBeEBkKmX62ulWX9U68kpOZPc6hlKR/jDrgoAcl5V+9S3y3fM0M25bEa
         F+weX+priwzacsWJ8Sx7YYvdsQsxv8ELOca+6sz8TRCb5C9w9gOQDmuEVCbmEIgtYnKv
         0d0X66+g9NnSUuy28KquGIQi/Ep2cOS9Tm1grGwNd9/n+9suKbCRhnfbFTW5oWgX2Jp7
         VokA==
X-Forwarded-Encrypted: i=1; AFNElJ+YDKNfHKV2+/qG48Gpo38m6RBPpf5Wvj3+2Rq4bLL1OSxHvj+R0/jAFtiV7tELtKT4m7HUV0ZLxuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90zsT/sGJsYWh5TnMU+T0Pu3g7Fcq2tvBLgQkM5rCwm9xUky8
	8siPGG02f76KhI1M2hWapDR2fdML7qRo86U4YVY6aLrG8QQqayzn35vR
X-Gm-Gg: Acq92OEVrIFVBxy9B+kxt53brrFks9JEV72Z4zz45EAz6hftNFka1iPrukEqvL+QdIa
	YSoEhdwcNyTybnWKu5Htb/fNeYSMCeUMQsGgyA4PSqFQtsIA2NTZ+IQNFW+cxc7WyE+PpceVour
	g1RYYn9cq7mrqTHBhKP+Dal9g1XuaG5t4WBBaY9apqn7jmfuz9TdjSCvgzWqm6d01QNLRAr7c8o
	jL6nuWaPs0nR6eNeZ8SEFNC7cr2WeG6MkyG58l/oWWUo6VIkef7DQ0b4tog1e24ykrNlDQrflJh
	JJipH2fLQDQUYGRb6Jwpqc83GbIapaIiQ4vakUVx+/q1V9a68+rgrnItLx/gANQ4fQ20422ngiC
	2n3hZraAXi7Wda5iFp4IO5P3janYc6oNGha7hN5TBQ7fP9OyYI2PWyBDj627J+qMQgfByRjqVan
	dC7si9eqKZ2LVyt8v+hNLkigKx4nLT7fJHYbrDW0vltIHJRPavoLrlQI4ecLjWYPSpmgLUkv/Wr
	nJANPVfgfIYiQXDF7HsPscZMkkLUEuq+o20uNc4N45JSKW2+sbaoVgk23d0oTNwsr/f7sk=
X-Received: by 2002:a17:902:e747:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2bc7aa20488mr72912765ad.21.1778442615602;
        Sun, 10 May 2026 12:50:15 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:50:15 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Mon, 11 May 2026 01:19:24 +0530
Message-ID: <20260510194947.31997-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
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
---
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

