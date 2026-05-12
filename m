Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7788368D55
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573105; cv=pass; b=GXFrigQuEgjIEJrufWC21KkwaqoepBWLZyZG6+ME3M3HaPs2rIrOpvnSGqHH6uIkHmckTGPSq0/oecF1Yzu+8H7q3XL2eHTPJFvuoEY0xoPUZyLeraPG03gPyumc3vaCbt/joFDeemWxS9pkCLZp+C1jY8DnSjg58GwopusbQ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573105; c=relaxed/simple;
	bh=dmV7M9mEbwPg3k4IoLxCF3fkIUZ+ihJZpVsBTFmfOmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSfcvsCbDmlNfGVtMS/BE7UiM0BTtUeBd6s3zEWGftwTmZafZCjxKIdlYFfvAWK4P8VC7ivst8jr2SFQbGO8IZTTehO49Jv0mY4/gJIRACnBWtSecq0Gxr1yH6C1YSOGboXww6Ko2Vy+Fsok1RrWxrBZ11O8XEh7iPb+r6TjVc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5VRicGL; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5VRicGL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1503340f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573102; cv=none;
        d=google.com; s=arc-20240605;
        b=k/hNHaoDDGVerxJl4gcoSdS8yA7uVO+snQOTDUhkobjDeNQFZUou1FYYnzdSbnOBF2
         CfbvHFAE1GaHnliLYAPucX6eWo07Ruz+4Rem2iKWvfGjEXw8q27nuA+LTvpx6bUeLUoM
         7HUHA6xz4m0+kwh4cuBf5b1+G40gZ2WVgszlOO+Tbxo0kgoWtz7Y2KdZtwAlSbcDfCyK
         PbscVE/3dleknZHhXroH46Gw5Q96C+9l0mxF3l8Ph3GtuLFk+QINeJuobEYhcscOV7Ao
         nQC33gB46Fsbj6u0R9B6fyF8HiYRxCV3u/dBnhraIENjOfFrOoFeQP9CvuK+qAqdd+fS
         0+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MPAWN+o2tXdd6tDwHP39TL8b7Fqc6jzG8EPSQl1Npog=;
        fh=W/J7CyACRchrnnHrQBfvf8dHnoTf+27F4JdJhLh5UC4=;
        b=TfLGEyTf/qqK1gs4Fl97AZUIQVNv88wxoJGZd1fVfsZrVz9eUvPvGpC0XPILFNnc7Z
         t2+G54jx/2Aj9OBXlbYUPhJS8+7Q9YLIqZqd8Mxrm8D9nrFQPpYXD6sZTS8bSrRELUjp
         LSWfYcQt/LpFtb7+J9cxX9F48khf6k3HPwZtI3P1Cs98B+8DKvSIVq20WXSvpYbgCp1v
         wnqs6Kb/eMP0djcCFpBSxxrP8luYikTxP/5+sdoxkFaAIPcKjQ6JmijE7/tDVLu/hI87
         zvuYZddTVaFbR/kL55Rt1+rql531l7jYfKy1ID9KpMOiZBXlhu5BedF6ew7BtsoG3k7U
         lgzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573102; x=1779177902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPAWN+o2tXdd6tDwHP39TL8b7Fqc6jzG8EPSQl1Npog=;
        b=h5VRicGL9LAQ6eb0L5EGRjdIqhNpekogaefphJ54WFqT6ihrAsM2aULf2WXag9XJzY
         iQLURiOoxW7OKxxS9SIWogTheIf0MGBx/dWT+iTF3sDw9/C7GD5GE68g1cniWepG14OS
         VMFESYSSv0Oywluob7U/ah1rQqz+vqCumCKTOHUVbsavhwnjW611WoQ53abe3XZ+0pwu
         kPmHurJbJCIyaIlB7zBHl9HtYvAZgGrwL9O4wtm3iEkGCpWkUmKt0gkDPWbank8YHl4x
         wSXoTrUUbQA72QTRFQUgO5qUw0Im/lOdubqaChSrRXglrbXK6z3x037slUHFwdRw0HUF
         bSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573102; x=1779177902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPAWN+o2tXdd6tDwHP39TL8b7Fqc6jzG8EPSQl1Npog=;
        b=RtzCG25riwPSMd2p0X9vk/HqqOfT17dsSEEoULuC3E6yrHn+BGBNWLo8m5KEAA8Fwx
         sHxwXK/EXcvGXfCCUzpczeUk3lzSlpBfXNxPz4IUhTA5MD2v6b9fnd+i2PACFcn3qxtR
         of26NIos/n86ZBCdhLKZgCrUyLAvRn1UDuS9WYmVT4lDlfIMRUL6SukI9TJKfilEszQ5
         bQDErNPrD3+LUX6Tx+cWPhUB/8ebRdEABvYti34wtFFTp9xhN67J8qCdrQIUxGD2fogh
         1kqrNHKeW379MswWDh3zPtWKOJDMEFTxwhrIqHi/1FSoCLrq6Za+KdOG4/TStwvrmecM
         Usfw==
