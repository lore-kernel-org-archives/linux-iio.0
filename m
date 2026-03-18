Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD137C925
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847765; cv=pass; b=hJUc4+IJksNKwLEhsq2elEsaJs0djnPe9FipBHa4v5iw0ayQ8oOxUypN/02rrq2XzSNp7xe80nVbv/nJDbOaMaYTAMeaPmsuMu0DO83+o+ME1O7NI42nwHeJtVzu75GUFi0Awwq0ZItDYQ83HQvK413gGH+1zT3VWqiqdJpN08g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847765; c=relaxed/simple;
	bh=msQtF/1wXR3cf8lmzeQnpt6FGzQZ7eRbD8BfTzqRfhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRYhFlmNwV/+IqcDvM6JVUaIVCGdbHaMthZW/0FSJ/Cb6u4A64pe4lSh1EJQUPk/MEt2S12jFeBRsTO6U3bOIwkoV9Ctd4Xijq2g5rT4y4/k7uZCt1iXxoVJPe0qO/t1yDzAaJ/XGNCjNCtY+Tq+Ca26arnKNTRf0kqz2pSNuVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIM9uUUK; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIM9uUUK"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67bb19ac35aso13690eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 08:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773847761; cv=none;
        d=google.com; s=arc-20240605;
        b=d5u/nBAl0ZFrDYeS+tl51h7fgXly1Tmx4kUeaZ8Vxsp8sIUf/6NiOYr9BHHGWKW7au
         W1HboTWI4IhiHwv697SLvdE0Szh0teE8ks25KH1SW7auRI+vmNiyhRxdVG4texDmOhxZ
         xkMr8tBnknuXwest0EU1d1IjVHUGmDwt8Z+nwzwWhdBNgXmodVR/CS1ykAhkOgPHvmuc
         mjwNrTwvinsrtyyGfoi4KLZGNmmX8sSmGiJ0mDEZoyfeQxho6zhqAfNYSAUj/Fo6QRb0
         krkke3Wi59pG+OnOJM2rhI+94f5ZmaAL0pE+HX2egkNnkaNBHqXr64unupiHxzJuIIdZ
         93WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgeZwhn1JgBIzM2IHsaL7VV4TKZMqZSl0daDQ6ZFBs8=;
        fh=mdM2U20CM6q2Q8C4SDaMDhgjNhXEH9P/fUhyO/WaZy8=;
        b=GyUFecGQON6rM8DLZ9nnivms6BwETAirfKLyzxADXEu0G9LLBLFgH76l7/hZLm281x
         +NxL6fq4rrqAzEnqHJwLzM6KxGROqGTT+gtDIhLtGzYZExBOxo6L6Zn4wJZLUKWQlnp9
         gErWLRCVnIG9iHqImziHWkqnGn1Uri4nO4Zmah7cNINzw4X1IxQMqVVlsGEJmdfhMsm/
         74E0/uzyl70s4ZZwraT7LoC3je4oTdF2UfoMv+GymK8mMcAK3wSyudoZab5ZfrfXdIZT
         WInlKZkXSkKHR5ZPVLNISTgxObuKr+bGxQ27W2koc1TVdflcN+qrLHjUQwTfY9OzGdE8
         ha9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773847761; x=1774452561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgeZwhn1JgBIzM2IHsaL7VV4TKZMqZSl0daDQ6ZFBs8=;
        b=MIM9uUUKvnSm4AiTO4Ap3o5OM8rXGgl/c8utPDLshlZy8XQgZ2qkE+GwLvwDBk57jS
         itU3y3ymie4jprnIjdy8EBHbSeEVbVirl0g5VizBdz6BgtTKVMG/gdvhjYB7MQ2Wax8r
         o+Cut4eHmmgvN2Ysiv49U0KEiG3oAIUQI5zgvUSu8z+sk2eAGAuyEhrJSqfPtTQ+yLVO
         1E4K+hTXFHhbSXDnX4q+/32NnyUgu0GLxOY4LIrqaA32MkaL7BrNGe5XQT397DfSgOf5
         hCzaIXCBbi67BG5+fldKD2cjQdUc9xbyPGaDEBHL/aIZj7YcM8YYqVVI0+b/9NoLDlT+
         lsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847761; x=1774452561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgeZwhn1JgBIzM2IHsaL7VV4TKZMqZSl0daDQ6ZFBs8=;
        b=VUxVHNfVVM59+BoZnJ/GsFrnJeMLEBZvbllzgO5nNTO/z7+ZW+O/uy5CUby+RRB3A6
         0KJRtnh3ih13CBWBSHvKXCa/YBLw+QuW3w7kEGoBirYxmstUdFhUPOR2wcoAzXOE2QNH
         oKeodwqhjNw/eLxaLbRwBVzbpzLNyaeraX7EWZ1/lhValpHhk+/7GPFb/DsyUGGIHKkQ
         NgvOOZtwYMCAF+UTVVYqxsjEn0EIYg6DLXyimiFaVNVVFAty72doL7m48iWvXr22wns2
         J+tZ7Q22ngY0SarqipwISiNwkYwmuzemNxg+JNa21+QPHAikfs2hiIZ5Xt/hQ43+QUBz
         1IsA==
