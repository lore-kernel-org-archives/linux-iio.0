Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629103BB5A
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737464; cv=none; b=LIswDE7WMlHO4gKS9r95PmgpehgX6MXv+a/7qW48gxenhBrVLsd3PWudMfo+1JHEDpnVUzP2mXIWiFg/pJkN5A36nz42T5jp4JY2iLDtnOq6msaOPSm9GVyhQTD2r3Z4tK4GpPYaKp8g3kst4wQrFLpp3CcFiOWQQdLmV/W/fKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737464; c=relaxed/simple;
	bh=tPVyPWLVTrFxPV3TovH+azes/eTifQaaKa1dNcvGQZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iw2gPM8lsAnli12d0SPRA8QHzxdmKldRfTkIvQjsBhhouVfXA8N3EJUZ0hH4+9aUFCUuIW7nyzfULWgogKcVziWcQbbWtLJpgePJpbAul9K4MsDQxmFJmbNOfYa0cO8Pfw/Qz/XCe3QLqXcuoxpUOfoS2We/qZeXTfmyEc1bcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=T1wPsGSA; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="T1wPsGSA"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56adf76631cso1496319e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776737459; x=1777342259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxD+OF1//Q7XeAd2dzKXp0hdwhzefN+BENpvO943MyI=;
        b=T1wPsGSA56OPi9U8p1a5QCjo0UH5wWc6/qQqLPRlFWW2YjMhazMQhjbdjxkqIpjU9F
         k0tW2OPaDZgmeZ3Lgke9/fyx/3vAtcoQEvvJ0t0I4N3RkVFL8ZkTspqR+DmLfR4Mvkmc
         smiviFR38/IIXsurVC1G3xPg05v5JTaiqEwjl1/RyTWZbpUUR3mP/F4Vesr11Q8QTDAc
         tZhlYLNK2UecQXgIippxQifb6qtT9fRMq2XDUxFOG1F3R8s3zuOw81dSAMk+MsGAyvmU
         dobjyHbxkJmFozyjaEbX3+vc34SzKsZbSayxURTXvEbw5VFAUChFXzn8MyccKM1wPLu0
         Xu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776737459; x=1777342259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxD+OF1//Q7XeAd2dzKXp0hdwhzefN+BENpvO943MyI=;
        b=Kls9A0uGkOpOKq6g8UqPthqiwuTU4dYUsFG33Oj3jLHzfQAjD/uPYt1wwFcS/4cp/d
         DZguJzqk0VmxT6JyOYx6J2eymaKViLH2Benl5i6ndwwe6MV8AsIpKYMfp0RNvhj+OfD4
         tmQGh2S9ocqCJD+EITtOBNuvuOEqEFfT2HIpYRfe5uvDacC+aSwarf6GZdq8RV2fA2/o
         KflIkcSRRSarsN5FaomFrJHCwMzF115KeUmliiF5G8waC5huD2576a0wtbsQfjnKSv8e
         MUCzSK4CTTlBrPpHUHp9mFAitv7IV8VleEUKZAx66AmTv4YkCuNbav0R/NK4/SzFldYG
         ZYWw==
X-Forwarded-Encrypted: i=1; AFNElJ9KAc1gOsh9hbkx1RiFe1u9ZlHYZTJA8KnPAMVtsuaEu6G6Sr4DXi/7wVKsMdo88l2PN4SPTQsGZfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIrC92/hggPh5hLVlZBoon2Re7L44RtzeBeBmDkrWyRt3KkC+
	+ptCU6Jl8pC7fdGwP4yAr1CHFL+ismAv+YnKVXZGdGNrQLB6A2ZjA3T+lY/WpzhNEA0=
X-Gm-Gg: AeBDietr+FT0EyV3EbjwHvewR5gLlddTVo/We41I6s2DQvXxX8NWCzEaScQDUQGQFuC
	/GPMZyIAUqlCiG6VXIngPMQjLmhQgu+4VlmaSFva794A0Jdbtq5c2jdAbwov/enh21CQg9cjdt/
	mR9xUwop8eimQvK6D/DtnOaIyjipVR6vDPV2xpc66+FZRjaQXbBx1J/PbI5aFH+ERwSdS/1p4iA
	jIY/zrLEAwwSyhM+zhnwX2f//ImGl/ts8wVkA3Z2FsnvdCABB7jcjbf7x3A5ZMrH8CEbjmeNpOK
	3B7LIyX+UMIxDJ6JCh1UE/IKF8A0fqrS73G4zU1oIcewMpRFJRfNKab1trLYVv32HBeaSly+cKe
	0JfYs7zY+djmDZxsD5/izjakblN3BOIxoZl85JEke/ZRvH38t/PbasfPCESwpUF/NNA3+d1lJfg
	fpGPLXZELY2hTzEK8nNYTYNASspCR5AA==
X-Received: by 2002:a05:6122:8b8b:b0:56c:ddbf:57e2 with SMTP id 71dfb90a1353d-56fc6816e2amr3267477e0c.11.1776737459352;
        Mon, 20 Apr 2026 19:10:59 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm6932891e0c.18.2026.04.20.19.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:10:58 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] iio: light: ltr501: cleanup locking and headers
Date: Mon, 20 Apr 2026 23:09:59 -0300
Message-ID: <20260421021023.563290-1-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

This series cleans up the iio/light/ltr501.c driver by sorting header
inclusions according to the IWYU principles and simplifying locking 
using automatic cleanup.

Changes in v2:
- Added patch to sort header inclusions
- Fixed naming scheme for functions in commit message
- Reverted original lock boundaries
- Simplified returns
- Used scoped_guard() in switch cases

Rafael B. Sales (2):
  iio: light: ltr501: update header inclusions
  iio: light: ltr501: use automatic cleanup of locks

 drivers/iio/light/ltr501.c | 130 ++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

-- 
2.53.0

