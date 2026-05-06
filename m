Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2836D9E7
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051319; cv=pass; b=jh5gYLqmXiiWPDqdzumR1r79sXFIAxvkDL7NfOckNFZWwf2awz4KsCJfJy/l2c8rSrrw5UcNrKjkhvxmHtQKL31/ewD3p8CQcoxXOzNot+mmfoWgECFVSINtPr6uR0YlemsMxdExj2K0pRBqipB3G9vnrt6YJWSAMqwFigWLmC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051319; c=relaxed/simple;
	bh=b3SZgmuL+IPrrTMBnzb1r0MioA9hnQBcJd5OUTFP5gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/cGQZPQ3ncXkfckmVZxtpLKh1j6fn/WatvmWUwyhIxgraVtpm6G+U9FCaKGcEgVtCtILqG/IhQJ/lCHQSuoTkI75GTCyANMtfWN07Urs3/N7cq1Lr6wHyXSJPMOwzfacYRTI9LdwUK4ZnJoKaUau3lOQW5IRvgBEfJuEpYBVQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eagb8zGW; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eagb8zGW"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dcd689829eso5478435a34.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051316; cv=none;
        d=google.com; s=arc-20240605;
        b=fBrFejtH5t58VXWPJp0YrTAxfmhuyBAUGd4f2Oa0oO9ZLv7yK3T3n7NyatdwFIXZHk
         0mixDIi9UvI836Vz2RHiS1wMPOqmXtp6wX9Cm5cCg5KQ0dAD4Abg78j1zi89ShRFSEMN
         6P8XHpljlEJz0gQhoiqEDLCzugxfcfE02zve1/Ubpjc1lrGyTyrGDyKYGoGDsPyX2zzQ
         GvXqFAaTemYTdttKDhkqb5DLmLXRKo1fUngO2uWh5NaaSdZwbVxaX0Q7/eOKHfxc3r5g
         bVZLhVhEdxKzWKQUP5+IwAdxz0czWQZBV4P2U6Zwdmnv+F+dPThuyB/eG9a3w0F8U59f
         pvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        fh=c6vhyzUmttln9T/Xdk7W6CjTPnH9JZYGJDXax5hRgfI=;
        b=dG7dZAB00/WwyFP7HvGgvkZ6tVDsi6+bNkVmZ3LQsdO4J5ljxUUEbhOfN+hP9yNtgQ
         2L4yxP6lJiib5x0WLlSQF1RA7hL6lUYxo2SY0MmEuSvzK3l4DGH/j6cnH2yRBXRSlT2x
         z+jsBlE1Duar5LBB2WugoBTeWjAa4z+/oekJ/L6opcq2O0Xrt5OJJtHiN33Wlmtewa7v
         QmiGDkOKXrwY5qXwSF84v+Z3SZAS4hP30NX06dlWFARpucu5agQ2GI8Afe6CkzqQueUs
         Le/lin7c2Agn0Fu666CKgcVmNgtWRpz+r7tdKaEs85+i1/dXUF0SA9/fdNG1JQpquMBl
         lrQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051316; x=1778656116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        b=Eagb8zGWVeWieD6tIrgESZIFXMyi9PHFSdyvLQzHzESl5YL8gFA+Sy6ALNyEBbJLj4
         dhc9L9FH3juIV4dqWD63oJp9e85J10H5cv0xV9J4cm5XFUH6+O+V58Dc3ly5avCG16cz
         lqJ4R8Pc47fskTR6bB/DKf1Clvv0DOsEOmTSywc8tDxyVI8VNF1VYswGJZuDbxoIw+cA
         asUwLKmJiPBeU/s4iOkxvSRDYExDoFS2NJkb7sPfZNZq8cPom8qw5la35oGJhgQ16s82
         BKbx/5PkQ9zvViA8f+u6rDU9t8zVE6e4F5RC876GiPiBhzS248fzhsW1UxtrObflsHwL
         USlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051316; x=1778656116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        b=aD/8UzcdFPCAP6DgmdO712nRVVnFEtRiThdz1DvzzU5SIcgfbAi0DQP8ksv5L/aqOq
         ZZjrDfDPiIp+Mv3Vzh9voYJbthrpvpjNGQedqYOn1U/kva/czVtxFW8YQM7t1zWGU4Kl
         ysR46GkY87scMRvdQkRAMxTH+M2p8YdRWYq+m8on2MhFNJ5smlxfrck5Pt3CQiN40MYD
         FzGXSGrnmPrzcRvOYkQPNf4eu1OmoERcL3vIs6kSlZryWsv69KX8kpu4vQqc/drMnMW2
         3wt61RTnRlKZzQFNYg0LnpsfB7uVJ65rCacLHiEzgStOUiNG5QsinRJNAui5vax8dFRr
         QLMA==
