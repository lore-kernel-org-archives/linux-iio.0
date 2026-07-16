Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5543F4D5
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223376; cv=none; b=nWbbIdvbZtQUpM/bxVCIvUnTRRbCJSvW1sBJnYQH7vJkapUkCzRUvcmhgbJDSMn3UtodUyn78rrYJZouyeFdlpKW92D8CHDaJY9CI575QnRXjhHB1ZZ4pewQmVN8LZIWx8GHbZQlkzJpMG7g+R+TRyBU3uXq9TIcOlXcl8myFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223376; c=relaxed/simple;
	bh=Bdre9fdJwVMzBFV9LYo7Or82eJ6WPi/GEPDr8PMl6aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN9xTlGNR454CRyzCHcLEkKvHBLje5el+4KfPW2bRDvRpgOcWghkMzB2VnQcgT2uznelzbXnOEdUN+aNBg1K5OrIRGyX1k1OjUl+8QzuTteuO3RgjescKBhLh6fJDb99qkj8NLr+fvvywN1WQJhzpVaGj+us31pB3KvnU4vWbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S10hIIL/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S10hIIL/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c19bad03so58057125e9.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223373; x=1784828173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jyKLv13yjCnmWhHAYzJFN1nNRxdkFskQEtHHi51g50w=;
        b=S10hIIL/vkDLS7qPZ9sK3C/HDQg5DR4hhA7k3PYV5A19sSgqdFCX5rAnC8TqKoE43G
         ZuPijzVIaPQf1zKU4+Jn6kdc/71KvmLTjTf4DwrVRB13S53wFGuk09AXPrfV8d44rNHC
         OpsqG9PmaWPs2cUJhMtvWPy5tVz34vPunxO4jAHM3fxQTtX6b2hjzRcHvIqboCERCQqx
         PN1ev/NVP9amSGbLJ/z8TPyRxEemRNQHQsUteZN4be4iIw2y0pCNbMhlM/fQilrpknGE
         6wYJEW1oLjsX0iJk6Agmgkx/rEXdnHXDnDEW/D/BdcoD6NV1jACV1b/FhSu0xqD2aCMG
         LE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223373; x=1784828173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jyKLv13yjCnmWhHAYzJFN1nNRxdkFskQEtHHi51g50w=;
        b=bk1yJvcWXflipBPldS6uTILAHkhXy1r2DnN2HhLG26wj6NbLfHZEQyCru8pmqVxXaW
         eUFiWXA+lOTUyo/REQjMY45G9StqBfQwhjSZ8xzuhODggpefIouXCDQ8ip3afo3cYdQF
         XtXIfvqt3yq+iHIWIhqBPv65P+gUZWqjMKVBHV1MmgxOOcuLdiyt6cNsF1qeVdGoh9iS
         hzQtxnAoPKY9h0+EHJokfufsr4ZDiEv+zONOEYeGkindX9bL+okEypgX9v/Np0tTDpzi
         f504/erEeWLbRAXxr0dQh/GfW7LdYPP7MXbbKYTeuPDHFjFDWtKE5/zGmNMIz6ADqOZk
         VX8A==
X-Forwarded-Encrypted: i=1; AHgh+Rpn5uiPPmY0jH2D1SzJocHJYMU5bNMAweMOyyu7RyhOxq4bf+u4mvwi1tueiF7WeDFSAcqiq/B+R80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/OY4Po7sTWoEqRmDtq2xXVAOMpFtiGosBKuHUspu/plUfULe
	eMblfFRQSdgkhh1rkQ1AUi06AWQoVHIN23IJ26S/U01nVs8Vq8/uSkEpGmvtcDJ4m1A=
X-Gm-Gg: AfdE7cnbRmVHztEwXxbS8Bu6wGGjb/bQX45XEtGR9tTDmaBE1U9/wCBhtKD473YxYFC
	cNuxBDBKhUPAs1IIGY3syQ+TpbIMlowIQmPDfdSFfAR0U86s6sJYl5+qwfKWc2J2LxJKjqmF/1f
	NWKg+kfoWR6Xgdsygo2XFCtLj+OrGOFW7q10bN+g3lUGPOSIaqaD0Fu2DL5wkK1NNsFF2Sd3PVp
	x0Two+ckWtu95aAeRieLYN4MQJex2r9nYQqOcQlKgdnenLHIqAfljjAwSZud1trXnaNiwpHnKK1
	8ofJCYOT49pJzNn9QhBOct55ev0D8A/VHVkJ42fcXcu96Alz7bop28ZgYZDAtHunop+8OKU5tXV
	vqVntmteLob9Te09k9IYVa+VSlJKBGSOX3ql6ipZ6JXwsqyz2LvVqlVhT3uC9CttktoYLyJBbHf
	IdOdQZQ5Az7BrY1RIOOxPERsIvOMcUQkz17OeScSRpGNMyyGsiUuCmB2+Fgt0ZEE+sEic=
X-Received: by 2002:a05:600c:4fd3:b0:495:4593:bcb5 with SMTP id 5b1f17b1804b1-4954593bd26mr23894345e9.34.1784223373498;
        Thu, 16 Jul 2026 10:36:13 -0700 (PDT)
Received: from izzolab.play.pl (77-236-3-190.static.play.pl. [77.236.3.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954812f0d0sm7983005e9.12.2026.07.16.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:36:13 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Wi=C5=9Bniewski?= <pawel.wis.me@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] iio: proximity: srf04: Add Cytron HC-SR04 support
Date: Thu, 16 Jul 2026 19:35:56 +0200
Message-ID: <3fedc827a2581d61bef9ea639ed77cf90e80047a.1784221074.git.pawel.wis.me@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784221074.git.pawel.wis.me@gmail.com>
References: <cover.1784221074.git.pawel.wis.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested on a Raspberry Pi 3 Model B+ running
6.18.34+rpt-rpi-v8. The sensor was instantiated using only the
cytron,hc-sr04 compatible, with trigger connected to GPIO17 and echo
connected to GPIO27 through a 5 V to 3.3 V resistor divider. The
driver bound to the device, registered an IIO device, and returned
changing distance readings through in_distance_raw.

Assisted-by: ChatGPT:GPT-5.6 Thinking
Signed-off-by: Paweł Wiśniewski <pawel.wis.me@gmail.com>
---
 drivers/iio/proximity/Kconfig | 1 +
 drivers/iio/proximity/srf04.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index bb77fad2a1b3..89e9d57ceba6 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -139,6 +139,7 @@ config SRF04
 	  ranger sensor. This driver can be used to measure the distance
 	  of objects. It is using two GPIOs.
 	  Actually Supported types are:
+	  - Cytron HC-SR04
 	  - Devantech SRF04
 	  - Maxbotix mb1000
 	  - Maxbotix mb1010
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 7be50bdebfcb..f5ee7d6572b5 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -231,6 +231,7 @@ static const struct iio_chan_spec srf04_chan_spec[] = {
 };
 
 static const struct of_device_id of_srf04_match[] = {
+	{ .compatible = "cytron,hc-sr04", .data = &srf04_cfg },
 	{ .compatible = "devantech,srf04", .data = &srf04_cfg },
 	{ .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg },
 	{ .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg },
-- 
2.47.3

