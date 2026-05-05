Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F066270540
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940978; cv=none; b=ZIhmFM8cc4oWGFn+6XlP1yucvvr99fScYapU474xz8MENAEz5J27PEcKuMU5QkE8cNGJBkh1fpBBtUaHS1Y96L55d5lEbVDS8x1dBEMQArg+pCmxK4fsrbkK8TVTMbVmzq9Hx9RccVn7BfK/WpC2lET8m8cpZinBQkzjpCy/zS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940978; c=relaxed/simple;
	bh=Hzq2DNRB4ml5m9Ae7Jk8kN+qLOUQO0dRQge3c19FbPc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i8E10m8FYUj2VQmGCyHeZWQ4O5kdEDjbLTIe9KvC7oetS58VGJIbqPZgDSkoI2bnWRLuKVYI4kCYnfM9vi4CyZwoWl8SB6bNGz9/C80cPceAfPpWAmopm4aXDFF8xtS3pTyROLS/WxwnXv9Kkyont+f0Vpve7T7MLuF8llIka7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMmlmazz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMmlmazz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dcdd1b492eso4827988a34.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940976; x=1778545776; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D4QqZvI0vo0qDGFIR/m77XA/GGRHzPVsN4iVFF9UDM=;
        b=jMmlmazzXwXVK6M3PPACvI3AHdVfhfDbGQtIRoil/N+F90pYqgk0kk/7ITcqCSVhIX
         HgPIopI8kBjkRrNEQQh/HXLX7f0ZP/Roazv2fQThg5NR4t/GpNFP3hwGFF8M03o4jDq/
         huolagXqV0i17SS76PUCDLhSIqnoh5xGUOMUTq91Tq+9LeZ9XnvwYCovB0JtItCzLpD1
         ZGUuCPwCkrx3I6UjVl6swrJdGAQrmWY+H9PGS+4f31FPgXIPU9sgTxb3360lLak+HsGB
         K9a8diXcL8IrgiJNqEwY7o1x3Zowu6W3jafTv2UK2erWvrdDNaX458d5AniFuqEz7y7N
         BWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940976; x=1778545776;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+D4QqZvI0vo0qDGFIR/m77XA/GGRHzPVsN4iVFF9UDM=;
        b=FyRgrhjuNAaQoDAfdrTfsq2Z8cr0BBmto+lWIt3W0zAkWnbwNoxwZzsc2v88cfi6wD
         njJjFPuCBIM3jwVMdsTM/qAJQpVx6Szf6XLDYzPRfmeC/cHybiI5ydZj3xsZS6Hk9GgG
         ndBP7TWoehPXvjFpgRQ2MXUD1qfNV61c4tw9B+iMfVPPUY+7qo8qAqaRfZuaXR5s8kWM
         wGqNNVB4IIJLhKRmWHK2C6ow1GTsSLGyVkFMlbOigsKoczj9NozewTKnZZrIvJ1wkoc/
         LdONHtHtOJKkXnqgNs7ojCKEqU9NxKAdBeeiEsHHBaCCsC4bDpS+J2Ggdn4pviBG22YO
         9zmg==
X-Forwarded-Encrypted: i=1; AFNElJ8/kve2P1I/IblU2Y8uF7Wyv7ho269Fh+W7Z5cnHnTMW8+5QshOAuZ+QIeps3SLrsv8Isplj2gxx0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7FSKcmSJA1wP6m3JyZft1BeTZieQb6AUNv79ZZjem26kfwkt
	gjeGuc04j1F84D4KJfYv7+ZUISR9SmJrlAgJSfZO/vjb6qvt4s2YJ4DJ
X-Gm-Gg: AeBDieutubj4UHEvo4ZVteZJRN9bSZa5lZpt/qV7C/8T9RZULiNI/xJliYcZSfblmkT
	qr/BZVPWVnVY0TWhjol3peDxhQBfWAj2w/Lq/qhYEX33xQMnnaWlqn44fv4Fo4/nczyvBbXcl1m
	CmlVM1k/6+U/UxDgmb6BRtcbjSUBxutWscjQQwq3Opq6B2mSXO4aQ6wUmD6s1kLfcmk3u0/DQLP
	rRuAYXprWGWicBwRfaWbtktkgtwDeR11lAU2cBrZfiwN8gOnFZSIzspcIuXTHgrkH5P2JSVuKoF
	nr8w6zsoF90xosRyg04l/HNkcYufTsiWC7LsgvKraqOjhRCOfALb1nnLA+6WgyBCvTAbCw4tCts
	mIOiLk1/HKBdcWuLmr+aJrmh81oQ3Lvo5Tmz8+yZBzj4A336XYuHw6zrQ6WRjEEWph5/HjZm0Y9
	64DCWDsumj0VC76NJJ6jA6OVS3ZU2b1mMcQIvbjzT1lJvyqSCYiBL2MzkO6RVKtIRFtw+icxM=
X-Received: by 2002:a05:6830:821b:b0:7de:cf3f:1b3d with SMTP id 46e09a7af769-7e0b06b1027mr658888a34.7.1777940976157;
        Mon, 04 May 2026 17:29:36 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac248d1sm9299609a34.15.2026.05.04.17.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 17:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 19:29:34 -0500
Message-Id: <DIABH47DS3A6.J29LEHJY7CIW@gmail.com>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Guilherme Dias" <guilhermeabreu200105@usp.br>,
 <nish.malpani25@gmail.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260504190455.9841-1-guilhermeabreu200105@usp.br>
In-Reply-To: <20260504190455.9841-1-guilhermeabreu200105@usp.br>

On Mon May 4, 2026 at 2:04 PM CDT, Guilherme Dias wrote:
> Use guard(mutex) to automatically release the lock on scope exit,
> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.
>
> Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> Co-developed-by: Jo=C3=A3o Paulo Menezes Linaris <jplinaris@usp.br>
> Signed-off-by: Jo=C3=A3o Paulo Menezes Linaris <jplinaris@usp.br>
> ---
> v5:
>  - add cleanup.h
>
> v4:
>  - fix indentation
>
>  drivers/iio/gyro/adxrs290.c | 75 +++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 44 deletions(-)
>

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
