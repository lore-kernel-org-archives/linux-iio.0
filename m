Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462756;
	b=5l3F72ee1rhIgPQMZn5AybfgMOyIqqj8YWLmyl1KAahs0+4KMSo6qmE2KtfV4q9pI/Kb
	 IYRDmQC65wMKocPz9BoGIg9kDy5UvkxAv2983v9muhqhy5/YHh9RNx+IKQ2pw/83jL6Ny
	 KQEHwiCvk1Vd1envReisKZpjhitxXYoCjKai3CZMIARnJ8dxQJcIBOWayjp0odMPSSntS
	 LT7PGCIMrBWAEl4fydg7wU6RR+rNgBy3WlZO/0RVz7DMhnHbo2OrUIzTgtx1HouxeXNbW
	 G3JvkiMFqehSmMwDMngf2+EA5SII4RIdNgXceFjj7/zsdieCkvqjVjlC12RNqPAZNAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yoVQweUhBNvvHzzBSqhEC+QBmmp2aRaw/Ip0znuFVys=;
	b=ZRwTAqy9R6gENwB4sR4g/rkVmBQSy6CwHDeZRsCjkkC7CMd4BeuKwwqrje4bi6OuMcUH
	 sMip8rR02nSraJhi3Uqj/5vu2pEypYxTEcxdmG5py1Ww0p3l+aDz2IpFd37xsSfSYaObA
	 W45ABq4R21zNxWDChniTebG5HWysfCSTGDiLt4zn915pxwU03mr6Z6tHSyiIBdSJkWMn+
	 fK8kPcPNV1O3dTSRLiSRLQID6j3LWcdUR7EL2qLVI/n0wNpXwE345ovL6AFwymWJR5LBv
	 VM7hdtOHUnF55fE4yzFPNxubMLx9+LLDKoOoyXyCx0fJN4WH37lz6T93NPGX3gqe7zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABKsVenN;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCE606A31A
	for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 16:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFCE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABKsVenN
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so14974045e9.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793462754; x=1794067554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yoVQweUhBNvvHzzBSqhEC+QBmmp2aRaw/Ip0znuFVys=;
        b=ABKsVenNXJ6pPb+KgqwprBr2Oa4zrVXF2hlOOUxI50ZiMl2UPo9qrUfMstWHbfReJU
         nkbq7N+LnFd74vGmV20nPi06hu6YALPPEhLlHw9yWY6Zs/jg/o5VYQkxQdgNmRTj8+sP
         ianCNXbciDBzs24ME/3caaUiyfJFy/Q3AXGOknNvr/cd951Ytf7npYtPPCYgiydyX820
         beeUJLTOC+Pji2cUGplwPek7TBOoj9WicrUTbCmEw301SCDY3AQ4eOVe15z4Rlyg3iFK
         6b8VIowDE7+RnBvAxQBU2bHzW870cBiP1pfdjH/v1X9lJrFHPhN3oUJ11jmd3SQLJXDU
         5OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793462755; x=1794067555;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoVQweUhBNvvHzzBSqhEC+QBmmp2aRaw/Ip0znuFVys=;
        b=gGiB2t9CW3UPB8m2YieWS47R62/PfRgaR4QGua2eEtawW+wf9nsonFB9EiCqIm1ayV
         dBn4ZKfMf41SDPlDRsOlmQviwXtllLJRD3sf4LmFKtH98BXMQVrf6t/t/p2DY/JNcP8F
         d/kiCM/L6GznMxF2J5fOtPwRF58LDu3moVSs2/VBFxjtZ6S7EaEl/2mcEhy9ljvNM1Qv
         tXL304Je+fjpoKHKV9d5flcl9JufO7cNQpBygRz2HZG4Yoz+Pglmkuo5F8YgvHusY3pf
         nrsRUAyKTKVYG6R7RhilqfI22pRQ9iosLAI1YWMUwBRajYsbLXOSPOGX02M6zAHtjGkz
         +bJw==
X-Forwarded-Encrypted: i=1; AKwUvBxCss1RY0OFAZi5nr7RPDshrPIdYOi01MqLJDpHaHXHui6RC0BftzmuPlPot5vSoxaVoHMV7U2F5Ps=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLnRceyZvly6Df/WJOAhLbiwMUxEoRJufv7Y59+ka7HVD/5kyU
	VYRyActsyrUtMnp4ve/2Y+M1objnDAE4lkhydofU6bw05lm7LYbWLNDx
X-Gm-Gg: AYBFou3wEk1/swVj8kHEKr2rft4LEoO7xTKsKB0jJv+677zfhWXmasquaap54aSMnjm
	Mzr2Lz8neTlg2i26MAzppBLji7noC+QiA1zcCaW70fNYai1e+HM5Ojcr/fRBei7y7H9ki5kzc8E
	/0oI9RFUr0HVQpKoi+bC7bdjxAe9xXjtqeMFZWTMm1OYFcgfa5sIg1jJjaqwu30/RakeDU4EV2Q
	p6o8NWA4oYiJwVb6DstcO9fq3HYw8aD6lSpu+eirdSZ/5idADqBymiDM69Kf22PWB4Xye9zTTxD
	aayQ2BSxOyIJZwQniT73D3KZd+xhpBtKRZvDh+SM/el02tKLzWsl1V/0qvj+sr5Y1VZv7Xnxx+1
	ZP6dVBcChJ01efwCiAr8FvEOdMD20aeK6wkvpMoFooOC33v7X0qkXY19WQz9I6iJEDBq16cJOmM
	sBx52VWveCtKiFBp8Dt0cLYmbIiroqbPDrbrcvsQ0cwWoYmfOJOfKxa/SYOkETfbGfEDbF85WeU
	WfzSGpFO31VnqWLmiThyevv1oyqt+J58/UZ0+zXnrwAEuFZSLcaKwX3e+gTTYO6jSaENWU5N2ld
	mJvOpg39lqKc8sht+xYhKb3NsUMH/4VrXtJmK+KftZhsvJlO2IDcjk3uBCCagKzxiv6FBOZ0d9o
	XGkfpOE6aRLJ9eJsNB/E2N7m5B18oqhThpfV6yqc8NGZM0Z8VvXRtTSBoxxUR/jM1dxdTWg2ezN
	kCut9zqi9BAgdvLVBlTfScxCoy0393ghNhemJf7gqD3XTtnzXvQgoFggBeLZCrRQ==
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr132615215e9.6.1793462754293;
        Sat, 31 Oct 2026 09:05:54 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2950sm212385695e9.8.2026.10.31.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:05:53 -0700 (PDT)
Date: Sat, 31 Oct 2026 17:05:48 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: Fix potential use-after-free on
 removal
Message-ID: <20261031170548.5bbd2c8a@systembl0wer>
In-Reply-To: <47d9e9120165e819d706f922c798517701019bf1.1793377431.git.liguangshuo@mail.sdu.edu.cn>
References: <47d9e9120165e819d706f922c798517701019bf1.1793377431.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 21:05:38 +0800
Guangshuo Li <liguangshuo@mail.sdu.edu.cn> wrote:

> Unregistering an IIO device with an active triggered buffer detaches its
> poll function. Freeing the poll function first can therefore make
> iio_device_unregister() access freed memory.
> 
> Unregister the device before cleaning up the triggered buffer.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
> Assisted-by: OpenAI:gpt-6-astra

Drop this tag, it has been deprecated.

Otherwise LGTM.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
