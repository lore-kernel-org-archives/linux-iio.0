Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87803033D6
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779569672; cv=pass; b=FaT5l6kZ5QvsfYWhHeRavnAlXNPhc/EtdyLyt48DSjFH/ONmHZT0l0qdNYHJ01Ham3jLZ8jOG+6P5jhfhk/1tMiF80P+DY1yLWGYhFmHkbBr2kl35wRNwFWEnb0GikP2p3UgpWsHtKnmkX5O9bMuM69OA929qyGbV7qhJ3LqLNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779569672; c=relaxed/simple;
	bh=llkDph8CaeEIwaFQ/4n2RxY0PvCWF6up/xO6UeTBgP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR3CxHCgAekdoe86dw3X/v5WA2tMWcNX5T0V+ZXo/aXb+wfQmSfZh9aCPeHy5XiJ1+rmw6T5PJBMnUSAqkaIJ9qTtOomT1Fzsv++Q3J2RWt/RZEtAsydNTAwvfQ6cHzJlFlwAJp4KKULBfV+QM+T9OO8GHzCms/WxkxLMNeGIO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgANgFyh; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgANgFyh"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-441209fb77eso5310921f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 13:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779569669; cv=none;
        d=google.com; s=arc-20240605;
        b=V3VIO6ej+mJLPxfUkNPJygTnxwhjo6R9LkEfUkxfcGoIcGA5RudsPcSV4r/3ywdhVz
         btN1ewBptDxX1Uh07A65WHhL82q+CALp/BY3eT2HPLu4oXjN9fnum3+JzazuP8fGF0FV
         ivP9Tp4JVA2JCDhqs7dRL8tj4nJvEcUukEbsmID3Twmjp6yze9eqjQl05QPnvUb9UhyA
         P8xGteJo7V5GZfTMBewkRvXIxYBGR+UYK1PsoeesGpFMaqZjytDM9dYWgt3ZSZl8NRha
         3OZpSKcALQiHY0tKQhd8e4NSJHCZIZcZFedRnGmRotNhs1oIqV3HGTQ+9qx6uFwoyZPC
         XFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kCv6JSLB7T8TK9SNxG9TdID/em+0onBhk8wMREHbIoQ=;
        fh=y32jtTzG01MTHWRkCrh5Zo2ZTQbkFHyLkZ44B/kQeU4=;
        b=EP2U6GMLZnjqpUircl/16dlHbggEqTtPhL2GDCzTfWWry5RzOs8ONitoPGBWLQGm5A
         3gN39LDGNxTLBsVXPwrgEfKaXuf6dUJzeDPEsLds1VZApLJ1Qc6i28CWB1GFfHnwi6ZL
         nkqm2kFKbx9mE4FOA5kzBlGiJaDdimKa0DM5tulKkJtL8PdwWtg7nWcpVxpdJHzHgbAk
         aIyHVPVkzDz+Rmh3kZ7w5tJ5Cu1C5doVw+eaYnasZFBqQE2yaXccgl07CIiXQWcwoDn4
         1Z+XW0EWIxl8w+w+eFQwyNYGgIh0xeyf3TQE6H5yFLSOvOjLw00TcD2oGA/AlOqOfE27
         //Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779569669; x=1780174469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCv6JSLB7T8TK9SNxG9TdID/em+0onBhk8wMREHbIoQ=;
        b=AgANgFyhYiReFz07FFJwyl6334VkNf56ULGEfYLW6sPPHhE1GHW6ke3ePk6rwpW54+
         H0ssNQfJA8ZgBp4J7NHskgc2XlomMzdNW7uSs6YRpkxyR9mKmjdIKHMLsB/ikAKNq1hY
         KKLf+42FVR2j1adNDtHgZerQRX892ussOKJu/+Q0zTHT+SqV16ghny8XA+oKHPpBRTmu
         rYhUNf+yEVhQAcEIU9rtz5im8L22kLLv4B1rO8mUPssCHAtK9yD7gvVZhHlc1e0XEcIF
         L+yg4mQZlngzDy11r5wJN5UyZ2F5TiNWE2dQtCdOxDvHVRIRO0caIL8xaGrPezdNCpjj
         oUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779569669; x=1780174469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCv6JSLB7T8TK9SNxG9TdID/em+0onBhk8wMREHbIoQ=;
        b=QdkxP1eZ1HSxPLxXV5nzt4Qmu0g5tSXUqbX/xwdisVx6rOOagmy9Ytl0WWYs20L6wQ
         MtPErGLJyZ5ZjO+YKt3fqR5Cso19SmNYbgu86oNiAOQgyPtrZ1QnciFnb8JdKJHEqiGt
         JPrWBEdJeBtHqNSrFj/uk2JzIWXk7k8+6J/vO63Dd06kM1VCKI2YOOIUGVHRstxdzhix
         q/m0+GlijSwpaXc2ob+vcCume4Xka8+YvWi5ovagmkqs96rf3HmyuOgaU5IZHZfXfZLl
         iRb+fKpG0eIv0kzNGOYgxsH9t38V6C38mUvhAvzUNIL+Tg1rLU9jcX2WRw4Q/nISEZM6
         nrNg==
