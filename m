Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0C347BBD
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375106; cv=none; b=o+oxK/Q3sp3pTE8Mw5pruELEz0pDcPgP86ZQ12adxK8Bvx+gBoBrRH9vimcvcrljBExPSFAIvfe8ZIQ8O1dTywroENROs7yi4Wda5gj44gsABb5NrmjrZ4g0g1wTyLAbKFxKnN49iWg53CRoWDDmERCFsHvMsCQLuXQNNXOyjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375106; c=relaxed/simple;
	bh=kl8uHsKtcdd3+P1gKs83VfUWcS1UvEVB1ftqYP2i9GI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ncAm3IOhHy9F9dB6v57WWKSpJpWtfXfx+s+uUZ4rziYxg2FVAZVZRwyyv+tuLXTP4WYiKxS6i6p40trVmc72sfty7QEebUfRlKlt0ho97pMbSkCP3na67SlHkfEM7sM6mPVkV31z9PXag7DG1MeJm7ZAEVHDuxJk071VZy86NUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feE4iIHP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feE4iIHP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac525c1f05so10609717b3.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375104; x=1792979904; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qiiLrBltsrNS/cDaqww/ZFhb64+tZsgZICIoZQIW4nE=;
        b=feE4iIHPPxFeGPeXKVUThttWLY1z4pJQm37Wyzvcf4xj8e/yvVhMvlMNkzAg7hkeQx
         KMm+atZcF/R2zpgH1/d7Ul28VijGj5PPu/sQjt3TK24nBp6tbxBdZ67nXc3IoT3KFryz
         wjjtnP61/HF9xVYSLQR5WUmbT1SVYWpQ33jPtMzmFau6kXIxn8gWYh9GKyGeFNF82Xdu
         hoqQq586l1vb/29BobZ6h1Wz6BNYh4fAO5okkr0K5p8D/BMhtDajEka4tyGVR3fjXiJI
         Ug8/b6CqVZcbqW6ULPggsGq269V2YcEx/2UITcKzoWMEN0Os9AS9mbyZRTtDvUzLEkIl
         km7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375104; x=1792979904;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiiLrBltsrNS/cDaqww/ZFhb64+tZsgZICIoZQIW4nE=;
        b=TULPBe4ldyyUO80LbYRgt+qiLdGYBLGMcsSe2xNSN8qgQr5HmV193599toM5GCdkhZ
         /x/rChBCuQzePfQKVFy7r9KcnZtmc20c4x0jEnms8aR86MO1eAeRdbhpZbe3Pkzjy+1t
         PHTnF7Vpvc01VHNQ12oKb5pLsgTdBqq6AqP9VE5/jrIPU7kQBztOmDf6OGNx55OtoZ19
         J0YEoucHo7v7A+vqA0r2RTMSdglyFCGfXVq9Dy6M27TQTNEKeROlqzwiC2nqygJzkGKU
         sT0lEaCQJEAiP4cr9Rqw1LBgTKcMyJYmooBI8vZ2l7dqTV7FhfLTP7aXaH4MCC3gx84q
         lX1Q==
X-Forwarded-Encrypted: i=1; AKwUvBym/W1Po8SoYJAHG3CnGKZrXi0ZRgAIDuq9TJ2hAIghW8NUq/ADoTSrO7+1PHOT6IQyxoVvbGHH3pY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKopnrBYQCq1gEGnb0DkswA/X8BukPEa3Anx9czLoLzNrLvM5m
	mzE6VikvcbR8BnzlLYmtJfm8NWaL1cl+tXLIl3GnNt0i1xYvdArEjC4e
X-Gm-Gg: AYBFou29VNVB0dENa6ntohXmlTNvfOJbbxAvRFe5nFL8R7vH6NmTLpsXjoesIBEj9e9
	Cf1X5l2be2M+bt/ItYNNIfy9i1gaIo4TUw5Fv8tNPQVc985yO2rDsqoLJ2y1ntuEqRmbgLHWSRj
	09724TIHOVWpNnYVtEW1XxIJwtEoKKtQn7MFpsWdqfavmh+KrMLjCZcLkpzNUFue11BLzi2TIKU
	e5HChqxBP3slQ/hZE7H55l0DhARyUG2547sG1UcOL/ft1ROQJmOensxzxtYXSHkJvFyNfFFuGSO
	K+Fh2+nzLjjxW734oIkKFh+Rl8ZwxyWlmV0PqsMVhrNH6beD2oxCXFkOW/j1stGBFWza2aMB6nz
	rSA4qG2nFd72Whki2pPeEZ6BX/DocapmdjxvRa90X1QrUHDrh+CUX4ZHi5u22QJKaWFocqLB7ai
	X96yaJr5l7U5XAkZ1KIw+rvKP03ITNMH1DVSAFOBvuYWJPp0A4KGYxMZx8SqH6+bfR5UwbgNDE/
	h5cnGKdm+cOTDLQ0rHPlAiv2nuicjTMZDRo36AmOD9Sq/BhWn6cV4Rs8gKlKZ4ElWviwfpwNsAE
	5jIy
X-Received: by 2002:a05:690c:e3ef:b0:8ab:33d2:152a with SMTP id 00721157ae682-8b0f21c14f5mr21503857b3.52.1792375103747;
        Sun, 18 Oct 2026 18:58:23 -0700 (PDT)
Received: from localhost ([2601:7c0:c37c:135::8803])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58af029sm35834427b3.19.2026.10.18.18.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 18:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 20:57:44 -0500
Message-Id: <DM8FXLI78NYT.1211XFYSRH5P7@gmail.com>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] staging: iio: addac: adt7316: error code and probe
 cleanups
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: <raffaele.tranfaglia@gmail.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com>
In-Reply-To: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com>

On Sun Oct 18, 2026 at 4:41 PM CDT, Raffaele Tranfaglia via B4 Relay wrote:
> Two small cleanups for the adt7316 driver.
>
> Patch 1 makes the driver return the error codes reported by the bus
> helpers instead of replacing them with -EIO, so callers see the
> actual cause of a failure.
>
> Patch 2 removes the dev_info() printed on successful probe, as
> drivers that are working properly should be quiet (see
> Documentation/process/coding-style.rst).
>
> Tested on arm64 QEMU, with i2c-stub providing the device:
>
>   insmod i2c-stub.ko chip_addr=3D0x48
>   i2cset -y 0 0x48 0x4d 0x01
>   echo adt7316 0x48 > /sys/bus/i2c/devices/i2c-0/new_device
>
> - probe succeeds and no longer prints a message
> - device_id reads back the stub register value
> - writing 0/1 to "enabled" updates CONFIG1 (0x18)
>
> Error path, instantiating the device where no stub chip exists:
>
>   echo adt7316 0x49 > /sys/bus/i2c/devices/i2c-0/new_device
>
>   before: probe with driver adt7316 failed with error -5
>   after:  probe with driver adt7316 rejects match -19
>
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
>
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> ---

This is the current policy regarding AI and staging [1].

Thanks,
ET

[1] https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
