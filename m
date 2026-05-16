Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03C3D16E6
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778927875; cv=pass; b=XeiBhn4o42fVQRxbnOre+BrhTx7Fv6GGimHqGUxAcec8+6khRNiD/mFiu0NXDIekS/AfjPQ06uzGXPtVz/uy96V8MsXs3pK4KBthxcLSgEgK3pYI5NrhinXxvik76uJFFmfcdNYQyPrQfRP8B8nhua7clz3//HFRwx+KGlQYFc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778927875; c=relaxed/simple;
	bh=wYQd7VYE6weklq/tDHo+4Eg5a0/6gRBYCIL7sd5HERQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7WaCsmd3BNAYfzgpiNnlvsuzDoRgcz4cPx9tWn7tMnYBLTthgdOHaOav1qINO9SUBMANfakD9W0Hk8YO3Bx0AhgOeTYlKTezCUAtioTStDh/elLlADNw05T7W7m4ydx9sYUCHmvn8eGIirTNl90cTabGOzZqKBa5aeFGn+hokw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8C6ztt/; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8C6ztt/"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4824176bbbeso231699b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 03:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778927873; cv=none;
        d=google.com; s=arc-20240605;
        b=LGhqTOKM6mtERbMODC5OWJ5MQ9qinSMxEhE0Cre4lYoxTkj0yE1fL5jfzpU7dg1Jpo
         s6anSp9j103neAfqXrccbazaUu8hNwrFppJgv58+lywTbpePBBrLw1e3VJbbp6tvGAMN
         juNUwLNdyUorXf0hAtsLNFcd6HvSg+61InIKDnfdQSuPv80ffvRltooWIdtJ4TxReFdy
         L4k9NnYzbPmUI4ePJuzq2f8LlQaKjhrvhNGKIpa3uaMPawCNIO185I8ut5FPHrYnaN73
         NXugkuc2SUC/KSUvfa6V5mYPlzlwLSjShkjLGmXB0hv1GQfC1/xYJDXMFKE5ZF+txSTm
         y/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        fh=l9fvMYb4jdJymZG5ZsTSiWVHKkCXmnNfu7AJU6BVLK8=;
        b=YY7NrVtsdya3g5lP1MHwIj8iIQ6rnvpQpW4KvQ2ODT9uheDuIv17vvbYQHy/L7do07
         kcdCCeMdDe67hgnnINUpqi7hrL13UKJW1M/UHh0aCAHR30MrkNiCVPj38SZd2Ipi/IiU
         ECPjToUZaMEZNU8jYIMuJE8Vgu0EU5tJUIH4K5vHqwXz3Nqdu5Hcsa3dBC+eNKlyGFW4
         zR1Vnt6DT81KZw5eEXMNTJSmUFj2jQhTZ5R6cp/FVe5YnBnl9Wt5ekD1s4rKYtgl2qHj
         h51DB31Tr5OR/Sm6qcxlyTQ0pWe0uuVwY0DZT8KcAAP21SV3vO2fGaLvxe2yvwRzsKi9
         ZBIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778927873; x=1779532673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        b=o8C6ztt/F68I2NMxkn5MLQ9uCtLbfcxPtuSu1hJc/x0EBSWcDI/V6VrObLxvsveWZv
         9NkjhWTQyqFlYCVN0BWetvaIb/4QomIxTJ8/mJrkK0Oi8G/V+Xutk8DwpWAQ1y8n96Lf
         ArtNRlaVIJlukCP/QZ2a26ym+YwzCv8pN3WjA6/gY1ZbfF4E7Pl7HkLNHPM+SUXkKnnw
         paTMb8drONsNgo+eoqU4endHcey0WyIZg3C07dVIH71xPOrHu3hY8K22reZTOhhpZpf1
         XkPtVMb6lfg/ynZzNkqSxuAUpL5XZj2TJybi3VLY+uKagDZzE6M+xIH51YqZ8U5E720H
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778927873; x=1779532673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLgGU3hI1hvXoPjrbJDKzwx/g0/uUa7uAL8mWcmhusU=;
        b=aMtnRi3C7lD1WPBxPN2asv+XuG+ycYi7g+RSQzXpSFCqCvpLDYwZCGQ1qX2SCBHKTB
         LciOiRjZve2FXhLmdyk9Z9akevyeJVs+k0DOdeXSdHJLMHmj/YHEIkWLtqvDkH/M0nml
         XKCf5IjGxL5d6woHPLrXoO42xGLbI5LYgai3rGLx3jiCKzoTYxA2gP7HiVN2NsexSJgx
         GQxIwhWyddlMDpovzFxKydv4szo/3VWeY8PUVdvjpVjZkvj6uOlxhJ/elpZn48tc6rHR
         tNOP/CndPfAsfoWew2vpvQT/m7SPBK0vWPPw9ydpTv+u3gHIbMiedxzjzl1CyBLOmF2Q
         SEjg==
