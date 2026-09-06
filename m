Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33933A963E
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710327; cv=none; b=jdFFaO0hD9b0NXCR+whxRKP37/wuf6iM+63lIfBZOvKNYRLB2pbUAuRtjEhxsSnSGOhlXHttkQje/NZhHFHwgi2DCRs4cRHvsGGcZank19Y7x5ueWS2ujFo6S7cnHe9tNynhCMhHjuiCUXIRNo4jdYDXunEaaoWdrC09Nn/OoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710327; c=relaxed/simple;
	bh=K8U4gG3AQblf7ICtp1xRLfTb5Hvus1HZE7hzEe6OtnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X4MjugYMjzImt7k6vkXK3OTSINNnoyq97PjWnkQjArBallbroSI8a2MVHPdXg99RCx/kV9R9uR64rReoI7vNRWuc4I90CYhm3vWUwGbPLpopTmuUH7tXcPWYeycJWI4E68GTg9XrIkOTYYKsgX1ixQHS4U0wT3cRNBasJ7pyuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/5mrscp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/5mrscp"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2707651a91.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710321; x=1789315121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/dbxaiPStg/QuX6EVqwVigaoYbaqasF56BIGaXeKFQo=;
        b=E/5mrscpWeXAtn4F8L1jTftEr7PkPzCNYA4x0LVYiT5kYhtXaPaZ+UMTZMyw7Jnabq
         /iepuBEtZjw6eIhflgSbtpGMFC/I6ZkHT0VtU8CEqDG6reo/z/gH0EozDF7JR8jIpiXz
         YfWLiAqqU7EExCla1GNy58dUb+DaU1I31USzZRMOBLyO1w90mqP+YN1fpUnAMChdGwfV
         GSqpWKdgx+pdB2PPfM9e72D9UkYiTUzdJQ1czP+N7EIRXrJPVK2nF7EZIyVmsDVDHxGx
         817kmKTrNuSm5A3HANzJJ8XRAJV8vL6CQ1pSOyFUn5VYZKUd6qw9jLr/zJ0CcZfkmpEc
         0B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710321; x=1789315121;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/dbxaiPStg/QuX6EVqwVigaoYbaqasF56BIGaXeKFQo=;
        b=hlD2srz7YDckUoPXJF7E9XxJy8/T2XcPTj5TRPQqZEwl/OifW9iyGRAJfQmcqA69PM
         SuHhfPkz5NCaY610sWYynnuLtxsrqZCUfNrrmRRVxOiZYAHYabzXpIDcjy7mE8G5xgAl
         Ryf/EXZrvOW5TupwgPRjGSa0JlZHQe7Nf0/u8ANcf6/zvvDh4ReBWwnyXwGL99kqg2M+
         a+mBiheqN3TnDnFwKf6krnhDEK2qOD/Dy5KbhzyrB4hgtrJrJK2doxJiBihi3aOpmAb7
         AXf3eoXfSnWeTKIE7wcUKSf07Tdkz42B2m91wVl9W1krSpbwz3veh3O6s64THUNi3F7+
         Kw1w==
X-Gm-Message-State: AFuF++kLPinVTm3IsVLZUMKs+AzgYDyBrp7qI3xw9DSpoJxzQ8yarwD3
	9hm8AiPGNFk4Lx13Io4pB9x/rQGfs6cOZ7VNXcL+IVFd2IZNj0JHpjoj
X-Gm-Gg: AYBFou0sC4oRZGU0erlMO5PrDnKrP05hI1ts7CvMnMhZB1A+0Csh+C4myWCJAfaOxfB
	i3hXbfu5y2AYQNBawxIizs7bXFkEObx9ClEPDO562/RXhf2J8QjYs37REM/fdOVvidfyRsqT4Xs
	o+7B+tSDzfoSH1s3lAD1se/S1N7T1AONYbFKEt16PBNgsfAW9Vl7LXBN1TV/FZJefrbXxMOI5rf
	LW0xq8uXkrDTgKEwEcw9Uwfflh5TsDbtg2dGPEIp59EBLdrPFfKe5AhUGTHvqu4ro8pv2K9I18k
	Vsu2z40yiP+EZjcqOvOf6/s5esKQRlMrD2g1xbpyxMZtqbx8uj99fjtkYUHBvKlRYNGGr7t3Yqy
	cc6B53MnKghGcAInaSreQW7DC84JleDBYmY0ndimmiE3G/3ujv3MNqmYxWsb3MGryqD3LEY3ZLu
	rtMMtdNkFmR6aDFDpYYl6wki9NBgBXXq2V41YSfj4Jak2+4nTY/J1Kbp5e/6R8+yzRr3sQivCfa
	iG+HPpANYezAHuF3+AySB7xdgfaNxc2ihcilHQll3To3fbcTs1olp8xMn8ahtWKWRc=
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr26240194a91.1.1788710321449;
        Sun, 06 Sep 2026 08:58:41 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260f64ecsm15941401a91.8.2026.09.06.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:58:41 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] iio: adc: sun4i-gpadc-iio: two fixes
Date: Sun, 06 Sep 2026 23:58:33 +0800
Message-Id: <20260906-gpadc-v1-0-92d3dc8ef355@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMz3fSCxJRk3RQTwyRLM5MUizRDcyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQDWtQlxaQAAAA==
X-Change-ID: 20260906-gpadc-d41b964d8f17
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Quentin Schulz <quentin.schulz@free-electrons.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788710316; l=477;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=K8U4gG3AQblf7ICtp1xRLfTb5Hvus1HZE7hzEe6OtnU=;
 b=KKdnvVHGc9z66Nr5HNx4ntRPqRtsqEijnBCzDHcZaEUJXlQxGGQqVwgyS6ym5BVtkrrzwfg//
 vFo8QEpNRFWCBfN3nxQpm1Vo5vSvRI+QU5qCcDHZdotA0ms+izqTQNT
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      iio: adc: sun4i-gpadc-iio: drop underflowing pm_runtime_put() calls
      iio: adc: sun4i-gpadc-iio: clean up on thermal zone registration failure

 drivers/iio/adc/sun4i-gpadc-iio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)
---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260906-gpadc-d41b964d8f17

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

