Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F535836B
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386812; cv=pass; b=MnQH7++HQ+LmkwPW73gedNOqJGFBSmArhU9h/iGzD6hRzTmq3FDpqSnLPGu5BXqRAnP31RGxsQkVQoX6Eny45NSo4b286ydZnt7O6mhxCQtwn5vDTX+rigpRtaP7dvU0oqRkMqvPH8OTIGPGYw0PRs/MLWCH3sURJo4fL9V93yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386812; c=relaxed/simple;
	bh=qeKlmI4PlQA5zHze0ERu2JSHVl9mCqqqEkPcUf8AryA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkVK2Xnu607VYyIk/ZYtND9M41r+vEmPsPXN8m9agoBTN35cqlgSlGUeClz+tVbXIs3aigZIXvzkGkKkSwlAoZb4hIJ3ZnjtUh980vu+hvycH4/D7PILWyh6t0AVLCVUgBN5UrDXE4St1kRCf9E1kQpsm/BFTadrXHIGmdI1fOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6YkN0qZ; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6YkN0qZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so98952795e9.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386809; cv=none;
        d=google.com; s=arc-20240605;
        b=TqfoC+vRVdhdQ7tiy7w53kReBHkriDgSWFrmdeMdXHm00eYY4LJYIqBiH/fRRs7F3Q
         iW/+cVaQNe4/Bjz9UGLpX/vuLD5oF/lJBlNBzVe4Mu2RFFiUGFW73OW8INgyAydG4BX9
         1X61Fzn/lXY/zsG6CqjULrVJaRDQhXgXloN0skGw1l9Uua8Wm8x6P3aWLK7w4ZF3XySt
         Ci1aetxFVrhlepCh6Q27aghA/fWvubTNP1jQMyX8fIVPfl/fIScDArhKwIsqcNKqAF6B
         hMlRqVfAUs9yTq5qKzRGzl+H7ljMuaMlFscXsKaK+gmSWeTmYvW9d7gJeYXjsQw/00yy
         WYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9+Bai1dK3KEzpU1AhCpQLr/J6l1TXTQZHY6bFrLw6yc=;
        fh=wXFPtbO01qiSkZlJYcjrKRlM+HwCi52kp3aQQRSw0eE=;
        b=iJQI8gKNTMo0z/+i+ek83O9sOAA6drgMqnAFrsJBymxe28lov3DZmSykgGoQmW62GA
         4I+BvuC7AA0dbwg0LEPCEEIP110sMlEDh55Ra3YP2G/1LR6a6sW+uPAUQOnEsVOTq+3p
         qIOhTuzPi46OX97pd6HGMXjWE7oqknYep2Y/rnoYZTdr1h2nQigiL21zZkkdpFQhnnqE
         SWwpbUPIRFFhjidzk0yIk7CvefLE3x013ZaIuwnj8GgJQNmwKv+o/IyoDXq98FDEG6lj
         FnCYJ4Fxa96S6hsIfBCLAhbzs6EBkzdvkZwrlRTEZnB77QoD5Rx/UckKdZNVbcjm1H/a
         x5RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777386809; x=1777991609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+Bai1dK3KEzpU1AhCpQLr/J6l1TXTQZHY6bFrLw6yc=;
        b=i6YkN0qZWfrX7pveSPvu8op9vIunBF4vW/jxJZT3KK/pYgQTdguYBgVZ/792a+ku8k
         yWKQHpbnLA9RBBx/wk7S4btWaRU5yKWSQj21VF9ynknLqmZSbfG9aWDWIGGYEsUgXEC5
         5NIFRIiN2YSg6Z6KmuUYBLo4jQMDrp60oUFFm5LPLflxw9BQ5ZzKi92j6Bk6rgQJX8vs
         To1T6QeAdZ/LHy+g1XfQPyFZNcVC27GqKYWgLzwDjgB5RN3CAetOAjR8a/8/wOUkrA6i
         IYXeZ93XfTkbQKgMadF140b1wWS2xn24FnON7GZFWxbWyrSWe1QGuNTsAB4CKKwsw56W
         61kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386809; x=1777991609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+Bai1dK3KEzpU1AhCpQLr/J6l1TXTQZHY6bFrLw6yc=;
        b=tKTCRsc4txwXc5ogu1s3vaK2sLHiwseOUQtCVC/Np3SNab4G+PflskhNS0VSTY3Pi9
         2kKgAYyzoFk5ITmL/oY1bOCiYsKGsGPxYwL4nyYb3K4BO+RSq5Icl6cH2ihK1odI0rqx
         L9BzpEnKJUHag4qUs0vVfg0Z3pWOFEctLI4CrHTiOgfcEI6ZTznF92r6295fCPbv+s9C
         +h45QuCsplqQSh5pns3eUmFaWwiYdJPqdZvSThuLNyc3V0SEe3PwXGfQgvLhqqUFNkTv
         1oGOU04UuctYCIVJeob4gpURIJk1FAF91F1VSiclm7gGb0uJrF5Wp6aYQR6ptlWAQIwv
         +CwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+VxXcJ2F2eBhEKHCRFNcUOc54MbuBlJAdfTduikslZK4bcrrXky2UDEvSsaoZbOyYkjAWxhTADcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItvHvtWuWLs0Ncuj6o3SvhhCp+Gq7DLP7f9c6AxlDd8ewZ8H1
	g4il/lUJoHAhxfItZ2MSABRTeLisr8ed/mQhqI6SrnoJHTG/GDPgxc9TbCL3EWfK9M9KVBG4WE4
	fuu/b+9WHVhe4i+8aJU/efPKO+b4LpOSB7eLW
