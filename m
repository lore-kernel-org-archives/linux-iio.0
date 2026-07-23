Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4613DFC86
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843276; cv=none; b=rxbVIqQy2+rC9z9hj5UR0ynZ91uUDlxy8s6Bx03qXdLrQtsfmpYXr+D6C6uM85kGoRQWHDsjZg/GyFKoE0Lk4VhKDqULvnUcvVRVCdGMyrcbBpXj3B/WnPJc9S3uhK705o0L9vkg5izaA79xAIPv8mtUXxWWXtk0ausJj2zcnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843276; c=relaxed/simple;
	bh=iV0DB1IMnoBJFnSPG+BJBYj6LaiitsOcMqjwyNRMcSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rypmBDKqGg2e8njMFnE73BPt6wRU4wwO7v6JXO8T16hWXr9oV76Fun3+ScBxFtvyvUGjSovjTVYOA5hbenlxt8836icyTprtg88atsok43u+J1tmBOa5fpO5kfmWr26eG3e0sKC+Ik3tnhYvlylKZ+T7W9HDwvqXwvNHXKITmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0C8C6bU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0C8C6bU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so11904935e9.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843273; x=1785448073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MVBWHG8ESuMad3qr42QTUda7Z4q11ujZE8cB+I2e/yU=;
        b=d0C8C6bUTNh/9oG6a1caj1XPTXLttCiqI7KhBzk8XQKS3iwV1Tb8IF2Vk+TZC8xV2S
         acSnI8QWNHa7sOT8GMkXpNGLcRevcH5KRm3g/GXDBYGn8ZHQXs3f8tWWnYoHJiSadOSJ
         UAODMeIL2zKCqAg8oNFrkgikW7Lc4O7vezmkGRmiFwg5j3QjbU9AdGJMQeVaxLnZr0qn
         EHnWHbfbMMfOONovUYZT8q9qtkUOqLZ4IYbzbxRait5sSg2zET0QjkYm6Rpu+312cRxK
         E5yFwLgYx/D44RGGyHerUONIdzxZMuM22JKE6EnpF4ZYUd/Q3e64n/xpM5Lt1+APVgS0
         SAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843273; x=1785448073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVBWHG8ESuMad3qr42QTUda7Z4q11ujZE8cB+I2e/yU=;
        b=W7zrIL/wOVZujSCRYr6cauGuJUqVhkZp8YHtNMHelROD5Q3ac9H2GnCpw3B9n1bOQe
         GCf8PScP+b+6I09fog5cOlPN++3Pdu18Ag27PY6+8yYrbc0PIWzSEovd0zfPc5YrzVC6
         eEwPx+Ap57rUQupcJn9KV5EXeZjaqoDXfMWteWHBHwYX8xbbPesQRoMH0kzOuOwKcYvi
         MAf5ZuFzGEdOmpOfALXsKeWxwdF1mZA3mCfWbUN7/RpDihSTlI1lZHJfpVzkAUD85Kq/
         SsosxG5oaUJtcsfqkFcsMI5soLO8zfbek4DeeAyPyO4oJSibYvhC34d/AvGIE2sP6piY
         0TSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoieIuQziuzGg6DHJDcsZmAfLS0nw1CnBaU/zD64LHcj5vO7lRD20vh0LewmRjPE0ButHsVWzvbfxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJjK5TQFOLsRcTvdKLdVfcwy6d2uePpXUf2QNRkrcjHkYUZTa
	anjMNwrOvDCL2xR1EEX1nTy7WdST8rac/ZKbVOhBhd+lKJWtRerkp34z
X-Gm-Gg: AR+sD11s6DXvQWHl3eGefaMlKzKPlWGfkLAO3U9l+fNA5XlJv6kss8Oi1nT0NR//h0s
	qeESN0gO4GLexpQ/6p1UhnjBO0Q6e8yHaOj7n/f+L2odjm9vAljbd0pXuZi++E8Mdyb1xKYCqHh
	fYxHVUyrXb+gh8bmLF1TdPjL9jN4vYgD50+M73bQ2+cqdIZE4PCqW29jH8XyFlq31/akwGDq6Ee
	PvQpfM3hYh2IE8V0rXocdis4M1M6ukAweDEAvA2FIie2ZfBWb3S1DtzxfaAnjuatydMWnufLyDj
	+UmUcCfF4WNO91Z4QRChe3ALRPtw2EZj0NA4qBRBhCX3bQS1PkuG6kfbJFuJC+tKPv755wuiKsq
	HNEvWx9NM+Ou5MxZul6bgNG05HBUymiCztSGvsfxIQ1CctgS/u7X+jlMu317EVv3QX424vuod70
	KBGUU1rF2x/zWNVEKzTINQbgv5o5ZTtpegUzcY7dDMywiU5PjIWeulRcfHlNLPtBYXoeJbyicrO
	OoH6aBl4FUrauKsTk1sM4f1kO7316xAlZMR2OnEB3vLrmuFRVHUsD1Mif1WYrO4HQGhqSlaNHHY
	V0hFzHkBU3QBCQ9fK18okE0Q6039LMzMXj3te6c3LseAQGuqu42Qtz6p1106ETlzg8SVhtNhspa
	QOpm6vnd/Al4=
X-Received: by 2002:a7b:cd14:0:b0:493:bb0:3b43 with SMTP id 5b1f17b1804b1-49573cbfb7fmr37428135e9.2.1784843273372;
        Thu, 23 Jul 2026 14:47:53 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bd9bbc4sm13559335e9.3.2026.07.23.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:47:53 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:47:51 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Message-ID: <20260723234751.5ff138bd@systembl0wer>
In-Reply-To: <20260723-gp2ap070s-v1-1-b8ca3a4c10dd@disroot.org>
References: <20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org>
	<20260723-gp2ap070s-v1-1-b8ca3a4c10dd@disroot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 22:58:33 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
> Corporation. Unlike the other GP2AP* schemas, this is strictly a
> proximity sensor and NOT an ambient light sensor.
> 
> For power supplies, it expects two voltage supplies, one for core and
> other for driving the infrared LED which is used to measure proximity
> distance.
> 
> This chip has been used in production mobile devices such as the Samsung
> Galaxy J6.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---

...

> +  vdd-supply:
> +    description: Voltage supply for the internal circuitry
> +
> +  vled-supply:
> +    description: Voltage supply for the IR LED
> +
> +  proximity-near-level: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

vdd-supply and vled-supply are definitely required.

-- 
Kind regards,
Joshua Crofts
