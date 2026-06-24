Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FB3AFAE2
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296034; cv=none; b=P1HLGf1yxhmsB+9B4Gqff3tnZSy88MhnRzNYPDokVLTA/wCVWGleSds4VSBL4+HlHFCZEcwQSKjAOOt69QKVwYPvWS6layHg/Jup5n+3qySf5C7S9YeEx6w2z5/Z54s9CHn4aMZy/209UGeB5+LBgZFI1Z6TFud3bBic88L3PSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296034; c=relaxed/simple;
	bh=zebcGPrceXHjgWE78xr/y7hHNy1EMamwmILQApdEpJ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C9w2ZHuI+wwXYxu5wMaD4BYIum8uzNlMgSUUglMX9DtJak+SAc62623rRQb2sWVsQe9bceKekSK5dG7hWYGWheOtpHHsPT8bCyyb3OqEwx7sKx6auigE84g7nl4cZkdFsyRM+cH2X+0T8a6dBzcmfQzRGCfVnI7kgC90rbrH4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJAJ+KXJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJAJ+KXJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842307472d4so412317b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782296031; x=1782900831; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLzHkC9eNs2dWN9wH2HpWa/E1ENUCR9ZQ9gzLDAm6+s=;
        b=OJAJ+KXJifcOhmE9PcJMCgFi2r/OA+q4Nvs8MXGIEAbnRtazDrcojbAmEqpOej/GJu
         yh+GYMgYeG4WWiSLpGM9ys2WhklGp+MUqH4zGmLH9xrS0e+x20yLWqjp8oWc1l9acAAI
         7WPVcpyEujpYKlpXKZRTkL/DdGFQ4Za1G9ECvAKJihnlZu+1X7qcXZxZmNwSCL0Q5zbZ
         IwiHbHaRFPNziI7LVhDp++d4o9QiU3mIBY6KYV2yxK6f3QAMVItIjRClJZ6qTTmi6hmj
         nHllB3z7UkwDkyUJ+37dh7K4vzrHUzSwB/Uzm24BuidOyb6V9c1wlbxKvTaxLoRzWoJk
         VrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296031; x=1782900831;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLzHkC9eNs2dWN9wH2HpWa/E1ENUCR9ZQ9gzLDAm6+s=;
        b=YrMfukz4bAOyahkk/rmCFClMrB9PJVOcudDahODSlKrLMIXSAgjphuTtyaWP4YGCAi
         eh6PdUUCAMN+R4odeHAHWsSsQKJNh0Qerp2kjjksAmI3LiFYcJsL+hQfRoTnBbrhjfoD
         aqyedgosHAqYka/4jfaA9brHSgV6s1kp6M/H9h1BL+g6jOFZx3w0+n2PnSEBMkT/GaYF
         56GmvMivuVcR0jxKaNyWK6zzOkDxQtDnAg4MB6RVeRNZbYrUfS/RLYyZGf98OhUK+fXx
         YpCZVMG3dkGRrI5u4tGVGt94DFYfY6ntpLn2cSUeNX6KZB+mC4c6B3puVJ9/0NWyTdYL
         GPFA==
X-Gm-Message-State: AOJu0Yxbyh/qF5BAVpdYnssi3YkPcq0EvXHn8TuHuuEDuxIDtuUFlAMe
	sGYFZXOak9psI7XZda5BI0SZIIxT2S6W209gBSG3dMNywnvKAZI8xacd
X-Gm-Gg: AfdE7ckKuAovToaQ5G/B6blNFTIixm1j3QsGycAn0xri/vTavGJ64M4Sp3D6nxvHzsc
	l8hZ4kvFMvXDYqj7pc0iWFgk/FdBosWpnNkzwsCrC+yCFqUJa/6IEc7FyuN8IvpmeudZyx8OZ+m
	O8XFcAYZlpWdvUYWzHxBQh9JG9W2GJBQjGF5WPhdeOIkZT6dUng2NzKH86sUCUzdTnHThSe599Q
	fVZfWa5uUFd/Hqzwj/bwZFNU+OnG8YVEYLT+9gkgwFzs7cW5Y187cR/F4JBBQsCbHlJS/GhfkwS
	0MT/i0vVYQKmB23dQUjcbdVM6G4xWD13edL1wFxn1WZk8AC94+zHTHEBWmO5jmeZe+Wnq5jgn8d
	fSQVGghEZ8+njWYI2RzdKEuZntsso+/gNt/LHAWILitKIK0BXzB/YmgiqO87RBo8kkd6mBN7suB
	oX+h19o5hQMcYUYXNryNPJwNHykMzDsNrqHC/MCsDphO++a4r0tfjIGGnBuCPKaCQEvBMYabpP/
	IGK0Jy99AdZqYA3SOy5
X-Received: by 2002:a05:6a20:3d22:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3bc5420cd6bmr21206958637.46.1782296031529;
        Wed, 24 Jun 2026 03:13:51 -0700 (PDT)
Received: from localhost ([2401:4900:8836:4853:acf2:b82e:a091:7b0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c168sm12454599a12.20.2026.06.24.03.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 15:43:44 +0530
Message-Id: <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
Cc: <linux-iio@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Oleg Nesterov"
 <oleg@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "John Ogness" <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Prashant Rahul"
 <prashantrahul23@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
In-Reply-To: <20260623203636.69a7429a@jic23-huawei>

On Wed Jun 24, 2026 at 1:06 AM IST, Jonathan Cameron wrote:
> Why this particular one but not the devm_iio_device_register() below it?
> Both pretty much only fail on driver bugs.  Or out of memory for
> which dev_err_probe() doesn't print anything anyway (on basis that
> is normally pretty noisy).

My apologies, I wasnt aware that dev_err_probe simply ignores `-ENOMEM`.
Looking at drivers/base/core.c:5096, it is pretty evident that it does.

My goal with the patch series was to change dev_err into dev_err_probe,
as my understanding of dev_err_probe was that it's a specialization of
dev_err for probe contexts.