X-Gm-Gg: AeBDietF6yvZMDwVy8hOc8FMLB5uFZqLiViXOpmvrwksF6Qq7IjXtDmletWAJTZfy9Y
	2YFR9cLUK8dWgVFQsickVBT86Ic1Z1bxbVPZdTZzSp2lC7frFg+EQz5YixbBtxZ9ixh4NF43UrM
	brO0rmgcYzwKhhmjnhXfOrfeDYEYEFdyKDI69Kj6lziF0UgC74CjxH7R9LYgJ8VCzJ79tfIT0Ja
	Ho6ag+eYVoo4SvYA8U6TccTsCXklARQS/X6UkoQhtI/ZF7COm9Rh8eG2mSoNPrdaVVjNtvvUXfr
	+F0foT4d47Acb8zFzZd6PXaAULXFyIf/gRWs71DTSyggx3mtv41PO8Dz2unbl+W6t9Wsm3v+EB7
	cZQVMvZ5jSzHJ9WYB390iJKGH3nJ8Pel76N9yp8L8zxf/4GkNf08vdw1k+wXSzkelv2RR/6bShr
	64/d0dozvmSllhMOGS
X-Received: by 2002:a05:600c:4ece:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48a77aeb20dmr54795555e9.8.1777386809222; Tue, 28 Apr 2026
 07:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428134205.1137419-1-rafael.guimaraes.dias@usp.br>
In-Reply-To: <20260428134205.1137419-1-rafael.guimaraes.dias@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 16:33:17 +0200
X-Gm-Features: AVHnY4LNVYyjdjserRS8zRwbzFbo9LodxJPFwZUE3blKcRicLAPuo7Gmc1mCwQI
Message-ID: <CALoEA-wd9jo_bPCGF0GqLH9SX7vWsCN7oyvkN3Q86R0F=WTjog@mail.gmail.com>
Subject: Re: [PATCH] iio: light: stk3310: update includes to match IWYU
To: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, Felipe Khoury Dayoub <felipedayoub@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 16:13, Rafael G. Dias
<rafael.guimaraes.dias@usp.br> wrote:
>
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
>  #include <linux/i2c.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/regmap.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>

It's better to group the <linux/iio/*> headers separately from
the generic <linux/*> headers, usually below them.

> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kconfig.h>

I don't think you need this.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/sprintf.h>
> +#include <linux/stddef.h>

You don't need to include this.

> +#include <linux/sysfs.h>

Remove this too, the driver already uses the linux/iio/sysfs.h
variant.

> +#include <linux/types.h>

It would be better if you split this change into two patches,
first the ordering, then the removal/addition of headers. It
improves the reviewing process.

Although IWYU is a pretty good tool, it generates a lot of
noise, some of it not really valid.

-- 
Kind regards

CJD
