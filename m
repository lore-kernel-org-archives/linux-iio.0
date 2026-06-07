Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C883A3E87
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780841689; cv=none; b=rJ14X8xLu+/ykieD/Z0KR3/V/ruo7C7ks0Kcei4gzbGYG0VDtzMudwpFJxrTj6pvFWnsX4LjxbxUBrp+2PhtZhtQaOjaAezng+b0LaGPs+4xW2Ms/eb4L2MSNZr29GLAOUmBvfgbl5MsHtLq/bZx12Vfiv9RyMsJJn4goZdcNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780841689; c=relaxed/simple;
	bh=P+Nb6j8I2J5+FDadA1c859H6p1jpbIiLjEm/gQu2pFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tL/hVk3wysPWUn97J4Rb9zXIVwysB20ZIqSe8RXkFOuvmPs5qNXO6AdvTJKhHt3rSFMNj+BGmNEyg2gSsC0iyjTziaB+3UXkU7VIa5M5gwSGJaYMMauc5/SCNI0EyGQrX+FTo4YGRwuE9ncaaA2LBLP1mnzVPX8+tisVnLHmcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvZgXppI; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvZgXppI"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-3075ce9c05aso6147197eec.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780841687; x=1781446487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kuj8kQpIzGjU4xu75a8AvJp0dubB+cjh4hqHihfF2P8=;
        b=gvZgXppIKH/zQVCNzkiYqBhkicvXC0M3oV5DsFWJ2yV06berPS7WdOqm6IJ7WKcZ8O
         Zn0hbO+cwvF/eppOzjbs178U0c/uCFNBHZIFp3xrUd4e3iUmR1XsrBfuJXKCBswsaMwl
         oAeqnklOyxBdgw7TMQq8dNU8N1nLeszsx0zd05DuIFtxNCz7bK3GljQ/hqAfUdCM+C7C
         v9VS0q15QEXZZUPM9t6AmIKfkajgbaHwlcnqSgqgkn3TwMCtYMjAq2Lo2eVUjsSl0u9w
         MbtivX6AjbNTQzyZOq8gUp+0gVTK6kTbuJggFnZnh1stKEiAELabnSKWosZLiBI5SlDJ
         E/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780841687; x=1781446487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kuj8kQpIzGjU4xu75a8AvJp0dubB+cjh4hqHihfF2P8=;
        b=mEUACgc4ZZrSYsD0uxPVSlvzvjnwZWBhlS3qKPzDL43KPhRI/sS0s6V2MNUM9B0RNR
         9Rg+/PQHQ0RsGg32YN8E9v1e29OiCA0WQVjwCZo6qjHQ1DeOKhNSs9cRjIlrOtYffYqo
         +CTqeYMHx6IAXHTTsifdDwDeUBhNattzdwUrDD5MvkNu0WoR1kjNVXn+MqI+lXYz77+Y
         9+3u0jj7mgvXTGYVGpBTakmcsYU2gsO0zaxS1o1jzkxgEgsWsOALL/5UruOvCd+pVNZT
         5wpAcLk9F11JEClRhXwxni9jUqm/2qIo9JMQnUMbF41HV1LaxKkRnowo9vOvfGpyDY6I
         hsGg==
X-Forwarded-Encrypted: i=1; AFNElJ8Got3ud6ytKHtFCwQoVj5gh+qwL0D8+1ygXAtCvQG2+iesyq6SK3UZTQ+SS7DALP9iuhQS+BJJviA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUdBkc9yaRdhrc7dQyO2NBUWTrEqsRNHheu7lJ0F1mlvX3Fst
	4xTrMnKVnRkn536977zetTkBKLqJe+PzOpUXA8aHN1GJ7Mf5gD2g9lQh
X-Gm-Gg: Acq92OFHE4FK5RUc3dEdbtHdsdYCYjv8FPCbhmDrKtAziNwLJs611xvniBNf3wMqzGz
	9VwbUZOT0SkaXedsJf0ZWII+vopsWm11HRkT/89XfIbyObh/wXqVRmPNq4aWMYftJTVFlc/4moU
	EzQRkKg+NjweLFDncE70WqrcQlxuMIxYucZqoaAgTxg/DVQi4N2Gc2ecaNdpvk0ZmROINc/a47A
	M4H4BomnZg4IS5ECbMZaIweQVeTtmb7fOctWf4mqun2PjhmFbePcca9DQXcZz7kNx4RobSslMqH
	SoJPVPjwvzrslBMSvi3y/LNmhVJtjNqnEYjaAW22Li9M1YfP0XvkjLkFz18nMp1yZNzVBeEwPIq
	APWu2znF1A1Wqa47QFpfk7g3u4kVy9x+IVCH4h2PuGerNrE4KjeMLoE10LzKdO6VzPeUBAWdz6y
	Sjm5vk+Qh/nv3hyrIK8OU0XV9SyPBbZdRWwyromGUT8dUygQPuL+WkEAYuTAeaaHZ3rw==
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr5783472eec.23.1780841687119;
        Sun, 07 Jun 2026 07:14:47 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm13472648eec.12.2026.06.07.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 07:14:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] iio: gyro: bmg160: use __func__ in error message
Date: Sun,  7 Jun 2026 14:14:35 +0000
Message-Id: <20260607141435.60229-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __func__ instead of hardcoding the function name in the
error message.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3275..8cebac89ed81 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -313,8 +313,7 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 		ret = pm_runtime_put_autosuspend(dev);
 
 	if (ret < 0) {
-		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
-
+		dev_err(dev, "Failed: %s for %d\n", __func__, on);
 		if (on)
 			pm_runtime_put_noidle(dev);
 
-- 
2.34.1

