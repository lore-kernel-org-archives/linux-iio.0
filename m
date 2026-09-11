Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523647FB16
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132908; cv=pass; b=KvJgXoxxe9vL3rYs7qujcDcBk2m89qZauDh5OUzIrAfVRKxy/zEpYDM7OZG46x5irb5/1oFscxixcOppvQUu6VoyoWU3F2zpdmndWuenyj4C6fKt1q1HzTgODhqh8vxheD+oWXvoGOzz01KcZU1JcnNlg5o4oIwEDqY5I+rVWNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132908; c=relaxed/simple;
	bh=5GSzj0e9Yb2VMZ3KqK3B/p1FAZi4+1j3IUEAn1TPPbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQUneO0ax1qArREUbFOhhYB1MqMF/hZANTBponGNGR0OFwoO7oe/LO2Q3uFaugg0E0gSMFQDMydBGEs3PjUxGwm4MfCjQJUvpgjvZ0tWmmo2Ly6O6eEaamH9LwnF2JNbzUb+DyuBLQoYbr3QHaC2JjdPR5GQhpCrShpHFKBrhr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP8T2clZ; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP8T2clZ"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-46f415ce6deso510894fac.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 06:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789132905; cv=none;
        d=google.com; s=arc-20260327;
        b=alXLZXr7R39VtlPgHnktXoHW5dxJXwLNYX+pJHgSwK1rdQ/ZwGeeIcFfr7ankUt3Xn
         NxKesZVhvjenQ/zYBjXAhzDrE3Y52cm+glqAdyj9VrkSRILD7dCfRhDhMm7+o4VkzfVL
         zXyuFMHAFLnBKkwM1/ToKFMd4YZZq95eo3zvM5c+icnjgUIV4QdyyNDSicM1nP3l7LCV
         79gz/FO0EYIbuRLyL1FQceGaODthDqIhGS8LjaHjafJW1J9O78wmurV8X0RJ68NZR/+O
         a+l3e1SEnHCoDs3mLM0lpuM9yBBE+lUw9+mcAw5rAztn/fHoPjIVd34vuR+mGMRh3o4S
         Zj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5GSzj0e9Yb2VMZ3KqK3B/p1FAZi4+1j3IUEAn1TPPbE=;
        fh=cIFul2OotvFzU6xE6/E3MJrhhsQ6yXkALBbAyQXjt2o=;
        b=FTqINczP5dZhWd+r58uVvuI/UOJT3J6KtUMAt2gubd3wpRowVmWkn+h2M0QOEp6cNb
         IENMBtZT05l8RJxyv2CPyk8BN9b7vRMsNNCpGbSB/4dLyfKRk9OHmdcV3SU2qDOuGmnF
         d/POPGS45euP8voxdhX6KY1DxzZ4n5oG2h8Xj98gDrz9l+A8lucwgihCzUNkJMHjPnSn
         wbyfdSNYQb4p3B4M+oPYBozO2Exm3v5YfS9/+MNBaYGYwzfNJXEI8ECp6bH591aqVMi9
         Iu7ybnfsB8YXsALcdLf3/1pk5GkYwgjUwqBbRxRAXRvFdX69wqunqGPU7l/fnXxc9SxB
         M3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789132905; x=1789737705; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5GSzj0e9Yb2VMZ3KqK3B/p1FAZi4+1j3IUEAn1TPPbE=;
        b=DP8T2clZDChX8ueDK9UJNf50GY+zepjIWDaySeeaSPEqSM9rCOIaOvPrdl8Hu9nGDN
         CD4M83bIRrmxEhZSLMcAJXHuxO8P3TxRmdCGreE//i2HN3QebyILDZYFH/4zIps/OOfP
         GnZnslNjZz3+7olfFCslrvWH6vtGBlm9evBdCZrKNtGKESsK2Lwgt2MemiwbFEfUv5ib
         9j0Sv7THzNS+MUSBZ3bBrAslGUVE1oaYRiPf44iFyGgG0fBGaRzrAsyLnJMCE8dfae20
         Ch4usIpe3SKuzKE7WSyIxqz3ukcb2mVww3c4BPdkZ5n5BiRjgMO8RbQKa0tPeLa1mRIM
         LsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132905; x=1789737705;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5GSzj0e9Yb2VMZ3KqK3B/p1FAZi4+1j3IUEAn1TPPbE=;
        b=Fwrkl2PJ25SihVnk8iY08b2fig1HoZhxB9ssQCo+hoCWCgW581wcZ2VnOjwt3RbUu0
         mWwy9pyfGX3wSz4xtLu5dsLB8oaq6I4y7gzYiNAcrsgsD9nWva2ej9oODjgqR4RAn7AD
         H6dtihLMQbzNhgqP8XxwbgTow6DkEM64LuMKW4nGLy+uWi8RopR2zVVpNvcRQUIJKfha
         ERR9w3W3zBuupf6Vzl/eEZ7CH9VpKDQxHlKbplNTyAiaSYVn3w844Yg2nfwHmbL2v9NZ
         1YkMIy9olazkYZDrkCWu1kHW/WZMKtpSmFmcExofeheoMRPw01NxXkI9JAUsHjcaM2U4
         RtzA==
