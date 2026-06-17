Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A04A33F5
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711642; cv=pass; b=nPr9GkS8lbCbko2jBRbDocVxbB0/80MJQWfERBr9GfJjUpGyzsP6TOkETpD9TMjWCDhBwx9MMIqyrm+887QaTcdxKN0OKM1BkQdHATmLCqL/hwfGPW7DwcQ7z5LvgXr/fEyRZdDU5ZmuQBtU5BmSofuV49TSnDvIbORP4DlEjFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711642; c=relaxed/simple;
	bh=HwkOBNGuMmjPEBGim2YTX/UqH8HbfazXCr6M1UjmBFE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RKpyKhybCnj1UY17mIldE1jDDVBJuXO9iQeZYKyp+dM8scf1xarUXHRBIkClV4dIptsvgx6xCrLp7+p5MPBErLJpqsQn7jOfWy0wuI5w2HkJ1fggsLJ4UFqhKJ95LXsU5XXQn5NODQ4JRspWujehBQJwzxKoS7Lq+74YHsFxfl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS42O4qt; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS42O4qt"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-660323f7b27so6034216d50.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711629; cv=none;
        d=google.com; s=arc-20240605;
        b=WjAu7jEq3EmvhvMAhEvcCRq+y00X9oHzInTwrX2y6V8ykYwKdEz5SIPi3k1UVvqO9f
         PAMPRNmIEldh3oo9nT+lVfX5Mx5d8agiT4dC5lgsVIvygm3YW+nFuU/WEHvZYbQiPA4o
         wsLmN2/VRU/2gQBVyzt84TfK8seRs9miU++ZEgPx68Y5H1ZN+rRWHksqM0qhXEu0CQme
         7Se6OAUYErJRI6S7LrC4MgQfa03HE0+Ixx7RLB9jaOtgLvhMeGRK2MLPofBjE/uYdhUx
         IbwlgOKNVUbc8WXIsB+3vvdBget+B7FvLbqjIc+AjkqE/2PCEtEzl/RmyTgt1h4K+zMD
         fgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=krawxfFexxauz/ZODpQ875TR/9W7qihi6I+2HNWCz9U=;
        fh=YP3oI1It55yGo3VlGe76G3UR4PkLE78fswgYxT2egz8=;
        b=JbabxkT3BtihM9NI4+xpwQEpPVGbJYLmlaVEDoa1InmKzECcbL25hzA3cY578km0IH
         8iVaSb7nJ5XrlUldKmiQKEtIizawXYathQpNyJq0zPlo8lnRW5fB+ZjwGRCsuUO0p/jr
         RBFXiCJiFngxuAgy+ZDa0q9+1/RkVuXbIqeV2Zp7wFLLtO7rIfNN7xQ6zg/Dqs5VB7C0
         HesrZxHp7eFRqp2Gi406M2/H9Y3DzYftEYdEKJzFg9WvKNh8NmfmaluJZ4thZLUVUMCq
         3F9vl1FCDrrHgEocBONLyXOEwlUUyxYGlWBAYdbsAZjKu3mai/uU/dDCQrZPMoeRg7sK
         0scQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781711629; x=1782316429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krawxfFexxauz/ZODpQ875TR/9W7qihi6I+2HNWCz9U=;
        b=aS42O4qttIw148dbUBisUzU24U4jwfFGzqHbYp5KCQ6dxBjec4EP4hut3ZtOluYvX5
         oKJI8hRfBDMH7JldikVlxmaiJCIzxFgifKtfgP+7aSbpxIYRIxgDsKbPjVJ4nEq2i7S/
         ZKkATqL+4YuU8t3UvVqiijuRTl3FdDkRgsyr9dJte/TRJSpv0WESFLcxAcojwnOCOXoT
         pOpkCTg7Wz5nb60OrKtJexboxyCLPv+/LhMY6vVr6s4YwMUDQ1B2jhCMXVUUv+b94nE2
         SGpIY8e+8tDwTDyS+prL7EzQiwgM/SoU0zbes/kSxZKjCqhm4Y7Svh5W/VgqXX7M5IO5
         HvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711629; x=1782316429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krawxfFexxauz/ZODpQ875TR/9W7qihi6I+2HNWCz9U=;
        b=hjN8YFakcY4NiQ1FVf61GP5U8h43wjIfkbn49GfZlJ5EadIAHF7uCfp8k/iI/Ierye
         N61Cu5S42LxcXCGQdQGvSqy5bAU1mt39EAN4RVRWJ++dwBEbeHxRa0vkVv6fhcwfXHVZ
         Z6AAOPk7omRjLSYgQ/7V9NhqHfQ0q1rnfJD3TmyYeiI0AupC1kYqe7Rf/XRuskoyu5WL
         sYjG8izuz1OBdacc1YF17JY5Lb/0cR3C/VAAc2KtiH8Uxi5PmdlPqJEzkVDy6+PUbdR8
         CZ2dkrS8pPisDGN8Bb2zBxmdr7J6abglW9V1x1t00jXV4XsN1wSUrVtiwgwliwJPHyAW
         wc+A==
