Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426363C197F
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964865; cv=pass; b=K3GYFSjhNXbJbn0XPat74YRl8vZSnMpWGfpP5HPcXq/9u3769F00P7fS5rlqSdf1ZAjQFfjzRBLKNAgTehUpaZtZ1URGiLS8o5I9sJEr5CB1YbHmNNOso2KM6MOLAAsuWCfaTJM7blcrhZdi8qz1ouuX7XRdnxThR1mGEIcwuG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964865; c=relaxed/simple;
	bh=ZdeGU2d7WRFu7aeQxQgeJTUiRsF3Vbv8i+nXpkIqXdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/LQ4jjU+2lPjg7tyHIazafVAIPCCpEmcYjutQ06DjII4GJtgMwFrenIVLLH5qaSM548/sVjd1VsNBU1xoNmtOnkZIJT+Xq/pnp6PbKK5kmSJ9F//UPb0fDZcI6YRy86wkr+fvmu/2oR9J+znILVPRFdiiCATedsYj2fyf5fvbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdNl2A0d; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdNl2A0d"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe62837baso2582697f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777964863; cv=none;
        d=google.com; s=arc-20240605;
        b=C2WHdf6c/tL/o4GTh1c3B/vBBnd0AIV5vColYmi7AbAas+j0wJ/eOI5ZRi+Nv8TlUb
         u4SZTehiRhESasUiG0u3dWOnp2ElCqqGt5ojpz6yNdm31/YZ2Cb7x9utChM/t4Dyyb7r
         prlVuoitBvxfMgRgIQrqLF6fxTG47S7Nd0bNjHEHkdkVvtji36jWTeoYLJ4PgePYAg6V
         TYdnqX7wPFoJW3ePvBfaz3J04eB/OhVhY/t2YUSLCJPVfOSLOdZ2LM0EbFar5RdRK5ec
         6Cfx04t1+4lUjRlM0ppNHgRp/0c6iSX3029v4ygCOjbO3S/fMHuXSv2Ukj/4Eb0QolAj
         OMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=splttaUbTR2a2xlXdzRLk/XINh2Urw7Z9q2d07yHPBU=;
        fh=r3oQpS3Mi013XLFsU5OdHaw0+eRx5ych0cI13GD1U7Y=;
        b=iGuN27g5FV5PIPAw3hMh2vk7Ktc5RYbm0z83IVvuEaLhesdq5gidl5s1ppO2vNpFKa
         2FurmF+mtcuDyEgd4MKcwBEwQQ5HzyPtxJ2GN6BgVGoDJGYuymjDlqXuDZCEtDBRl06E
         CYZGpad38kmKrVsl0udtTiSUts/ITTj09zOTP8LULc/tIG5KuOhSiapNteJwdBiA/xHC
         JCQJ5QBDehy9pXDheAgwfwbYq2zrdenSfZeSQGet5kTPB+Ie/axITiIJa3Bo7TC7nhSD
         2VjQ0NQZoYYLwtO4hS2tIFOBUfYDEofBDlOVI3+7t9VkK2zXr5G/UcT3qdvhp4PTyqmP
         ZavQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777964863; x=1778569663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=splttaUbTR2a2xlXdzRLk/XINh2Urw7Z9q2d07yHPBU=;
        b=OdNl2A0dWodcWx+YEw5D80mQSt+aegzCOiLnDR18eYoQG6rXefd0AlRR46uofd+pPV
         RxAcQofQvh0aZMkO/QbLymMtY4KZXnzGNQR1vx314mgE5VJUeEvMo/bnnHMOPVubHw5g
         esgegoGYabkpH5VPO7Ndt7pzkiXwVUJZ4xdyVsmhsKB2n7cdrx+CAV9wfGxoHZfYnni9
         nbz8Xvg2qNoTOrduOBLm9AG8HigbNxFf8ezbQx4FRYZhHPdvwAL7BH15u0KmQbi5cnzB
         vB97EDivsl2oTNii0tbH0Qcp26eDbuObCKosfaXH7bBymadImtmx9EXOoGYf7dxJEX0z
         NTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964863; x=1778569663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=splttaUbTR2a2xlXdzRLk/XINh2Urw7Z9q2d07yHPBU=;
        b=nS//ccTYpLS6RNu1h9M0mBAltq2CGNjh0HaNS6tnWQM2N3g/lSgFEHiNRFalk6mht1
         tiI9IGrYlAyV21JLMX+BYryVM+ZNk2Hg+LXRyG2r6308n68OIi5LR+oZdTXlwfD7loOI
         3Hb/u+N0x6LXRLBMEzCTEvnuhs0cZ5/2CCUxmQLo5JfzKf2i1d8HaK0C+7etIo5+9ry2
         0L+QSm5uPCQMBLMin8cbSK3QQ/uExsY3Y8nuZqpoiJ27LD4leiWhc9YCuquqE9BeSWCD
         N96/vnZI/iAcG/nTutTxxwP+9uG6SyNd0dclh9QQMLtO+TJcYgBP+4et4Hl4/KrQ9Q2p
         u6Og==
