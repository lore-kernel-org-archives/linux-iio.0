Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05B339709
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441303; cv=pass; b=tZ2Kz2BUMEybhWvIruoLeMlIsJsuoz1tcPScTtb+RzoaFiC7BYcxScZxWQbudfsql4AUxU8oNNppCuO+oIoIR9S6VDZS4O/FRLgxH7AS1tc3+y4Tzzp7N0gutKLVOBk4w2fPqFshkip0MNoJnSYmhBcJt5mJWILnpoe6zn+N7ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441303; c=relaxed/simple;
	bh=DZuVyYmAJlNHQeh2UsM5TuQEw8xVuRp2mZfwN6hfsiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkB28vVg9qWx8vff0plJyHDZ8GC3aIMTJ6QqpnbQt/NskpgtZQLy5JWW7H6VtiiCVniQGbfc18McaUL4XvPS4y3AedZubBOJJVkW6ex1s8cfC5SIRHR3Qo9cqP8u7A1YF5t0gJQk3gjCzw0PL76UoGZWJWL/daQgxKZmLf/LbOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHXv+wTc; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHXv+wTc"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so5895518a12.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 07:28:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769441300; cv=none;
        d=google.com; s=arc-20240605;
        b=FXW801/TMIH/YHU/I+2v5PRomLgF0zh2lFGD1t8CUeMbYxPex7iytPIoPK8VbHVzJ4
         IBqNdCPSfhBeUdbOBVAT6iMgOoyZ7lc/jc8kE2zNOO+XiSArRBNZtsWaiqpyyPUyX86n
         mMvDZvFKgUHS/E6pfPJ7O6HXllen9xLCGLdMyKu4TYwYbRgjbHymE27+Jn2up54KgzSa
         72mYp4gx5hUmGmOs+x3fCwDKRFVUGvi7riMXWVoAXfJAeOAgsgTLw6hINl+RzBgZ5MWs
         OCMAxT8bvXCR1pBy69+C2R/W5yIMx4QyGx6ZtrxCyxhzuWj826m6uK+CbzXuzTlKU/Ry
         jAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P0XjDcj2o2hjGIIH2CLp+7qJSqdr/dOfyw8ype3p+r0=;
        fh=UOtNFuX1c4pTE5OANbj+JQQZ51YbaztagKD/m3QpFGs=;
        b=X0qIQzGfq3ncxcfdnFemIjJuITNz2ATTupsjhUg/8bnZcSn1y20smvSrbBNrg2B0Wh
         Lpq+DtOe9NyImkv2JZ+SKqLYp583ZlvRn1PM/zz7mGgNuCZgLFDRUDUcJKHURJs+5+qc
         ZBLtW4mDgu0HBzjVTCVTFyA4xhDv2OLhqcjnM/ecjJLN3bkJLgrH5en9m84rxbI3UgBL
         xiNvvpyBWBUXfEp9FfI2l7DORg2LFE4GOOE+P6i1+0s7zekmv+7rC5L8o/mJ++ZxnmAg
         o0DLWRkEjFHV/gEKo+vjFcNp968VUEJ8cyBCgeT4dGFsPMBExGkjSH/IOt5dBU+zpmM+
         vBkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769441300; x=1770046100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0XjDcj2o2hjGIIH2CLp+7qJSqdr/dOfyw8ype3p+r0=;
        b=YHXv+wTcg6jYwfwFy1uvnX82KQVSdGJ3joUvsQDfZChy+qJE6s9nWRng2SA7fnZL1g
         iJWHptzdx1i8Lfb+yAKI7wAcf+DmnKO+E6PauJ2y9215ej0mkt2hPb+r2sTBPeurNHR6
         DfUZ7MRwprr04t3ydTIwWcT8AskQhVGQZ5nLzqIemtQ9PppeXMa7LH5pyBkaPlPfVXd/
         t/fys1MrzGHUCc+hqC02x9b+Vszf3TVZ0xT/RqyhAQ38EeVrsowZeHstgykX330PncE7
         W1GVuf4/gspkxTo4XO4566yFjA9RfMhQ6mpphllW3EkLhdI0kceRlgJl7/hDOYr+gcu/
         mTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769441300; x=1770046100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0XjDcj2o2hjGIIH2CLp+7qJSqdr/dOfyw8ype3p+r0=;
        b=hsYEPcBjdyx0/PlanVDquylMjZQd4p67nEaCJp1gFl/9TAWAimQXVhWnLwtvArC+AM
         8Vsh+UrtcxR9g8tTa//7e+HtD2Tv04cHnpDnLxx5WVC4gf3lIIadC7DB6mPCvYO6bQU4
         KMl+lPlGqkvsOj2oeEcIsb3wz0IdmISkU8P76yj8xy0tVXaI8PnNtCPBzfSwWVblCuMK
         UtYfZaag0ZA+5Otamqef4tiHnC+IJC4SP3nXSG0BThEQJJnRfmRn0KGKMnhEg/e1dJEa
         h++cnuBYqUW/MZD6v1Y6fVGhCPKu9Gy9JLMoiZrE4rKsDJ4sb6zX3//zPTvprCZoRkKi
         UpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA4nHoy7urjq2nnC3/AFUubsn45e341l7IyJpNC6UMtFQIZdkt55r6dguAB6leIr9+lQVInvKTa60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7AOO4C4dUOMl6uMlcBq4K7Dsk5UrEYRcGFq4bZBVaBOR2yBG
	9/BJdQ3p1ZQDw2pAsYjvICGtvBSJYb/TB3vdwHeDLv/CR/HA7Cu+wt8V80dqACn056NGAzlhzC7
	wseJZkdKyJSl6avwy4NK7gSZabv0nCv4=
