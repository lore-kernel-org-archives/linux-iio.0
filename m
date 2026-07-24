Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27A3B3C17
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926192; cv=none; b=oalHYiGiubkoSll3bl5PYHgGTkrVg7hRQ6FFRZ8L5L47SdERp4txoF1JjqUs3vf+6aDT4KtwEoVilAx2xJZvTiDyq2fOkBUcwPVZAQ7rl8Fq8Ay36csTTLU+a4JvWNu+JMPCqPkgfWKoANzcf5cMcnf+NyHBrC6kdOgm3W5pGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926192; c=relaxed/simple;
	bh=+6NzsAXpxpUyYVYr7CrkYkFkcEajA1+j6cXX/jJG7dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4N83b7I0FpFOY05PdcxPBReOmILWjD+Re7O9qQ6OZPQbBr9CYK8NVeN0StH5gl5KpstECKf8xn8q+QrNPvm7AEkdL8KJaWpiW79Tj7Jc/xmBxMe2rmUxq8qjB4CyXqrn1x+jMigOqD/alkoUjyyig3RmqBivTHSBocPxC+p7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OuWac5/7; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OuWac5/7"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4472500e25fso473161fac.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784926188; x=1785530988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SDKoS7M6FWotXuFa/jW1tR0/zPrDl09a09em6cgDMYE=;
        b=OuWac5/7t0GMPJyzq6fBVPspdI16+xujmkjf1yVVM2kXyj23jXPn5fiQXfzZpm3wYG
         dj3bx2eDzUMf5HSsvihtyXGXBHCjUSAu8NkozKSCn1jZzbFB0zs8IUOTwuC5HOylY1ol
         cY1kMgR7SP38ONftkum1iZ+HB1Hdj2EnyRp9GF6lJ+cV5X267xqBd/dD7HSz8f2TqDwg
         ZlsmjXSi5a1ki4GeuTGMcHQA+GuOn/VahBoUqvTOdhm2hcveGGO0m4ZPEox7QioLzlRR
         R2SgxjasOs8ggPt7k8EAXsUibyi+7w9vHMS3e8iSB1yvREMQxp2HdCkEbO8ZEA806zl1
         dynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926188; x=1785530988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDKoS7M6FWotXuFa/jW1tR0/zPrDl09a09em6cgDMYE=;
        b=RVh/YfxJ9ZjVFw7fDITl6m7wCkKUnGAToYrfDqgKADqTCIjMqg+4ay0i1zVk0uDXsy
         IX8npYj6dFKTQXMWIOHm740W261FFcsaTWuTTyOQSv4+va5xivgUtjSpXJ6WoKiZifnG
         JwvllXjKv7YZmka+gpf5ruRM5tDkuDvUu4EJIOC85Q7fzqIk1+RIOG/CHtChVTYumEVr
         e3IEIqfLb+JnyCauA/1SRJQ50xxyEqg6WffDxq8GQZ/M9oUyR+eA2h2M8zet9kogyo5p
         bOpFkzMuDryaaNJYrfV7/MhZcEZ6ReJR1sIV3Q9j3SzsMskrp9sjpBcB1jQQnBTGcv1M
         SUVg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9KWOfnKhl/TmUOHo69Ep4F+tfxiTMRY9cMD78z2h175B+b4FOl4ajTkoYCddKHQaWMzZVzhgiu5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx65MIkUQE5K9FWS2+3ibBm2LyD2nj1f764EUzViAS4vcpgLuh
	iSQxRnpxCbiVpvj4VevOY3JVYJbtpB9fiabT9UncPOJiuIThVzjsYtnI2/SuBLis7f+soHqqT7u
	F9Q1w
X-Gm-Gg: AR+sD13+P/FxBq7+07u2LclN4acKKh5lgELwUhC/ngpkWYtuOpsmv7NvMoqO+pBkQ1U
	1Egb/0f1Qh3pS/ItSKPRvPY4ob8M8EWgB+JOVOsyjXFDzkEiA6C+1GrDSZSzbrAZUQKoC+Bz/eN
	6ldG4EsCfEAZSdPgTNTLVwR6Q2li+bvldtcmb8viAaGmNlMQ07TOAJWeZZkhKMOXfSxrXxHzkUt
	nFNjqMJgtpMblbjzBUvBTgfhffv95Hl382WSq54aOfnxyyla+8yNBRXNXoOBAx2JUTavAsplgIn
	PC3p2p3h4HHc7+6nOPNK5330ZNR8DBDvrgTDQn2oGDgDwwIcTenBh+NgdCYOS4/Y0psWrSJFhkC
	g1H5X53wGmPwVcUfZrwHTSQ8bNGmXYPK5pdBDKEpbt83fkg0F8be1dulUCL7LqfWTRpvH4AmzUj
	fqZg5Nts9eXFxqCihw
X-Received: by 2002:a05:6808:178a:b0:486:5466:e41f with SMTP id 5614622812f47-4ab6a190e23mr32272b6e.38.1784926187877;
        Fri, 24 Jul 2026 13:49:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e66674sm7255201fac.3.2026.07.24.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:49:47 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 15:49:18 -0500
Subject: [PATCH 2/2] iio: ABI: add sysfs attribute for _burnoutraw
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-burnout-v1-2-f0204cecbe3a@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+6NzsAXpxpUyYVYr7CrkYkFkcEajA1+j6cXX/jJG7dM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY8/eVgHYVCXmvEb2EPRwTLgV/6VbeymHbE50t
 pJYxg8FW8yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamPP3gAKCRDCzCAB/wGP
 wJ5xB/0R1kB6mTw9e/dBjym6WUujDJHQ+RRrT1zfav9hdHDAyDlhdNHLgHYeH/zyVm7EbWO3YSi
 F/K+D3qx00eyTS++hxAN60SKYhqiWs9Ej34ybYYLLndVqRqDTKCxxTlosG0/O0OLG54rrJtfkF+
 kGqielXIaLQR90VRaS8ZhIc4Yw/YDNqkXszHX1L6cNcDvOUQjozVcZfW7h3nc+Uay+vsl2kyCVY
 /notcd9KeRYi7cFTKuX75AGAwsckOxKIVO6AhV0LZJpzPwGRn0g5JfSLNRcgtvdz9WXrgJP6wOP
 urNnxi/73CDeRBnbcNTaTsCLk438i9BAt7oSqXdd04Fzoxol
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new _burnoutraw attribute to the IIO ADC ABI. This is likely only
applicable to ADCs (but is seen on multiple chips and vendors) so it
gets its own file instead of being added to the main IIO ABI file.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc b/Documentation/ABI/testing/sysfs-bus-iio-adc
new file mode 100644
index 000000000000..d45f0a4eb18e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_burnoutraw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_burnoutraw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value from channel Y read using a single conversion with
+		the channel burnout current enabled. This is typically used
+		for diagnostic purposes to detect an open or shorted input.

-- 
2.43.0

