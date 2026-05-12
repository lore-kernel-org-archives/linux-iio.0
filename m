Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F03E0724
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607490; cv=pass; b=SHSDqxfHcQRB6tuSzZD3xX0pGEMGnzhDi3umcCLU8NteYihlJNMSN8lHWg5X86qgFzKFAe2BAhjdlzKibBsHmcKbO93JqV2ZVuLWGmTU1aqeQewgdq71m7I5wS1K4/0iHC7sF4ZcO0XUUdVMOboczdWr1ADe8u4iOnNPYnjii2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607490; c=relaxed/simple;
	bh=CV5UnxnkBEtRShENGkBCB2rsomBz0C400j2DBJ2LrVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksZvIsIsXiOPxGEDqUUZR4i6NMjzPrnCQ24VpIsOLA9qRzYtS0ESJAiQBjoPM7mkFsTiseupZ5rw501gcfWk0cd4powfDKAGzZNA4cykYH+MmvTm3+JvLoYqO7TCzEcYb76Xkw/BuzlrEPiep8R0gsyepZ/H4GhX/fmlUZL6Aj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI/sSeue; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI/sSeue"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bdaa68cf81so58243477b3.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778607488; cv=none;
        d=google.com; s=arc-20240605;
        b=Yln9N/ARvRPJb4TqzrWrsCR5jjtBJdra5Cp7Jw0REev/xndsX95KHKhF/UveKpb20c
         nhacnuH0KmsMIOed38aTvL4WeE+VBu6bRbeYy5/0r2Jk7gtnGZBwOfJVBari+yEu1/ot
         AreaYHjaaW4S51XCdtbP5bovyuQAjQ0Nihs5FfZQLzKAMecv7YmodCg/WAEIYJXap2pK
         MS3PwxfzN+uO2X1c3JlLYz1HflYBpNIY1uGo2MeO7iieeTkZMgGcoCBB1+fJany5mhIK
         vDHGw1v8djyJeulBGfN71rcP2Taa01x0oBIlRF+wXXi+FoNEA72eocWLekFFNpRI8lpY
         fvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xwf2mAn4PLlLI8/tSPjVXt+hsPj4dYrxB4sPLFg6go=;
        fh=jYWyFzhDDMJPhfE5q0H7hT6l0vtDF44SBxQcaVSpKsw=;
        b=YltENsf3IsV0xWEu78GvsFcMqFBTbKWTQuelNmrG8GbjYTihapFQJQ3YQ9yGHeeFXA
         qLwolK83Z3AQCMje3aaHA7SSgf2F4FTAo3M6eJSeeY8WF/XxeFEJV5oDseez8ZVXSyZR
         prKGdc+PXEM93v+rmQifMrSVhrpa4eNnuhQRhC4vIZIH4CNhSXxGl/LqtXJcB0xHQ2cA
         qON4DELH1P5RhRaIBju4aL0eEcl73CztVRZ3iGNpKyI4cmxhu6R4J59uTOyp3NGa1fOx
         6ILxCQSK/naA3HRytPCq+unh2sK9R+y7CmY5unAeUYvshWXq6fV0zJOLvp+cBuAt7u7f
         dj7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778607488; x=1779212288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xwf2mAn4PLlLI8/tSPjVXt+hsPj4dYrxB4sPLFg6go=;
        b=CI/sSeueSbkYZiyzm0DxpKu9vXl1kK0kMtVIJp4Qik4EvH5e7/006ykku4iDloyLWI
         oI7L/FtOdOWm8xb0CEvZEMF27zFi6ZdI8eJz667A6pZ9uZF0RJEWO4d+gv0c09FL1JVQ
         l6TjUx/2wGbtGuplonh3roaHA3V26/4DMHExiqvteaOY0IkpESbztybmikg2RlVx11iX
         RuAyrWmo6QQm845W0xodXoXE/vKNyL7GuFScWe12DIanyblvz//4frOmvcfr3J5McfIK
         i2AMek8nhQEGJ6RzA3wFe0BCX6Vw/QKGEHV5AE3xRAMiVUX9cySKNTT8xBlgRKXenktt
         JutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607488; x=1779212288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xwf2mAn4PLlLI8/tSPjVXt+hsPj4dYrxB4sPLFg6go=;
        b=fHH29bcTZGHRGjO84Qzpbf1yC0NDSHfkdoV29XD3ZO3BA1W4H9Kojq7TM62HuoSlOH
         QGLbtr3n+7vH+w74M8M9TuBH5KQYTikYYhzYG909Ur1FEo1li+zAKMwnkA15oWoJdHHx
         K1x61U/EtwVxR/4yTVeHsQy9q9L6WdtcTdvpANeHTbs8ztrccFQcRhiPUJZL+PMY2M+Y
         Nxmv14yVP0PIh6vB6cOsGrxU0b7tarAoFims3YOk7EfJu8AF0JmgVYOKTBYLZBu5cEyr
         NgpEpeyS6OKRNVqCVnZ/u+jLnBjJRo7BtUrDyPDpN/xDOcZ51qMx8N1o/v5dtLUZ9PNa
         aVIg==
