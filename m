Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45C3563F6
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737338; cv=none; b=Tq32kOH7LUsvQ0NsvsfoLfqDJXd7k/RBWjRGRIjs/3uFqo05tNGMZ8QMtzv5I9kJqu5omhdSUsvczzRTVfFi5+022QYYZSpHfTq4WXGx5QLg6a+BqpSB4mIpx5jy69ueEBlsLWDM5LJfKTWtHuy5K47XlGB7tHQAGBu6gO9r/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737338; c=relaxed/simple;
	bh=VE/QFdE7A6pGGU+Ppxswa+drIXptP86XND9VPgIcTqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwm4Y6DkKkAzTgdrx7yzS1OR9T/myvjTIw3XpLvKGXVQYr1JNTiO4C8wzOfTU0wayfu94TBnMFwFQxZ1rJmdDeUR8JyPg+F0ESBRT/CW6UUhhkmBlfsGCSD2/I/zoBO1GCHihf6E50gYlLnuN56KKiVB99teUFOi6ChL5aqDR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxqne31c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxqne31c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a168355946so8635265e9.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791737322; x=1792342122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HphZQSujEUB6aVAgGUZRqNc8zkx7WZOJuXz3x+2nopE=;
        b=Bxqne31ctH6q52eMAneNl/XovJ3dizzJBV0kmej5GA0/jiyj4hT/4tbq9NImYEIBAF
         bRyG0VnVT2Jo1QCMxt7prAnZvgZn5iYYb7p50hClZWymqQT2JdeiC0dsglKGFIKFHyZ8
         g7cEhDvHPPRJf6De+prGTN8KFB0b0KX/mX2YXqoh2CEi1sSNTBtnN9xaAAWxk3YVok9p
         mS4/gg7k7Rc85apkDXXoIgp0Uk7n3jhnoe048/vfULxEN9rq7QA5tTJ/xnuKSpuPlVx6
         1FJScjpDlbiQZCdkFlKtJc2SbHlyzys1pIZBcABySXDgBYnHmujlLR6vDSjooIPquVUB
         shEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791737322; x=1792342122;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HphZQSujEUB6aVAgGUZRqNc8zkx7WZOJuXz3x+2nopE=;
        b=EodhfF7WUPmNtec86+CmXWIP5DM/svxQoARZs8xSkMcROObSmwrosb4Ae+vjO3iM2u
         TfqPg3zebzXouKk8fKTtv9AvNa4BnxZs4WidfPR7yn28WJliK7KocWb0GUUrSId5VlEu
         oczXPKyIrQ3dQrc0GVek/4J4DZxIqu7c4NX3nnE2wXegjuDq6CBklMZTWdWwvqTR2Gsv
         lwXMEsMXA//AhSQDQ7xtugNks//3W//nuLDogIeicOuYOnJ+qJTkGYoA0+8dMK9TQ/5j
         RLZqcIQac9Cx1lI1aP6RzjYY4G4wfdrS3RdSh+4SiQ1Ot2jSBujeIOADF+4yRoQ+sMIS
         gRvg==
X-Forwarded-Encrypted: i=1; AKwUvBxixp1fQHlalIUHnHqAuS9j4FSPRtEwO79jxs9egVHQ9gVALpUvklbg9g5MnQjaUr7CrSuoBxLXAcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/h7A0JdzbLBdzW7NQeHziP2HP11U+tsus1NI0D/lG3NlruqYM
	572Hvrw0wAbDn5XB3pA8r9G768PRspJjVRjgB2+LceDNpRlHuVjo8xPD
