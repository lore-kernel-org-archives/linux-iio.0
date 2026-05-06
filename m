Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE4261388
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064624; cv=pass; b=mafRyxB2GslMcAh9Ku+ecf0rWkbitYYoPM7YA46AcYpbOipOJpYKlDPgKxfdLC1jxWIYNkSIwjCQnIXgKEtnpClvb+4fx8eeA5Rr5tsrCjdIQJtPPrgwgesvD5D/FvRwW/n20IoF+M5gC9c1Mi1cztTlzRQ7cpokRZfedRux3NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064624; c=relaxed/simple;
	bh=BlnRLkwyMPeNTSpP/iAXHGFXC3tn9AcP8drkGiekx8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmdVFbNwJ3svN1UHJ/afXnAXDLWTaumMqQgBJ3zveunHqHyY2C+PSvT3I2Br4z2czwZP/zQk7lrqq8TNNX7GBJHXhNQIF0JhoPgx6YLZmlQHGBw11IWMBtwT04ZBvZwWnRbPwZRK5GrFh3RHcdz1sAGRVqxQhvoPrqV1gWVwyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG60U0eJ; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG60U0eJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d102471a4so30106045e9.2
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 03:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778064621; cv=none;
        d=google.com; s=arc-20240605;
        b=YESRZ/7xJ3h5yWqkJ2PIcvt0PdfvMdad5yq7DD4NF/OhUHyN965lNiSBJStbNnSlmL
         hoXYVEiqL2ohDTcTk0lXRiuTE4RT9ap/LJwUh9NotiSIDP9qhCLKfQzmM3EzOyH2SpnY
         F7nhq9maG3FtKDj68xpeP/aNdSq6LedvaD0tqbfUq+GhEvkaCz/SFNlPATUf4iaXND44
         YkXRNCsjfK0Zd/CKcCwskeXMJMEK3r+KA1IknJ2cQzlmBrTqPetIorvfBmPClz959il2
         4HyP4snicFEHV1HHSWk8CC7kE9hyex93B9O7E87NcMG7FtHE2XSkyZUWSrZ7WFnZ0ANY
         mTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nSCPfabPiukH8olRD+jOmb+DxOr4x9Cg9JzaPxixMEw=;
        fh=HEkMX6jSvL1wh+x2ltCVnaYuaK96w/5Ls0VjdamVoBA=;
        b=OS4onoDwu/+pZuYOQRGBzBoTi3/JfTO9N9YRqUbHgPbhSHcDji2lxwFIwWT8WENJBA
         ndgHO/8etcOhA97+LvS7tUw0F0rnkz72IcYm6VJHOZjVj+xAU2Iffyj+KRjLcJHMW8LU
         eo2MYnQqMMewkdssNNwVVFvOgUYNVPMsdJJFPmuRwL7M4YF9WuJn6bRrW6vwjn9TgLR0
         w8QdbS0eph7TsyoQgWZqZXYpagxb50gYwcY+rIuDj7qJH8RqTV+VXPXIYuJSQgTFIFsW
         aop5T+PfVBRkOV1YISTSZ0dOUBPJsXGLs/5ihdcujJQSIOpEWmvtdD+LBbQA1c7eaIBM
         axwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778064621; x=1778669421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nSCPfabPiukH8olRD+jOmb+DxOr4x9Cg9JzaPxixMEw=;
        b=aG60U0eJmIwHNO3JkarUp8SIncgCDAzoA6AUHU/4NSXGHgRRdVM7aFvhLA0G9F+/p0
         ViBDfIq+sHdxTurRftFL3vpgsKnMdqulex5BtYHv1J+IOEvpMjtND8gSGXkumhjpikov
         ysUBAFMnqENmhlh6PQd+paiNABFlAU4YPqV2pl+dZoP0YUeDF2Zw/ZgC3sfTYSf029Hj
         S8bWtmzsXZl6oWD7KMVgEcMR1knuEsHAoyqs+zaE7Yd1jWvJu4MTgcWG6BU3pqCAvMfO
         1q7lxAsL2n2WpbSkiWLRw0U4kww0MshszwY8Q/hCLD6D9/raVSdB6pGn6kakg6ja5CpH
         3Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064621; x=1778669421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSCPfabPiukH8olRD+jOmb+DxOr4x9Cg9JzaPxixMEw=;
        b=YfCrIM1/+9CzDjFy3XMfCm+idJHmNTF3RWnLCirG+T7IoY09SV9eegZQpWi+caNtFS
         fCw3JdhmyCISzU1NbXNNGz79Nti6gUBCWTFAmKUwlIQX5e3TUDhlkIoa/umE+Gjzc8OP
         xBZMYlf82eE1qeG0dZTSSXezhApmoq5il/oRddB0YBYHk7DneP41U9Y954vnpixqGYj/
         rxSoWWk6BE0aCJQlr/fH87+7ZM/nZtA8Z7f0Pu16/lYZStRh7woq3rZ2qSP+uXo1wmqj
         CErEEeQmhZz/9l06RaLqUmBuTpehYMUHEybaiOOwzdigqYIZ9vDiRqpPQ59YupzIHOWq
         fgCA==
