Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADB3DD538
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276707; cv=none; b=AmE2bTUu9b4X5JsqZKj4KveiLgvRJzPbMFse6p9dbqoWUomE0JZldMm1raIl6JrRDjhItfwPtaWeGWpDnCUvyxEDHpWVwQZ1433qdlb3i6VnaQL9bt0Bx3scBaMeqM/ROrb4iV5tMP39U15oO4y4lt7jBJ4CSdDTuTO3CJ2ttd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276707; c=relaxed/simple;
	bh=H23wKnpBFeeUjfAu5POCn3SgHqzmpXZ+i3e2+GltQVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvGW+WMXlEKmb2WJA4/o5/zOuu9n8Kgiki6HOdvLZOH8Ib0YW1ltrpih7SyuHjOEF0kj0SbNyCnZG0LEsL4cXOYVIqnLeTbbvznHra3q1U8yZOCw9sfUZ53Uep68GlU1wgDtAZiWF7GYs/ZvWvIwOVlVxCg2CTvNrtx6BXCSqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwDy4zZK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwDy4zZK"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3937a1f9f7aso5778561fa.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779276704; x=1779881504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H23wKnpBFeeUjfAu5POCn3SgHqzmpXZ+i3e2+GltQVY=;
        b=fwDy4zZKa+XqYnFLJa65V1RwJIvzWEZvlKsOBx/JCyEfe6g0wkrnKyjXzVskebIoGu
         H9aZd3azEVX7ezXH5KKot0gf1i0K/nNs1LVbhUc802l09dpn4JwLVqcaCIcZ6OliJSVt
         uRkKW63rQ+xqLM/HnGhm8cN8MkHW3IkbEgUqX2XuPYxSGvZZA5V0wvgdNAtTRimpITN2
         Rlr7yJCmAJo6nSNFi4iM63pYXteC9b4cZHJjZ+7KgEwR2PNh3onBITMNnOzO1kvnx43k
         AxHJxdzq3aNTg1fuTvbQN6aNJvAderoj6srsusAYQhDbp46TYUYAC07APNfPduuGO+B9
         jJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276704; x=1779881504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H23wKnpBFeeUjfAu5POCn3SgHqzmpXZ+i3e2+GltQVY=;
        b=cCIoZJdtNXpslEKjK0L1kFbYIMrNtFOE9AlyZ8gBOhxD3qQniYkkCCKiXy8DxHJa0E
         SdieYblflqWfae/QkwWFjcw+8BeBn3QaN/FJMMcN/LGiiDu6Pf5yPkX2x3Vr828Dob5o
         X7uLRzSTuVMrIyOVT2p1OLk7vlDwL5+OL5AFHgmRlUGTsymHN2Kmdnvs5Tsu+Uk3AP9F
         yw16hIHUZs4xLIDKFwwvcJgmmqZINfIJpXitHZrFKY9aP33C8CBpwPf2KGLhbx0V68Ub
         o/ioUwG9Ta615md4m1MASO1DlgmUK0InM6WGtwe15vHU+B2lDqFpM2zGWW5vJK7WlFei
         jZjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YHIQKEcWjNHioPv8TJgyhSvQ+8pZ1XqsvNImoK2Vj4y318Ae8gORGDOqRIRZZ3g3wQyq9vVn3+co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMBPxuocBFSJUXMMTV203MlplxdGpxdSlRIUsxyZcCvtR4OBH
	2muBM8KpYyM3K9tQ55FjuaccPFGgMhZqJKiCzeIlMj8YiBK7QAKWbJjT
X-Gm-Gg: Acq92OH+K5VjKsZa9KxhjcHGF5swyoVwvzb9RVPVrvj5175AE/60zPTPxT6bFVvm+yz
	a+gZ/2u1hm0mDWP+dsO1ukUwaQRxgwPbVDA2icZi8cw9Z9sO/LNFK01GB41C7Q1PK1k/F7WstBQ
	f/vuADzhWWHNVOoGooY9fzPCA4pjW7Mu3VY3anYLHrVxQiQT+ga+QLddkkk34/WHT2smUEVcVJg
	1Ee4i89uOBMxDCffzo/XBP2tEI57KkHRJOOwskiJXck/Kim1IKE1CVgEGTQxLEP6sRLogVP3r0t
	kpnEJt917dZSfXq55XAeD3mYfzOrIDzcv14teYwm4M9V/1E0AL3R9jHfAvKuRTsyDRbDKRuotEL
	aJ1i35BqNr/63z6+vObEbjI5MAttLKktzZfytnQIUb3rB467RA++fff9PtR4hXCLFOz2Vv4C0y0
	CH2iXAjo4uxxBPtPUTjyuBGamjr4Njz/TfABduyHCLPsX291lLfJz9k3cYkw==
X-Received: by 2002:a05:651c:881:b0:395:9f86:b433 with SMTP id 38308e7fff4ca-3959f86b5bamr13522081fa.6.1779276704112;
        Wed, 20 May 2026 04:31:44 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39588790604sm28518581fa.31.2026.05.20.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:31:43 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: xinyuili@126.com,
	linus.walleij@linaro.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: use devm_iio_trigger_register()
Date: Wed, 20 May 2026 16:31:30 +0500
Message-Id: <20260520113131.14599-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260520110437.13955-1-sozdayvek@gmail.com>
References: <20260520110437.13955-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just noticed Li Xinyu sent the same fix earlier today:
https://lore.kernel.org/all/20260520032447.1683688-1-xinyuili@126.com/

Please drop this one and use Li's; I should have checked lore before
sending. Sorry for the duplication.

Stepan
