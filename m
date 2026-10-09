Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9037F728
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547593; cv=none; b=cIbHviKwukdAapUfyoO2ugS/WepC5UfI5v0Ht17C7bQe/WBtrxiEinr2exEdtk9YrGHnrNEen2g+azmAJJhR9BVOQz+/+JzW/hORi0rBL5oOw3k8egS8aLRsJtY52Oouh88wGKMFN5bvST7euI58KkzCNRQ024fiTGU9H/8Svv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547593; c=relaxed/simple;
	bh=hOv5cDWUXPtG1yahyo6pzhmnH4Ks7c65TADdBXCaVOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4MOR9fQDkzi+zoh90ZBMpXsinbb2SJywE6j5gI7gf0qGP+8VHk2rgV1ZkFuWkLsRNEK5wMeXQdJBovdA0Vfw9uSE+SSeEWyvZkGU/ifOXZek77i/RmdCo30mWNQIwPhhDNXRoCaOOvuUFv9GHUNetrG+ewpbPg93akcXBZn8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlUVp8FQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlUVp8FQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a02718da81so30331595e9.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547587; x=1792152387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ZIo+hbBbh95/Ym6wzbahCH1ehdtPjKzs3eJGJE97JM=;
        b=LlUVp8FQ2MPyn6ZFghQagi1IXoAdvvWZX3b735EJI1KETnOaXFX1HSQiwBmgXQhBAc
         lO7mgmTX6ncK3rCjIi6RAPC+lzHc133N+3oQsaF+Bg33WJm0vjSJMZZOGFj2LFw0t1Vr
         Ozv0bmKBGCU7TE3nMFgJlWpzPQxjlwB0D2lHc+ZjXmrU0nc6IQNOhS0ZjyBe8i1Zqfvl
         1C0h2gqZ7sfbaJgJbUNUSvJxVBIeZU3WQdpqVyBXiuvrK4NLxwxsSEOgDRPvAB5JtUVo
         KO16HSMNWrFhriIr7s3+2Hez4qrhsM3qB8pqA1XZlVFsGYW2yDORNg671z6GsEz1AMJw
         dYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547587; x=1792152387;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZIo+hbBbh95/Ym6wzbahCH1ehdtPjKzs3eJGJE97JM=;
        b=cLxtKZ7UyaFm1W2MstMWEFnpq2u27xmQI6v5DESsC4rGrn0+pvqpWfFZpgeVG8p8Tb
         nFvTGzrnxBJGpJadN1xRHVs7yO9jS5x6zpkgYZPhrTDW+b+LYToXGtQw0mVt7eQl55uL
         wUOLbsvfnL+bN9XjLaQRl0bTk4IqV7GPT5ji9Bup5VMtaCOmxL8MDhsJhM7WgEEmQxhg
         CtrIlfb8etV/ofa+pH6332kfKt4rVEP1FxVrriyq2eqdo6ATYuxZzIHBiyV2QpYfnfKk
         ohnQrbCtHHlf0KOnTaFs8qIXS8pVSTv6K4eyJejkNI1BTkL/B62Vgj+G3CnpPIkKIN+V
         NCPA==
X-Forwarded-Encrypted: i=1; AKwUvBwN0ObcB3wikfplYDLS/5eKsD7Z2VB6BmL6t0uH5usiFHYurUoQBq6BrIXtyJJ74jcxz0SIrvWKHHY=@vger.kernel.org
X-Gm-Message-State: AFuF++luy3W44YcagOcx4eI6o5/rMAtwcdWrwiJUlKz4F7om0H/qmGdJ
	hjYg8BnTv1nTbWhTvOTycpzV/Vr3DKp3ZqOlu69pVulvvY+4X553i4xK
X-Gm-Gg: AYBFou14VabVscP96SezEyscEQudlXWhMTF3/UoE9QvHvKgCVRGUy+IEfHpQ0M2DMiA
	hDYvgp5FjWHlT3u78ZKK0bZ6tzf8vHZIfDn+cStimO5XQPBmtEQeXM/d4LQo5DQgEGfCUAi0Itf
	Y3pBD5eEPX8ORNpgXLM1NIZUAJqEh1WKKaRzDJJ8HX/khi/OTYMCMWB/mtmW+mXO1Nw8IctcvAj
	5bopCKDa04jtUJl7j51jbqeoA21ZpBjn12dNZ1wSFVed0ITN8c9lBi/JTCsUOIYVq0QGEslxUY5
	1lXihWkCx8NGSLU6FL1ZhtrGNW8Gb3Pc4MNUwDUkPDO/dFEHsuWJiV3DevOQ+ScqKFQi99ZuAni
	17dGZhAABO5c9z251IPdCvo+h15oQEkN0xxhzZPYIx082pTQYbkB4ika7MAmtyo5ruHGjJbfDK5
	6s/MvzPJ9KLQN5KYas6Gb2VJohJDWn6xlUmeEhomVHjkvev+lCfIG1cwcpH8D/wK1o5Yg01mKpz
	mNyLjsbTKbSH6LpGjVdB7fscDhBSXq3Pl18x2p0+VGgQpDmF2uOoZpXIAMsIyNp0Q3Vtn/gWXNm
	hEFAjQUyV2HakqWWXF5mMd++lODHkjXu+skh3SXOZV8mgPk3PIpwejwM4IVWK0gjABteMXsEGxR
	HzIIi3iy2AKC3MlfTWeGStmvacopowve5jT4kRo6AdFXCAjU8GTy1ejzmtEp1EmfdcQ==
X-Received: by 2002:a05:600c:3e0f:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a18e4b60d8mr31527275e9.23.1791547587405;
        Fri, 09 Oct 2026 05:06:27 -0700 (PDT)
Received: from systembl0wer (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bc6a484sm57732875e9.2.2026.10.09.05.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:06:27 -0700 (PDT)
Date: Fri, 9 Oct 2026 14:06:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
 support
Message-ID: <20261009140623.18920555@systembl0wer>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 11:43:34 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> From: Andrei Stancovici <andrei.stancovici@analog.com>
> 
> The LTC2493 is a 24-bit delta-sigma ADC with 4 single-ended or 2
> differential inputs and an I2C interface. Its channel map matches no
> part already listed, so it gets its own compatible rather than a
> fallback; no new property is needed.
> 
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
