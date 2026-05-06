Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B453ED13E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093939; cv=pass; b=a8EAPVUjgzg5x/1XW176RfKv4k9WPAIb59sNdlqDRPun3SF1MsYP2keNwAYMXLP1eOeDw4p4wFpeJ5+W/AEe4K6r/mNBo9bYeqjZeZX6Hzc+pGGaaKAFYDG4TmMkgGRjQUWD3zme8AUHxImuDSfArO7z535q8XmB8QnetEiGsvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093939; c=relaxed/simple;
	bh=tE6f4XgZoH1jma4dFZSUgjhU5p+OJ7p9PgNrWT6S8Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV0Y6jlgx2nO8t6wZ5RhOy7JmEuTVU3b2yqmjqk1r76rdNIw2vtdJSullcvtyARYL0kebYYktHwaVJYmGz3kjT1NwfVl/q/zzqqOppaV6ZJgoHJ9bvwCnSzV5wScyM9i+YDJnOxnwlTkrE0tEJJfpMz+pAQfOWNfT4KXE+9IVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVCYAHqz; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVCYAHqz"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c37eafcbeso5345416d50.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778093937; cv=none;
        d=google.com; s=arc-20240605;
        b=ffDXIbBF+V838OoCtjCVmf+zFfp3YiBSgmKskU4/S7c/9N+9p2oedJYye4vjIhNFrN
         y0WNpcYkIuTwwbXFwWBX3r+s1pd+xwzdLHVu7zUVc4gjaNsZUu0nDSBrYrKvHANBD39r
         +IAeydQ6HPnf7F/Fla9xxPnsYuy6B+XK8gZXI8Mu09vxrhVMo2Lfzzw092y4Z43OlOr8
         fHe8k2PWF5sEBbOSKIIai3QaPa1jPwselluvVlZPFAYS8H5/kGYQYitmRvT2KtbRq2Xf
         CHejqh3FJpitx+znhyQlIZnuFMwBDS42SEw8bCGS4iFY6xaYmFSr3+6b9+sgg/Kcc3Sa
         fTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3cL3Bl124BHSUweOHlg4fNcUr07rVDZKfNAxfhMj9yw=;
        fh=/FHThuHBUiwL6ZxxBGAanbKUOTmI2315GPoQmuzGgqc=;
        b=UJg8ZL/kBj5dluZlNeYK2ahDfpXKKTSiRrIk4OoVCUXsBP9fAlIFm2Bzsp6k6S5i07
         t9s7Lbm/2aAOUtaBl4Rop6++3nsm6NbKWZ6jnFBDIRKPkMNHF9FsBv8fbDEYIEMk2xZG
         TwsPORKYZMYPIkuT9VTyERKD337USNehuRpZKvDcw5tODne4imRdwUr1xl2rZGZKON2G
         0UbUK73Mrtte2ZlZBMAuCVtMQTFOIZl5mJT7wm1+O+8+Qf4qesB6Zs6nK59wlPgZJMla
         RNdmfmJER1wFfYUM6SjIS/mD+SuNJnr50N674FgYNrBUa0FPH422/xqkvxamZxm9Akoh
         paVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778093937; x=1778698737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cL3Bl124BHSUweOHlg4fNcUr07rVDZKfNAxfhMj9yw=;
        b=NVCYAHqzQAyaL39fkPmv+gKTDcJKpE3RAMw4Tqd9yAwp5km+yM9rqLrhCVXGn6NW3H
         g2F0JNsWZsbBgGL0lzh+48Tpl06vXgY21zrxq9xYparU6gbLlq6hM5TMasKvoLaahX0z
         tGTO/BztS4btienrRs/OsoerkAV1m6/a9943nzFj5OZZHTcqnQiDlfMqV+ZIHAZegVOp
         wGR8h29ITvTplbkoktrH2aXGt2Wc5Bejq4U52k86tF6/TywRMYaZJn4nhaxqIMh6Fxm0
         qu89mGdQTDrqOlkaXxGItzm/V+sdXz0yF9oQf9LIXzQCllUd6UriPaxZ60w+9nGDV6YC
         ZFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093937; x=1778698737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cL3Bl124BHSUweOHlg4fNcUr07rVDZKfNAxfhMj9yw=;
        b=FAt6zY9zxhJInXWe/2ovXKMe7xr4PZiSlbvNfJoitIlWFu/edpakfQv5TudZ0GIUJZ
         qaE210nv9siXABau0mILvRxsRbzmvZUF8m2DZwkINSlSIrH2KYoEfdL/1DUC8hSEevR7
         Zd/2Yo0VUFk1HCjM7LSOsHJgQMWdWyPgtb1NIqGfh32LMBRDGpgjaV706/Ozfs3mAMOJ
         f19vHXU9nWikVtvUPQFZZyRPAuvvBv56vSwV+2Q/rEirMSb1eHf3i67XrDHjy0RNJSPv
         DSV+NMtZQbS42NRgZel/bXl/e7YVspGx6JMnBoy8iFmkI2tZJRPqDBxXR7BLGnRnPmtP
         uUyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+J9q79oOCIbJ5DPszz0IjR0T/4R34ybXKlVl5hkLhMRyMC75xc05xwZ6b+W7sIom29JQNlUDet9m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFG8hZFoxePCdlmT3+rzfCHV+8DoHVa+p0m/0QGruSC1ovoy4
	hBTstKyUWKJ7Ogh+RcFIN9R/Ac6hy6z8YI1jhGZn+hYJp1JKcSNEkBwno4ifIxqVebfqWDqEO9M
	4tBvf6L+PR/R/cY/zHJNteTDAicvk+nrQrmdj
