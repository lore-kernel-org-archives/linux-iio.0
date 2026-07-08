Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3F45104C
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515275; cv=pass; b=WUU5S7jCLheNG9AmLhFgqtkB/X1y7wmAE26ghGQRp1SL77lDfqMlNjFXNOkk21z4DY9CHHuWdtu7aiLepnOr0R+f6uySSbme/BPGd//sLBqUZNeW9H9saR99mKgFmo5UYhCf0VqujFZWDRFj2wZB3vMjeSehn17s/Z+ntUsGtwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515275; c=relaxed/simple;
	bh=4KH8mGkFSz/seHkadH0L2qYSd3c7ngK9F9pkUSxKmHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM98N9AwyG6XxxV5Lg8dx8YezvT4GTVAAzd7vsfDSU4nNvZDZpc73SlguKlggPqSyaPftliRiKCu2Spr7Gq58iIlq2TO+7fkNSBT23VF6N8netQ7nzq+ugILAJ5CAD94aKT1VWq1cdTrvXBnWyZ5VI//+0I5OPlAOQZI7JV8TF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGeBM7s4; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGeBM7s4"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso917105241.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 05:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783515273; cv=none;
        d=google.com; s=arc-20260327;
        b=kuMcdni7djthkdDpAJPTA/UXcLhLgGCY+dRGE2Z6C2QzY4cZVgPZk0BuiHtOEQfYvC
         wbJropXhOA9upmXmmuXH83ou9ZTxVU3FHQyQ0OrQApvq4Kn2PuTx9G50qcsvl/U9VWvM
         4kfF/bAT+apuq/ZhCsypaONivQos1CTLuXpzvGdSK28lOOztEXs+VhkJedLY/WOGh92T
         LfOpKzhph3l9bE9qVnuou/5wJmpHU6f0EmifLAJLzj3dSxhkSWIr9F+mZHyQgH2Pqt7O
         YYKx17qCHEHgB79n620xJcx7onqit5SdGMTYZLzif3qrsW4dYyp5V9grx4le86prEtuc
         ldzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pF6Z4QJnlrmRAFEbhTsGEDqzggaHUPXZ5ncnx7Kx0I8=;
        fh=XpgJ4cip4BAEvufIK3pNpueztpq+OmoiEoH9tjTq+5M=;
        b=LubDYJIQ1fV3MwxLpVCviPT8WIWMnJbjPntoDaHa5P2NX9PwTzOKVpY383P2O+RJHf
         sf08+zIIDtskUGggbtMF0x/gTj+F68ydTxB5pg6h/IqhiVBX3jZEPc5rR0GlDDh/LnBg
         zFV25OiSNPK7Fdh2S5e7UvstRuPe8UiNcwraZhYjmqUYuOieC6KIGvaxqNVuKhVNcZxV
         4NT06Daq26VZ+j7WD1bsG+fujN004zF4r3/vL79afzTjnG7AZfYgY23zikJlH+YgTTxK
         f1xANN6jJI3Z4c5bQzfSOIzOzveZKy6xP0Ay/bV5KCeR1WG/TzhqSIObVWsTN/5o6V9v
         nQRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515273; x=1784120073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF6Z4QJnlrmRAFEbhTsGEDqzggaHUPXZ5ncnx7Kx0I8=;
        b=EGeBM7s41bI8X2qYVZ0X7vcqIKCrSBNdDEh9YMuRrQM1QtC5rc8mSg3zXlDiq1Xvdx
         j3gPG/ER6LjIXSo0P/18eeM/DQB02W+zdJMWuO78R/mBN7EbvlZM2vA96iFV3glWEnCZ
         UlePfaQEgkgyHNCjqprEWqS5npPgsV11gowcLlvRk4RgSi6vb/MaFrLVmCW22vY3h/we
         HL2V43ncGR71x1gMen54r/O9T3R4Q3In9q/epetGH5d5R7Gf54wk59wmbuUpMyy0qOe+
         Usjt4uuEWz4aS+oKT2TL5s+uYjD1hOxqSM4Cb7nuuJBHf/rbZwcp0KqCLrd1F9tZH2Kd
         VmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515273; x=1784120073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pF6Z4QJnlrmRAFEbhTsGEDqzggaHUPXZ5ncnx7Kx0I8=;
        b=lfbbI+JaUgJdDSCq2tNdcziorxvXGm3YMjwojbcCNAbr1LQSDF+eZV6ldcqxfS0t08
         zxkfBryfAkh4GQqsFZeOVQKyRX2MbXwt1C4z6KE2jHRPp/76mnDngNzIYOR1z+oNdZ0Y
         Lq15S9VVBnPVrCsVGwPzgf3I47ZpdbeqR9C0iRqD0RbWyDZvUrtZ2DysW/cB7AEPcoZN
         es/YdP1SnbQg8uZNBPTwAsHVIQCXuwQNCWejYltu568BG9S6blSAaMGxTUzdaQWHHiMs
         rbjNzZy6Bvf8aFJYRtAdVUk4WscbaLJaVyZ9uDr6ui0J6G4yiY1fPKx0xUg72TNyuY2z
         FxVA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+rFbUvNeSBoDAEdyzzTpCf4EbVaKIaqcjHWEuY3jxZ6Xh3QR7DlJqUmah4kWS6CQpKpcfQ0Elo5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSq+7UJzMSi2FxsqGadtUlJthuzDMPhfvFKHztIuWSifGqGshW
	tvJdeV363ijpMW+NRiCrOY6R+knMUE2gNRiAJkhlZcJgTj976vlC2CYUTKRed6nHwVgW/sO/+sR
	FM+Ap9KcG3uCi8B76Gy19Ogywg/PD+2A=
