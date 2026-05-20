Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039F3D3D01
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279598; cv=none; b=lU+X/zT1kBY3ayc1g+YLfKYuoOIlIgA58YAtSVPfhU4vrdW3qmnre+v4RuBAMbcrazgFrNRbWW/u6rRwqzNQeTwNBftfVBKH0TpD+OCveLPP/o6cQqam5z5uYM/PYKGvFX36vWgi2f01/uFT0iYIgOX0+aBmlOKCu43htwWQfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279598; c=relaxed/simple;
	bh=8xoGBygncwwy/m/+1rldwBNVyFERbPABvdymmXhWtwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5x3a7aXB1kDQPl15A+58MWoHuQRSLa93zPVviJe87+Dqzdx3t6XZbJen/cLw0lV4VeZedT7cbOdiWmwZ/x9KMeqbIBKyazCXNDIi5ID2Slan5nUM4vmmOlKOStw2I/DMMtCwTE5rzVibmDpj8SDyTZZNg7pD7+YXm1hhZgsGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBeqjOdb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBeqjOdb"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a41a9a97d3so403953e87.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779279595; x=1779884395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xoGBygncwwy/m/+1rldwBNVyFERbPABvdymmXhWtwQ=;
        b=MBeqjOdbNnUEZDN9wqp4P2C18o1rPhrIV1GPwuflbgC/4HdGslwOeNAQODNAv+nb8J
         733weu0XnBxG6uA9IxjXC2liKMKPj5bQMDBThfz54Vf3hTVQsnIpnzjDEYetlONsK2pZ
         P4UX9VlutpDeV6HBDukSZkHusMzcs5Hil+4jVaYEP/R1T2sBa5jwrPGihEpaBgdGFJmr
         0R9x2ioFRi86Uc+HpDL8qjD9u6IyahcVZZ+rwg1ly8jIHfekonr8yMJmzrphMBCvamsI
         PmALB167V3V1sQjitBRKqkbllDv+7wZ8yl7MqpC9NLyljPwB18b5Gk89B+21InBHOUIo
         6pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779279595; x=1779884395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xoGBygncwwy/m/+1rldwBNVyFERbPABvdymmXhWtwQ=;
        b=fcDkELX//jakMEiM9fKwvs8Iq6nn107qt98Y3uGw5X2Zl2TePv1pF2lp20MYcFE+pk
         ZUxgU47ysCtEPzKUuPcfT2RtdDsZM5SIB5jXhBIfPvSqFRoLlKex+/wM6XfQIRltkBL5
         5X5zyk8NkGjSLIV/y3NFUYHtWDpiHxaGxEWlxEgiKScEoeTuvEXhY7/OOJ2AsgPKsoi3
         bmuRXXPKYN+zixlF/DBCcnlVl2UwtJAfVsz7ysiZ+Z3QEypJ/kXUE5J6Dof6/k+i8x0S
         bTM4pSfem62pnFfTXgJp288FZ3IiOPe3ehF2/zIuDwoyxd9U9+MqkEEkiX7M5sycF26/
         xYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ba2LXrT1eChaSazSinNkAnuw223dE/wtSKEzo4Z4lHYb/kc2z4NUA5N7Cd3oeDA/7sPGjuieqgX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWMgItKkoftQsVcA3LNu4ceH6qmw+V+H8A8zz5fvkFJmMEa2E
	+6MuRHkH+0URwf08SV3ixmDab733va1WIpj9KY8CyiAFyxeIbVjx5u16
X-Gm-Gg: Acq92OEg1ODl0Sp/rGcvp0FF2mbDUOu4b8jttqiv4b6SJYB0FGa+XBEBfJXkY/U10lZ
	Vv/305TDHhqPJBdNZoSTlGfAdsWrJvZFKrAOhvtCZ8Bf9IsXXpanlNpvrEuBTljeRbZjF8TjSix
	/DYR7wR2sf1e92EU0F6SWYR0qAMex79fzbfQwnx09NvCGTWYL9Ve4PpglG86r93+Zt80uAOyd/v
	S+qkr/JIYU/koHjYZGDfpH2BpuaYwpSSicQ8+LGZSzS9/iYqGM0NSi1xMyeWW4U5vhpbckSnVz7
	Q30z0QXxCo5nnzDACROyulVPvkwEmXML/hcOzLx5xbtjLmqGJTcv/itf8XVmiTPOHu100/5QDus
	NJaQAJpU37EP5ngQCNMP8rX8M6lz0pAmeaQ1wsGREXoLH7m2ZIkOhwWCOQAG3rnfQ4f/uwbAAJf
	oFL/PtaKJonr+r7UcDTkJr7+EbQs6hcrzeb8FLda9ALHUUDfdfWWKuKnl3nQ==
X-Received: by 2002:a05:6512:1195:b0:5a8:6f01:e1a0 with SMTP id 2adb3069b0e04-5aa0e745878mr2562854e87.3.1779279594625;
        Wed, 20 May 2026 05:19:54 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a619sm4904867e87.27.2026.05.20.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:19:54 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: m32285159@gmail.com
Cc: jic23@kernel.org,
	tomasz.duszynski@octakon.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Wed, 20 May 2026 17:19:39 +0500
Message-Id: <20260520121939.15266-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260519131944.25174-1-m32285159@gmail.com>
References: <20260519131944.25174-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "_locked" suffix in scd30_trigger_handler_helper_locked() reads as
"caller holds the lock" by the usual kernel convention, but the helper
takes state->lock itself via guard(mutex). Dropping the suffix (or
renaming to e.g. scd30_read_meas_data()) would match the actual
ownership.

Also, the int arr_size argument is forwarded straight to memcpy()
so it is really a byte count, not an array length -- size_t bytes
would describe it more accurately and avoid a future caller passing
ARRAY_SIZE().

Stepan
