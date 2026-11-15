Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767995;
	b=5bSeV16FILP0OmvA2Wh8TF9fXJUlC1/zFcoaVQHzwFl9DETi4Ca+qGq48gGch9tgEMb2
	 MGpPlMnmOUXeOIlFJfE2WXuyM7eM1ob/mBSx5TMWCH8t4poSP3oV6LuWAD4Rqep2/NiPS
	 sJOqSI2e9Kjr3aSrU6CCXU0+hlG4zwAEw+SEQvm4/wZNl33vzu7IGDX0m7OT2Vn3PtPKo
	 BcqpScqzJSUn/KSwdnP0mSCQ+aNMqsW2hVzGjfnkdSAPIcqVNBspnMSI8IZhqVPutzr8W
	 N7+b+gXIKpTEcUiEg7WP6Hj/IrEX6i8XpI6a4Lx2LmjLyLgIehD7MJEIB3XQx1JgGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dlZpADIpQe7KCMb/+6RlQ2VbIrVPTUiha7CxAd+TEZ8=;
	b=NzE/AhlLeqceAbXWmc/B0gDGr1z5XOK+kuFp97ttRtUdwUSWCbMnXNkAaZ0vb5VQ8onD
	 f2bptmmDlsVjoOPcdXYO3VdlA1hp9htNIB41ddKnl5KncVy/Yohn3F1jtxbfutX64Rg7r
	 tWjm+0CCXI9iCw8wk99GqWgMfbBpA6G2BWaHw+mriCubQvAMT3jwd16Y1oRqgabrKG5iC
	 7fozkOEYSq5+87D2rzeJKRdqMN+zSre+cufPwx4Boya2f7FJygta5lzH0JMIuiZZZirKu
	 0Oz/nHEHW9mjkeISTIXx91kpj9LvwPbIMyhya2qqWTAU+i0KcIPcpHfMkQrUJyTxbEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VlJps22F;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4E606A31F
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 18:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B4E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VlJps22F
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so2452244e87.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 10:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767994; x=1795372794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlZpADIpQe7KCMb/+6RlQ2VbIrVPTUiha7CxAd+TEZ8=;
        b=VlJps22FPn47sddPz17DzkkRJRee5hZY1O7X22u8+0EcgI5CnnvVRxSakufd/WoG2H
         R8WscVnazSdfoSPaKXgY2frrGTQczJ7TJX9G6NOFKhxRjpfYeTwSNymp6h2DLrKhu3ku
         pKuLZJTtpEEBLeilit4PtYDtflgYqkA+xxGqygF//R7oSSJx0+Csv1kGi0AchKXktmcM
         UaU7EyHR08uSCNV3l+o+kFImPfPYHICXivwG8NmMQLN9K0+czNEETaDHKr+7IbA2oafT
         F6F3kw8gZmBHjaNF1aqA4ltciHIBjY+aEER0Y07OTWJkfR61OAoJ694GKj2ILCfkFCDR
         EnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767994; x=1795372794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dlZpADIpQe7KCMb/+6RlQ2VbIrVPTUiha7CxAd+TEZ8=;
        b=N1DjUTu2H1HR0jcwuXOKw4FFtAIjy915WjSUVWYI+A6ATLPo3eCAKCvTm3B5JN9x5C
         d8Vnv9CdGDrIXrYv9GEooI8I6RiWwE/mb2KuHUikx0ldKPPrgosaXk528V6BeScyjRtT
         kwb0asAyt8q1/DgA30+RE4F3zsfSJubmcb/sTBENN8cBN90yHaofJaC0vWzynPIi587q
         Ys8RVWJBc+bxh1Hx1FgeV5YEZgYu8GE4HHxqUQguPIrchS6Fpkjhn3224Lbf9Qyv92vg
         9t0GA8jaRKfOq/eL+1vo30AIsX7nZzcsxjySC9Y2tUQg8QHyXifMo1xDUGtbbfT4ODPz
         YYBA==
X-Forwarded-Encrypted: i=1; AL+hErFldTKv5zn59FAQktv8v0qc8sGZ4Vb5bF9eQRodrAIu8oJ9QMMt4tjrfS7K/F/A/WeavLDekQTadFg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZdQ+B3XqqUUk81Tiqr0tSGrDkijFsF7+LJDKsLBDU4hmciBwb
	b7yRmIMbTnASqExFg+eN3EDfQOFjt7xjt6AJ7PMDYBzI4n5et7hkyZvr
X-Gm-Gg: AYBFou1tNf9E3MrexZoq6QvdJ1CIdcbUvv2R7v8XciTCt0G75IuzxCE9bf5q4EIYldj
	yUirY3B1y1jwHAvlzrnP3ZlgabAz0XW3xXrqEs/syb/1LTfCyGmm1+jmF1YMyP8W2IHKz8j9ho3
	FueUkrRmBSJ8R8JTk12N4KEf7wyW1qOtuNK9nUxYxgminW01HoCSW1oyZY3NjFqGO4hrV5ETZIB
	g7CU9BQ281YFxE4g66v/aGVyH69vfZQV/Gq3wwhwbvv0lvB4ddGtaT4PND1mj7DNlSVSAls6xar
	4za8rYK8tt/78LHNFgdXsrD+RRiIAXDRy2S7jaT9mV2uALu1PS1Y5JWZJfOIxB5eZIpSirX+ONQ
	B5ef63LOxLkUak2krOoM16nMNwX1/yP5lYD1+hF+BIoR5Dipdgvo3VbNDYE6r9rvkNadnao9PTe
	HAzD+EfuQm7RtGsgSbb8cIpSRisK/mKBfni76HBHUKmJzxNKoindexecC+fw1DR9yjFcHK/XdNO
	cgAw4+FrljP8sASd13x4EcyvVbzgY7LFsmB72InGQzP3/KhNLV1Por/trNYnyP2AY37La/ddipj
	qvZVOTQaEByxQ8hDDu4YctqEvcDfwyxkR8KgXE7c0BzhMPrGB3NcHDoGXu2O538S+H2w6lmtraX
	RhD7dgcCknZOhYE71CLBS78UIgs9CK0tjXc2s5DiOV4U6SXhlY5U1qgNfp+M=
X-Received: by 2002:a05:6512:15a6:b0:5bf:b22f:19af with SMTP id 2adb3069b0e04-5c1709991d4mr3424142e87.18.1794767993422;
        Sun, 15 Nov 2026 10:39:53 -0800 (PST)
Received: from yantra.. (nekmmqug99g6ubyegcg-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:9e2a:fc94:8694:1840])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1713571aasm2532348e87.73.2026.11.15.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:39:52 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Sun, 15 Nov 2026 20:39:49 +0200
Message-ID: <20261115183949.11591-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115010203.2a939bd6@jic23-hlaptop>
References: <20261113230241.82046-1-zoone.rupert@gmail.com> <20261114013817.476f8fb9@jic23-hlaptop> <20261114083525.11972-1-zoone.rupert@gmail.com> <20261115010203.2a939bd6@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 15 Nov 2026 01:02:03 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > Probe value only lasts until the next temperature result. By the
> > time the buffer starts TMP_RDY is set, so first scan takes a new
> > temperature anyway (checked on the board, buffer enabled 5 s after
> > probe). The probe read also covers direct pressure reads.
> I'm a bit lost.  So how stale can it be in the direct pressure read case?

One temperature period, so 1 s at the default 1 Hz. A direct pressure
read takes new temperature result whenever TMP_RDY is set.

Probe read is for a pressure read that comes before first
temperature result after probe. That one would use temp_raw = 0.

Thanks,
Rupesh
