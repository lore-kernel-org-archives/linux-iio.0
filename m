Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993577;
	b=HeMJrGJjq1zLrCUknBUL4ZMtRR3Eh+ellkMFSF8r61GOTBhmEpZHYTIaffjbxSRDnIgl
	 iZvwIk0RWdG9ZFMIk9lMFBCBvb21ijyL4Tq9o9NZvqtIBlEF8xQbhtclHj+7LQwn5bFp6
	 V66tVjWY3IlrKIr9bCq4SZFkQqOKIzMSkR1hTqW+DZ/SRr9o6PqTiPvnQbW8DGCkGZYii
	 XOtZoJzCTHW8CcDS5aY6jF0g77uUymTt1SyET2DsaUXwue9lDA3zUgVY1QcFvanlh3RF2
	 5BBGFPuq2mOqoXVlDo+FIlB+gCLSy99OKCEKW5Bbvp6I+VnMzxaGRrcuGUd4Auz2vbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eV00qevpiw0uwOmkgJzGcKtSnafIzvVPxNUpPKZUN5Q=;
	b=qN0lu91a4epLlbdPrRe213auRmkXR9w26MRP6p4zkm0emwG7qEn7NT9rtKyd/7UQoYfN
	 iwXwpHNNNO9fmjZpMT3c59+ORBBqkt/+msAPxayC+RLHqNzP6YvJV2/f5mRoissbBL9L3
	 zPGKjzBZwX5/lsP+sPQYcE/rY3O+n2/pCN2BRIaOaKhonLD6id3KweJeHoB50/iBdif8d
	 w1AM8TAhQ3qCfXcq+yeEWSgRafa3FSrrZnaWipSiXwyJ7MJ0Niseoa6br3+jksK0TPvOf
	 +ymru1sazBnJLAiZjdsyWsL3nXOJ3qbQc33YC80boFl0J6hWmwTdn9Jb7KsLH2Yf1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZuEqrqc5;
	arc=none smtp.remote-ip=209.85.167.70
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1C606A33E
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 19:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E1C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZuEqrqc5
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5be60ccdae7so581730e87.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993575; x=1794598375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eV00qevpiw0uwOmkgJzGcKtSnafIzvVPxNUpPKZUN5Q=;
        b=ZuEqrqc5moQ8zAXTVWRc3MmHjV99fcIi5I+eXYb+MaqleUi+jOsied54WKEB8jQJsa
         CqgvUyDoZk0r33vgI+AQ2PTXDbZuJo4bCbsfUeZ5c8hUcXn/8V18PpeLdjL7/yqVrCQR
         5y2nEAMgcbOE3ZnI9WKteq0Hjd46ctISfebk6LBsqYLzK6r2J6NxnqttC3mzBMu9furs
         U80FG6iDeCVS0GmwISG96v+NE0wz92PvJ8Lab/Nese01TLZ/SBUI/zDl1ALNq1RkLLkF
         QUhlxrsCAE7WDqErg+AxqOJ4bOO6hM+EEtsINebgoVZdFS7oPPymt8aVTb9wxg9tyfp9
         raew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993575; x=1794598375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eV00qevpiw0uwOmkgJzGcKtSnafIzvVPxNUpPKZUN5Q=;
        b=VRdfGCdLFFV6vaCPoxRcIgCesEDIO2sv0ceclZA6CrB0fMcX+BQLKCy/91ytAJ1Nl3
         W15p1mdOzLqUNxBIRPlvfgqwkonqM2Aiaikeq5cWQo19CKTFCv0ufwAS/ErkRefLBEiM
         G5zQhHhYviob5tkerBfLFtheAXlp32txtD8S40MGTrg2QDxzY0kKAetF2yfV4pCoBJkD
         8nrhg45BdFPqQgaSyqUaDrzPi5OJ+SFUKzM4eY/WqixVSr/0s+CzoghVS71mzLpqI0A5
         ipdmBKm701njoEqkuRkLAZyMfNtXvCyvUDR4MiGpTqnj8GhEpUhg4lbv3OHkx6ifUJaY
         P4UQ==
X-Gm-Message-State: APuU4Z+LhkuSN/5dMvn1LOTWh4XCp8yTtuUPOWGbNIvc6MWerXVh5VGu
	fe361HHikp2CSqVIIC2VrNTCrDD64x4a0vr7g836nzr8BJ+E8aZyjcPllyJyPdpLJsspPe4rJhZ
	KMi94ALYwzg==
X-Received: from lfyy9-n1.prod.google.com ([2002:a05:6512:609:10b0:5bf:f63a:785d])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:ac2:4c4c:0:b0:5bf:c9c7:eae2
 with SMTP id 2adb3069b0e04-5c003c595e7mr1028653e87.66.1793993574941; Fri, 06
 Nov 2026 11:32:54 -0800 (PST)
Date: Fri,  6 Nov 2026 19:31:17 +0000
In-Reply-To: <20261106193129.43493-1-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106193129.43493-1-dbalint@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106193129.43493-4-dbalint@google.com>
Subject: [PATCH v1 3/3] mfd: cros_ec: load cros_ec_pwrmon on supported ECs
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.56.0.455.g6c5a503b38-goog

