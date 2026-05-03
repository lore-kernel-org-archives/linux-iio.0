Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97663AE196
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810222; cv=none; b=PoNcQCgP3RY1NtSJ0FHKCnP9cCsu1NMMRK51+zdgUrWbvKv8a4X81ps84FdHS0eRyyG3b8/LIJMMI/hX1K8pQFZ61CG99WfBRLVHsyrgcPtxsBl/5g+0YSowSd3xxeT+HtsQd6t09H/BC98Fyg+iYPgAfQPU+x63CYPLzLpdYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810222; c=relaxed/simple;
	bh=97BloAxFVtTOzajOIz4gcpCzymw3iMe7qiRHhs6YZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyl+vw+MI2dty/1IuSb53vIx1QT9HU+h0kmmGQ7T8oPJPpejx35+3SAavYzGwQSiMFlr3c2rstI/4HIP4dvUWiADHdwaDdrBuPw2zIyGfX9PjTQbdJcnySEhNpWzJxDcpLeQFvpbL7veiMS++krmWLMM/zCPUNbeN1o+HPJLzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXvTKVFs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXvTKVFs"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso2431521b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810221; x=1778415021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwuq32avt18rSkWA7/JT7CKrN0qUNBlcSTis+msHENE=;
        b=WXvTKVFskklq1Cz6MMoxC9vBQGd99XZxHYuplyd6qkYKVZEjx4NNCr3nOZpRJMHBZ7
         lw3tKIgqy/9f0GFd4TwRVwj18BvosGk8Uk6xkkyUOAVQ14gz818PzfRKvq7PQqFA3E6w
         Lisc/+l2p8CfZ6AH6ANBMxgF3jh7XbcZ738BGvQgGhbcsBY5kZKOa89/hafksBiJA3Pl
         HYVCpHfbypxIjbgvvX8HvG9x2FrJVSfE17fRLLVySz+QZ0mECXEQHQ3tNOOe02yoLw2k
         cbJzWiNSNeEmAKLV3Z4K1Hwq8exzOgS7thYAVpKgsZo1bykCR1SJKT/xv+g+SOJxSajy
         i5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810221; x=1778415021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rwuq32avt18rSkWA7/JT7CKrN0qUNBlcSTis+msHENE=;
        b=GNq6TQWNrGqweDdlzXiqfP04yz4F/9DBfmbnvKOckkZ6WxVi4G8hOp0BdxhzhnJBRt
         FcxPr4c4NEXaR4stH7R3dSn7lKN+FdnyZEZPHG4rB4US/x9YN4MlcNJE8wjKx6+FQeMR
         0XPcTDRDglQVPe6FZlUxnSFHfKU0j8h/WSn9/mHOMF8HH3iXivH74CyO7OUVInSKPqEh
         h2MRvq2cqajbCipmaFIKL24d5/OWMhVBWBpJmgAlt0imMMVHvvFAd4rWKAM/s5KjADnz
         3LsNZ8coRP9MNJhFjazhiMahwjesSZ5lJx8L9J5zKDT2k5LJ1w+6hdMaI/ByYjoJJNFM
         a0RQ==
X-Forwarded-Encrypted: i=1; AFNElJ9trmJPPRQUe/IM58LvImS5F2jTP71c3bX9kuE/EbE5VaL3pR/zHdRUlVInug8HItSKvuubE8OLeEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40z0QvTOh/uB28q0zRAVIVeRwvMfynvJG0OVoLyROpYsSkGs4
	Ksbim9a8ho+/iU7jqUQ7jW6jwCQJJi/S2ILvyIecJbM1VljZElgtCysX
X-Gm-Gg: AeBDiesJlLxs6b0d/oFRaYUgrwHgZbhT4e1zbgMCagui5F8vurm7B86Ht/d9KqwCFHm
	PfnGXvmINU0A4bVRJs4cfRNBQ8C4cYI6y9VuQvqDHZYzHzrYEDJgnoY1OJuJ75gfh7hqWCXuFso
	3GoSb5RWPCiM8hUEXwZbZ5f8XjsnxF+9C4ctRn6sHnxcYVqStbyxAnUPcD3QN5ulavyU4qKCl0u
	DvJ433Kkrm5NuxBEDtq3AHCclbh4pLthsspfD9kq2lUenKFDegwTBwJcLIMH07Ul1Brc/nMX5nZ
	gl7zq4n8Q6pPV6z2Tqj8nU9NYg80NwECo6crqPKLN+FPUY02DvU+5b/MTjVMldOLnHbr3I+iGsP
	AzzcvkiXA8190ezBK/96ShppqvFITeujnT/Jcz1ZuAw+56+s7QckqNZPpAd1Fuvut7VGsAnalGO
	FofO+l4OItfcGwK+xfVNgSrwLcM/22/HlqE8Ls3YX+4Hfne3IIY8JSqzXtrThaA//Inpl9FP8xI
	mD7rMi7AYp6IPe9cKwMXI/IxswnFRRiCxymDyRdRf25+eQ7RAyXaH58Lvop7OlFG2+JSAI=
X-Received: by 2002:a05:6a00:1ad0:b0:82c:9c90:54cf with SMTP id d2e1a72fcca58-8352d2d75c8mr5419894b3a.43.1777810221020;
        Sun, 03 May 2026 05:10:21 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:20 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO property
Date: Sun,  3 May 2026 17:39:32 +0530
Message-ID: <20260503120949.80292-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional RATE pin GPIO used to select the HX711 output
data rate.

Update the example to show the property in use.

No functional change for existing users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index a8eaa1f18de5..9134bbe41379 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -37,6 +37,13 @@ properties:
     description:
       Supply voltage for the on-chip regulator (VSUP).
 
+  rate-gpios:
+    description:
+      GPIO connected to the RATE pin. When driven low the output data
+      rate is 10 SPS; when driven high it is 80 SPS. If omitted the
+      RATE pin state is determined by the board wiring.
+    maxItems: 1
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -61,6 +68,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0

