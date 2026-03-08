Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE83368AD
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011915; cv=pass; b=lS5LZ+fbstnGBtssQZ72yfer3T36AfrUcFgdmCj/PAHktnSqB4Mo/dIJdrBUPuyKC+qWTTkcmW/vZa1lMjyEEZlXRajgsKsclTEgeE5IFdXZv6BAlFBzUGvuIckPK/5asfbcp9+84NoKo9UPq5OitbjQbfCl3Hu0ZomBFXndlrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011915; c=relaxed/simple;
	bh=5Z2KSyJ/QFZ0lsOHEdjn3KSNPTbNcENaH8pqymvmgRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtZN+HaG5vXNOyGWBeE+U//pXAAB4AxjdXOIWrsWCj7NqkjfJ5GaHnq3YopRGgxgF3K+x6p6mqVzT8U5L8ueDQg5CxqEcp42ZTkyX+XHWXATE2c4iIxInTSq6eF9uwJqgHjILq72E5n0ssDaY8ne3phSWiNS6XpYwkchfu8ZmF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQFk9DfJ; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQFk9DfJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d73e0e0a36so360739a34.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 16:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773011913; cv=none;
        d=google.com; s=arc-20240605;
        b=c3VYERP5sA+Tcd0+heWGBJZZuIknw3F8WNvm8R06PFoipQzLOYRrouaOIC3+EbtIBP
         Z4J1wBQ6ENpieXMreuNgV3gCfGxmanCCh8zMzIuldybjz5dnkceBxr6HXHyV9miikmuU
         q6klEiGR/NlkuvelCiAjo2YMTZC6lpyhvkKEpvkuiHhMof3WIaWh0BhrwQIiiAw58lKA
         WeQ4HhfJUXSRVmEs7KV8jqzBE950wruM3GRcQWl+S25B4z5GO6ZA2jMCOkOIFKF98zMh
         b8IBYQDvQSk9v8yT59dYzhLudBjCcrl1cttPmKcHa/wlFKr5yQXKfNXgsIle9mSOzOlw
         UzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BnhkC9qbst9MqLCbQ6WeJOM+fVp/M+vMnJljWxRqQaw=;
        fh=xfJK0cRVg0rORfAyFjAUbMz9T8S+v21GDgV7QN76kyE=;
        b=kvNQXjcaz00JBtPn1GD6AsIsSEIalE608MKhw2J5Q2nV+55n7+JAGQDU4YZytEkbRQ
         BSVkyprusewjVwTtPb9vZ+fm/pufwMinjzMBvpTxTPLDUDh1Bm982ahxzfXlZXjb8tc/
         QcAa18bhC/qVGazL/bcFxtZTSsLwMo3wdwQlqcO5tiDmkaqvJQq2wskjAM4YHb3tm3Lc
         48H5perGEBkX00/UCako62opJHuVPITiWdh9ZfhKACuF+QiF74kuWuhc+JXJnYVP9Nmc
         2qXI3drYK+swEqmJymj4s5aBSaZTEfp3sy7+eR5xv3JgXmCnHj9h+z5dsXzhPqC8vIYp
         XWMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773011913; x=1773616713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnhkC9qbst9MqLCbQ6WeJOM+fVp/M+vMnJljWxRqQaw=;
        b=FQFk9DfJzZbfD+5X4LQa/Xmwr7TuGg2mVl/gvFQO2kSL3LCAZxUzjAmsQG7GZbKvxK
         G0XTbwGFpfA/ocZoJdJR/g5sC65FrXSmyPkYisx5ZLx+ht/SSajjC3ZWEAMWOJcaKgtT
         kB6AbCgsVt3f9eLYtt0OAQR3FRk4M5HcG5a56JwsSZQ2iz4VD5M3vbeFRuzLXs0XY2/d
         TAjzjfhXOu6rWWSjlby0jiwcJQ+xTacWaJZK/O9Rz38/1fQs6x4eS5NZoVVgsw8dSwJz
         pUHj80Hmxcur21JALieExQhdK1A41NamwXw+v6101+2HPQb67MXdSxvEl8X3bv777r4l
         ALfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773011913; x=1773616713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BnhkC9qbst9MqLCbQ6WeJOM+fVp/M+vMnJljWxRqQaw=;
        b=r2Cais4jgAPqCx8mZYxseE4EYqjkCgSHO99kwjvkmDf20WCPzjktYkQ/0Z8GBRi1oM
         s2eFOnaKhzNT0ZukMuWOZOqWavKJlnMlViYjBWF5oRPXBnzuUqxiQyQWbYCgmFuxl3O4
         ATm+ZrtW0dAg4F2etUntmn9mT8S4vw5/mtTUBXAGEfTmjdcnePDXmSoZm6YszPqYAekN
         iEd7VMPFKl3T3ke1M9uDU0EAqFMi6p3LaCSFVLl+ADiP2oJ1ckPx1mIJg4E3NiOjMSe+
         PYvaChhMt21evPgD6x2nGT74vXqJ5tDgGUM3BKeCNvsQwQwU/UFDlyXD4l3I2uj531AH
         7qSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwhxkPQlhePXY2gWDQoNh85iKypUU5a705tOANqTIVWVhxUQu5DkjMATCgq1FjcDsOYyg4Vw4bzGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfJrLU+HsYidTPIuBwHV6258mLZZBm32C0YuebHTbAfIJxfVk
	fnMIfjNK2vgjls4TRmiFePygDkRq0aHWhwd/c201x/pA9Y8ZP6uriohw8JaQHMwrZKpvmWAshw7
	3pcS6XNBApc9M6TE32lnYdod1+IKT51w=
