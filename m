Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737127B50F
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227479; cv=pass; b=Ea7fTG2ths4Zb+cixTL6N3HgGRT6gwISGvfq/ecuRTUvYTOpXLzR8j92bnF4jJtXSNhDz5d8E8wwM4goxRCIEXZ+ILGUIoKdq5zMrF7ZHwcLmrRGkdT6kRfWN2YwwyzP0CHHAWOS9jw4YPuATuEXlIuiExQz4dp7O5VeBuIQx98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227479; c=relaxed/simple;
	bh=+L3OLuSoqvDNKM39a0snTfjnzPqSc00qTFoLuDjWE2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOIRZX4xLQrv+qwqMYHvlaGII3XC+OHSBcADiB8ecjwL60TmuH4yUMaf3vlgt7R+Vvr1v5pERbwfVnHfXn9X/osGFDImAD7WslZUS4nlhJSNpoZXcoX9gUJhvXJUvS6MVOLL9fk+lrdl2sZ9iDho+t7wg5ywIpE7witGrQN7zlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6f4WDmw; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6f4WDmw"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6587cee8b57so5077043d50.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 14:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779227477; cv=none;
        d=google.com; s=arc-20240605;
        b=EGZZWXhFnXKRT0Wp8pJuD9/7FXIfYrg1TxUWPct7B20TuZaXyLAcwtCSWLtT2ZA9tG
         GOUhVNAzzT0AqLtam96yz6VYuJuoSFYgclApp8WZDcJjsssTk8v9XRbmr6K4WpWa3Ixb
         WLWTrh8Xc26nl3Ym2x8CUKo/7mZEnx+YJb11TM0FXJ0zAr1um+lxVCPgNes5ku0HQaLO
         9E0TSa/deARWM1XrRlubJH1SN90DlJHoCmaOvS+e5NvJnlGgFiKiVgO8luQXJrQZJ9Ei
         S8IgSMv8YJQL+Sfr5045wugz1AKVHGnPuWVABPOTtwd6xsrJpbZUMuSQLGsNdZW0x80O
         62Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+L3OLuSoqvDNKM39a0snTfjnzPqSc00qTFoLuDjWE2w=;
        fh=FSUgPFrSLhlumj9P6n6sQnmfD5IBo9ey/F/mVbPcUjE=;
        b=N3cwW1zDtMU7BdR8yUdgQJ7sKEFwz+OXEbGyZ3Set9PwRTE0gqTzSYCrG9sjv6ksZo
         xiVETZGKZRkggxXcrLdsq7XaLjQGcF8+vB0PrvWl1qUaVk8+gA3GlUYADHTH/v9DUpZV
         D8uST8MmXu92mbToelFsattXy6MyuEeGsPnaDByvFRSDbw1vgzFvEwUiAKyIsQqzjJWj
         aFfR20s8lkUTavBBk6ir6sMmgld0xWJ05/jO//mx8ZquLIpD7IIVv5GOVNPB00d0RSZ7
         +JGifgJuV9b9GbQEVoiqHd0hQnh25ZYh1C8lwHa9rYW8qkYA03kQWV/sFt+l0ZdB169g
         bcbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779227477; x=1779832277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L3OLuSoqvDNKM39a0snTfjnzPqSc00qTFoLuDjWE2w=;
        b=O6f4WDmwmiOGrWi2CT2NSNt5xqEYkFqYD2OG6XxZG9E1zNQrEDuium6WwmI/i637OE
         mgeCGIghDrSiKXikP/kTdwKkTIgXWtOauTatI5lSwyjBQtsrtStYYwOsWSNqWfzKE5Ew
         qgY09xWLV956S7HcOYWFavMcwmpHjQCgY8D50JDnBqrikN/4mIyIhmOO/+xEigrbDyY9
         lQ0qeFs2WUq+uhshzslt8uknUBhv+uy0pBt7ja3v3o9yNOt2Hrs5NoaZzKVeC9uaYMPq
         NDdlJdMcC9j4PApgHBzMDJNlogVbykLc/vtomLvIHS4NG/hnnuoOevR6jZk2lFFXet2P
         WQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227477; x=1779832277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+L3OLuSoqvDNKM39a0snTfjnzPqSc00qTFoLuDjWE2w=;
        b=LjXCBhmjbfqRfFZ0L26WQg8FiH+8lmo3/q/ycD0Mpculvgh0iN2oOCpm2poHLViRwJ
         3YZzHa7A4uE1KvDb0UGjai4rf1HAP6wqJWYzXIeqOe04k2O0XZ/bRzKa1xnbZZv6W4EV
         3I4klEr92+GmQ6zYT8LJn7yG0hhphorIgPPyIG0C3Px4k2KuXuh0pR1wvI4xM2P09U+T
         Xg4QZ018x8MQXoE6V54LYQsK+w6HZs4x4/KJGkBTq13GX0Q8YCfzpEQ/tFWC4VAtrijs
         1mM/2h//FKkfMw5k6XtpYxwr0BPVHeLbZahBYuTKVRCZhvV2sJkq6iNiHlhJ3j8ouIE5
         Bvkw==
