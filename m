Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F8369965
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607712; cv=none; b=Kv5FWZ7oDBLTcv9JnAUvlRqo/hPEh/eyICyko/1GQs8Nwe/cQhH6eCNRTeDH0ls18+l25TOZDkI+DZgMccr9YzRWWyrDj+CE6ALO6H5WctReIH53fR1KYVu+gN+XYrEtR/Ajax67JjFbSqSjpeb1V+4bAoJVqlJLnz9FYsdd/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607712; c=relaxed/simple;
	bh=WGX0XQW1Y1v+z1IdcNozewhJkNcGnleipMvP0AiYsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEutMrT2YVLkUNPoz/B+ZDmSie6kgyUobwnKc+fCzbdgw/XdaWw3oIHcK6Zx9Z9K/7tf+7CbsRQgvECk1jzu8ZljDfAcW45ihDNEU0EGwnLRC5Paad+PxJ1woDYUT6TlVCaravWoQxxrwL77de/iXrYpUCzS6zd7Nf6VRMlGgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOsJxB/I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOsJxB/I"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36c68964315so2421568a91.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607710; x=1782212510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=WOsJxB/IjN1PhGnvqLkxXFqOSFfPRG0c4NvYpUQv5gkpkdmYklQ8dYmtw4ZSHgzK/6
         G78C9NhTzadikgymUbcYEKjNxFJQwXQ1hHTGHqC0gv0AFoe7Tt+daRs2Zjmbep4Tt1ei
         tM4AhhYVwUATe/rmCBNUuAQDiF2iJJ8eUp7qRI/meFBWaK7SXtYEgsbZGkqR6i2aRxmH
         6ks+pwfy+3Z7z7dH14BlhQ8SP+W37I++KEe1PtpDdrMNuOad49PbDmMJYHbwOVE1NPP4
         PtN1LlY7esgzl71djvr3vygLUdfuyts3NCwXbTA4OwPOebbvahiZMTs0KE200z2ZQQbL
         Nm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607710; x=1782212510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=a8iysrvLjXdCcYpO7L3DzWZ1kfgt+8GAdwcT81UNP313+keRyO8Bsk5gOerr4+AeNw
         9Xg9RnBy60vJ3nlQV67wsK1bPniicyBI2buRaHbZbkpwTWfskV8xOsWWY7mK/SwhG1RY
         /YY9QcyupdU6HympRHIFAOtgiSbmG5wugghEVe3xW5Qc3Gz/EF8F0falpSWykJ84QChC
         wFXnKWikUR5OrZbsPOhe/aitQr/Wig4sXNV4iDbe9wdTk7L1p883NoH/xN7DS9Le80cR
         HZ1ShtVgF2/Yem8lD3Dze970oRaap/ZoDt0U+mCjdGa1uTCEDchmm8voO+o966Fafg4W
         UQWA==
X-Forwarded-Encrypted: i=1; AFNElJ/FZilceTn+QL/+WuP3Pq86IA2cO664OnQWL0t1TOY/bw8N5jRH26p/qkf0MC7YeguFdX05e44q8Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3TTLNfOZfbPq94qcdDajQjt0oJjLDbdeNtnF/1UcozX/+Rgl
	LMtz71rIleP2JtsYWM4jhUeuHBKn3EjMq7nUS7EHLVNqD//MNZCKgXs1
X-Gm-Gg: Acq92OF3CYJs6GrU+Raj8op8N6ZoPPO6oYSdjPRCdCGxN4xnO74SntU71x61WfEAf4F
	kmVxD1ZyzezUgJKl57GaS+5Vbe+CWkt3Y3ofOPREy3q79PcMm0xrdWK0LI3B1Tl2BrcT/paUSFQ
	sHz/qTD1N7pGllsLaQfYMWEWDUUp6EwShcm+tXjFJEX17Uttts0WLG04juUdoI5A6J4SC0OOoAS
	flDzOkbma26fmpzyEvsk86eOE5VprHmwjDddAR3LW6YLko1sK5VE7j85m3UCBXq3kQYlIL2J5SZ
	zsqSx826g8ylV1l4rXB6e9lraAqqUTWPCGBuy5Y7FcXOZriG3SsBG9wjAAN4HSunT9G2+lSnxpr
	eTkUxenQJaqoeI7OWLOJUoWyWyY/bikXfmximd6H6jkwiPQXssVu48oAR1QnlnpVnCNhUuMik6v
	A+GJYyWyZniipiXlsyYu7bnOku+iXvJXjyd2UhdbKXRHNNskDD
X-Received: by 2002:a17:90b:4ac7:b0:36d:a510:f908 with SMTP id 98e67ed59e1d1-37c522f3b17mr3344504a91.5.1781607709910;
        Tue, 16 Jun 2026 04:01:49 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb67sm2668045a91.9.2026.06.16.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:01:48 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
Date: Tue, 16 Jun 2026 16:31:42 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-11-950d25a05d9a@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-950d25a05d9a@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-950d25a05d9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..0999f7dbf434 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -329,7 +329,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