X-Forwarded-Encrypted: i=1; AFNElJ/CiwebRLesVcBFwCwz9YWriVpCBmCesfO5C+MtNXqOZ5bRBBvq78yuHrCiofKO4vc0pl2Z05wggTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLw32la33dvD20835eWAkDN6gF33yY0RweNi8QQDOQNG3HtGr
	NoBk2xT1RTcD/Zfpo5VdXbrFZz3xDU0kDt2HVfxNQ4Mag5mN7FxjhMOEq/sK4lb58++t6xJk7aM
	+WnvbVtoy6GuFfqqAKq5Z983wHS4aiDs=
X-Gm-Gg: AeBDievs3ZhUwci979QkOixdau2MIfd/iLplovIoEkRObo4EYCSaGCnZNW47OEzjUHp
	v5F4ziqjJZcu+EZKjaAWpj6A9/r26XUiC08ZMpe3rdqhsgnU8uft2RZZGvl7mb/9EHA3pi0pVeL
	yQXAvoCUUgtKfyWZtjvtUMlyE+NJry9l0gWpbOykv50vkuJcu1ERHhe7AKbr4vVBwb8GyvUEYXf
	WPHam5tX+4tCcMTRNeMV77Zg6kpyExtiv76hdRWtVrLkEMWGKW8QnDPVOCaJD/zNc5MJXVgIbs5
	JeFWTGB7hGss4z0L8KpAqTax97uG2CPn8nStLOolAqeo8J3Zfu34tsiuZHqLPZ2eFtVr02m2ZQr
	ruEA6YDrtEE9vU0lwrYntL3gL99va1sns+UmCP621Ts5ATQ2Z5/+sawYzyrO4ADmcCuIKttOc/d
	KiQXf8UkuRb/NXIQHk
X-Received: by 2002:a05:6000:2586:b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-45003914f85mr3249255f8f.7.1777964861693; Tue, 05 May 2026
 00:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com> <20260504160606.07f87f10@jic23-huawei>
 <afl404iaPbSsK5XF@ashevche-desk.local>
In-Reply-To: <afl404iaPbSsK5XF@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 09:07:30 +0200
X-Gm-Features: AVHnY4JdQLkVdbcd3XUbAigaRg1TldHrWDvjwkL1oMYbMVrJ2HTQeqNWNsnxUy8
Message-ID: <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 06:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 04, 2026 at 04:06:06PM +0100, Jonathan Cameron wrote:
> > On Mon, 04 May 2026 11:48:18 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > One question inline on whether it is a good idea to be paranoid about
> > gpiod_get_value() potentially returning < 0 to indicate an error.
> > Right now that is treated as success.
>
> > > +   ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> > > +                            AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > > +                            AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> > > +   if (ret)
> > > +           return ret;
> >
> > Should we check val as well?   It might be negative if gpiod_get_value()
> > returned an error..  Obviously the original code didn't so this would be an
> > improvement rather than maintaining what that was doing.
>
> I agree that this would be a good addition, but since it's a behavioural change
> I think the separate patch should be made (perhaps after readx_*() conversion
> as it makes it easier to do).

Good point, val should definitely be checked. Will send a fix this afternoon.

-- 
Kind regards

CJD
