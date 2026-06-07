Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F02EC0AE
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865573; cv=pass; b=BZiOrHx8cF3WclYWm8tXp+U8c6+aUTHeHGXTI6lbK+TIFh+zkuD7eUnk+JVLMgG20ZsFoV2zqQ+HvwOxM8xF269f0fOKhZQSH8cU+S2IP6BoorfZy2AfPLtv/wyJ8Ayx/tye0YiltBs7DgJsf/HoWwPGEnPKCc/fVMqzYUUXQJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865573; c=relaxed/simple;
	bh=vZoC2XCI/DGhd8gJS4Xd5Yi0S1yL043KiJVCF6eOp30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhiocbsRBLiayk9AQ7fFPssVwSWjandl/RqiskZ/28PyGhX4mAMJ14HnZUPhtCexjBLOdI7Fi2cwIWkPZ7I5Q5FZhA2Zw1BQVZ2dmNkwxPyeGQ8YHCo9n1VxIRrl78ZwVXGqW7iSqFuQQzoGnsf1zcP5QIKIagdtvMOeRxQf/OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ov5Tv5mD; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov5Tv5mD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-660323f7b27so3777901d50.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 13:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780865571; cv=none;
        d=google.com; s=arc-20240605;
        b=FPx2hzM5iNorpCHYy8lhvajh/DWOXtUb/mY+xUQ4Vay1bZlPXcE92W3HXLnuWgCXE9
         rM4/qQPHJs254FVnVmI6LAlO1A76yDv7omHl/Mw4/Bvfv2tg5lmwWS/AeUZOQdl1md3f
         qfFXUtSGVNkK/hx/JbJKgX0TI/vOGAEnKEPzENu7hStwnb+KO4ugr9g+F7/XbwzWS56e
         5O4g2Ol5gEYbpwDC9J3D0rTVrmx68GvFnxJtg0pyPJLNxZkWCBzxppc33bbtA1jgkwE6
         xxYlOe58dss+qXCy9nR2zL8f8LPA02Yv7hmD4lJaQZvhP+Y797S8rY3OsKCOHshs/dSs
         +07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        fh=kU6bxP/nf0R4doiuuzbe39XwSshV1vNADetUXQ35LoA=;
        b=SdANouEzwTFkyufwa/JuZjOOuqmCIW9XblyzVFlIgUVWDlqpzYQqga8i4zI0HyUX6V
         lLF0/u5PqWrXD1pib12cPiNLCN+aHAGolSREp0H464QIoOcoR+8njaosFs62spArEwa0
         qW+QUBy4MhaXjbqOwX+4a+yu7Qg7r4ygoMrmbDrRvoIOplVqt5AQo6KzfZRHO0a2DGyf
         /84V4fPKqG6Ot838Cop++bURBk+38WWac4KNdr7r0aWIJp8xXsw1h4WsmwV+WLMRlxcl
         DixzbE6W8o8+uRIyUflR10WNLCbIqZ8axsaHMphMnQ2ZLj5ULE/LIAeWasxnXLYTg/Bh
         p89Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780865571; x=1781470371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        b=ov5Tv5mDltavY3g13DSbbgKSMdBeT+YW9dQlBrCBKd5yLfAnQDhqXci3IFQrP9E87X
         6Op9dvkx3Wgm1RiKM+QE2Z1ybTOMTS/gUsubszdxcFcfdxsjNKNKHRcj4YNgofdEOh5z
         yvDNcAoBnNbyGyFxTI326be3U0Qruk2PPLpalRK8OyHgV//XV+N64D/u9eYFffyG0Jqx
         1IL7d+XcLm18PG8vNlEdhMpkxdFSLSjKwmGPWlLOElN6QSsj6AY9GDV/V+y7HP9+inOd
         5EYyd4AgMxUHTpfe86YisfZPm5k++78d7a68CZSYEZMLFD4KIUSVbaETnf+yYsv6XZHQ
         mV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865571; x=1781470371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/81AVja23z3xt75X8Nbqrb+cC2JxCzobXTf0PeIKB6Q=;
        b=aaknTidJQaopqlSDuNX0OHhlIyxLcmKz7dRb1EVC2SgYkt8vCbEsHvNk+QrStvRQSn
         2VRmNz12FY/oCSb6YGDjL04VYnhQt2R5um4Y1h0QQOVZrg77rbHdTz6/GKo1ZFhyFrST
         8BhdVAr3j04iKqBqIpne2pDxCan8NIuAUjwSNiPbwu28VTRrd5SYx0TTk9jzfsiNVPH7
         9DT3Cg5LBWFDsdlIPYENPW9FHXHd5vyJuGdH6Ecop0Siz2XNGydg7rc2u4fYuX3790nD
         uvuJmaeBb92gWN3stW8v6xOQM44l6s6orgTlsf14VwQBLpDcgDFa4SVIq5zwz9FRQoQD
         36kQ==
X-Forwarded-Encrypted: i=1; AFNElJ96e7WTr4q4QGOBflQxz8GdLGk+VNNlyVbL8CX4vvc/Cu6RaYHZSvHddTyOD4zO5ED3qUvVcqlbewE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYDkELmAaRWcs5TNyYRADEZ+1h6iiSR/I50CiJERfIOhdvNdd
	+FHA2M2dwCN+hYeEnTsupOjt4RsxDVM0lQ1bCOIsN0xeR4ALvaiimosaLhDuGPPsWstlb1lNvz9
	NNGbjN6yMrdMRTqaVQD5iPDJQ5fCFG2A=
X-Gm-Gg: Acq92OGa6sPkPxGJ9JHPhdDRXHp7rZzxBHSUS+pVEfyMC/Ymhvja9hAQQMYoZzvSE2V
	bdkeMa06z4kvpAdCEiJbwJSFbMufjmbpN7xG+1pg21LRYo1egG/4SCNwTshQ/yO4utUA3ZnWZfs
	LWN/Y7cC4Gfmuj2u0CdvGjkED9pFiUdx52MPpF8P7vepyOqjVbhjIYL86MaHEVGu5uB4Rz8JDEV
	WQP8Rsc5UEfiK32DS1mnk2aX742Z/1FzJHzhnCnacqDjxLaBc5RZ63IVmCIWZ2blnooKqxj4kO5
	YNSo3cNIJRGoW2JVEbqfQzXcKA==
X-Received: by 2002:a05:690e:134b:b0:660:ec14:ef87 with SMTP id
 956f58d0204a3-66106f153cemr11077968d50.34.1780865571452; Sun, 07 Jun 2026
 13:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 7 Jun 2026 15:50:50 -0500
X-Gm-Features: AVVi8CdYUyEsJBZuEZpF4d9hRqPKQN9LrFimrV9NNTgG4FyAsXCSjpDMM7bbtuc
Message-ID: <CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Do we *need* u32 though? Usually these types are for places where we
require specific bit-widths for a reason (e.g., reading a hardware
register) but I'm not sure that's the case here. I could be totally
wrong, in that case please correct me but otherwise I unfortunately
don't see much value in this. That's just my personal opinion though,
Jonathan may think otherwise.

--=20
best regards,
max
