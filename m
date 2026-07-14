Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB82931C7
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056610; cv=none; b=GrSfJElE5urzv0v+UQE+9g5OYdMVoxxc9HYXq3yxyw2CLAMyKv/TXbML7lbWewZbx9uRCB4ILq91ax3e7drY/0jdCR3vLDw/m0nGzIxncLJGwSKpxn8vFt+QJg7LiHqpdA7fuizehDRrA9PakNmEv06Jk7CU5tbZgYcXGaHw3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056610; c=relaxed/simple;
	bh=+f+IDLTrXMIwTZ7iuJjJZVhlyaQWKezzbOXQBgkin+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLqjw/IiQ2pBFAFzIcT3NEbDRVh81PpBsr7qInKpKbeekfTkGoqoYqPycYgwPQXGtgBfJ0vZSzzVwcSAw8XTlwdPGN0TYkAfm5KcqWdNExnBT//yhGvJqVtBAPeTTQXLoOHnt3TI6TrJr3CpsLt9lUvQikaf3qnek0dJypCEv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CwlYWUeq; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwlYWUeq"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a46a53abc9so953039b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784056605; x=1784661405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuXRtMtsCrbKtroiJGCdttoDF3tRJIUhOu4EeJUBsWE=;
        b=CwlYWUeqvLnTF1uafTf4ApxV8OCRd58uuBHZK6U1cLp8LwKUF8sSP3iIErGqbiQrXX
         SpZtB70POQ9kZg5JwTumT24Cs4jVeuflxIBb4PXE/+Dk0UchakKoteHEON1UMLiRRhAZ
         qT+KRJTiLwXt0nzzoYf9JmzXhKDe/UMI1ELqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056605; x=1784661405;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuXRtMtsCrbKtroiJGCdttoDF3tRJIUhOu4EeJUBsWE=;
        b=q1VHwgMSoDcUl1jSjXQZfZXRXBfftqlStw0TL/82RaXoLo4vzt9QZMFlBuLh/ohJCl
         kBiJ6xLEcJUJhrDxApoW28ZmLG4hanxG/8mloaS6u7ECQYGrNjSlompig6QbGofBVeVW
         axfDgHpNxUTbynfbUwaXhWAmUrYCJNGM8zMUxd2dMTlZ+Zgm7psGs8y0k74XyDELCP7y
         UT4wyvk+UFQ8PH8zK1nk3Pvcz2JTQePXLd0F1Ox+EIty0VgTZuKqGKjtzlJDjiBpry+F
         5OFFw25cVSUn1L8PRiHZcj6fI5YYQgLmKevhp3/Vcx3DQUyy6IwX3JM7Cc+rE2VZM/fL
         dBIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sY/1A64xMXeyUSRIl65z1LgfaNWYnzqDdWhHsZn1Rbw71JyIivs00tGVYSP7lR2QwxfelJ4GDEkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxammLqB/9cFO3+bpZWJVyvWo5bimAEThtZ//3c2YOkNNN0+kdv
	aAtMuHhIEt+HMWHC/v3S+VsEcB18Pjyt1r7yHmKlqtDslbtmxAexY9BxcMxSCioUNA==
X-Gm-Gg: AfdE7cmIIGbp0fqD4j8ne21ttlv/WkslPvSrZ10mOtl4Ujci5ZMcmRe5Nbas7bqj1qr
	abHkqdWA9wJFbNB0/9H1XgBye4piIFoYyMsIaKguU70Rp1U+CTWwV5aRE6EMDC5KsxwbwbWKpW7
	wyPKUduW7bnqBAS/SsOCSW2kYNxnuMM85XPIuAIb0qYD/84G5evGIKl8IhroXzGsSMyMjEvYMEy
	8l+apcKubodvtgmPsHwLjVozkg9lTsLDhB4VRHkHYY/Bv1EZPik0uf90Z/4lZIqrD7taN7rwLGE
	PcYBfH6SID21I9uH7rqu0/xr3xoLNt7J5ofad1YizFp24hZIfzeVzgCcLzEAUB8TqXKWhCWygaF
	40Zo2azJzt93WuDV3EHPg+H2yNCC9jYkm2q2COkuVK3y1lJAHRl+hcaJ5DuhFRW0gPIWLe14md4
	FYtqPPpnw=
X-Received: by 2002:a05:6808:4f22:b0:4a3:26b5:7c3a with SMTP id 5614622812f47-4a42ae048e3mr10469731b6e.15.1784056605373;
        Tue, 14 Jul 2026 12:16:45 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm14767236b6e.3.2026.07.14.12.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:16:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible
Date: Tue, 14 Jul 2026 13:16:32 -0600
Message-ID: <20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the compatible for the SARADC of the Rockchip RV1106, which is
compatible with the RK3588 variant.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fold the compatible into an enum together with rk3576-saradc, since
  both fall back to rk3588-saradc

 .../devicetree/bindings/iio/adc/rockchip-saradc.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 6769d679c907..f0551d665916 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -22,7 +22,9 @@ properties:
       - const: rockchip,rk3562-saradc
       - const: rockchip,rk3588-saradc
       - items:
-          - const: rockchip,rk3576-saradc
+          - enum:
+              - rockchip,rk3576-saradc
+              - rockchip,rv1106-saradc
           - const: rockchip,rk3588-saradc
       - items:
           - enum:
---
base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
branch: rv1106e2

-- 
2.43.0