X-Forwarded-Encrypted: i=1; AFNElJ+nawTQzaw2T66eAWLlS3XqkIe0ZS2t0wHml/BnP9mNh6UZ063Bl3txtqBfBE31OHMekSK1mrYrSJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SaQA7/lBJpk0QB6fLtp7Fjk1+CGMazjMMsDwboJm5iLuHq9H
	DcfHVDwB77fy7NE1cWplDmHFGlf18m6KaofybtUdJv8N9VLP1V0GyACjZkchsQc6gBUS06E7KXY
	7kErJhYS7gp/oCWP3Z4bxSCQxmLynZVY=
X-Gm-Gg: Acq92OHtJXskA2r1+kyoFUHUzH5HRD4dJX36NFVzssbHMSdjokck0wfjWW0VlIMuP65
	85OBheZH1BA//zzzPKm3AyjmMxd1gbz7n1COhiW0D96oXWu++alqOJseyWck46T/IXRvLie0HtC
	iw0lx9NfODo6rGPYL55n8y9TpMvPRjmUZJRyH1dNzCcwPCr+2vp71SlN4cF7iQv9lm3KIKDlNQh
	yUcYnQm/24GGZa/2xduMCqXCvTE4wPRcLMltFbd5ArY5+M5//OOCSdH7odS2TX65zaYXJfmcUcV
	DthgFIz2toy+aOZPs+HinDFAHnA1tLHGNUnDoltS6O9/LV8Q9CtO8OFrT/JYKfXmMsn111HwB/T
	0/wNqMSfojbySWyHAF2G7Adgfi12TTHFjLEwRh7Vvx3Q/SvGOwSyV939YnPvUlNiXCzuQxb6IO/
	bDPFsVWs7ZmoAsGc6d
X-Received: by 2002:a05:6000:2383:b0:43d:7dcf:ae26 with SMTP id
 ffacd0b85a97d-4515d4d107bmr46262506f8f.34.1778573102193; Tue, 12 May 2026
 01:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073505.1310-1-joshua.crofts1@gmail.com> <agLeEitdYsi5O2E1@ashevche-desk.local>
In-Reply-To: <agLeEitdYsi5O2E1@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 10:04:51 +0200
X-Gm-Features: AVHnY4KMiOJSr-GzO-_TBzSfSlqP2j6pIPpJGrMXE8WWQqWOXH4wNKmB35RcJug
Message-ID: <CALoEA-wOAY9fYuZdZZHQFj=+xN=WB=Z30g_iKJUVQHHiHHXxuQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 10:00, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 12, 2026 at 07:35:05AM +0000, Joshua Crofts wrote:
> > As promised, I'm sending my IWYU mapping file, based on Jonathan's
> > version with a few additional tweaks by me.
>
> Please, also add a link to Jonathan's version.

Good point, forgot to do that.

>
> > Other than adding support for more assembly file business, I've also
> > experimented with individual symbol definition (see BIT() and GENMASK()
> > in the following file) - this is to prevent issues such as the tool
> > wanting you to include <linux/bits.h> when you already have
> > <linux/bitops.h> in the source file (I agree, doing this symbol by
> > symbol is tedious, but BIT() and GENMASK() are symbols that especially
> > do this, and they're included in most, if not all drivers).
> >
> > Feel free to improve this file and pass it on. I wouldn't really fully
> > rely on IWYU as even with the mapping file the results can be weird,
> > but it definitely serves as a good starting point when doing driver
> > cleanup.
> >
> > I'm making this patch an RFC - this is not intended for merging.
>
> ...
>
>
> > +    { "include": ["\"vdso/bits.h\"", "private", "<linux/bits.h>", "public"] },
> > +    { "include": ["\"vdso/ktime.h\"", "private", "<linux/ktime.h>", "public"] },
> > +    { "include": ["\"vdso/limits.h\"", "private", "<linux/limits.h>", "public"] },
> > +    { "include": ["\"vdso/time64.h\"", "private", "<linux/time64.h>", "public"] },
>
> > +
>
> Trailing whitespaces.

Well, considering this is not intended to be an actual patch...

-- 
Kind regards

CJD