X-Forwarded-Encrypted: i=1; AFNElJ8x1nbh/AhK9jE+gPWK/jVbAPhUFhmujOc85FBsPkYTNG44KWCawGLGsLN3JxbMPm04AwbpT3Vdwhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdkWAmHe3pREO+lkhoqZ83hQ0FGx264vW7T8mgx/RM4u8IdMr
	8iROtRmMQ4FOGL0h7selDdsXaky/hm1IqOCMc7juVeQ+GpxZA/RYaTrUDdqiEvvJ3uHdkR8Sy/m
	+ylCdaz4uqxMQZkdIMxprPyRTrr1zIUg=
X-Gm-Gg: Acq92OGDB41ce4m08oAnp518UlOYnk7hslUR0IvYkX2DyP4YRUmfiegGm+kCnqWIXlx
	wpZ0qE5fDN7u5C1sEdQxawrATPJIulvVfJyh2abzPCEQX/0GgWMwi3ykjeLUL7exvfj4ciLVGks
	1mSN/+kzpJ+wgLt9CWoM/N1B7x7G6xzJXoiupSan8nlUpVE0lM9t682ybsdFaDTmeyEYuhjgysO
	U18WzWUbDDU/aF1GF8/Lh6KdIq7GjUVfLBZPdDZdJTxJSy39+D/2k33rApw7Fw8jTOEXGAmKIcZ
	0tJtvXb/L2sCbYoIkmEq
X-Received: by 2002:a05:690c:ed5:b0:7bd:8782:bb65 with SMTP id
 00721157ae682-7bdf5d9913emr331643737b3.1.1778607487765; Tue, 12 May 2026
 10:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512120356.40839-1-m32285159@gmail.com> <DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
 <CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
 <CAKqfh0FyELOpgB1W+_nv4a1G1tuSjnVxbEFrUeR2+KCT2Q=-Ug@mail.gmail.com> <20260512181040.7578fbd0@jic23-huawei>
In-Reply-To: <20260512181040.7578fbd0@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 12 May 2026 12:37:56 -0500
X-Gm-Features: AVHnY4L-QZs66Vl8D02oGR8PIwcfowfxFdhyTewpWy3DOQOsWugPrGBDqMY1pCI
Message-ID: <CAKqfh0GPx8D-eGfoDw0epa8mN7fQGD-hpm9sZfimPKcj_RR3QA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:10=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 12 May 2026 10:30:42 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 10:25=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Tue, May 12, 2026 at 6:17=E2=80=AFPM Maxwell Doose <m32285159@gmai=
l.com> wrote:
> > > >
> > > > On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote:
> > > > > A Time-of-check to Time-of-use race condition is present in
> > > > > kmx61_write_event_config(). Move the mutex_lock() call above it t=
o fix
> > > > > it.
> > >
> > > I think you want to elaborate a bit more on this. Id est explain why
> > > ev_enable_state needs to be protected. Not everybody is willing to go
> > > to some site to read some AI reports and interpreted them.
> > >
> >
> > Can do that for v2. I believe that it needs to be protected since
> > later we set ev_enable_state to false (basically right after). Could
> > be wrong of course, but Jonathan did confirm the TOCTOU.
>
> I'd talk more about how we'd get a race.  If two calls enter the function
> at the same time (which is easy to do) they may both pass this check befo=
re
> getting to the lock.  Therefore we end up with at best pointless repeated
> work, at worst a reference or similar count issue. You'd need to look clo=
sely
> at what is protected to be sure whether it benign waste of time or a real
> bug.
>

Well, since we're accessing the shared state via kmx61_get_data (by
the way of iio_priv), we could check that value, pass the check, and
then have the value change before we acquire the lock. TOCTOU race,
no? If data->ev_enable_state is false then becomes true after we check
the value but before we get the lock, then ev_enable_state changes to
whatever the input variable state is. Anyways, just saying that this
is certainly a bug. Would coming across it be common? Probably not,
likely one of the much rarer ones, but still worth fixing.

best regards,
max




> Jonathan
>
> >
> > best regards,
> > max
> >
> >
> >
> > >
> > > > Reported-by: sashiko <sashiko-bot@kernel.org>
> > > > Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m3228=
5159%40gmail.com
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
>
