Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE313AE718
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388408; cv=pass; b=MvfffoojK78m2J2UddrWeZmWFCWXo2boCjwEiAV4I4CXheIkgi1UqptvoZQ1gcaGe6DeMnEq9or/ua+RzzrBeC5nLmH4eXGLQJ/k5fQ7KnlBEKvtHUsMovqOOPBxtDP4Aa8fQQUPeC6LkmRRdJ4Kt6E64lsolstnr56zphSW0ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388408; c=relaxed/simple;
	bh=O4XtywALEhN3miBoCFbTYw8zeas7r4hFIoNzGoJ6LcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQDhkwkCP6tC9ReyEGnPribWMQJkUMiDbEtiIUBA7cDph7lBkPtJCBsZfW7UcBHJGSFgUU2h1oGjwQwel5mIDb9go4pPekg5dqSZndoAj1FQ90r7gF4V6H8S+9Rr6hpz/uJTLxu6a+Lk6xI3Kt6aNEu2a5ndaC4qN86RvoyZ/KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rET6iWn2; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rET6iWn2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501c9903edso11860770d50.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777388406; cv=none;
        d=google.com; s=arc-20240605;
        b=Ra3uENRKfQmLBqE7isd4QGx18tGsWkzxXj+RMbf615NXbj17C5Dj2LR52tDWxke6aI
         5IYk9MwD9eu87ovBgFgHLhtMn7+FpE060C2EGiX6+YfqCDnZ3kzuMxaZ//GgG+uvnA2Y
         NibHPnQztlWvziNjLpt/c6XgqQdFukKsEmJEeqqpdcZYaLeGXvHRqquba4ZcgShxR0on
         I5LGTbuDVuEetVvy/nZl49WIjoGCc66igkenyVMf5eR2LBRBgMCJcXebyCdw2GwwegcP
         ylFMTC6nZGToS/fVGd5jC96GxNv7xtxxgWFxk7moLkTrUELlXNneIDSpgzMAmbsuNOL3
         PF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4XtywALEhN3miBoCFbTYw8zeas7r4hFIoNzGoJ6LcI=;
        fh=3Iqr+I45ZwAPpBZrh7Pb/eqZbVHPQJ/6vS6D4fuuPRU=;
        b=U9fLFRAfCRYa4+bX6s/98K/Fh04wqrBEbPekhi6Aw9b1u7pxtC5O6x48ImCcRnzuqu
         bSt7y2bLArm0q2Qa7FGuIq58574auV1pXb0w/NX8cBlfMuM4hYnSwb4ieXfGHeVS1+C+
         /aRW3c9UYBohz86kDZZDwYsYOBosK/N+5hN4qBrXBwRoOQ/k7kbf19JWNJYYR/H431kn
         /Wgr5peIQe3EGjZ14UpNQGTAHSKrBuF77FGuPtz5aiwLIvgQkNkWSHYmLmgTgBdZr64y
         WfX2K/GvvrhAy9YOM7jNjCQyHEJrAdIW0G6K6dPJnkicwtDRQPICQnEwCytCihhn8yzx
         zU6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388406; x=1777993206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4XtywALEhN3miBoCFbTYw8zeas7r4hFIoNzGoJ6LcI=;
        b=rET6iWn2bvYZjMDQYgF5T3Hr8DX+2cp6lBoSjU5EXZC+Q+Ffv+g8kp3RCuyXnkY4q7
         UAvFjipGYZ4KRK7pmgVS5uFvcbLH5fR3JsAvJTt2sFuH32USqh9juSwt5ApTjyMcQCpi
         1+1tqpJU5xd6uRTgyKBgnwLyamL37+QT2FL1pGR9KpHrMwCVuzqgAANYQNsyIOsp+goc
         TovQaXyWYjqqdQ6VH2iKeW7RHMZlAe/7UfFuHvsofWqdjnpLBCluRKX/g1ptzCs68pHW
         F0RceKvesy0A6TnKx5+pt+qlJ0KvdlImy8nEAR/zYvJ+43RgMx7zQ6hDjAqQoMobRv3k
         SGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388406; x=1777993206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4XtywALEhN3miBoCFbTYw8zeas7r4hFIoNzGoJ6LcI=;
        b=e3kLFRPngj8FcFnUrqd7PNVSMEt9bkwaFozYtTHy6J3Z7u/VaZAcHHmHj4S3pOa4Sn
         Q9dyhx7cHFCF+rlaPhgPX5zninORRkSAC/MW8HsFYtpy9EHjtm9+nlIzQwKgO+IsQRyp
         9Dy+SJbejA6PoCdhye4GZuN9QR/jzStrpz3S9aHWdWD6+/p0vsu9jIPoxv/f3hx5FFm3
         uME0pLfYg2RrekorMO3OF+ImKGTwQAzJUFxlXQI0Tpas8Y285vWwvQ0DSj+v2eQ9CN+B
         xaIQvqR5yUOJbFWQizyd6A6VRUb705UjHZyhBtHbbImJ1m5LJ8AjDrUbRHDSStOVGoIL
         uhnw==