X-Gm-Gg: AfdE7ckbfR80Rif4itI16x8TeBZOoI8MVCVoTVQoIfNs2xMZrKDkDEoXlxvgE5JQ6kd
	sg+htJSgBhlzM72U2C+1JLtO950pfaPMFy8Wy+h5fq1YEP9upT0LZwNVMnX3gCOAv71Ul5yLC0a
	QS+kRYBcOcdpXpEDwalC5Ami2ipiK8BYocwrkMH8CBmJY5AfKidtcV6rM4d77K+mDXaiohnfK7T
	T2GOuyZ87O66EI6q6CCfxCOONVZdWfVg5UA0bBbVTwfL6Oj26E7krF6P3eM496jPp52D8Ha
X-Received: by 2002:a05:6102:8484:10b0:738:9c21:1b70 with SMTP id
 ada2fe7eead31-744c248347fmr2627225137.19.1783515272662; Wed, 08 Jul 2026
 05:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707112714.2261727-3-shofiqtest@gmail.com>
 <20260707140545.0000029a@gmail.com> <ak0X8yrg5ujz8r5L@ashevche-desk.local>
In-Reply-To: <ak0X8yrg5ujz8r5L@ashevche-desk.local>
From: Md Shofiqul Islam <shofiqtest@gmail.com>
Date: Wed, 8 Jul 2026 15:54:19 +0300
X-Gm-Features: AUfX_mzInWCIvscsRQXhs2s8ccCnggzguweifxX9eaebhUCx9qb3sZM9knbA-t0
Message-ID: <CAOTCDVth36hE1JqAi3vJ3hKuqhs_yyjV0ZZx5mZotiJYzNDATg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: health: add MAX86150 ECG and PPG biosensor driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org, jic23@kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I want to address your concern directly and honestly.

I did use AI tools during this development, primarily to understand
kernel conventions and check my code against subsystem patterns. The
implementation decisions and the responsibility for what I submitted
are mine. I should have disclosed this from the start, and I did not.
I apologize for that.

Regarding types.h: Your feedback was not ignored. As a new contributor
managing feedback from multiple reviewers across nine versions in
overlapping threads, I lost track of your comment from v4. When
Sashiko flagged HIGH severity issues, I panicked and sent new versions
too quickly without properly reading all outstanding comments. That
was a mistake in my process and entirely my responsibility.

I am committed to contributing properly to this community. All
outstanding comments, including types.h, array_size.h, and err.h, are
addressed in v10. I will not send another version until I've read and
addressed every open comment from every reviewer.

Thank you for the direct feedback. I understand why you raised it.

Regards,
Md Shofiqul Islam


On Tue, Jul 7, 2026 at 6:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 07, 2026 at 02:05:45PM +0200, Joshua Crofts wrote:
> > On Tue,  7 Jul 2026 14:27:14 +0300
> > Md Shofiqul Islam <shofiqtest@gmail.com> wrote:
>
> ...
>
> > You're missing array_size.h, err.h, types.h
>
> My comment against types.h was ignored. I think that this contribution is
> heavily assisted by AI (which has to be mentioned), otherwise I can not
> explain such an ignorance and mistakes from a human.
>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/timekeeping.h>
> > > +#include <linux/unaligned.h>
> >
> > Blank line here.
> >
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/kfifo_buf.h>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