X-Forwarded-Encrypted: i=1; AFNElJ/XPyq9ibBegnmLjhc2JpXvc6E5lwGWIlodAG0dFTDM/h0g/ELFTjFdyGZxBNuuy/zsla1QvnDVivk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUple99Zj/ufyQfmZKCUKOk3vawEiO0f3AZLOLmm9nM0P8bOlO
	BTfzdEJqn2+WWolHeL8Atjwk31IYOrIFI24NzRBaasCkSJ4ySTYBYglKSVbaX1++6KnJ55p0yWT
	tTFJEQsa+4A0UuCmux2rGFdSrumt+amk=
X-Gm-Gg: Acq92OFgopFC3UwE+FL1w2MhKjklS7sT4eKUBA8+/fRWcCphNjyL8f9j6YnXhhQq1qz
	NrpO4OKOKC5KiSZ5krkMxS4VP7BR3kEA+TCVzn3tpUxaylOgOaAjl6q+JQRYJUAM3LCarG3g9FS
	xX6EDlZniM+uElMPcRPImJLlVreK5HJTfeNfD8WTw5fsXpDyhS4+1nuHYuC+SlEdfi4D8X+/iWm
	17Zj78viPzz6YI34IX7+7Mj+7ZCJy6k0kro9od//6tTmfT525/4ut7MuLzsiJNEDu6/DFftl9CU
	XDrBfO5hAhoQDu4GjNqb2biA+Qp5lYkbkZM3YxSi5ceZS8Y9
X-Received: by 2002:a05:6808:3992:b0:46e:df55:23fa with SMTP id
 5614622812f47-482e562d225mr4937835b6e.17.1778927873270; Sat, 16 May 2026
 03:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505173455.181358-1-devnexen@gmail.com> <afsGZOxaJFvgLKgw@ashevche-desk.local>
 <20260516112506.34bf411e@jic23-huawei>
In-Reply-To: <20260516112506.34bf411e@jic23-huawei>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 16 May 2026 11:37:40 +0100
X-Gm-Features: AVHnY4IlwekU8noSa01RMedGARv0RgMx3pQkmr3KjKH-eI-DwHl2VJ4jC35ZUTY
Message-ID: <CA+XhMqwSz-PPVBhZx4ubVdr1oJxbib7EY_eOX_CCFiV0SNLy7A@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

sorry those messages had been buried among others, I just missed them,
apologies for the slow reply.

On Sat, 16 May 2026 at 11:25, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 6 May 2026 12:14:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Tue, May 05, 2026 at 06:34:55PM +0100, David Carlier wrote:
> > > bmp580_trigger_handler() builds an on-stack scan buffer containing
> > > two __le32 fields and an aligned_s64 timestamp, and pushes it to
> > > userspace via iio_push_to_buffers_with_ts(). However, only the low
> > > 3 bytes of each __le32 field are populated by the device data:
> > >
> > >     memcpy(&buffer.comp_press, &data->buf[3], 3);
> > >     memcpy(&buffer.comp_temp,  &data->buf[0], 3);
> > >
> > > The high byte of each field is left uninitialised on the stack.
> > > The bmp580 channels declare storagebits = 32, so the IIO core
> > > transports all four bytes per sample to userspace as part of the
> > > scan element, leaking two bytes of kernel stack per scan.
> > >
> > > Zero-initialise the buffer before populating it, mirroring the fix
> > > applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
> > > bmp280: zero-init buffer").
> >
> > Same Q, is any part of the above, including the initial report/analysis
> > AI assisted? If so, you have to mentioned this in the respective
> > Reported-by:/Closes:/et cetera tags.
>
> David, these questions are outstanding if you have time to look at them.
> I might be ok adding tags.
>
> Rather than risk losing the fix I've applied it with the tweak
> as Andy suggests below.
>
> Thanks,
>
> Jonathan
>
> >
> > ...
> >
> > >     } buffer;
> >
> >       } buffer = { };
> >
> > will suffice.
> >
> > >     int ret;
> > >
> > > +   memset(&buffer, 0, sizeof(buffer));
> >
>


To answer Andy's question: yes, the bug was found during an
  AI-assisted audit of IIO trigger-handler scan buffers (Claude,
  Anthropic). The tool flagged the partial 3-byte memcpy into a
  32-bit storagebits scan element; I confirmed the leak by reading
  the surrounding code (storagebits/realbits in the channel spec
  and the iio_push_to_buffers_with_ts() path) and by checking the
  prior fix 018f50909e66 ("iio: bmp280: zero-init buffer") that
  addresses the analogous bme280 case. I have not exercised the
  bmp580 path on hardware.

  I'm happy with whatever tag form you prefer. A note in the
  changelog along the lines of:

    Reported-by: Claude 4.6 at the time I believe

  or simply a sentence in the commit body stating the analysis was
  AI-assisted, would both be fine by me.

  Thanks,
  David