X-Forwarded-Encrypted: i=1; AFNElJ8IhH9W56d1ZGW0cdP8AiamHmiNxxKeXtDrAgRl2UgPWH/BKv6XQBphmjbeyAIcHwjVJO1X2xnYOgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCx5forbD7T3NJ7lSkYqOrUfzZZ8rwWnebr+IzkcOPAr3Cn8R
	PNb5D/S/R3fZnTWn4XgHmuq0G8eHEW+8EJ8UQugQGtv2wmhd974D+sWzhgbyXqrsedbODflMF6S
	PpVMTmHVTXyip1vHj2TQ9FRNHwGDIgBw=
X-Gm-Gg: AeBDieu9ffHoFQ8vZZFf6jLDTi3CIMJlRFF0MwPrAaeOrrRb5IayRgWZcl6D01zeBz2
	78O8I7KeJb16gQ4kkiwMbtnqdGqcbYa96tvlHgp4ZTVTGzvdLitcrm2LwAq/6lR+GwSO5IjzZ9k
	y1u0ipkb08yZVilavHPGswtnMuhKsgVq0SvaB0aagWcgEoiG0V6uwKj6F9xDdlsrexcbN6YXeE2
	2s9MLbsBFl74CHYU0sddpBsCRVBc7u9EQVAGt+3j40Zcxsu3St8r6pv+CsGVcxhFiHjusfmEFMe
	um7kyRD7lOACnzIz0ja0iH54F6YfeT2bqrQIndPzyh4Pq0k=
X-Received: by 2002:a05:690e:1482:b0:650:3064:4cf2 with SMTP id
 956f58d0204a3-65beed3a8c9mr3111120d50.5.1777388406129; Tue, 28 Apr 2026
 08:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-2-m32285159@gmail.com>
 <afC1atIQYUaFBya3@ashevche-desk.local>
In-Reply-To: <afC1atIQYUaFBya3@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 09:59:55 -0500
X-Gm-Features: AVHnY4JHHVKIDsq6uxzXt9cXjz1iHDU_olJ7Cp2br4AG_C4-a6RANEi57CWCbdA
Message-ID: <CAKqfh0G+PXj8sDaJATKJmywghesm+NOJoEff1bC_gsncHQxwnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_read_mag()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:26=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Perhaps we need to also put a summary of the extended critical section, s=
o that
> it will be clear that we thought about it and decided to cover that small=
 memory
> access + some bitops.
>
> Otherwise LGTM.
>

Sounds good, but I'm going to wait 1 or 2 days to see if a maintainer
wants to comment on whether or not we *need* the summary about the
mutex scope. If they don't say anything I'll probably just send a v3
with the summary added in the commit message.

best regards,
maxwell
