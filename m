Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2462296BAF
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598173; cv=none; b=ApXesWve2TTdXFPT4xKHu7PqYPNv6pY82bQB4JnRfbSlRk9JMlNcJh1xKTTbqQ8D3EYejh64+HMJcQEvXws9lOzFDasTuc6Hv69HZN2pF5NmqXyByDeW92slM3ieHYL9xRAd/oOY7kDHjTw3eOJS++ge/cvl4jbfucFXk4HHsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598173; c=relaxed/simple;
	bh=bofUNRpYQ9VhIsmdvCBbGbsJYM8dyffBHxWEp9KQLms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXMb6eukXlQ0ArSXu/mXW5CnpZ1o+UIOwnJ/2CPYMYp6nDVrL65qUWjRdm9Ly41cTvAoKuagIX/UQVNwP7dmWG7O0tR4gdxMS0FrABqSgHq0IVu2//9WXgo7mvtSn9nLyYStlJarAmWCbopR4iC4uXmBXkdM++jHbgKb49o2Cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=eKOqgNtO; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="eKOqgNtO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ed0a45e970so1886373eec.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777598168; x=1778202968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9R3GKV+brGr8DBBiDlaEBUMrmzDGWJnBmRi9Q8SRHGU=;
        b=eKOqgNtOwqiRy1/f1QMc/AdJIK3ClZfoGYkXV4qolfotzYuldQuagfOO3kU3DhR5dN
         T9te+o3cZmBtNx2U+gjHn9SjKAzxE+vjP28Mb3qr8kM1SMBFIdFESY/9GOXjF6WFOyug
         qEgkwruBGaBNuYHe3SibEKGXTTxH7yyMrsSf5uikrIkymBoTyLMCAvt2EH/lOvT8AwoA
         sQwD/Cr3YcSpgsqIwjhL3kn+n6+vZa+vsKvxu42T9/xbODkh9aAC9IXiKvN5q5M2yGFf
         yOMS71CjRSJVkdhAk6bDYfP4dNFL/DKuSvW8Ra+JmxENiMLQN5gZCSVKekHdVoOssBLv
         5PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598168; x=1778202968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R3GKV+brGr8DBBiDlaEBUMrmzDGWJnBmRi9Q8SRHGU=;
        b=GB1WAtofpsg0FAbd7GrrTgP0USkFtJ636/KAs59nTSapt+jZ638aYogaWwcchnaaCp
         lzvhtISbZZW1jpL+Vu11DfbJIRwbtcFHSu+/477baSTF4v8BtZk5ZiOd6leYTTJ8uFr8
         c8cWJmU/AlIQNhOT8eq0OL7UonxhM/BEVG3C5ULqUyvYikZGfifTwx9QjPFvKHgLFVwC
         HoehMUxilMn6oEkbnB+ijli6OJBlQNvVp7FJYPURBpkC0d3nRv0uUrev23jresMUF6Zo
         nrglt4F9YbJqzromiM00EMeokmr9xGcSr3VCQN15mswkpIRsqdffETvz/0A4zp4EEiIQ
         6odg==
X-Forwarded-Encrypted: i=1; AFNElJ8mCOdes2nYHN7fPuXQJW5Zzumnn0y8BJOvq0PfG+/8v5AueSCmmECKJMnBW0QUxEVfx2NR9G3fPFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaOCmY34tiPFxPDmp5WAC4DrLSorrXDFTVINyicWrMwXKuF5X
	XMHebntiXrgYJbpnnocgCuUzt/MzZLTRYgx+hAuNBFwlgMOBXxAa2G0w5ZsTbvshWJ8=
X-Gm-Gg: AeBDievf5dnIWiallGIWwU6+L+pYaX/5dTRSk5WKxPnQP7Nnkp9qtU/gEy4W40uI0Wu
	z0L9xWPvMxqU0wZ3XvWWreOW6lu1/UVo9/GftyGTekw/Qkdykqv9fJcWwDkxQZ58U3M2S0ZtShF
	aOMt7Qhs2byzBXGw+hhJ6k9au/ujLUij0XeIf9IQedG7qpWiQT6hlnGY0JmvwksufmZoxz8OCjO
	uousQhWlaUvQd+7fo9/5hKfnsyDqdT56FPkDb6wc9NevJnzeHGf3EleXtfEi12FzhP6UjrQFSQr
	d7uK6owfogQMux1Tx6xMK9dCGWWvd1ewWen/7wcw9DxJodvvRpKvsN9kJ2C8higoqPxxZVRuwZu
	1qvq3PKd4zJsUQwz0aDSd+3e3xNX4RA2IY7SqVhMeLF/P9rGMYJmyEGarbbyH28NurPF+PPRR9O
	I7cDWW
X-Received: by 2002:a05:7300:a98b:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-2ee87680932mr390066eec.11.1777598168318;
        Thu, 30 Apr 2026 18:16:08 -0700 (PDT)
Received: from fedora ([2804:14c:bf40:2363:5316:5d16:72ff:a622])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2casm2472686eec.14.2026.04.30.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:07 -0700 (PDT)
From: Rafael Lopes Santana <santanarl@usp.br>
X-Google-Original-From: Rafael Lopes Santana
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Rafael Lopes Santana <santanarl@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] Replace manual bitfield manipulations with field_get
Date: Thu, 30 Apr 2026 22:15:46 -0300
Message-ID: <20260501011548.15369-1-santanarl@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Lopes Santana <santanarl@usp.br>

Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>
---
 drivers/iio/proximity/aw96103.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 3472a2c36e44..a8a6ae02438a 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -591,7 +591,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 	}
 
 	for (i = 0; i < aw96103->max_channels; i++) {
-		if ((aw96103->chan_en >> i) & 0x01)
+		if ((field_get(BIT(i), aw96103->chan_en)))
 			aw96103->channels_arr[i].used = true;
 		else
 			aw96103->channels_arr[i].used = false;
@@ -643,10 +643,10 @@ static irqreturn_t aw96103_irq(int irq, void *data)
 		if (!aw96103->channels_arr[i].used)
 			continue;
 
-		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
-			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
-			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
-			      (((curr_status_val >> i) & 0x1) << 3);
+		curr_status = (field_get(BIT(24+i), curr_status_val)) |
+			      ((field_get(BIT(16+i), curr_status_val)) << 1) |
+			      ((field_get(BIT(8+i), curr_status_val)) << 2) |
+			      ((field_get(BIT(i), curr_status_val)) << 3);
 		if (aw96103->channels_arr[i].old_irq_status == curr_status)
 			continue;
 
-- 
2.53.0