X-Gm-Message-State: AOJu0Yw+tDIidpEDrBTTKgKVauJoj6cNiaWePaDFup6vvf4WTldsWZSh
	JoTN7BQJKkCOMUlaotSttl9RopJtSsMSoPLaRuhcNui691AnCXDc8usa3u1ZpNPCaVd9DOEgA0g
	CRqxSzhiwO4DAajVYkLNGcQhd6wNTIGg=
X-Gm-Gg: ATEYQzyBDNSXvfjOrzLoC7MJqhbpSxRBKZ1VTkQ+QQda3eNhAqbzZP+jbcjUyk57X4E
	TPTJ9GxODMOoIDKCq7ambRbXo9e5m+xsMwKArECJ3cDhekGf5IWU1GVFZEarsXdkwXrqs0v3UjM
	XTUmfWQp1LWEoMa4lg3WAsbLdvz+VvtgIT0XEV7T2fPjjm1Bvy4lrRF7F6o5z25ZgZJJkFNNIy6
	bnHVRfKzQ17t9f0DCTpQov3IjWhB0aJ/mxagHsa+BrpJDAuecbVtmiTs+QWC8NyMZJczOdbU+h2
	lWohMQS9cXSyyDGQTMHajyd1ZnI/XPXAJEv4Ztg8jA==
X-Received: by 2002:a05:6820:1ca2:b0:672:a49f:128e with SMTP id
 006d021491bc7-67c0da65886mr2372961eaf.8.1773847761592; Wed, 18 Mar 2026
 08:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317232552.28485-1-rougueprince47@gmail.com> <abpd4Y88DhBlr0Cj@ashevche-desk.local>
In-Reply-To: <abpd4Y88DhBlr0Cj@ashevche-desk.local>
From: Bhargav Joshi <rougueprince47@gmail.com>
Date: Wed, 18 Mar 2026 20:59:09 +0530
X-Gm-Features: AaiRm50O_wX7lX-eKS_KIgoIG86HZ4nK6Xy9ng5KQiN7f5G_u6XPnMVN4K8dVl8
Message-ID: <CAPC4XCQkOTOtEOAfnQeVajczX0cRVbWpPU3+F1hoZwiqBqAweg@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad9523: check return value of ad9523_io_update()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

On Wed, Mar 18, 2026 at 1:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Mar 18, 2026 at 04:55:52AM +0530, Bhargav Joshi wrote:
> > Several functions in ad9523 driver calls ad9523_io_update() to apply
> > register changes but fail to check its return value.
> >
> > If the function fails, driver silently ignore the error and returns
> > success. This results in user-space assuming register changes even if
> > they are failed.
> >
> > Fix this by properly catching and returning the error code from
> > ad9523_io_update() in ad9523_sync(), ad9523_write_raw(), and
> > ad9523_reg_access()
>
> Missing period at the end.
>
> ...
>
> So, now the errors that were non-fatal become fatal. Is it a problem from
> functional behaviour point of view? How did you test this?
>

Regarding errors become fatal, is true for function ad9523_sync()
because even if error occurred it clears the sync bit and calls second
io_update anyways so returning early here would make it worse, Apologies
for this oversight on my part.

However for the  ad9523_write_raw() and ad9523_reg_access()
ad9523_io_update() is the last step and Returning the error in these
cases seems strictly correct to prevent silently ignoring I/O failures
and returning false success to user-space regarding the active
configuration.

Regarding testing: I do not have access to the physical hardware, so the
patch is compile-tested only.

Would you like to send me v2 with dropping ad9523_sync() changes and
keeping the other two or just drop the whole patch?

Thanks,
Bhargav Joshi

> --
> With Best Regards,
> Andy Shevchenko
>
>