X-Forwarded-Encrypted: i=1; AKwUvBykx07kYmVGtg/AXoM+evA6/Q5q9lLLyWzRLRlOZGSDuxtDBx+Nf2qaWYtS7XqFx6A8Ng1EfXIeVLM=@vger.kernel.org
X-Gm-Message-State: AFuF++kkPgv7z5ekr7pC5x+/o+DJsJ/acPucu+QUL/8prgJBU5bQTRQv
	8TpfLxZfBCBV8XJMZsd3Lz4GyP/b8QRjsot+MQfFn5CxH3U96Hosuen7lCU6hHRx7Dtwr41Or3S
	INTyeKYPcS7SSeuXIUY4JaQaqvKi0yJ9+/cQ/
X-Gm-Gg: AYBFou1fTplZ67LabeFbCpjCb+PrTMQFZe00RdsWFI/CtxpJui6S/p64sMoDGuzDSeX
	qcLzSecS0eQNM2E7otq9euJ1p8ZWP6lHrZHoZwrv3RVfxoJvYihR/dVKKBLznuCqYyyDKMXBIdM
	+JeWhFFN29DTv1kyidoG15L936pBTKodRIHXFEWaQh6+KHNV5cAH1eKpa6TFciYUcIPIATA/p94
	QlNBldiPupdRibMAJaUY6gil5BpA/nTNOIb3pFJLFS2iseI4kGNaVQj1Z86HfCyY43h1CRLd9zn
	sNDk39KSpZmrWMNMnWO/c9vHzAKyTaUzRGOkGalSPsYx+aAWS2TaQ710PmDhN0sjdUU=
X-Received: by 2002:a05:6871:4082:b0:479:a30d:60e5 with SMTP id
 586e51a60fabf-47deb6b21a2mr3169202fac.37.1789132905351; Fri, 11 Sep 2026
 06:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
 <20260911110456.24873-2-abdelnasserhussein11@gmail.com> <20260911131834.0000514b@gmail.com>
In-Reply-To: <20260911131834.0000514b@gmail.com>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Fri, 11 Sep 2026 16:21:33 +0300
X-Gm-Features: AcwNN1V6XBqz-WHyitn1RiLjHTKAlPQpxveccB8dqCvxZHDUYuXYYdrHvshVrYM
Message-ID: <CANpqX3YjCJCmvp98iymexGLvL0zLXvM_M1F1YypbMCUQA0BM-g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] staging: iio: adc: ad7816: Serialize SPI read operations
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Joshua,

Thank you very much for your continuous guidance and patience with my
patches. I truly appreciate your feedback.

You are completely right. I mistakenly thought I could clean up and
sort the headers alongside the mutex addition without needing to
isolate it in a separate patch. I also apologize for letting the
`sizeof(buf)` change slip into the mutex patch.

I will prepare a v6 series shortly where I will:
1. Add a separate precursor patch solely for sorting and cleaning up
the headers.
2. Keep the mutex patch strictly focused on serializing the read
operations (adding only <linux/mutex.h> and <linux/cleanup.h>).
3. Move the `sizeof()` argument change to the DMA buffer patch where
it logically belongs.

Thanks again for pointing these out.

Best regards,
Abdelnasser