X-Gm-Gg: AZuq6aJtUjpnNxD53scLnZaBy7FvrSEZjBbsmpYCtTFq7Qqw1zmPmMa7jSVirCy5Y5+
	8td+l4CipOIIlIPjPSwtScifvGVxt0uFLiW7r6xSVwx72lS1f6zWMVUy2mRd5Wn9v1D4rPVv3tv
	8OmHegLVoXmIJ6lVcV08FsASEpo97nUUoEwzHbM/L4LtfKR1x8y5gyttb2RCY7VpwXW22bV4S8j
	ANSws3H0gXaFbfSgKplsP/upBQan/rnmQCu0fbPYyCeweGB6c2q6+UHqydmvsVYYqftXbY=
X-Received: by 2002:a17:906:7955:b0:b84:22cc:3c8 with SMTP id
 a640c23a62f3a-b8d3fa128f5mr341632366b.4.1769441299497; Mon, 26 Jan 2026
 07:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com> <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
 <CAHc1_P5hY6-z5s0J4SW_2GMER+NP4NsqoVVVaYFUg_gRi=31JQ@mail.gmail.com> <aXc3lPNFF18ygeow@smile.fi.intel.com>
In-Reply-To: <aXc3lPNFF18ygeow@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Mon, 26 Jan 2026 20:58:07 +0530
X-Gm-Features: AZwV_QiB1pA_yKuA5_b0Y438f7gLUi63CD2fPIwUfe0nRdJptnszvolzl1iHctI
Message-ID: <CAHc1_P7vG4=zzTB2RWeNXzaqbXZ7zKokUJkRXnwQOXQBgJJmqg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Jan 24, 2026 at 10:26:04PM +0530, Shrikant wrote:
>
> ...
>
> > > > +                              10 * USEC_PER_MSEC,
> > > > +                              10 * 10 * USEC_PER_MSEC,
> > >
> > > This makes sleep shorter by 2. Why?
> > I have considered the timeout values from the RFD77402 datasheet.
> > The timeout values mentioned in section 3.1.1 Single Measure are as bel=
ow:
> > 1. Every Status Check =3D 10ms
> > 2. Whole Flow =3D 100 ms
>
> So, you should do this in a separate change explaining this.
In that case, I can add a small preparatory patch before the
=E2=80=9CUse kernel helper for result polling=E2=80=9D patch to adjust the
polling interval according to the datasheet.

This would mean changing the existing polling loop, for example:
diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77=
402.c
index 69cc1505b964..3e14660a4bb1 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -132,7 +132,7 @@ static int rfd77402_measure(struct i2c_client *client)
                        goto err;
                if (ret & RFD77402_ICSR_RESULT)
                        break;
-               msleep(20);
+               msleep(10);
        }

        if (tries < 0) {

However, this change would then be removed in the very next patch
when the polling loop is replaced by read_poll_timeout().I just want
to confirm that this temporary change=E2=80=93then=E2=80=93removal is accep=
table?

Regards,
Shrikant