X-Forwarded-Encrypted: i=1; AFNElJ+/8ScTZ5GP5EGZTnKJ/tAcE5Rgv3GnieJ29ziB0qciMgS7vpyWoyZ1GpUvJk1CBxClsOuy3D/C9oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqkpLxObhAJZD7P6+44ULQQbYDAZSU/aM1mMzk+xk9Jjdh7vp
	W69VBz9JUIlv3f7Yk22eBH4GT0coeCuzs00cVUUYMWALDHwNg/DEV+6UhoOZlMEpJVgQbyHA7J1
	WXyJRhKVaQAaynxr38SO05dS5vt8u02g=
X-Gm-Gg: Acq92OHqWcVopDAeBW8KT2C+nH2Ezxr4gq7DlcfKebDfcTVPdE7AOYQKNhRngSvl4ih
	ZRtXuH8UOM0PQLJCoN+23NtZdoOu+uj/yeEiSpiqDCqUxwOB4qUUxBkYQrfH30ugie8Sw2FEddF
	eRJ/QKNeX/VX0oOIuBIly3ub+L7XxTu1Lv/oYKhpwKraXYgTewQfdjArg7s69Ejw6BvnVI+7EFl
	PiKH9EalzC3LBqoEWW3rjiUBBzkfUKnK0Mrs2hXiWIvnLzyqAobZZwXWw6hyHNZUco60nG8efd6
	xWmp9WUje1EiGpnGxCtI3QkkcPtwnZgLZPV4nvtxEgmP1VynclvtmUIki1vttcMJ4obnYpBG5rn
	0U1Q8O+9FEbkMAVAtsJkdQ2i2Aji2R90Ryx6q6ALEUqUxDROQz0VWdreZj4+E+PFokrpyABTBSg
	3MHPUB87eS1NZ7nq9m1BmhP6nBLxeXledgYr3wu+k=
X-Received: by 2002:a05:6000:41e4:b0:45e:73a1:8d04 with SMTP id
 ffacd0b85a97d-45eb30cfd63mr13469348f8f.1.1779569669132; Sat, 23 May 2026
 13:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523184418.7586-1-sozdayvek@gmail.com>
In-Reply-To: <20260523184418.7586-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 23 May 2026 22:54:16 +0200
X-Gm-Features: AVHnY4ISdo0XzdwWid_Se2d1M88zggrBDJsCiUkjYUj4PAOwY3aBKGNmKWUTcpM
Message-ID: <CALoEA-zXqy8EKubvAmmsbk5zY2UKiFqkZ0KwyjFwmNvUVy1J5w@mail.gmail.com>
Subject: Re: [PATCH] counter: interrupt-cnt: use devm_mutex_init()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, o.rempel@pengutronix.de, kernel@pengutronix.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 May 2026 at 20:44, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> interrupt_cnt_probe() calls mutex_init() but neither this driver
> nor the counter core issues a matching mutex_destroy() on unbind,
> so the lock debug state is leaked.

A little bit of a misconception, however unless you compile the kernel
with CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() will translate
into a nop, so there won't be any leaks. Nevertheless, the devm_
counterpart makes debugging easier, therefore

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
