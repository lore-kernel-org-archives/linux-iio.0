Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0B35E1D3
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917446; cv=pass; b=tkQPFwjDi8wRl2B5uLE5XscAd8xwEXxJ1jhQ0YANbEV76Ix3CtOsnzpN6XpWBT/e3vpKX+cGjV0+k/SX5E7JNA38yVPApapAfN3UEl3AFDqlQPLQJFSmlW4YJGHv3eJ8RVS3YrLcpC1p9V2v8C+FY+hZroS3xtoHNQSUkRimYKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917446; c=relaxed/simple;
	bh=v/TOy+mVoCUrT1MScoKexZjtpf45Om3+UrUr+OCgZnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOIIryyqrOENij8XsOruyRn4iDjMTsGc/S/HKX1fROad2saTR+kL833plFM6LPEsUsMP3iZVvzWrw9Tzu1pakJtyS6qmAl+cH6J6g06KZlr0JD6dUyUxb41ELnNztgfNmwAHW6TjPMyhUGFbgldCOGYFF/2wxtqSldlpRHCfS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GrPlpV7z; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GrPlpV7z"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e97e73234so11351141fa.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917442; cv=none;
        d=google.com; s=arc-20240605;
        b=Lpc2ueGOuYz4ZxZwXlKTBcWhmpqo+t+RiFY/g+r+RWaTuv/v9s6NQhMf66qhXhDH0A
         1Twfdyj6lW6Kp/dK7yOswtuwrlOIwJh6KV/ksLv4nkQwCMcqqhyvSpla/z3L187FP9U4
         8+FT9r9E7R7XpH8jAk/7zUHN5ATnZiTE4qX/hXDeyMqm97H5UYCPTg7NCNiF0uUOzLSK
         tFM470QO8HJvSV2mWED5VGDoKCK48ixrVwm4qeWLgD/lejCGTCqYpzPcgkgCBD8nO4XG
         EHCXx0NPLZrEptQ3Txzq0H/IwkqfhFVu4wDkRhVvyCNu8kd+Dpk5tXQsTnc2Y2AIvv0Z
         O6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WL7k9voA8YUxV+I+bhTZKowfPVkgy793ox0R2aAzkCo=;
        fh=dU/D8Yiw3zc+Ki8A+AMUKsMhamIMSRxL1ON6SMuMEAE=;
        b=jzpgd0hXewFL0tuHZGNoQYFpMxOjfoTyeDEtawLATtjjraSOF3WePchedraHnWRfU8
         xqSa77ot4/l2O7FUUysyexKyhHJpSkVhW63ZRtOiku/UY2tPYxndo2ePAB82PfPIh0hp
         47xGR9cPAY/vGYUfgB7FrOdAkZdr3vhKROgse/5xGdU2PyQBTgf2HV7rStsCKYD2QeVO
         063nmKi8ji9Pg7a4WkdTA4p0u45nhMBpGT9mLqdGHJAkwmW89pmIETbKODK1b8rFAUPP
         7Ct9KBG2kNJKmrubfEy5cpVC4cCDR7GjQx72BiJRhiVNeBWCM8Dku1eYgkEnDsQuerFy
         eCvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779917442; x=1780522242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL7k9voA8YUxV+I+bhTZKowfPVkgy793ox0R2aAzkCo=;
        b=GrPlpV7zGWy0PeNZgOqDq8LWV5py2nlAXyCg88QmEei4dm1AJG2ksXxRHG5RNATBTT
         L04oWI8tlpKP9LJPRJgbYSYHfjGJzaiEd872CZFgkXZjq694dwAyhwpNqGiOJJLE+eEd
         gKHWYhw/cNTWMCVc6uTcPICrAaPp8/L1+Z0+ylZ3zZxMjlMpNyVIHX/IRNprM9fPN6JF
         abPtljMDd3tPWnZar/eMcDkUL8hSwE2Xngh4jopuC+dgY+CDuJA+i6swXET7tNG2sqJT
         spiu0oAz48U26DYSdQC/KiwWSxbPZegQKrqpVU/FN+A3x8MsM5ATJ9yZ/QF86z1rnDUL
         Zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917442; x=1780522242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WL7k9voA8YUxV+I+bhTZKowfPVkgy793ox0R2aAzkCo=;
        b=CFC8tB/yrSOGm7lpy9qgkRw40/TJUHXkxtRuzcr0JtzGF6AKmBD5DrK74nHn8gFKzH
         XeFCR8EbOfKG3ntbd9Ps9opvF6SMY9veS5KerI99uK5yYRdVMIVHjGIFqZkT6hLDzWR2
         vFYU4xgR+Jgh5oZdn5ymSEmxhSeeqPBZVZP8js1fg4ebyYvGQbw8q6UOamP9RfnfNPlT
         mgMljmlxneZ0VpVUxF5gB9hrF+gLS1kKHlRxvoyzfJIYLWcobiUkwXvWO7Yc2mluU32h
         VGVgI6oPdQ+wgi8QphYjrEKgHzffChlo9nmACPrNo3GuppoLhVo+tPL5FBVuhdeTkr5S
         q5SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tzYcCbEr4GQtRPHHF6IMoFxbqoIGsj8Me9PXUW+oQ/D+4MoHJtvFrEMD7sFZGW/RCZ9L+hhkZUY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkBJCJT/9AzW29bYgx72VnoNuqX8stXTRVk2fPYezPoAenoHu
	o4ajHOhdwmZNmVKN5eUjc/vnvmsSTGNLvZsvyV9Coax8x6ixgLLMyQkorbni0727wydWntYctgN
	d4sBwwpS2gSs0UGQJfm6oLYb/RB6TYAci12aUHwoUDg==
