Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3D3DB62F
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168685; cv=pass; b=Syv5/vFHEt/nnpZ8eztHZ0JLPPzKWrQn1yhFkwvmP5h4LvQ0HNtlRvV7sM6McAekcMnNUAI9I3qgCkF2gw3G6jq0e6A7bakuKkPzZOr0ejXLbw1f6QaIVb1rq7kTlvw8aOhh1ZvxeHv/QGygz291o+0WEEroKMaK4gCCRyvxtVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168685; c=relaxed/simple;
	bh=bmrTnTvYbbEYt/hNQtoAIyQhIvH6WJDaVg0j58bTRA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGEtig6w97dMviSi9DSgIeIit7msLfOhLeXTkNkbFMNooaGiXAQaUhjmcEcB11h3z2rcPJsFhF3UB9S46rqkdCFyUHn+/pQEatEn8v5d2ncPFkZW7i+5NsuTs+gS5JOzmrYgHFjmlWq6aY/58y33TqT7qgjoiCs05UPuNLuB9hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJK4c+Ys; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJK4c+Ys"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-46fb6d65c28so1873399b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776168683; cv=none;
        d=google.com; s=arc-20240605;
        b=KXDjZU5BZk/EPvf5eDNCeUz/0dqAw0On6eXZcqNjDmylvqwidMzRLKAmOcrGf6V/en
         xCbJg4ykJLGeD2fw9PAhY/mIhFjACrRK5tcWmqQOABqPMWcZ/APAHmT+7I+r4DtaxZGQ
         UERPyUOWPzFs78PoWIVjNGqdtfZnSMxRJHHPg+ogiPgVlFK87A7jpHHLmfKOrtQzgCwY
         nPQktO2Gymb9P9lr95ZDEwB9v0JEvuK8WfuLFrHC3Ur8B6gMRxKSI/WN3kGoka/9WRuS
         7Se8jtKxZHbV87Yy5IrZM/TLbMPepI6cK2cnGUGuMQrJhWOBVwR0jOf9cLxrS+UQ8qPM
         ZxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vMS4QV4cs3UTdyfk4y1tazZ2iZR/VzeUPa/I+j7yXak=;
        fh=GdjTZQvxm0olvbJcgMXelyO+5DfKYNsqfLsmeOCosAw=;
        b=dSu9rQxV8rerZGgNRlJfH7WqwPapUw01htL0R2tFRlzvOlKak0Dp+dxeQoYJiW57ND
         adRtfGVEZjN6Kp3k9D/iLsuJ9v69GI9muj9AWYVCslVmlmTGWYzJiaHNGX7yURTr4Eao
         mPcMusYdBvI8lja+PyYt1tO44rJar3vZkqNtitDheBFAjxPhMJvEEBlwgvIgNj4gBq8J
         sP94Po5Cu56zK20PHXJ3m3wWZrfxxzpWhjsIyqhMH00G4vmxUHIPvlF4IJxl/kXzcfXq
         5MUuUjRIvolE0J27E7BGeAEPksFX13AsUv0Jw/eLQNGyBsIBWPVGkvnqoHtxp2cxqFPw
         2hVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776168683; x=1776773483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMS4QV4cs3UTdyfk4y1tazZ2iZR/VzeUPa/I+j7yXak=;
        b=sJK4c+Ystas38+VpR1hS28Tq/sTD0L3dIWwv8yPyrei4X0kt08rDx7iwt6h40F6J5R
         Fd08hZVJn8yIpTAYcPaTDrOKQzIb8x+kyfLpGtoIgSfB9hYi2D2GXUgySLABa6SZe0OF
         7lYS58ovB+TPWCpafn2uH9Bd8qVdjG1Cvvrkyj6tJvmy2Q/+jRXQoDM109pMHGc0EJVP
         mTaQUPvh03mL5kQx9+mHRSNEX1MSEI6fQ1srnwWhU2AIqZfZUrbDUeabLQe3WZ0pO/ir
         /vVVwb67m715kHWUngSO6icj4PZJLgs+I9xCJg0iqaUF5UqzQcOfeuT1l/oc4qWANkof
         1EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168683; x=1776773483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMS4QV4cs3UTdyfk4y1tazZ2iZR/VzeUPa/I+j7yXak=;
        b=hWoLKZJoeEkKpXV69/0UTZchnMDe9E1HKbSyhGesEUq7BJGtC3sTXlQXZm1zjCt5TA
         cSAdwpWxVKl+ACeS2iYyIMQz4GRxETvi5p9vYdpOearBdSHfybifGpvNE0aZu7NQDp0a
         /3qOQv0UFKgGwzjCQUrRDDUi7pbD1SJP6r3wEgTrzMsxf+6y+vHGAR0AH/IXTAYjoycg
         kWKoTZ81WT/O05ldgPCssOkjM5Vrlph1ecaKrRrxxlv7aAgdD9f4Q4euJdy8wr0MUFHF
         vgI1eBZAUyzzvYh65uPwCkI/KqMTA/QrCAk6ZiZ9vDqigsV4EFBkwRnjdTPYCEEoGOQG
         Qm7A==
