Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE41326D45
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681593; cv=none; b=pdXV5ZH0lTUs2dP5fxI4B/N6GgKEdoZhLJspjVgb04I6Tj9w5aEC66ajsKSmslKXsIeFjTn7AJSx+lIlcean6mkrY4GO7+MYzc3xuIKD8jszK2B3kZ8NR9Vv8RzwWcFIcPTQgCp/c33b/KaVweVnXtkHD/8xySlYDewgwEwBYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681593; c=relaxed/simple;
	bh=CZ1jj/eiHUYjGjlvolJhpPQIMl/aN3JFj+jg+nCFVEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clOPi6+XTLgz+tluu4OmYc9/gyac+71egllW32bVRS/LKgyk2MfD/usFUOmStX70RGhjGs4CbgL0jOHNQi7TDAJBqb4jLZDbWZoEDO26Llt4sRs9NH7Frk4cc8q/8Qp6RS3oa/0fdt5h8ZjlPgEkXgajq74GZpsXRj/opCG8OdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5QHY4EM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5QHY4EM"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97d5b790cbso28773566b.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681591; x=1774286391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrOVP7ftGVSwzsjwgJO9DIOtGTWA2U/htQxTfqCFeYU=;
        b=Z5QHY4EMw7pa4wLUPbEWBfKlCivNMR+CiRr4ZckwZ53Atfavbyan9qta8SUB99FSTq
         ORO4a1HiTFiWQKaptg0di8cKeTODsWTTQ28tHa/Nk0pXdznLByXb6UbBw5X78MVINb4S
         izwnl667pGlIYfnNlEscJMs8oY33uUzH3oDdFCWiXLWcACEUKP7/yebPwyVKbPXIs57e
         jUauZxsE9EddMUBbSuECgQEu/eEhRMO1qUIFEsGWRXOoQmVROorNGgdvk8f6/QrZckyE
         IyO0Kv3aRmQhIoN59SlXHjeRHWenX1fRAXNucp4F4g0Pe3CyWXa4Ak3pIKwA1LyXe7Hd
         xonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681591; x=1774286391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hrOVP7ftGVSwzsjwgJO9DIOtGTWA2U/htQxTfqCFeYU=;
        b=LygxE6ERXDHmkMjYUCiKpgf/75R1zQtcno6iA5CdBhrYe2WMZnnAQ/e8CjDWZ3TJtF
         l3hgiWMi3YHJ10wjFFSSjfd4Q+DuE5kqyE764MerO6lSGrGWkpyRxCFQTYEZ0Qbkdlcp
         ngGWyK6Cp0qxRL/244zA4oFBMNBDs+PFp6cObO7t/OhnoDDh4ZvL4sysBVjTugeoygkv
         JCZ4tKH//4gnVFKC3CiRhhMSfgCMyOcVa/Q9eza5/7lR1KMkPmm0DLTNtJ5JQCv9clsa
         ttZBM/BAYmbLaq9m6rrh4iF7pNlyH5kPLwl0/4mcYmyKrTQ00VX5uRZKW2fLEGgPUv3h
         Vc8Q==
X-Gm-Message-State: AOJu0YwkNP5LbeWkKInlk7wc/Q8fFLV+M2lXnrqq9F0mjPUmXdJquiwP
	z/5UrHaq/Hkv+reWDN0HXK1CiKZHgrpdmcBzozM9hkTXy2B30SxXqHrk
X-Gm-Gg: ATEYQzyAvwU9vLjpuHtIx+FgWw19cKwV2nshHtJCcvj+Y635sNzHEuMsUC7AT5NynKI
	R1NLnFdRyOfVB2z93HTXieDWdqIPEQvFbYcFnaqRag+8z8JlUdtMLq17KMTBz38SGNFn8Eh9ihK
	ClGw77jPJ8jqBQl2uFNUI5ZAwEhfnv0CoQnjM1nVTxuWcXMegqlB/EdyS7D3MhXKhoFpvtnO0KY
	+bsfBoTY+nHpi7vBNRvr1lqOgA/mDCPgPA27uG4+yBAyZlS4OKFJ2tpa/nhmHfaI7tBq+nCwoqr
	Pf6A19pYBYwQ9qnK9PmKZsob3773jN7m29rhQpW53UQJuZriH6KrjC6Za1c2fjrveSW0eS4lVmU
	gcA5bnfce/Ci+KH3teSRq1Xq3O7O/6iGWFOLkWVB8cdOl760qigVQ9fS5g/VfFPyt62bCP8wSda
	ekC+md8QhqPjVv9MNtGFh9aI+3lg==
X-Received: by 2002:a17:906:7953:b0:b97:73ae:e1f with SMTP id a640c23a62f3a-b9773ae1114mr769934166b.34.1773681590773;
        Mon, 16 Mar 2026 10:19:50 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:50 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:45 +0200
Subject: [PATCH v4 1/7] dt-bindings: iio: light: vcnl4000: add regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-1-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

These sensors can accept 2 supplies - one for the sensor and one for IR
LED [1]. Add supply properties for the sensor - 2 for the sensors and
one external, for their I2C bus, to ensure the sensor is powered on
before proceeding with setup.

[1] https://www.vishay.com/docs/84274/vcnl4040.pdf

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 2ba4d5de4ec4..a1b4c02db246 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -33,6 +33,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+  vled-supply: true
+
   reg:
     maxItems: 1
 
@@ -54,6 +58,9 @@ examples:
             compatible = "vishay,vcnl4200";
             reg = <0x51>;
             proximity-near-level = <220>;
+            vdd-supply = <&reg_vdd>;
+            vddio-supply = <&reg_vddio>;
+            vled-supply = <&reg_vled>;
         };
     };
 ...

-- 
2.53.0

