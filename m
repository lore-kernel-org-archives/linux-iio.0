Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A903363C40
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788630; cv=pass; b=Y6qpki55a07S5noJHGAr/pS0wePwyXJ3hwP01cf0IjLGhlGfMnwNUNZqi5hmQzA0zzseSQrKsl1q2X90msBeBeckDM+9zSQvgyQ3i/ktN7rRODuN+7hGnkXqEw/gIWNxOPUcssN+snwK8mba6N81JNuMnmLqY4KUDf7Ysv4FLh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788630; c=relaxed/simple;
	bh=ZzeujSdsWCVVN1DdUwSWJZ7PCK8VF1sapEwykIQLEYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO3Z/b6ip1y/czFswcbjvNb+y/YHV+ppPkZS29Gv8SSuOX2CbQcGlOGB9iYIef8O3rmklR/LFTto3d6IC1hpuTbLt/zYlJwq3eUpZ3R746mt3tpVIdARw/RWBz9+IUonZzO1c3vh3GpT6TqzjtDJjAcabGQbmDNd/le3DK1kBKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUePJ2zs; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUePJ2zs"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2c1b09d69so638507e87.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 09:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776788627; cv=none;
        d=google.com; s=arc-20240605;
        b=XpLZzdYOsB1HPSc0EUPBtxZe3bNE5macj8yQIfn+71LCa1y9mVo3TQCt8feSNtsm2g
         Gr56qfOm2aNPczhU8WTuzIsjJSsQHQc6cZKwpy4ANYNCuohdJcX2SJpmlRfZab3+Ysac
         V2Tc6smjBH7vnk7MUevHhkprLTqUu0ofCuXu44i40hKWSQLAq5GEVYsmg9whjV1A7OQX
         Dn3WeTgT5I+n35dpYVLoHR17xOaqOUxF8doou+597Sn+jCBnWjV9Jk7DmnEKka4BiBKx
         ZQL0D43KIu0kU3rdhMX+zJ6rv/4IZmKB9t8iDWJkEjNQSl4hfHwiXvZiWGKpvO+ijMPY
         sHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pII6GNgKNm5ogHzia8R6tYvSqBbEHUePaPOz7cJsyX0=;
        fh=FfVDBjqn5s9mYifvKZ91yCNSKewuiNV6eCSraEIwBSU=;
        b=DIonJtNTD2vEJFUww5YPltkPkWOs69c2VsNhf4p7+2+9tQ92ScY6TVFu1Wn3lQaQ6q
         PzUgwCIYwet3vP/YrqGxYTghHIRLDjiSZdrBnxkEEGR1OcYjLdhCRhlDARQfL8pBDHfG
         mO4KjE8WYdnwOZznPMbgBAKiX9Z9dIgyc0ZAKdPbl/Ask0DpouJMn5rmTyaxqeBgL66P
         THgwUjfjJsUbwc0Coi1Hor7gBT3arUgo4WnRpWgxitErCTQ08hct9ViwmbRiOVav1RSG
         ycf0JtQrLZssG/9ONwG1lwHNvRnyja+t4ZZ9Lhv4DUCkUAskCwGrVIoFwi3ZpreDsoHx
         8eRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788627; x=1777393427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pII6GNgKNm5ogHzia8R6tYvSqBbEHUePaPOz7cJsyX0=;
        b=TUePJ2zscwZ2ZYdkPa+/Samwj6znpZnMq7yYW8JC5Othbn8QprJvyVS2pBqyiNA6l5
         tNYhm6ksvTdlftIv1SLm0IkUDDOkffIOQ+tcGL32FUJ34Q5tKx2K43Vj8rRWUljsuVJR
         QO5nbWw3Z+xXO8yiUJWCbH153DkQcdOQgYbECCDsmzNddb2N4uTzd+3/mQCIVEeZVtYa
         aNQSAjoYB7pptmTjez6GvGvHZB74stKKQR7cWfypCpyrExn7VMgTvJtx9xziif1GpL44
         HylSIii3u7chsrVyRbgmTT+8/FhZOQXEpkzHUh5lCeqUyW1iIQVhsbShu8+1sTJhpcSQ
         5MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788627; x=1777393427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pII6GNgKNm5ogHzia8R6tYvSqBbEHUePaPOz7cJsyX0=;
        b=XMFrlZUauF4lfnrkRpV9FGCR8vmq5Mnj2aRaJ7Uiq6mHN+dp7sYSkNeSVMy2lvyFho
         rwPec5pHCXihk1Fo68bIDqd9s5L0Ygnj6HpeMtjGqU9rT7NnDkFqmQttyGIxsW9REev8
         ntZLhHE1ytRMGawvRc0gc/746QyU5RvrFBvvFVoAc4aLjc9ewdZnkwlDKrg1C35T697l
         Ca6smZVymF1u669O9ewMNX6vvStjf8aqqCqHQSz8Bj0ZOMI8rbnAEYv6ETJv+Xo3+ujg
         Nv+/0eJZIpOYwm6ApzbnRzvqWP3j6mV6xGMKithJj2vklwQQNZBbRqhFmBW5FuVSputu
         5JIw==