X-Gm-Gg: ATEYQzwrMpZPaRwcHLxF+zBwrfpgI1zESDF/Uzcbofj+3hnwoUqdfD3ELbHpAI83nFc
	hl0gXsBjUkBnpjByxrGC0IFg7jSQ2pFyrV25zUU9bXoHa+IQ69s2lWovTJ/l56b4PG9k05Ln0Nx
	533Yhy2x1U7nuHTvzkxpWE8e2KIAQpAA5D5C/f6+gzer5ePO3c94eOHxplt/wPYa6yy9sE9p7/c
	lwYLGFzOv3gyjUTeBiqe8li9xtPtY3ovWzs6hCfp0cjowb27q/rkjcH8M+dNF8Xy8JzYBnGjeEU
	EN76d61nZXpv3LjNxAyrEGTTnRp1Oen0gTJraLcoDg==
X-Received: by 2002:a05:6808:1790:b0:44f:ff2c:f65 with SMTP id
 5614622812f47-466dcb0d34dmr5206797b6e.38.1773011912676; Sun, 08 Mar 2026
 16:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305210347.120446-1-rougueprince47@gmail.com> <20260308183135.1de38062@jic23-huawei>
In-Reply-To: <20260308183135.1de38062@jic23-huawei>
From: Bhargav Joshi <rougueprince47@gmail.com>
Date: Mon, 9 Mar 2026 04:49:01 +0530
X-Gm-Features: AaiRm5334ij4aXgd_dki-Lzt6To8PVZT7xd1ejy0lE_PZ1R0F7_UCokGiCzNeeM
Message-ID: <CAPC4XCQC_JqdFXf5_OYBPk-KOcg_xDBo0N-s0uQie-t7wZHoFg@mail.gmail.com>
Subject: Re: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove dds.h dependency
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	tomasborquez13@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Mon, Mar 9, 2026 at 12:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri,  6 Mar 2026 02:33:47 +0530
> Bhargav Joshi <rougueprince47@gmail.com> wrote:
>
> > The AD9832 driver currently relies on legacy custom IIO macros defined
> > in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
> > and, more importantly, exposes a non-standard sysfs ABI (e.g.,
> > frequency0, frequency1, phase0-3) directly to user space.
> >
> > This patch removes the custom macros and migrates the driver to standar=
d
> > IIO API mechanisms:
> > - Standard attributes (frequency, phase) now use info_mask_separate.
> > - Non standard specific toggles (frequencysymbol, phasesymbol,
> >   pincontrol) have been migrated to an ext_info array.
> > - Remove dds.h header dependency.
> > - Pointless frequency_scale and phase_scale attributes are dropped as
> >   suggested by Jonathan in
> >   https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-huawe=
i/
> >
> > NOTE: This patch introduces an intentional ABI changes. The non-standar=
d
> > attributes (out_altvoltage0_frequency0, etc.) have been removed. They
> > are replaced by standard attributes (out_altvoltage0_frequency and
> > out_altvoltage0_phase). Routing to correct register while writing is
> > handled by checking currently active frequencysymbol or phasesymbol.
>
> Ah I think maybe the discussions around this bit got confused as this was
> not the direction I was expecting it to go in.
>
> This doesn't align with the existing cases of how we do symbol selection
> devices.
>
> Often the last thing we want to do is change the active symbol before we'=
ve set
> the value. We could have done a multiplexing write function but if
> we had it would need to be separate from the controls on which symbol is
> in use.
>
I initially thought multiplexing would help perfectly standardize the
frequency and
phase attributes, but you are right. Multiplexing would break
hardware's modulation
leading to unwanted glitches.

While we can still use a single standard attribute by introducing
separate freq_write_target
(and phase_write_target) selector, but that will overcomplicate it for the =
user.

So, for v2, I should drop the multiplexing approach and keep
frequency0/1 and phase0-3
separated using the ext_info array.

> There are a few examples of existing ABI for this in tree.
> e.g.
> dac/ad8460.c which has 16 different rawX outputs and a symbol to pick bet=
ween those.
> dac/ltc2644.c which has _raw0 and _raw1 for similar purposes
> dac/ltc2688.c is similar.
>
> We've never added more 'standard' control for channels with symbol contro=
ls simply
> because there aren't that many users yet.
>
>
> >
> > Testing: This patch has been strictly compile-tested. I do not have
> > access to physical AD9832 hardware. I am submitting this as an RFC to
> > see if these changes are acceptable, and to ask if someone with physica=
l
> > hardware could test thisg and provide a Tested-by tag.
> >
Considering David's valid reply: I would not be able to get hands on
AD9832 hardware
to validate these changes. So I am not quite sure if I should continue
with v2 or not?

Thank you for the feedback!

Best regards,
Bhargav

> > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
>