X-Gm-Message-State: AOJu0YwKz0pdHvlaUYVt79kmUGsobm3F3q3ymNQaWQqb985oWM4ofjfY
	S4lVarCbcQUbMUvtg8DEZMMXfxta9RjFgtCVeg1aBhFVVUqPzsrH6ALPmAviMNOafdHIl4C4bGn
	TDbdbk79UQyXxbb8MpRenm9cfQRpjLZo=
X-Gm-Gg: AfdE7cm86DjZAWTpebly6NUYhy1eFcuUG2Vqax0zkZrFAYl5MVpp2apzoZWVClU1ajV
	L1FFokQiHssnYhNzNihB11mxtYj0V24CtES1rbuOvefE3La+a0LJpEdtoq9d6aXMuZIyaup9vnk
	/BmAcm9tLToWssInT7lMgmE4naFByHD+H/f/aP6Hnulht+kQUMZPJtt8QC+Xv33b5m3+W5JoV9a
	H/yDJktsdvGxJlDN14jfF8nDPC6GeF8IerGutlnioFhqxtQQC2nPY2/SdUfccwm24DPj/xW2vsO
	SJW2IDPAk6P5OTXaJ689makPbCkvjiutQ85Frw==
X-Received: by 2002:a53:ee0b:0:b0:662:cace:11f5 with SMTP id
 956f58d0204a3-662cbceb921mr3026783d50.56.1781711629417; Wed, 17 Jun 2026
 08:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mert Seftali <mertsftl@gmail.com>
Date: Wed, 17 Jun 2026 17:53:38 +0200
X-Gm-Features: AVVi8Cc6BHNZJ7_zNzfxQNdwKFhxdsroq1z1KG3jsAQ5krkW68TJqXkhR8eMVBw
Message-ID: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
Subject: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: jic23@kernel.org, jelle@vdwaa.nl
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been digging into IIO to learn my way around it, and the dmard09
accelerometer driver caught my eye as I think its scale attribute has
been broken since day one, so I wanted to flag it.

The channels advertise scale:

    .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),

which makes the core create in_accel_scale. The trouble is
dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
RAW, and SCALE drops straight into 'default: return -EINVAL'. So
reading the scale just errors out:

    $ cat .../iio:deviceX/in_accel_scale
    cat: in_accel_scale: Invalid argument

and userspace is left with raw counts it can't turn into m/s^2.

To be clear about how I found this: I don't have the hardware, I traced
it through the core (iio_read_channel_info() -> read_raw() with the
SCALE mask) rather than seeing it fail on a device. But the path looks
unambiguous.

I went looking to fix it properly; add a SCALE case returning the
sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
DMARD09 datasheet anywhere. Digging through the list archives, it looks
like the scale was declared in the original 2016 submission but never
implemented, and the driver was written from a vendor source without a
datasheet to begin with. So I don't have a real number to use, and I'd
rather not make one up.

Hence the email instead of a patch: would you prefer to just drop the
scale declaration so the driver stops advertising something it can't
deliver, or does anyone happen to have the DMARD09 sensitivity so it
can be done right? I'm happy to send a patch either way.

Thanks,
Mert
