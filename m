Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690122;
	b=z5ylKAX8ixOxLWfkQawxeKkqzEmlxiC8w7pPwWTo5BLdaPkmVoHDmO7/9olUoKGmkzwC
	 qcKnEdXh8AdRk0w8fgWzip4osELfDwscF7FJ1mbbuNA1egc0GQ3pO70vGph7KvUb/EHTe
	 cdNlMzEdTzTZLWlV5qAsQ9r2XWAM6kBKFnHlr+DRq/tb9qUJNS3xNvnV3YQiO+aZ2jKSg
	 qdRFuFf9n1taVaE4sQ/cun9hvkDy0nQuBv339uCd37w5sMTvKiDMrPDZTbBFNwqq/0OUs
	 IxT1Sq26bc3+pFlUyJJ9iCPidmbOuPDpm92C1Q4WoQvtF80PA8YaK2Hmk6APR+dBvAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ODOROgglBubCeueofUdqrgO8xPhnTBc5wYg4QXauX+c=;
	b=IEMIOQhCyXvIXfXQSOrKpMwyHtSGpdu7yXSp/J6wTd2jB3AfTgp/mg005ap6+idifLDA
	 jcV/kUZOlQdwWLwEDRiKviAtHGdpCGCNQuV/vT8zEH/wJcF5TfPgEhqh9DejwrARYofXN
	 AIanQqEDKU4fdZb5w4opuWayZkr+/dpRid3iReGv4yhFt4BlQjkJiEad5fRZhi3Q731rY
	 jx1D4DxnBnVODSTavirLGi7F4AT9v1FklYJdtOSvAQshiReZS+izoa3E+1rWXCsKlS4LQ
	 tjHDtAngrEePrfK+BrqGd8Re3Yen09s2Pi8Dj9Q2vhJf72eVQgvKZG1UDagNKKPJobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+JSa+Ut;
	arc=none smtp.remote-ip=209.85.167.69
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D7606A33D
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 10:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22D7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+JSa+Ut
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5bfc3cc4754so2617373e87.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795690120; x=1796294920; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODOROgglBubCeueofUdqrgO8xPhnTBc5wYg4QXauX+c=;
        b=j+JSa+UtPjpLo+sLj+TvPPvS+VD63xvtyFAdACGiYvbxcHRidvhEQo3BC4MewFvMDN
         zJrwV4oKir+FT6cOucBHDIo+Gyp9y4Ceyuy0bhyhV7Pb0py8HD/4PMQKUXiYUnFoWZVC
         WGMUhIa1Ecb3o6+khs0L6CBZqbAFYcl2FqmPLG/keSGCdndjVpO10jxNt5rcPf6ScdK7
         gvLGrSobF06UnvXpighfRp9YBMvT8cFK+fxHSPQ22rNxIqMaTcnrA7xQ2mwms3vQxT9T
         iRJvwc0QaAn24GiIA1PrvGWvXgsZFxZtNXquu8m96D075i50zKMlnRkR3m57dg5H2Bxq
         6zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690120; x=1796294920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODOROgglBubCeueofUdqrgO8xPhnTBc5wYg4QXauX+c=;
        b=IhcVq/Ku4zEl8okgMtyUa3uKKk35UorpFb/WMo+7pz8mfSc2h8VpdoR1wSLB63/6KO
         kaUpGvdgXICpueZghbEHNGbqPAILEi6+uve6C2gysaq8HEM39NEGxtufvo3cGSMmafQR
         xtnMRaj8u+X68shqsxrgRok0zoM8cGbeqkILMKYMWCk5WWRtPM+MxMeINI8TDU6qXZhQ
         X0rSpYRNesvtooKY8tTUpE5RRzlCTmaI2L0hqgKpUgGtCaU87Q64pX5CExBuWN0BHXF4
         yS2zNZA0pg4PbGAGyPKnSDwoTvKR/M9OQDrP31uFeWwFkfYhM1RSS+H5tW1Uz+GfvCAa
         xMxA==
X-Gm-Message-State: APuU4Z8k7u/+Bd+ILjSOMYz8aP2jhwGdX8ntuC8F3kiR18csATASfikg
	Bbz7DApnot4puoXG/UTNXF89VTZryvfCAxLEpfe8DmuMg2G+rF3NsHsUCOktzGiCzORNFMuJhY1
	sBbBxzzKaBQ==
X-Received: from lfbfe13.prod.google.com ([2002:a05:6512:620d:b0:5be:4c8a:2f0f])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:a819:10b0:5bc:f29b:1a5c
 with SMTP id 2adb3069b0e04-5c1bc7d0b80mr4028854e87.23.1795690119891; Thu, 26
 Nov 2026 02:48:39 -0800 (PST)
Date: Thu, 26 Nov 2026 10:47:57 +0000
In-Reply-To: <20261126104757.2860272-1-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126104757.2860272-1-dbalint@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126104757.2860272-3-dbalint@google.com>
Subject: [PATCH v2 2/2] mfd: cros_ec: Load cros_ec_pwrmon on supported ECs
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, mfd@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, mwojtas@google.com, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"

Load cros_ec_pwrmon driver when the ChromeOS EC advertises
EC_FEATURE_PWRMON.

Signed-off-by: Daniel Balint <dbalint@google.com>
---
 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 529a23b804f7..9cf85636b7f9 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -115,6 +115,10 @@ static const struct mfd_cell cros_ec_charge_control_cells[] = {
 	{ .name = "cros-charge-control", },
 };
 
+static const struct mfd_cell cros_ec_pwrmon_cells[] = {
+	{ .name = "cros-ec-pwrmon", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -151,6 +155,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_charge_control_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_charge_control_cells),
 	},
+	{
+		.id		= EC_FEATURE_PWRMON,
+		.mfd_cells	= cros_ec_pwrmon_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_pwrmon_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
-- 
2.56.1.839.g22a8290db9-goog