X-Forwarded-Encrypted: i=1; AFNElJ9W+rKIa9U+HdBUzRV1+ZCstk7wG9ijvwnToKbkMUdMN2Dm33n204kr6PDnamfVqCt3ZLlSZXgDvFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpZ8M5AV1m/RP1emvv5Adpxd3R+8TWvkgDv43urOrA2oAMFO7
	+VVfeJPMc+4dvhqwykEqT/Ds0+nWcVMEAo5/YRBuFzjSgrms8W52LGJncfNP1oyrRgmJmtqczNP
	6Rd02dXM3w1zkHyKaiQ5x6JEobGPzRWw=
X-Gm-Gg: AeBDieuUZudBeuxzX7g10/4sbSuqivQKGj4UVYAZ38tJSj0SbmWmIrc09CT6egq1Qyp
	2DxEUJ6CD7gAjRrY+sLVFGhENtSB9ROf14MhQnSmg6RJHWCJFKC3MiNNYeWGS7PmfYW4e9AYBdt
	EDUi09VExrfv7cMbF2XBNeea+UHdXeQ7UE85mA4EFYM4TBaRwDHLfa0ePLxSvpv0fVD8+6z4HCt
	Kud8wkJTdJb23+D7euKxQJUpnJblT9hMTxV2DzVERNrEs7zxyFGBwidKX1otKhKPCeG6beThaCl
	drqeTkY0TuVKoBue8h0csvAMnGG53mBR7a1gzDXxX1t8bGEv
X-Received: by 2002:a05:6820:f007:b0:688:c97d:bfc3 with SMTP id
 006d021491bc7-69998d095f7mr995678eaf.38.1778051315984; Wed, 06 May 2026
 00:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505133748.51355-1-devnexen@gmail.com> <afriNDbCrUsXwV2a@ashevche-desk.local>
In-Reply-To: <afriNDbCrUsXwV2a@ashevche-desk.local>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 6 May 2026 08:08:24 +0100
X-Gm-Features: AVHnY4Iy2Ls6WXMOqLU6Ra0Q61pO6ttLMlyXLGaz6OVSYbk91OAxucA8qW7tSNI
Message-ID: <CA+XhMqy=_dwpTz9c+kZ9tNJz-dHDRuPyc6TsoXWKODKgxqBJ0A@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack location
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 07:40, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 02:37:48PM +0100, David Carlier wrote:
> > itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
> > fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
> > parameter (a pointer), `&buf' is the address of the local pointer
> > slot on the stack of itg3200_read_all_channels(), not the address
> > of the caller's scan buffer. The (char *) cast hides the type
> > mismatch.
> >
> > i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
> > = 8 bytes into the parameter's stack slot, which is discarded when
> > the function returns. The caller's scan buffer in
> > itg3200_trigger_handler() is never written to, so
> > iio_push_to_buffers_with_timestamp() pushes uninitialised stack
> > contents to userspace via /dev/iio:deviceX every scan -- both a
> > functional bug (no actual gyroscope or temperature data is
> > delivered through the triggered buffer) and an information leak.
> >
> > The non-buffered read_raw() path is unaffected: it goes through
> > itg3200_read_reg_s16() which uses `&out' on a local s16 value,
> > where that is correct.
> >
> > Drop the spurious `&' so the i2c read writes into the caller's
> > buffer.
>
> Very good catch! I'm puzzled if that code was ever tested. Do you have an HW
> and that's how you enter to this bug?
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks! No HW on my side -- found by inspection. I had recently looked
  at a similar `(char *)&buf' / `(char *)buf' mix-up in another
driver,
  so I went grepping for the same shape and itg3200 stood out. For
  contrast, drivers/iio/humidity/hdc3020.c::hdc3020_read_bytes() has
the
  same signature (u8 *buf parameter) and assigns `.buf = buf'
correctly.

  Compile-tested only; the analysis in the changelog is what I'm
relying
  on.

Cheers !