X-Gm-Gg: AYBFou0qSeETnmI0liyO4BRw+VQnvMwtM4e/gbnJwxvuTJn7fl8OMEh4vgBohHuM+L/
	wReOLMK3DZrv2ZjdK8v40pIHkM2YzAnIoUlcXTeLZp1j4xzu63A7KMkIA5OG71ikS+VOgfhAcEr
	fqD5F3Ny7Rpo6hGIs4i5s9GvFRyA9A8OH7+1wqLGCyZiThUg0x1jTvAjlrlwifQQKCtrFlWSlQL
	LPrEfTaz+BPeKfy7F6m9FCd/xki677PKpLklZVyV8JGr7Rz4ijnSKKXpFh2ipXt/SV6c24bgPBa
	MolUBKyYHvvrtJ3YjU3ylbFDPrhUTfsDg3ZQh4NS+b4phQvBxwCowkxoLof+DZVi6wo60Bp6M2t
	XuLP0dRQ2aueNbwOCvDIfaEEY5lC4RO8vSNX+2eR1WMGju4ctM6ff0cvew+2xaH8brrvNNsA4HL
	l2GYorg93Xd2ypHSrpX24jixcjRYLvyqHqCvSxZiadxzR+KNhKS39zT8OF3APNdJzgE9KIm3uXt
	7z8DfIpsdskNrG3BjrAJghpR0zkcFm8dLEdlKd5UMcoo9dHrwuZKjF1zKDt669hejkPGHyKx0ah
	1ZsAYvtA69POdTnhKhefhvPn1xGUPov6Mu5kP6HLGbS8gTu+UXng1DSTX9tCkqK0iWgeH7LkR+K
	LuzeE3nuad10L80CkQy2Vbnb95A8F2EA=
X-Received: by 2002:a05:600c:3510:b0:4a1:7033:5b55 with SMTP id 5b1f17b1804b1-4a18e4cc437mr152326015e9.21.1791737322002;
        Sun, 11 Oct 2026 09:48:42 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abda3csm15577697f8f.36.2026.10.11.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:48:41 -0700 (PDT)
Date: Sun, 11 Oct 2026 18:48:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Zixin Wang <ywp1023456@foxmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: light: cm32181: add support for the CM32183
Message-ID: <20261011184839.4d62884e@systembl0wer>
In-Reply-To: <tencent_C2E579008244A394105247CCC4787391C209@qq.com>
References: <tencent_C2E579008244A394105247CCC4787391C209@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 08:48:56 +0000 (UTC)
Zixin Wang <ywp1023456@foxmail.com> wrote:

> The CM32183 is another member of the Capella CM3218x ambient light
> sensor family. Its device ID register (0x07) returns 0x83 in the low
> byte, following the same scheme as the already supported parts:
> 
>     CM3218  -> 0x18
>     CM32181 -> 0x81
>     CM32182 -> 0x82
>     CM32183 -> 0x83
> 
> The driver falls through to the default branch of the ID switch and
> returns -ENODEV, so probe() fails even though the device is present and
> functional:
> 
>     cm32181 i2c-CPLM3218:00: cm32181_probe: register init failed
> 
> This was observed on an H3C MegaBook 14 (Intel Core Ultra 5 226V, Lunar
> Lake). Its DSDT declares the sensor as:
> 
>     Device (LSRD) {
>         Name (_HID, "CPLM3218")
>         Name (_CID, "CPLM3218")
>         Name (_UID, 1)
>     }
> 
> on I2C at address 0x29, and additionally provides the vendor
> initialisation and calibration objects that this driver already parses.
> CPM0[0] reports a device-id of 32183, and CPM1 provides lux_per_bit =
> 2200 and calibscale = 265859.
> 
> Treat the CM32183 like the CM32181.
> 
> Measurements on the above machine confirm the register layout matches:
> the power-on value of the CMD register (0x0001) has bit 0 set, which is
> CM32181_CMD_ALS_DISABLE, and register 0x04 is the ALS data register.
> With this change the driver binds, the ACPI-provided initialisation
> values are written and the CPM1 calibration is taken into account
> (in_illuminance_calibscale reads back 265859). The reported illuminance
> tracks ambient light without saturating.
> 

Code is good, but no need for the above to go into the commit message.
I'd have a commit message like:

Add the device ID for the CM32183. The device has the same register
layout as the CM32181.

What you wrote should IMO go under the ---.

-- 
Kind regards,
Joshua Crofts
