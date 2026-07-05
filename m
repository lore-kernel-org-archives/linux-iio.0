Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10D2F9D98
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270653; cv=none; b=NppOwsuCPOUysIQoWH3aa1ICLcskc+rwFgDZPQq0lw0V990ILZufUFE5XGme6RXgd/gLfAZHnl4zL11VMasGW8XIKvXC9oP1//Y7uJmdVUGWeBoftGGrVn/RpAT/XVTk72ffAMMKzSYFTovI4PVpfs7Ps4IkQN5rMNF52RuQamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270653; c=relaxed/simple;
	bh=P3Ks4mocpdIEXUivuFMkzFbV286Z/TWBxR+6eAPxe6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q14OQiycQF/04cpcaEkmVobQFmAdWpf4hNCBNC4CHCFNW+DNVoJ7Oix4agxrKPo9KxQTJXo1UvHIxavwHAO43qvD1GEi1LBAAQf63nEEueNGxIkMRWc7zBpkKSj65CBzuX9wjtRVTG6jqC9e/PyHgr2C1uWDK4Rgztgvf2VPFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDZeRDNx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDZeRDNx"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b27c7451so28958815e9.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783270650; x=1783875450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3Ks4mocpdIEXUivuFMkzFbV286Z/TWBxR+6eAPxe6s=;
        b=gDZeRDNxDFZOE6TNPzBNHeGmvNoo9fJTM0voyDlRuuk8gfwZvnfWTZMN1Ze8+mfaTL
         oLRcTObQrnDCemv8WoT0gjd4jWml0MTTMSqKTTf1t4cmoq/6SZYuCkN1pQgs457OkVuU
         pqyyarnw8N04oFblFGdvd4ghSq0AD5M8swRAprnW8LgkNdbhe5kg+Xt2vhZEjbhw9w5m
         5TGWfbqMcuoEBVgMKdUJrOOxT2UYJQGf4UfB4v+neHUo1d+NHTmc3ASOTPVKZvhKZKt/
         1tpnCEhbRIKkSILvKSQi6QSvSl9XHCSuC0x9opRTJ9csAcJiR3opmO4gbCTtFm1DWdXG
         olYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270650; x=1783875450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3Ks4mocpdIEXUivuFMkzFbV286Z/TWBxR+6eAPxe6s=;
        b=M+zhrKPLuR4UCIC/3M0MHBxQ1VxemmKYumA8zDb+ahSCjTysPdtiL4QBU6YBV2W1Ul
         tZsr95RwgwEZlPOPL+qUpSrGmjyHSgBBHt/0H0EjDXqM/79DJlf6P5MYapf+S/IvdmKJ
         kt/p2nzqlC7dCK9iSHm1RF4mQR8zIXbElxfqWkEEX7C8clpuV8Xx9IPDY1MUkxp3lAet
         8Uak+u9ZTxO8A63Ioxt0lxnh79xC/Qglin1W26nrSPO/6KbBDJv//xmVsHrnBEfjo6bK
         cVJjJxfO+Xl9UkIWoyrDLr7aDQxMf5UpZX+mSPOMRuxoIgPJRkS6eRBVyR5dX8FKaKkE
         VSUg==
X-Forwarded-Encrypted: i=1; AHgh+RpVxMZUdCih8wq4E2ljGXDBSr61N6JyUooDdWfUNekfMCjTWi+pSe7k6VVN12Jp+z9o+13DAtD6Dl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd2Q60ZTASGeAcq85W4YaH2zSiz4OVAe0rCiZZHJi8V5gXL+X
	JmIO84vKP46gOkXDES54XMwLRGaABCJ5f0Ok/r6bC5ZcsAmT9khx/AJ5
X-Gm-Gg: AfdE7clV1yKCccrn/LnK+FqcVmQWWpcVozjltGy65QnZ9JWB0BWHYZn2KCllSRTfIOh
	kMS1qI6K1b+ofs8SrLwYaB7NyykQE4+xJm1MyI5EBzhY+SEsrJxwyCpF766zdudR19T0WcNn1yN
	Q954eV7Gh9nvPl6yX/2RW1DPHN1M3u6D60ZIPdAT/TJCwkmPyyodDmVX4nLAoEe6FwNDdxGpb1s
	GREl0F/NIoQRdd5Drv/LE7Si2XR1eSOEHPPT2NMCoe0XrgTrAvoUxBHdU1qY3/pAbtwG80Rtjvb
	X1QV5o6//oN3Yx2aSi/qCkHy6AWWnchrr9hFCuSa+p46Yvf9J6AOE2Qd84p+fsEsfAEgaAzNnyH
	d7M2klrEiFT8zUFLUTBg8DXOzirBl3EoL3L7lOhm8T+pdh8FoYO6vlRdWXbdjc/WwXyfTiXAfww
	ECeizWegtzk6m6gpns
X-Received: by 2002:a05:600c:46c4:b0:493:bee0:4360 with SMTP id 5b1f17b1804b1-493d159b8fdmr65120135e9.17.1783270649788;
        Sun, 05 Jul 2026 09:57:29 -0700 (PDT)
Received: from avermoal ([185.13.176.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce12c40sm363764965e9.13.2026.07.05.09.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:57:29 -0700 (PDT)
From: Mikhail Lukianchikov <avermoal@gmail.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: convert Xilinx XADC bindings to YAML
Date: Sun,  5 Jul 2026 22:56:20 +0600
Message-ID: <20260705165620.9818-1-avermoal@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d7607a98-f5e1-417f-ad64-d0029c9de662@kernel.org>
References: <d7607a98-f5e1-417f-ad64-d0029c9de662@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Convert the Xilinx XADC binding documentation from .txt to YAML format.
>> This conversion is part of the ongoing effort to migrate all DT bindings
>> to a machine-verifiable schema.
>
>Sorry, but what effort exactly? Where is this effort documented? Do you
>have a mentor if this is some sort of mentorship effort?
>
>And if this is ongoing effort then don't duplicate:
>https://lore.kernel.org/all/?q=dfn%3Axilinx-xadc.txt

Hello Krzyszof,

Thank you for feedback.

I'm the newbie at Linux kernel developers community,
and sorry for my mistakes in sending commits.

I'll answer your questions.
I am not part of any official mentorship program,
I just decided to try to contribute to the development of the Linux kernel.
Yes, it's a ongoing effort, and to be honest, this effort is the general
community initiative to convert all DT bindings from .txt to .yaml. I didn't know that work
on this file was already underway.

Tell me, should I continue working in this case?

Best regards
Mikhail