X-Gm-Gg: AeBDieswBD99l4AmmFM7H1kgAI1gE+/cKkapzQ0LANM5QeMf+wMXiOG9UE453RIFiXs
	zkdSVDMPGlKFkUd61ZsYDh0E2LS5jexJ92xx71WE5+Ttv8q/cyi7mKB6wstnwFOhu0eGUAOcBNP
	lPn5VfPxU8x8sQQu80Ym1/U4W8m2m6t5XI8o0z2OBgEcgcnzA/OPO2dWYW1UJEcGQ3x91ViddbE
	VVhh7+E6tPVoeygLo+pfLh88E372Kxmnv5lkrtkQnwNLXEoDN+G3191zxGsGiOVd2JqMufeIZ9v
	kK4Kpjx2ESgsgGSGvpgI
X-Received: by 2002:a05:690e:5d1:b0:656:fc53:12df with SMTP id
 956f58d0204a3-65c79a1f5e7mr3943219d50.56.1778093936937; Wed, 06 May 2026
 11:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506182931.494-1-sozdayvek@gmail.com>
In-Reply-To: <20260506182931.494-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 13:58:46 -0500
X-Gm-Features: AVHnY4I99r-P7VOCGqHZLb16-r-qhPqnLgMg5WUJaOLeWHlMoc17iMk7Xq1B9P4
Message-ID: <CAKqfh0EZ_Tku4DK1F-J_UNTDzgmKshbOQS889Dpf8sbChm-LrA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: scd30: orphan the driver
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:30=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.com=
> wrote:
>
> The maintainer email tomasz.duszynski@octakon.com bounces with
> "The email account that you tried to reach does not exist", and
> the author has had no commits in the kernel tree for years. The
> driver is in practice maintained on an ad-hoc basis by the IIO
> subsystem maintainers and contributors who happen to send patches
> against it.
>
> Drop the stale M: line and mark the entry as Orphan so that future
> patch submitters and get_maintainer.pl no longer try to deliver
> mail to a dead address.
>
> The F: entries are kept so MAINTAINERS still describes the file
> set covered by the IIO subsystem (linux-iio@vger.kernel.org).
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
[snip]
>

Hi Stepan, Jonathan,

I saw this was getting orphaned, and I was wondering if I could step
up as maintainer. I think it would be an interesting challenge but I
think I could do it, I've been doing a whole lot of stuff across iio.
I don't have the hardware but I'd be happy to step up to keep this
driver up-to-date.

best regards,
max
