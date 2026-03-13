Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBE2BEFF5
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399451; cv=none; b=WOlW+L/+G6//bYRM4EMG4+PxXIXZdLgcvib2vZxPlqIAO46Fi1RlKndZgeUqKn2shntbi1GXfpwEZnVBgB8oirzNJXPC9PUPtMPsR9o2vCzqLyAjoCWD6tcNkm1s4JJ2drZc42iq08P0SLwQFMOQB9Er/o3FOCN0884dfydB6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399451; c=relaxed/simple;
	bh=N+EUMKW8o/9rjbqaO5/kRfo4UuktX8cwqEopTFI8zU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDn2W9yapuzj4KC1HIn/aca75va33/f5IOxuNoAFAdOn7GV6x6LdVmVQcWhWjyti6dPgECOheX/D1dTwomF769y0vX6dpoQ770Bej2pYRZTr3sXreosBngtjZZxW84TNzcmjP0Ty5+STH/+9egf+RsVRvSWXVyqteZ3+yJfu6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79898953985so16303807b3.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 03:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399449; x=1774004249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+EUMKW8o/9rjbqaO5/kRfo4UuktX8cwqEopTFI8zU8=;
        b=KhX8jQD3EMvjLk521wLSo5/zVRlLV+ZaT/8bfUQ8Z4apAR23jW5MrWaQ8xHCWJAdC7
         cxLibYdzn4zrwjloytvIsLRgRz+xfVoaMJLa3tRZNcGMTii6eIN/x8qH4bPvDSOPuspx
         dZaCfD4KCMltH499TadjFCbpgo/AYqX+49SlEkX6WYAop/AlCdc9hb8mcIKPPW4TPJkX
         BxDTTwRU2I3blEdWeDOcm3+tfAJ0phlKJFul/nmEoKlKxocuBMrszTh+5kVJjKHan/rt
         nyIV3f0phnFV64AMr8vEO14gF6Y2LL9j7YE1W8z1lwA8Hjwabd07Af98mLJwopvCSfy8
         yXkQ==
X-Gm-Message-State: AOJu0YxuEQ8pggvAMoBiGwOJSvbqviQEPYYN9C0Dc6slMbN51WFa7ugA
	sR/af4Y5kK6CgbGLxUJ4sYsUymvZBxxUCyDhxnAvi0kUafpvJgTQNhEErKiuWFuIMtmsew==
X-Gm-Gg: ATEYQzwK5JXijQyys6w1lvBl4KrUwEbNmvqA83z34CARW/YHaFzT+1xG5EoaHP0WxRg
	2KOfRSyPTxJlC75IOcxxOgqzaBZ6uahNkqU4/TghxiYZWPRv8RGyhiiJf5vkN1MgiUKsogVPanv
	O2lPZdbLwndObmyPTiZJK5Wcw0vO2NA30tdIqHxC85x+1iLaXIbrWbxEU9Fciq2aQtKqgcN3Zl0
	RCM8vz5aNPxGEf9wPT1ur4qlxyCPf5EVSEn3kP8x0eru2RcUj3cVVjp1Z8SUl4IM/7fpTVRJwQ5
	9v5QFMUmXm3G2BjmU0sqI7pe9aX0jruzbAal0i1C+QqWZD4Sn0KSaXtl3XI89DgSn7evJfdtOQs
	U+nsDh6oc10tFqE6B+urTiHCH0+YBJmJhyg597rqTiLYjoaKynNnqQy+7UM3F+IyEVEhn3m5z0e
	eaKXq7Ydf8UgP/kjsQsNApA+rouDDtdpLQwrhIic4dfdXVsAvAp+/gPK/Kdx31mtZjepg89ZcS2
	VMlsLfxnMCTft1WjU1blf8V9sbMCjw88W+0WMIKeA==
X-Received: by 2002:a05:690c:c50d:b0:796:34f7:8ea2 with SMTP id 00721157ae682-79a1c18d82fmr30678407b3.31.1773399449431;
        Fri, 13 Mar 2026 03:57:29 -0700 (PDT)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com. [74.125.224.48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917e0c421sm44669727b3.13.2026.03.13.03.57.29
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:57:29 -0700 (PDT)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca1ba0089so1990544d50.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 03:57:29 -0700 (PDT)
X-Received: by 2002:a53:c049:0:10b0:64a:e799:1d84 with SMTP id
 956f58d0204a3-64e6304d479mr2200425d50.49.1773399449098; Fri, 13 Mar 2026
 03:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183721.40482-1-email@sirat.me> <abPaqo9pBSClZ-PH@ashevche-desk.local>
In-Reply-To: <abPaqo9pBSClZ-PH@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Fri, 13 Mar 2026 16:57:18 +0600
X-Gmail-Original-Message-ID: <CANn+LWLZ28_0nsgtk_Hh_-wT7x1k4Pg-U9GV+cnPtQG_22gT3w@mail.gmail.com>
X-Gm-Features: AaiRm51t3mDZaAf73112SokdohhWIEKBUIeHDPCuYGLDhDLvPmYE-qnlAgI863s
Message-ID: <CANn+LWLZ28_0nsgtk_Hh_-wT7x1k4Pg-U9GV+cnPtQG_22gT3w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Mar 13, 2026 at 12:37:16AM +0600, Siratul Islam wrote:
> > This series adds support for the STMicroelectronics VL53L1X
>
> NAK. we haven't settled down on the v3 comments.
>
> --
My Apologies, I replied in the v3 thread and will address the reset API in =
v5
>
>
