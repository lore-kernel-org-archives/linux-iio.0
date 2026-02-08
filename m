Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE52701C4
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770527693; cv=none; b=rAeUIAE+5rWcfZ4uNaA7OoUL5kfdKu7GpV4u3DZr3T6LgaosVBiEM9+MLPRcu61yQk2nV68cCOgWwjRq2elSRMeQrhMGahDNqwFj/j9f0S6CWqScmQhnYrMjsrfraNXgnf/gspKqrHptZgkpbZbxNar2G5X8ie1zBYSey4aa6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770527693; c=relaxed/simple;
	bh=PYqOTEy1Bun6QiXI4hjiw7WhkNUrL3SPjkRw6BohOmw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tMkIMpWY5NrnsUH8TtAE1XKom0aRDcUOTDadyo7Ubq7pv20l8KBFxWsKB3Qb7yqgn9BDXVuISMAtwX76Ch6vGkZu8Rf5//7LPCTW7R6w8O4x2REY+oqcm2OCKJbY+6RKqHYcjCh5fm3dn+6UuNkGADm4EwpRWQsIFAPwjId+vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umru/KtN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umru/KtN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d18cf89e72so2688532a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 21:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770527692; x=1771132492; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYqOTEy1Bun6QiXI4hjiw7WhkNUrL3SPjkRw6BohOmw=;
        b=Umru/KtNKkyprFYJPqnCugoKT+sf+BCkxFz0MUeFddecIZAfzN2y80B7IIxeu6clSk
         gVrCcNa5ebvqQ53o3C4lS5T/ZdEHWFRANQMg2JYFh2Mect0UfPBCCDyZcu3SXyxgiKX1
         4hg6AYFrqo5t6ASd58IriRoUrVZWnHMhQ8EAvfGVT/9YT9BNYYLO9DE9XisfUMLf+y+r
         zIkHSbTKtI4Bf4oQbj4M4jx4RqIN2d/MpuaPi9kwA51knaMg4wQq8D93TQuBEwJMsB3N
         RlBkqs1kzy1iJBU4ersk/PcDcxm6UsyPTv8Dv+CFewxpFphp28Dxt+6Av6OpYljnFcMU
         DOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770527692; x=1771132492;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYqOTEy1Bun6QiXI4hjiw7WhkNUrL3SPjkRw6BohOmw=;
        b=owWvL5d6cxpNl+Fm2CS0VuKNsj56zfzlkLECKQtwq0CfaJJ0gSC3ktKza5xX1YmYfs
         nDaWTOdMQtrjTqTw/BMMkFa913crpVvHGPFiGkpoVTtA4+SlNCN+cAPOWl0Ci/7lwFs5
         h5Ufcqo9kx71LS8W9Omgy1LaDKrLK0un4U/xaGSckVRhu/NDp32/8OdVrx4nqjyrpoh+
         BLFCNiYcQwPcXJN07khJbAoGY+sIdoVOBz+84Jb2B9jiVO0eyG0FjSrICbOY6TSd7YvI
         TQasbwtO/lTdSoiOgIUt4Mes8RFM9pWR0fYEBofnWI0sg4gIoax1MN9HbaGS0V8C8QBg
         QCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIJhDxucFF9rcYCInK1ubBmSFKGpqwPGlo3z3mNkq63Xevts1NIE/dCX2unZZBx2p0OLMjjyt/CDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2e9p+UNO1L8UIwcOGjnuuY86M+ppWg85oTpVOsoTzG512yYo6
	75MEmEH4u5uQQUMZlmHZEFq/iRl2fOvwMMntMzobmVBG9nB2lWYS1I4h
X-Gm-Gg: AZuq6aKkL9gHUHIiM26LbIg2P/uRpMo48F7WgOTsaExo628ZMWIrN8jyMF+QrfUXV3I
	SMvqR0IYjK6DcgxT2Hs4kLYg/+e/fy1pFgeWWeMIVTps5x/Gc1HirX6DxuIR12W1RRWyKPCmcTa
	dEFF69znBdGLhZY9baVhuP9LdVxA5gJcmCyzbzkzmCmPQF7cwdie7HDL5zTgjn4NA0/VCTooiYe
	MtuhBiRZo0+Tc6u+Ljqi2bgem4Bvgy+DgyuLNi0n9SlXayXwroRI/ZxiZ1mkOyn6Q/3wflXiWyq
	isOe2fPf0eYTiKVcSgl0wqDZG5AoFgb6mYyvutB2y5PBv15GJHBffZyPdpOpwR/X0szTr8RjsWB
	DtIrAOnE4qC0KuXcpdjARZlAZWDUGrGbJdNL3XzP0fPYlxWkJLRp1lBYCYavDGLJk504Or9yUmC
	qRmHz0i5b7b1A0kIcIFei4t0FygOn6f1CK+NazT3K+X66dmAfhKsCdeHShmi3TPFRY+DiQdAUBS
	kYe/T0YOYtxtB/eMvmtabrvSF1Kcd9WOpbIp6IxB5QMqa32L0Ffho6x
X-Received: by 2002:a05:6830:82be:b0:7d1:4f21:ff79 with SMTP id 46e09a7af769-7d464485844mr4657169a34.22.1770527692530;
        Sat, 07 Feb 2026 21:14:52 -0800 (PST)
Received: from localhost ([2600:100d:b16d:c41f:8d6c:e914:6c96:3df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4646fb636sm4965368a34.5.2026.02.07.21.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 21:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Feb 2026 23:14:50 -0600
Message-Id: <DG9BOO7V828W.2QYTAGRZ0BUNY@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Neel Bullywon" <neelb2403@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260208011659.53722-1-neelb2403@gmail.com>
 <20260208011659.53722-2-neelb2403@gmail.com>
In-Reply-To: <20260208011659.53722-2-neelb2403@gmail.com>

On Sat Feb 7, 2026 at 7:16 PM CST, Neel Bullywon wrote:
> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
>
> Additionally, replace msleep(5) with fsleep(5000) to allow the kernel
> to select the most appropriate delay mechanism based on duration.

This should be its own patch. Please keep one logical change per patch.

>
> guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
> and resume. Case blocks in read_raw and write_raw are wrapped in braces
> to ensure clear scope for the cleanup guards.
>
> scoped_guard() is used in remove, runtime_suspend, and suspend where a
> short mutex-protected scope is needed for a single function call.
>
> The trigger_handler function is left unchanged as mixing guard() with
> goto error paths can be fragile.
>
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>

Thanks,

ET