X-Forwarded-Encrypted: i=1; AFNElJ9kSF35ISMy9mnNOGLfFjmhUw0M0QJSnENLNBKHyCBMga0S0m76vnz3ZBvyMcPZAr0XMstuEzvT3EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQXKAY1q64XqVo6BXtsldsCieP6HwMXMyVSc9PzLHuKhjjpHd
	LqEFlAOJ6rr5/cMJp9k2zJP/w1cTJtfSoFd9fayM4/YV+k6TDeHaJ5XfiNTuYh1xXjg0pIbHTYJ
	t9nxWvE0D2fn6dG82bzVka661dN2irks=
X-Gm-Gg: AeBDiev2g5LKk5Yl6Vd/LUyRJL3F9vqARV1oPMNrngbsD9IfVnLjOmcIdF85Udya3EB
	l/CF66CPSbz0deJ+vOwemX2921QQMP35y2nhzHvT07fM3HcKDcec0h+l5LiGXdn3IjfZk239F2Z
	B80F608hCpcROL1Ko/Xo8i9zS52xStfl+qsO760L90Cy0IjVfaUDhYbWolVI+QxRb/fI0a2uKhH
	z8nBLNl92TpwUBS7i66Q9DhckXWQ6yGF4ph4HZ+qdgArWbllazMt5qodKGxfrNbjTAmwxkFAjIt
	8UjTpwfrHASe91mpuQnsFPSsUsp4xpwRxpW8ey7gimWItGCboq2+YFG2EizVRbiaQdMD7YTRCpc
	OZEAFeC7mIz1toBUuTP+xpRID37mDKJ8AMQ==
X-Received: by 2002:a05:6512:3d9e:b0:5a2:a82a:178 with SMTP id
 2adb3069b0e04-5a4172d168emr2957766e87.1.1776788627152; Tue, 21 Apr 2026
 09:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com>
 <20260420193320.22df4979@jic23-huawei> <CANiq72kKkRW7vwYKi38dvsM4HCtKGwzOF4ujMS-X=peGb_Vi3Q@mail.gmail.com>
 <CAO26r3TqeLOF0mEgrsZszNU2TnGv6++OtSzEWtcSgXj-OvpTfQ@mail.gmail.com>
In-Reply-To: <CAO26r3TqeLOF0mEgrsZszNU2TnGv6++OtSzEWtcSgXj-OvpTfQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 18:23:27 +0200
X-Gm-Features: AQROBzCXtxVgJu0Q6UlV7AensaVDHs_G0UffM6H2cCriWMOkuLQvzbOnutpb47A
Message-ID: <CANiq72=z6DxC=uJaPbS-AFd3hcB6T4dSxjH-NcexN8a41kix9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] [RFC PATCH] iio: position: rust: add initial AS5600 driver
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Frank Zago <frank@zago.net>, linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:38=E2=80=AFPM Muchamad Coirul Anwar
<muchamadcoirulanwar@gmail.com> wrote:
>
> Thanks for the pointer, Miguel. I will update the constants to use
> `kernel::bits` in the next iteration so they map cleanly to the
> datasheet.

You're welcome! By the way, eventually I2C etc. may also want to
consider a more convenient way of matching a datasheet / defining a
register map, like we do with `register!` for MMIO and PCI config
space:

  https://rust.docs.kernel.org/next/kernel/io/register/

Cheers,
Miguel
