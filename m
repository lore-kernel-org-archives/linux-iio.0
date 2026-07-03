Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394B37CD5A
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068630; cv=pass; b=Q0YAtlBYndU3nZ7Mh+IB+TiI0UMBNOka6qCOCT4/Q7n6xSoyK5IGHvfZGeipo0Z1xX3OSZzeQDeniId3Q3ZMVAQsY2FZMLwS2dOypdCsd0PYuj7AZyARxAzXh5mwUQZ32xtET1JgBF+hzEef/Q4Eze7kEpiErh4TPDk8pi/EUnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068630; c=relaxed/simple;
	bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu/1pYGn9CCn907fynRGqmKQk6NVCLCuc/DjmGqNcaOexU5PD4tjgpkOjFS3l66PPgelzoSpMxNRf56ebGqTitJCFnYa1AT9J5ycdFSklsTzGIuvWpLscwrQUAU275WaeziSpFD8c0P2W/vYfmNlPVKpLpotPSqaMFVHGkBTHmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp35/55s; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp35/55s"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37fa06b39b4so293014a91.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 01:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068628; cv=none;
        d=google.com; s=arc-20260327;
        b=UBN/xC0FFPKc3zO6Ly/npxAh3/0zI+NUpFUXO+J5fuy9ifGTnKNhrdoSfWIX1j9qYk
         CSYMXrYMNZkP+mi7tCBcirYpwKLBECwOyQrKi/arX4IzfyKzOuY9ov3K35GkUzts6KVz
         urOpLxj0nOekcvJ+55Wp6+QJxj0q1LMNUBhor96Eq5ZKh8I2toMdiOkTr6a1V17i3Zk9
         +pSEM3B5LnH/LsbYbFEaG/QkUbj4j8rcI3zInm942k+6q4CffYTUuAjUEzW+hrlSRb3Q
         /ipZPmL52MzvF1RGxdgUf1tUSPZcr3quJFOfzYHFrbY8wZbpmVDAZ5riYr5AdU7zNhfr
         Q+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        fh=AZkoEoRqk48yl1XszKtTekTtIUBorXtdTZ7cXgtt0YM=;
        b=QOfFfNroLqQMOdC4MaE5PJDNIhqVmd2IQNu/FqeUQdME1zojTCZtWCKMIXjQb5vYHi
         avRKwzbQPSlCzi2tRswZJ2vKwGiO6ItBgOMcVD7oarNPa1jX+HGHkhCV3KmILWZtfRqF
         875c39uvZJx5tcYj/PhO5WrshDylqLzab5is+YmfE5NLUlr0RuPms2N/g3HEnCFucl2z
         j/hTJRdp7vPl2Oy4DBnDV7Q0byDIwMtg2jnLLI3bBCqhSb118H2EZ9ceCqhXCULeG9zg
         6tzEkm5GkSVg+mucacY+0/4AQRL+FgvtQfq7Q3AuOpOBcDvxcK33QJY8raM3w71JZ7xu
         w2Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783068628; x=1783673428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        b=Yp35/55s2vBK2gEHGs8sgoI4osunm/jZFHkATgRYASC18u4qN6qcDOA83y0Cdxh+o6
         662moOywNpzPRSm6IfkxhQGHxJCFKGZuWl7sBT+LyeT8WG3ey8TijM8RdF2Wb9UG7IHf
         Z+u8B/sfKHEOfDIhY1mm2KEYg7Hd/7HHLOj5jVWz0EzKOSpm8yhwNRd9Xa+5gBtEt+qA
         J1yriTyygEOyXJgZ2983NY98/f9+OH9YXN6AoD/E2fMB+hnW0yiaFpi2qnP9Axtd6LWw
         Y19k/WHx59Oz1dyeGCfMHMJSwufeMXvUd+o79pWRAM7jVwsUyEbjAHBnvzl8qk99dTuw
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068628; x=1783673428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
        b=hK3V7wQKTfOrp7JAtXNXTkQpLO/LIw/nF5ZLNUfQO7ZXd2LsMeioXYFNN2+cKWvfOC
         CMTsMiDR0Sm9pQuMB1z2NiHA2eGN68YomZfuJ5Xv/hPGLoPXowrMtvFfb3KAVM0+4EmZ
         1a/7yuT2fHyWZ8dHu3lmKB8Iz9iwviJsXxIJIaQkIv/HfIqKQnYUheDgTsep7WZNUBwI
         DWrIzR1G2RYXF2DaQtYIU7LIXZ5eMMextElG0p4XZFtF7mkEsiSruepO+vW3b2lejtSI
         p6LcnxJj7TYKY5KlQaUQ/7tpAeHQiElkP0LaSUHxAf+x2ukNXwlwwK8e7O2HcnEyeCQu
         6z7w==
X-Forwarded-Encrypted: i=1; AHgh+RpnJanXGs9O02iGwDYtCVwA3hm/rKsOeJz9DXbsVeEQuqhVrppyu4qaU3REAzOWOiZSIjt08nGPuJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoATX122rPEKpeJorkCQMR3AP4WfxTc5lQEePp6zAcmqnpKPk
	xpdtlGG2+73TW2ZBX/YdJUvdOi1XTM+zErvbnKkgUjUrma5xoN6uKpG1r4wQYoVWViyR3/vm1BN
	9phhpXtTZqSdDg1G8sVW348Drfp1vAkY=
X-Gm-Gg: AfdE7cn71X/kdg8O2QzpJOlivcjm+Sf3Xp7Or17mSyXShwng+hpMejKEvV9DxAkdLwu
	BLT4l4OvsrXAFLU0M5xo1iyRpPmwtWpqfnbVVqK0UMFg+WDE/8b/VF7ps0eXFAsUEbpqcaw7Dxv
	3UgPAWAQGUKLUPkv5M7Br9Qf4YSYBBpEKVOlAXuAM6e6XhFNZaJzRU8y1dERZznQnWjmd0LGHbt
	RxjYp50Xoejr0HuzsbUu3tanD8FbPxGag6uvfB2/CRarsLpAxkN+WydTLsQUFLcqwSjjahKZ3SZ
	rSFUTwknsqTT8LFjaJAOr/FF3N7jlg==
X-Received: by 2002:a17:90b:4ac7:b0:37f:9ce1:cdb2 with SMTP id
 98e67ed59e1d1-380aa212cd2mr10449000a91.32.1783068628598; Fri, 03 Jul 2026
 01:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 3 Jul 2026 11:50:17 +0300
X-Gm-Features: AVVi8CfxYzwSfzZ6fk5dLYRyOYewH3BnmAC08YjOJmTVCgpVqq5v1ruOm9aDpBE
Message-ID: <CAPVz0n1Pozgz8DBt5BrYSktVfE=D5E41oy+fMODGpx-L-qQ3YA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello there!

Jonathan and Daniel added their Reviewed-by for IIO and backlight
subsystems, so I assume that should be all required.

Best regards,
Svyatoslav R.

> --
> Lee Jones
