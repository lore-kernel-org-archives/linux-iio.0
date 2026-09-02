Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DC4A9D6E
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369759; cv=none; b=Uacmr0Cv6VKFOG6I0Q4ybzcJZzQRlGgmGdlfpUbUZyYjKJlL5ZUTtJBcz73npq2V0a0pk8dnXcSOWxEELYFOneuxHDCnW2pPUqdtRhqxakmjhe6Xj4VUGKusabWPrveIXCvrQEkjbAXtDXTj9ziacTjVpnyDMw4JRNtRklFwm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369759; c=relaxed/simple;
	bh=Nr5B9X/EA/TPHrdPqN5lYHsqf+HIQ0e6gSRt/7NYRVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNPQJV9G+fXRQvvGQN7R8tvSzLqoZtwdLXEC1I/1DZcTBaOiXqDRqtnjCwQVkCeLSb4Bu7szk6lbvr2TRFbjjXBb2exd75KHwB7u42oM9hTfHV0ZLwHe6vtmLNvAgIm5wtLMtcdau5ajhvYQcPqb+mOiRbbPz1k+Nqr79r6a72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLMcVDBq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLMcVDBq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso9565485e9.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369756; x=1788974556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzeE/hU4D9bblLATFtWOwYmE1vpCRHRwseWHzl1OrOs=;
        b=aLMcVDBqVHT4BH97s7g+kcrhDlAbQ9HBXtgguDvbd2RwOvgNmpcZLw9tTlsFVNq8GB
         x9jLDFyC+E9PbbROEBGHqKbbh+s9JwmhRcgmZfx8WcUy4D8gmquWRnjUa/qgQIYNl4dG
         5k324k6piC4a2Aj6rlMQPHZAdZKIS2Bdj8zGkjDVkv+OoZ93xB9Rno8dcDCvusXCFiQO
         Gydf1mJL1mx6il+N9cw5tDwhzbceBaD2XzjQXsvCa8/wh9ru13RMSNnRXlo+0EOn58hg
         rByLCDU48+lAjTZVflFYVrEtHKJX2Tm9LM8y7sOK/HAtPrQhZoc8JZBVH1iCOktfQ7HC
         aGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369756; x=1788974556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzeE/hU4D9bblLATFtWOwYmE1vpCRHRwseWHzl1OrOs=;
        b=diWRJQwGETd7AohEkO9AUF3Sylos+nr1PXTOa42aURCezRjIGH8yzv4MDf8gwh2SU6
         kWMyqpsUtLJju1nvSlIvLoi4nhJDxrQtHlw3J1rlaNrriXXpoQ6FxQwIcMFQ/sNlJETr
         6TyQj/OwZEWKaw+Yhz4MVXnUpXxy/bJg7WGNdkkp1tsZs8EjfVJxeuOU8I92tZZjW9Q2
         4xojXudhYK383NvgtPWS0bNRA6FIBc3GHMdF1Evm3zSOFkc5YeVCXq8v6uNBOB6pKIz4
         ni94H/lvikbCYwuSWxj5LZEJ1ynMaJOp7dq47nzXeqZSnj0TWnri14MMa45H09p5F22Y
         huhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNJZ/zUz1nNtxfCAlaZFXKVDKdrHod5zHjdp/cDpP+4YsXfi1Cn21qtEOzIFsgojlCBviSOdY02Hc=@vger.kernel.org
X-Gm-Message-State: AFuF++n3a4whlEmTBK0eUcJgiSTNCfEQzh6ERiSKdQP/Kifw6kTTHYbG
	d1vSnEHXNtpBAU9nRLptqMqxayEbOIXE52OVZCsG8NaKsbOqxYWrXCzq
X-Gm-Gg: AR+sD11Gte5A2gmOA1mOAAavLboCPUqYmx0TCdL17CyZGtq2d4NXMA48VwqDgVuq5Ee
	HYrYxKfvplEK65KrntTF5Dmvq/nUY5zH3ytOVMv2DbUarV7UPDlfTAukx3bBBlIky0KtmXZIPjs
	QMXMISF7HT3XFmIwk9cFkzu3ZY2APH+rvSC4AUO/yvcoStiSw3WIe/8CpdGz/zCoN99c/kHHAF6
	MR7ug0F0fVKZgbi4C6vXqx1UdNRgtBJeCXU055SFmNm5JkX4CEc0UeQQDQx7Boq5fP30AtJadfT
	wjSY8fvbaswI7k0AMOcn786LRy4lmnivXWVHBchjfKY/SEZqZqqmjtGJ0ig+G+AJ1TMlEQE0NGN
	KFmOMohbkvEzz4covhgxeu95Ysc6V8+Z1Ke8hdf7hdFUCiNvHhr9pei4CRNDJ1wPoZGUZ6eynUn
	4uKeLQSh4HyWc1F/544b7Gunc4g/L2lhQ2GXQ2/KUF+/HTkPKtfGdrJMUGdFjzBCGk6kPkGo1jH
	u2jrj7hTX1ErFxn2pWw7SUEoz3DR1qaE4ZRwpjF
X-Received: by 2002:a05:600c:1d1c:b0:499:da8b:1476 with SMTP id 5b1f17b1804b1-49ce584a24cmr99214025e9.14.1788369756384;
        Wed, 02 Sep 2026 10:22:36 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.251.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023d6sm5813145e9.8.2026.09.02.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:22:35 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Wed,  2 Sep 2026 20:22:29 +0300
Message-ID: <20260902172230.5234-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional label property per channel similar to other adc
chips. This allows assigning distinct names for each channel which can
match the schematic signal name.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 718f633c6e04..777a75c21d7f 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -66,6 +66,11 @@ patternProperties:
           - minimum: 0
             maximum: 7
 
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A descriptive name for this channel, like "vcc_ram" or "CH3".
+
       ti,gain:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
@@ -125,6 +130,7 @@ examples:
                 reg = <4>;
                 ti,gain = <3>;
                 ti,datarate = <5>;
+                label = "CH3";
             };
         };
     };
-- 
2.34.1

