Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF921B191
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399362; cv=none; b=XSPyaWQxnT/muq3SFz7iW9qd1QCjG/+th0OrfpquASvCZsj/hY4xAGYSvUkTmuzjt8/axMAJMb8uJeKiOSfIkzFdJA/wK7RAUtSwj+s4EGV0XaT+G7tUfusDZ9wo9E5SZrvSDrcOBdETBrlG4e2l1DWC9O4r2nYYni8Ga5ro0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399362; c=relaxed/simple;
	bh=xWJukZR7qun4SLAfI53dfW+rWEm/QwqPyiKcmt6t38k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smYOMtW8Yw8QK80mYNw6hgqEtY2oLI2pw11GmcN3Q1YXHxQ1o78LrDBgH1jw35oxZVRc+HyMaPf4KwJIzsdQRHtY+9yMVkQ7JjGrm2RVdRUpbxSko1RUHuMZS4NHeHluJPkXWueykwC1sTqms/CM8PAdT+VNEJSD8R+J6RYPdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986d231b3cso47070357b3.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399360; x=1774004160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWJukZR7qun4SLAfI53dfW+rWEm/QwqPyiKcmt6t38k=;
        b=JDz9ESKihnprejvOL47KjBVDZNUcHUy5YgqQoWk/CUO/WoVnHFROu+iVvUCSDIkDKM
         +IuzjG6nm1IHM5Hnjqb7uDNUYx+w4OSS0PSq8bUcfqvu66N28OMla0UHXczhiITgz0XI
         XCIrrLaZapGdn/ANnw9vZ9EUOacymOyVa4LpVOf5ADx2jmRLRzJKyzsEvhzh+nCKg9Ve
         EgFgXa+pK6j3rK4nLgptmoePG4GS2M5JNzOHl2hpBiMa9sv4tk92b7vvLZ0DZhZYO4z4
         pRrxzHHYNgvVYFfO4SDIBf6a2eFKXuGolu1uJ4apmMvhTUE7B/FDMgdENkPmrYzzjcWH
         +Q9Q==
X-Gm-Message-State: AOJu0Yx/ToxA7D1K1DnTaE7zMUOGyU/jqBEa0Z6asIPYmGFSrWjOFqjg
	DiI7D7ObdS8dk8t5bRUTV3/CiyVH6wubjAC9Tzf4LD90op7a3mqlSu6FgSgbSjfS5bsEMA==
X-Gm-Gg: ATEYQzwnhtI8dx11YLenosOQ0eq48CjiWfyviKRdypLfG1MBaoPiJR2D4KsLZn8K8q7
	7teaIO5NV4u0Jeu/Vk7jyTCw4ciG3Cacy/udA4UEO6NKT+3e/2Qlevu9JZSlIsJZtVQz6CCUrif
	FReWlk+tpBJH69OmOgXINGuY2AOhYVrpY4xyG/oJ14FBdA175430Dv1wLvQCDcLhYYxc38Hlnh0
	dITVRwk1HG3daPLZzrQUfNCero6Jq11TezrJOw35cjHXK1CWggBGfua1O2TlYFM2w0/7fZUS2Qf
	echwnF6HKA+8AnM4cgtd+N2f0Z7wESLCEmqHIvMQ1aefCbNA/s8p6idnDxDRYzG6bBOaIXGRTb4
	SSili4m2KGiv8ECBt+OQRA1GCOmNscsoqQHUXnIzsU+5HQNDjZCqXc1NsobNA3d1UgDkREUDCZa
	kzqpps6u7Wd0MO/KsgWuHTvmIUTjWNeH3HpZv6KQd0g+Z4SOvJ6zuDRZOTmzeTjrO+mfd2jsEn9
	ar2sLDNxEo9JDV92XjVu7XZzdgcCw7smHzskEwGGw==
X-Received: by 2002:a05:690c:46c1:b0:792:7745:72fc with SMTP id 00721157ae682-799475e6f5emr61076677b3.21.1773399360298;
        Fri, 13 Mar 2026 03:56:00 -0700 (PDT)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7991974ebd2sm42244397b3.2.2026.03.13.03.55.59
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:55:59 -0700 (PDT)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64c9c8f8783so2396494d50.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 03:55:59 -0700 (PDT)
X-Received: by 2002:a53:ee4b:0:b0:64d:6a5a:ac3d with SMTP id
 956f58d0204a3-64e6289f6cbmr2073213d50.39.1773399359165; Fri, 13 Mar 2026
 03:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311224044.21480-1-email@sirat.me> <20260311224044.21480-3-email@sirat.me>
 <abLUgxivQnz2ISeY@ashevche-desk.local> <CANn+LW+mg9Ridm3aMrVhy7cgvmJO0JNV_s_myfRCW8gPv7Ggkg@mail.gmail.com>
 <abPaaSgJi6m6mch9@ashevche-desk.local>
In-Reply-To: <abPaaSgJi6m6mch9@ashevche-desk.local>
From: Sirat <email@sirat.me>
Date: Fri, 13 Mar 2026 16:55:48 +0600
X-Gmail-Original-Message-ID: <CANn+LWL1anBWWQz3DKbZWo=0MSb5EhY3KSiq84=qgo8ZO68XTQ@mail.gmail.com>
X-Gm-Features: AaiRm52AWgFnivg9kHX3kLuPles6YeHu778rjWkq6sm2jrDVCYGJ_SYCDT66Jl0
Message-ID: <CANn+LWL1anBWWQz3DKbZWo=0MSb5EhY3KSiq84=qgo8ZO68XTQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 12, 2026 at 11:37:26PM +0600, Sirat wrote:
> > On Thu, Mar 12, 2026 at 8:58=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Mar 12, 2026 at 04:40:37AM +0600, Siratul Islam wrote:
>
> ...
> > >
> > > If it's a reset (semantically), use reset-gpio driver and reset APIs =
here.
> > >
> > The XSHUT pin is a shutdown/enable pin rather than a true reset line,
> > and the existing shared st,vl53l0x.yaml
> > binding already defines it as reset-gpios. So I am keeping the GPIO
> > consumer API here.
>
> And? reset-gpio driver is exactly for those cases. Please, move your driv=
er
> code accordingly.
>
Blame is on me for not realizing that reset controller now also
supports "reset-gpios", my apologies.
My original hesitation was due to not willing to modify the binding to
add "resets"

I will switch to the reset controller.
>
>

Thanks,
Sirat
