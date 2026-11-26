Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680726;
	b=071R3sm9ItSDnJPGpov/9eYiIIfXAPki6goe4rDv8xulCPqn0l1NuGpjTOwDl+dWkn8m
	 fKYTdAuaXOBb484BuDSTXVKnFWpVhZZ2dOJKnt1SXOMUAIp6uUMtakQyu38qZNWLmRQ+6
	 XHj07sqooatKRgkLFVKYpbcrOtqm6zoesa7epoX3zIJt2EX6JmKGzg0OV1pUJvRUQpfMr
	 DT9ID1j68U5gOT5McJpqkblGnC4PxwTChjqjab+rJJnfnjvMQgpZ18kdagTOBHfqA9L2S
	 w9lUBYwDTsdfyAX3Igzuo9TNuphRw3RpqqpZ5xi4S5GtkpmP97kFOwfyMf1R0AQfsPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
	b=BaA03PBrZ7QSSn2+jXOgcBZ8rIMCzWenEN6e7SAP9lqruGFQwVgw9UxWmHlKNe0+RqA0
	 lZs8Uc+di+CS2uSsGCMWY1+UYM/9UN2i5uhR/Ggo0SmllLr93tXQ3M9CjbN6wCE7ZZkF8
	 0sPYq3Qrd07allC/VZN/N7ju6Iv75PGiiTBI6ukgD8G/AESq9K1rIUTOxtFiAS9lovX6p
	 fgWBPudWteuhKS24pzUTXgD5TfIcFIICBkdluqsyPO1AywnAFY9C6c7fMdNVRtzWYINd9
	 kct/E8r/NpwAmxGGy5iRIcefFX7BHUPrcfIlSbgM8RAjyxgZ+qi72nuAgcfneMcBsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afNMj56i;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C0606A329
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 232C0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afNMj56i
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso2719700b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680725; x=1796285525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
        b=afNMj56idSUsA8/GA/AHUpfpy019tdDHMdLysmAmbyTWWrURWFDGPWMCvEgLuvEzAu
         2cNy/qGrKZj7x9oV4EKwSjgkLbIhCYpMY2/nkynFBAzrqDzXH5sUyTjax3FLn7U+Cyt1
         RkA7UNcS9jByW7XfK1M7oDDXG9IKgNYMvIT/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680725; x=1796285525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
        b=qt76biN8VnXfymjmj5oACmSVpo8938ZyzRQTA6pfdsL6+UOyWp68rm32AKuwLByqlZ
         mDDlHMVwAqMCN4yHZLc3X5VajuJu+15st5h0yu207K5f4NVTcu3ZXf2+V1e3wZWlNp2W
         yWIlcH73VaJ09/hVoT4yRzf7M3NEpmo4r1O9uZVjUvihiogFFO7hPrcB/xSRmTengvyB
         YcNFqInuBpi0Etb5EhIOohrToUv+u4KTviv11Ni9FMdy9cYA08Ki1KeH5E+An/EjC8M6
         zu/evU3ATTrhmCR41YljAe5d85bfHedkB9QHpdaojUxA1SdX5Z4X8M4vF6Byh/1KJ/oS
         f+BQ==
X-Forwarded-Encrypted: i=1; AL+hErE+7rvxzB6p841EwqZ5J5K4n4vN7Rl1Wg0L2z52CBHdcpTNuVLFSruaBV2hwiYkgn0g2ZqnCALNUZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sD5xB5NDNBHl08XQbsPiBseUBkM6ejp1I6XIyZxSEMbsSaCmt
	wo1o0+4MNDD6IPVH5obF5Mc64dxewJ/RVH7WvStAclHpuhp3Z6icO6u1KuOuiRlLZQ==
X-Gm-Gg: AZFdTZfMEk9FdyrnF7YN+fFi0/k7Vk8Id0Oc7uV21uHCTbS/I0nOfu2/GFemnixkC2f
	iuzJfuZTnQP9mHx333kTSbWgKupFPnE/8waaqKNWm8IRbqQtSeJbBkBoHBpXYu7D6wReBK/Tj5a
	IPEShQx2BcgvPM4X4upuvCzwKO3oD29JYfATz06v9Jd86VHPFfyXVIZvMY3D0/hQw7x5nfTFgsj
	HysJSybRk22Jhk3c8jcFacWYZxeKuwywhVxpLxQwPcUjzl1fYQAaUjXuqYFkkkmGiPzduEwoRkB
	pFPSh13sjaupB9CUfWu7PvcYb8oE30HgGihyBmGucsEFMGYu057AyAf9WBCpI514krfpoO2EGrb
	XF8phFRJ8y6JoLfqrZrRLMw7MfCJZvLLBRi417uhLrutmxA7eizczA1teXu8akk9yAKFiWgt5Co
	nDFtBHr6y5YPbQD6DOBi+S+SrmvC7g58C2scdL0bi/fMQ2z1CckCQHWL+0mAsMegeM724TTyErC
	/ejD6Sg8ig7RIB72thqqwSwfHetkr/L3fbxtpiIkqPRHIvKn1mGXQRy3vCBLke1tBpoi20ue9R8
	HynH5egtzwIUI27XW2rPvKc+T8Pg2PGacRJlkzX9P9aoEs5MCFVQz58ce4eF
X-Received: by 2002:a05:6a21:8982:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-4014a274c36mr19665217637.7.1795680725481;
        Thu, 26 Nov 2026 00:12:05 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8cbe173453dsm7079649b3a.25.2026.11.26.00.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:05 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in enable/disable stub functions
Date: Thu, 26 Nov 2026 16:11:53 +0800
Message-ID: <20261126081155.501493-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126081155.501493-1-wenst@chromium.org>
References: <20261126081155.501493-1-wenst@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-stub versions of pwrseq_{enable,disable}() are no-ops when
the descriptor is NULL; however the stub versions always return -ENOSYS.

This would require more code to deal with on the consumer side if the
power sequencer is only needed for a subset of the supported devices.
One such example is the rzt2h_adc driver. Only one of its two supported
hardware blocks requires a power sequencer. The driver could be built
without power sequencing support and the other supported hardware block
would still work (provided the Kconfig dependencies are changed).

Align the pwrseq_{enable,disable}() stub functions so that they also
return success on NULL descriptors, acting as no-ops like their non-stub
counterparts.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Added blank lines before return statements (Bartosz)
- Collected Biju's Reviewed-by tag
---
 include/linux/pwrseq/consumer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index b69117ad3fa7..d3f5f37603d6 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -47,11 +47,17 @@ devm_pwrseq_get(struct device *dev, const char *target)
 
 static inline int pwrseq_enable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
+
 	return -ENOSYS;
 }
 
 static inline int pwrseq_disable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
+
 	return -ENOSYS;
 }
 
-- 
2.56.1.839.g22a8290db9-goog

