Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805030C157
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427922; cv=none; b=bcMoGVKTy28lN+wERYFakdfZWG+E906hujWCPkAP+HaFKKUETQfjqCOoeWfvMV1Ds+hpM50p5Ne6xJiV7v97Jz51jmuPp7yPvi/98N3vOwZKtsyser79HQUL32C1NJsRXmxxAIjfqHPFuwCe0TacVMvXmerSVe8hpwbiLr442IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427922; c=relaxed/simple;
	bh=8Qig20Vn1Z39mL/aPI0UZZpoHMcdtsF7kx5Ekyaw5xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+Pxjooja568Q3Ezn7Y+I5zq4A3JB+ILAJd4+8Gyk8weqR1W1nzoV7WXhvdlNL22YpAGJP2P/7kp2EptogsA3ZrTvcx4HdeBDWAEngvxe+OU+Y6xLDba8XdURZWVqBb7awgQo83AWpoplvMw+weOXTVmmnFbWrweK/X9Z8NYbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaItmTq0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaItmTq0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17659735e9.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787427919; x=1788032719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qig20Vn1Z39mL/aPI0UZZpoHMcdtsF7kx5Ekyaw5xc=;
        b=UaItmTq0/aOb78MI7RCW+m3E1neKc6PiOpHa3+nfuLYPY1cL5nsFJrV1eJSh9DGxq4
         52+DoJV15yssFXrw3aMNBU53p5PAoRCi8XaeVKIfiHj8kG2wzCC0dvPqEH9y70AYPedR
         uS2Rhfp+msL6RNsQ17a2F65WqFOmhxkjytZTZBDky5RvDLxuw9dWHG2dOF2kBL2EyfZ9
         ZJQQPG18corrP7M+Paoea3nLs7N8tppBEnmgAibMnG+FSkdWUq9Eq3sxz6NytKzowQPD
         eCBsg7KT5gViiMbRpq9zwGsOSxQ5atgNmA1y1pV9zlAn/ZccVoTlzmGCqYZPf5veC4hQ
         IOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787427919; x=1788032719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Qig20Vn1Z39mL/aPI0UZZpoHMcdtsF7kx5Ekyaw5xc=;
        b=Q5GlnvtYwLBGasHpwf+L7dFq/FW+H/vx3wLxgEq89q0lxqHSW2cfXjyWXhM0TuN2RQ
         16lKXjCdCRuFPq0i3eTkCsx5tUDUZOO3EtQS2fkErvfoRb7E67kK2X4WVQKpHowokJt3
         SniEUzM0nHgWR39TNuUvPNJ3idN/1aPNDqkX1vFsL5OBeS2jLtkeMff6a3lMQWkDHLLZ
         FplScnixLKFoDm5npc2Q3thMaD2EW3yKcq9fc/1gtbmyl+hlLdvdYF8npNmhsiAZN+Na
         M4r7lk1KsSHsl+8rdP2E7wBQTA8eNqHXqql5HWeAxw5y2O/0fqOdBjLnTX3YA51AANfG
         cW7g==
X-Forwarded-Encrypted: i=1; AHgh+RoizfxRqGuclPUXm5nY73cYtJtx0M5+yRRNiCK7ZoPe8YZga7g/rInJpusLvVhi9nwvlapGByfgse0=@vger.kernel.org
X-Gm-Message-State: AFuF++lziqVW0GIPNqNXW1RQUf76taDddSjyuztnI1fk9O6Jx1U7UR6u
	lxTV/KA73NLjGchW5KPFTS+zK7X8s8ByHGVBRbYpvxdD91I73m4oVvub
X-Gm-Gg: AR+sD11tB7NY/t0p4JPkB4vZkC6VDE90pgwWSZkyxKnFqhaQ6KGmZCA+xhE0YjhZjZq
	ChLaAEwPCdHGP6U87CAIvZ7ps2kTVozPf1jTfOKs+Kk2X7RsiRJACNTSK/J06ol1o+5/WdH4cU0
	Bqt1OKIAT872jgkvCcVtMTXvNRNgK6Shd/hU7tzvpR52j7XRW7/o8ZushLS5O12HoJxHqGEJ8uc
	R5B3OUeM5INDs/29MertF9kY8+YhCXzvqoE+KxQnnucbFNEcRoZjb8EKh1iT02JE/5KB3ThU2QO
	PvIuXdqMBOozkqGrN2CHuA+Nex+CTJ9OcxcwzC8Fj7vXvlf2gyAWWzNnmgAlEKj1IQGq+oSWySz
	pCXwIVG3yO4i5vex3KwPMLiJDlcb4gqYSGxKrdVxnw3Dy1qNs9Omqj6WkEEEfGbzeSdkjxTIjNM
	/s/z5kZ65HMpVICj9tRV+YRKLJMbLysLqafTF60O0zGULZu0TohBsQp0ESSHN3+oJc/Uwtomfzm
	gD++QtMgQ==
X-Received: by 2002:a05:600c:608f:b0:499:a4d1:d7d9 with SMTP id 5b1f17b1804b1-499c19d7367mr69091855e9.9.1787427918747;
        Sat, 22 Aug 2026 12:45:18 -0700 (PDT)
Received: from fedora ([105.74.8.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499bd581a49sm31267215e9.1.2026.08.22.12.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:45:18 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: dlechner@baylibre.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v6 6/6] iio: dac: ad5504: support scale via output-range-microvolt property
Date: Sat, 22 Aug 2026 15:45:05 -0400
Message-ID: <20260822194505.20389-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fb0b857e-eac8-4755-9330-5cfe55523271@baylibre.com>
References: <fb0b857e-eac8-4755-9330-5cfe55523271@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We should probably handle range-sel-gpios here. Otherwise, if a new
> DT tries to use it, it will end up falling back to this old wrong
> behavior.
>
> Either return an error here that it is not supported. Or implement
> it by making IIO_CHAN_INFO_SCALE writable.

Thank you for catching that. For now I'll return an error in that
case, we can always expand it later if needed.

Best Regards,
Taha Ed-Dafili