X-Forwarded-Encrypted: i=1; AFNElJ9m8fDtfyVoQ7eeMV4eojB/ar4vcM2NqOFy+x7fIm9ahcKVYNLEQwIV+X6VURQJKEewGG9Ijof7mBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMU1UP59erxOf9bsqk12ZNwaidNDscBS8PFUT6Acf7HA9d0fDy
	J3f9PnEJp7XjVdVfarI1/rRrZQDh3OtIuFh7IIM4KM9hHgUJ8RQQdGI3x21SpTACM5mr2SOD+nJ
	BedBHddQ33MQHt4dWYl0XByisXyRXeIY=
X-Gm-Gg: AeBDiesSpqBShkbKPPDUEgZ4TF1PSZ21fIn8Lu2l4QlwuzmerBSsFGA91+l2nYKMSFR
	NUroqes5fkRVR11SS40MvO7usRY21WC1wh/u23LtQ3GR4o9N4cZL/Jj7G2ZE+yV6KEA1m3tQHcv
	C7RPpN174pYYu1eKx6BTAy3mKGi9Pr5lRDlFkJpu6ibfRInk8VuJ1dVdt8SVHAKhd02a0HnGUxt
	KDY5cXCyuLGD+3i9fAfHtY/WAox36neAJmTmE5BWmi80y8np3Bd8wCUFAt7w8nFzG089uVgnGBg
	mmF9j/QpO4vDiK0LubCuNkjk9ETJJ+NNseAH6A==
X-Received: by 2002:a05:6808:2006:20b0:479:3f61:ef98 with SMTP id
 5614622812f47-4793f61f889mr3626813b6e.2.1776168678853; Tue, 14 Apr 2026
 05:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414095929.11257-1-devnexen@gmail.com> <ad4unjKuC6Ff_yse@ashevche-desk.local>
In-Reply-To: <ad4unjKuC6Ff_yse@ashevche-desk.local>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 14 Apr 2026 13:11:07 +0100
X-Gm-Features: AQROBzDfj0XwBqswteHJSS4t3C5iOmGO9MtqXStcn35i-bOXhczIpRLis_L3E5k
Message-ID: <CA+XhMqwuhte0j2iO-NYVrjV+qQKcuiDY5qAD9+oCLkRqEhwKSA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 13:10, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 10:59:29AM +0100, David Carlier wrote:
> > The driver acquired the ADC clock with devm_clk_get() and read its
> > rate, but never called clk_prepare_enable(). The probe error path and
> > npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
> > causing the clk framework's enable/prepare counts to underflow on
> > probe failure or module unbind.
> >
> > The issue went unnoticed because NPCM BMC firmware leaves the ADC
> > clock enabled at boot, so the driver happened to work in practice.
> >
> > Switch to devm_clk_get_enabled() so the clock is properly enabled
> > during probe and automatically released by the device-managed
> > cleanup, and drop the now-redundant clk_disable_unprepare() from
> > both the probe error path and remove().
>
> Also need to mention the message drop here.
>
> "While at it, drop the duplicate error message on ..."
>
> > Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> > v2: drop redundant dev_err() on devm_request_irq() failure since the
> >     IRQ core already logs it, and remove the now-single-statement
> >     braces (Andy Shevchenko).
>
> ...
>
> >               if (PTR_ERR(info->vref) != -ENODEV) {
> >                       ret = PTR_ERR(info->vref);
> > -                     goto err_disable_clk;
> > +                     return ret;
>
> Now it's simply
>


ah yes true true :)

>                         return PTR_ERR(info->vref);
>
> >               }
>
> ...
>
> With those two being addressed, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