X-Forwarded-Encrypted: i=1; AFNElJ+BE8cvvZ5pFQb/Tokr4q6l0haElw36jO4XtKF4S8aYZKNoHwuZiBb6EgIeZ+DkgjIfxKvqX78oySg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ucdOqr3cJGhzCa2uc7QVWDysIRmRJHMBwSi3UoBQe3wiZ9X3
	pZ6jWsdGzp7Y9Uxz0qwoC3g3STJqcU95MCRA89wT7Oq19vZvWyrDR+LxzoGpR5e3pyP36fG2Qa8
	4Ejvaaz7iXJa/LKGmNdDhesaz+cuGUew=
X-Gm-Gg: Acq92OFJfVcSrSmiWtTAmJ+lr8Dgj7G6f/NrmO1/I5vi4/E8BbeFF9k/P/uqXI1YHsH
	fPfUSdrS13cPqB4zkkGPuNLn3Ev/n1OYQ7572ONSie/Cs8gTRX3CG11DeE0BlH/b60HjtCIIz9F
	GoxBQKoYVT2xNZB2Aw0odnYChrBzwyld7NaqVv79zXrwE4Qq5rwHTORQelHlSrQT3pOyrNGtdRS
	c+tqSwwAEOvMHRD3A4k+rkhAaTqlui9wJhshjz235kiygGDh1BICWWhDRYVdavfdN6oa+Os7aET
	c/Qg
X-Received: by 2002:a05:690e:419b:b0:650:7841:6dd with SMTP id
 956f58d0204a3-65e2284edfemr18955768d50.31.1779227476894; Tue, 19 May 2026
 14:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519131944.25174-1-m32285159@gmail.com> <CALoEA-ztSaPV_m0oj_aY5M+BKTFyzO6dh3R4fu_iOnfKz8oQiA@mail.gmail.com>
In-Reply-To: <CALoEA-ztSaPV_m0oj_aY5M+BKTFyzO6dh3R4fu_iOnfKz8oQiA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 19 May 2026 16:51:06 -0500
X-Gm-Features: AVHnY4Kif4zNqKRXU6N0asIX-crn0eYZ5jnqNnGYJ5SjoSegv0jI7YR3kW2KOTA
Message-ID: <CAKqfh0E6uhVHEbnD+Jwr8kgmk+_YLxWVXeEoWPE6Au2gqQ85Qw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with RAII locking
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:41=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> On Tue, 19 May 2026 at 15:28, Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability.
> >
> > Add new helper function scd30_trigger_handler_helper_locked() containin=
g
> > the critical section for scd30_trigger_handler().
> >
> > In addition, small refactor to replace "?:" operator with regular
> > if/else returns.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
>
> LGTM, Sashiko also seems to be alright with it.
>
> On another note - this driver sure needs cleaning up.
>

Agreed. I've stated previously that it may be a good idea to get some
newer kernel devs in here since there's a lot of things worth patching
in here (when I say newer kernel devs, I don't mean the absolute
beginners. should've at least submitted a patch in staging).

best regards,
max
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> --
> Kind regards
>
> CJD
