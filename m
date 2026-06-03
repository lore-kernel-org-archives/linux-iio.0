Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D524779A5
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495735; cv=none; b=V918SBDIE+jHvVWrtWve3gvXYQmjdYAsQts0MF0YRy6WS/tRLaW0wEdQ5KrPt/zZNp9n/i7ZEL9/GdYmf8NvZ/jDNPPCdeww3hEOFYZ/2aaJYyT8du26RFCgRHjdRz0uQSIhf2LzHRF2z22wHWWvmOSxEEpbXOVquozoft8gs/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495735; c=relaxed/simple;
	bh=cNitDgpG+YYjAKvK7VvFwa+o4R38DcEMH86nv13E4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzQlzXYD4XO8Mqe8MlOu0IlmJwQrNbrsUAu74PoOdszc5bse4MWXRY/mFnORBf0Q14Evd0/UpXp9SmrR2ys2a1wUEDk/oHo1BkbdmKl+byZHW5FOt7TJV+BDwmr7GY10+bJSUbWZednG39JsU1RaMoTU3b/neFeAaSvAKpo/x1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRII+2uQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRII+2uQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so464225366b.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495732; x=1781100532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmb1yX4mP1Uu8kbitSMZnCcGiRxACvqmJQFx0csOrFI=;
        b=iRII+2uQUaJ1TcR7UekAIe4idzHIsG8tHgmdUYr2iSy1gx1x4WVamjqCnxuyMMezrE
         KBbXgEu8yr1yjdM9XH1GuzKJJvLRpYN8lccrSmbzQjVEN597qqiGhKlYZ1CG/uUeLJVV
         T/vo6A0d+mjNaQjaXr69T7hIuNY2TYW/z3I/zEOckvK21j4Uk4X0QX2baAQxLqov6Pa8
         08//5p66x9s0TRd6aKkobcsIDSBIvdMgcOZdWbdWNSmKt0vCNlVwXpbyDLvxQueE3LON
         LDLN1wFGyRDI7S8orqLzfa+fJpvTiQwfHdm0kcKr6huRl2fVPudMIZfVPFgR/ozgIbfH
         gUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495732; x=1781100532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pmb1yX4mP1Uu8kbitSMZnCcGiRxACvqmJQFx0csOrFI=;
        b=DdZcxXCoKOzrA1WGePRVkYdLWL3jra5vzNkQEHkFBkr+rvsRfz8U4lKn8v6wHu176F
         QNS6u3fBOBLlXqFdwttzQTYM0bQiBhZb1Uc6+S4edsoUarPCG9FrLbCyn4UcE0r84J8v
         YjtnUquxJRC1p80Kp4+d0n+xGabGk1NrIzSdAfJfSJmib9B15/H4RfZtEHdvZOWEmnTH
         8fVVIn7RYSNXPFUER3jWsnU6rcGFm5DUljzxhc30Iv6CnEBj/zyu4/IfESkfj58C+ZIz
         t/u2lsL0RzR8yfOdu8xovHReXDSvriS8RCH7+/Ycf95njPxSs81MM3ccc5L4D/GqDuxJ
         7Mtw==
X-Forwarded-Encrypted: i=1; AFNElJ8uOwoXuJ6TCZmFMjiq5CSlmxDH5NNwkFX5q0Mu3+obAEhCXZqaATcEIFddpb3aj1wmJIDdj1N/bQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBiZrcTVgPsRSJ/bCu6XtXvpmRjHDzCM3c+WDxzdS6++RWatm
	nm7u7Neq7geChFLcKdUhwdIgh8+OSBZli1UqHoiYZHeB+ppRJpoYLB5S
X-Gm-Gg: Acq92OGyDZn9EfiARmZrg7KmbDeiveVrPBd2XgB14WzJ0ZXty/g/caIdL2G8XQ62iCC
	P4NJ8M0ImUT6+nK1TNYXD5qOfyiSPKxm3ZY6vcT4yQzF3iA0eDb/3tfRXsWnDJ3hnAqulOszu52
	l2aNENwL6uV6L9CAk26X7f8s28WN2/TXxFdGXDQe2kTBgY6euPmEMzypK4aPT0JPZEB0Ko+11o2
	1eD81Ap0KuU+Q+gLy//jdw/Hd66afpTIzgoJ2ChqDqmHpYgQF1lkYUvzT/3SXh+BlhnK7Hu4RdS
	78sFFw8Xa5ayIJ2Z2kuZEb/reSWFfVgdIpF/xxf1OJuxjv9OiyCHT+OcEzaOp0wzHBxwq1Fk9M+
	krOlk63oQLaYdt7lKoz2E5wJDjeEAzKHnmiUUBsGsvHwD2j6odv/idCvXNpTu0MLz3o2UeecTp6
	bIe3yhZmuiIfaAl6Y/4B2Alp+TKh7Ei3u2GGLd8fbxTO/5hK2K9o4YvjcTsJNqgAROmH82vdOMP
	HQspLUPtY2QNS+HNg==
X-Received: by 2002:a17:907:c10:b0:bed:6bd7:71ad with SMTP id a640c23a62f3a-bf0b3ea64e8mr183726566b.49.1780495732295;
        Wed, 03 Jun 2026 07:08:52 -0700 (PDT)
Received: from fedora.embedded.cmblu.dev (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1ac0sm162062866b.62.2026.06.03.07.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:08:51 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Wed,  3 Jun 2026 16:08:35 +0200
Message-ID: <20260602-slf3s-v3-reply-08-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com> <20260530205435.37326-3-wafgo01@gmail.com> <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 14:45:08 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> We could add a mention to the IRQ pin to make the doc more complete.
>   interrupts:
>     maxItems: 1

I would let interrupts out for now. The driver is polled and in v2 the
feedback was to not put properties in the binding which we do not use. If
later a board uses the IRQ pin we can add it. Ok for you?

Wadim