X-Forwarded-Encrypted: i=1; AFNElJ/f/e3NA9j9JS50Qbxw6dcSvNQhejYwmfGmfGzq3xWQdalTm1t4grcNUh+sDVRRUnpUmiwSXo2bEaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAArMusZQVsIOYDGpb3cyOfYDajNbAjA0BavigctemvUonRzDz
	mn9oYZTuxqzHuCDQ2Q++HCNxPX1HycVmYKPPKd+SG10N9z/yluGD0eeAbFrdF7CwIuPoUa4JkGD
	1GgnLsZUYcwinwg+i2yr+jnukx4bBa4Q=
X-Gm-Gg: AeBDieuEEhjG51+dXRLuNuHGDxAM166FXghYnsNYobcgluCNxPokFUSpbWvo7jc5Pfm
	LOWmgIxn8c/4kZkSApQhhlSPfSVhjgog7Tsl9Zx6pdfbDrsSPQIvrI5YfkClzj52uiNtY7rHf1z
	WXgcrvHnA5E3D02yvItLShIgaJrxDnD6obQbeMyZOUptZtWrusALNGsLvUVU5YxPQ91SmkfEinh
	c5ZFzgCCYzS3Bowx7AwJUfxXB+uWuTU77Ls+QCBRCqHDPsq2O6qnJbVZ6JHUlXsn4XH7F5Xy0+p
	hJWSeS6oyNdkLqRwXEX0nSjDRZ9Ovt7rLQclh3AYnRWI+gLZtk95uzn9pngOvo/26YEMqdIYGsd
	nbiqyhMGpodCSCLg1ZhMtgb/6gM8wReHnwkmefO5to+Gn/MsKXQB6IJNckVap51T5BQF59/i8U0
	42uQlvdJftXlhqHqMx
X-Received: by 2002:a05:600c:4448:b0:48e:526e:1040 with SMTP id
 5b1f17b1804b1-48e526e1226mr45049025e9.23.1778064621189; Wed, 06 May 2026
 03:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com> <afrlT71SjyQLh2xz@ashevche-desk.local>
 <CALoEA-xjvxYOQ8Kt+OXR=6E_TrjUmC4J6ZXftE6hri6z+Wzhrg@mail.gmail.com>
In-Reply-To: <CALoEA-xjvxYOQ8Kt+OXR=6E_TrjUmC4J6ZXftE6hri6z+Wzhrg@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 12:50:09 +0200
X-Gm-Features: AVHnY4I9mFVaaKUBKKDkhwm5BhseTDrJ6-kcXr--u9nfK6vNY6PpKHTgOEBkXog
Message-ID: <CALoEA-xBcPzoy4T3+0edrnQLV++k2VN5ozWan8L+gnV5P3CLFw@mail.gmail.com>
Subject: Re: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 09:01, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> On Wed, 6 May 2026 at 08:53, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, May 05, 2026 at 01:46:03PM +0200, Joshua Crofts via B4 Relay wrote:
> >
> > > The driver currently uses while loops and msleep() for polling during
> > > conversion waits.
> > >
> > > Replace the custom polling loops with readx_poll_timeout() and
> > > read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> > > boilerplate, standardizes timeout handling and improves overall code
> > > readability, keeping the original timing and error behaviour. Add
> > > <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.
> >
> > ...
> >
> > > +     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > > +                             poll_ms * USEC_PER_MSEC,
> > > +                             timeout_ms * USEC_PER_MSEC,
> > > +                             true,
> > > +                             client, data->def->ctrl_regs[ST1]);
> > > +     if (ret)
> > > +             return ret;
> > > +     if (val < 0) {
> > > +             dev_err(&client->dev, "Error in reading ST1\n");
> > > +             return val;
> > >       }
> > > -     if (!timeout_ms)
> > > -             return -ETIMEDOUT;
> > >
> > > -     return read_status;
> > > +     return val;
> >
> > Besides the unneeded return val duplication, I think this is the wrong location
> > for this check and it changes behaviour (really subtle change!).

Hmm, rechecking this, I agree with the unnecessary return, but I don't think it
changes the behaviour of the function.

> > Before if the last iteration gives an error from the device, we return
> > -ETIMEDOUT instead of the whatever the i2c_smbus_read_byte_data() returns.

Looking at the original function, it always prioritized returning the
i2c_smbus_read_byte_data() error code before returning -ETIMEDOUT (even
on the final iteration). In the new version, if the i2c read is bad,
the read_poll_timeout()
code will still be zero, therefore allowing the code to jump to the
i2c value check
and then return if bad (this is still the same behaviour IMO).

Maybe I'm looking at it from the wrong angle though. AFAIC Sashiko nitpicked
everything except this (but yes, it's still an AI so we have to tread lightly).

Same goes for the other patch where you raised this issue.

-- 
Kind regards

CJD