X-Gm-Gg: Acq92OHdeHJyfvCJwNMncYV69S6AIvlazB5d9qxtbSKQIoo0IRWPRIf9wqkJ1otlhQk
	IY1USeJLq78GfSFtJJNB+OEm4H55DPmyzl5zJFKyLsp96tq25fxtM2FWq8yku34jUJ9KWzOTd3x
	TJd5Las+w0XjjNpzwdq/07+JufHGPMoi2VGfK7estr6VTti5NhrFPRSkYXDgYz/of9Jy+A5j/tH
	0KQ4yJG/XeyRVbJFNA5///nWTcynp9oAn5vGVxN0KTEPYvHIFw1JgOxjTT0XCSpgsXYXmHG9CW5
	J05RPTbHQ16HUbZlrMiQqD4qErAtcbGBfs1DBtZtcu7Qb5j9
X-Received: by 2002:a05:651c:1143:b0:394:2b4:ca36 with SMTP id
 38308e7fff4ca-395d8e1aadbmr74951561fa.30.1779917442001; Wed, 27 May 2026
 14:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
 <20260527164312.355729-2-jakubszczudlo40@gmail.com> <CAKqfh0HVzRnNyn7BFW8OfVKkYt24L=X7qXeZbPTj5mGzBSSfyg@mail.gmail.com>
In-Reply-To: <CAKqfh0HVzRnNyn7BFW8OfVKkYt24L=X7qXeZbPTj5mGzBSSfyg@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 May 2026 23:30:30 +0200
X-Gm-Features: AVHnY4IYTzzfnPlhjRjrs-8lp8U_NqE1ENF6xM5Z5E9xssopM_cZyNmWzLQUnv8
Message-ID: <CAMknhBE9QdzWn35419sDyTiYviEFK3ZzWsfSOfsbFB5f42y-1g@mail.gmail.com>
Subject: Re: [PATCH 2/4] add ti,ads1110.yaml
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org, jic23@kernel.org, 
	nuno.sa@analog.com, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 9:27=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> Hi Jakub,
>
> On Wed, May 27, 2026 at 11:45=E2=80=AFAM Jakub Szczudlo
> <jakubszczudlo40@gmail.com> wrote:
> >
> > Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> > ---
> >  .../bindings/iio/adc/ti,ads1110.yaml          | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads111=
0.yaml
> >
>
> This and patches 3 and 4 don't have commit messages, can you fix them?

And the patch subject needs to have the proper prefixes. For example,
this one should be "dt-bindings: iio: acd: add ti,ads1110.yaml". And
for multi-patch series, we always like to have a cover letter. You can
read all about this in more detail at:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
and https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-p=
atches.html.

It is also more logical for for reviewers to read if you put the
dt-bindings patch first in the series. And be sure to use
get_maintainers to get all of the relevant maintainers. This is
missing devicetree maintainers an mailing list.

Also, this chip looks very similar to ti,ads1100 that we already have
in the kernel. Can we reuse/extend that dt-bindings and driver instead
of adding a new one.

>
> best regards,
> max
