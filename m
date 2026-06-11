Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA340B6E0
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187622; cv=pass; b=gb7c7FUx4jPoQsDsghvxwG+rDNTYYKnJFEg3f8agyzksIpO8aLgB1uif39iITf96lYX49A/SqWmT1bER8HxXvQfrzr1LywkcyFtGe32Za7tn/fUZQX968Ydztc55I+k3l7qvjeyLnUKPJjN4N3RhcvXqpZDzrNmb58ZA07RhFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187622; c=relaxed/simple;
	bh=ez2ospXstMfaz5xWAd9V4fEufsJqKgDo0LH3emCYfnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0wlJop3+gb+Y1l14F2Gdk3gDLpZHvgi9/GVJMwurCnK9UmxHAe5qFWjLBpzVVRkk+ptZsHlq8Vwu2uuIAqgywDh+/rLNYvqeaakm/1qcd03UwbWsP6QtkqGKb77YLCD/SRH/M498N/zubkGX0BQeNAs+28TX67zEmqrvCIs3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNpb+Cs5; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNpb+Cs5"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so99743407b3.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 07:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781187620; cv=none;
        d=google.com; s=arc-20240605;
        b=dR45zJGWrVwaDJPuW5n5LbUWUEPcJuINLQOMd/A9SEGmax+zomp5eE//32qLMcxwmx
         joK5dS04ytsBpZfvIA5PCl4vDpPhTZ9wcGgr+fBsIROR2bnMRDXn5sNgjinvkjgicPCv
         0clqagFYIYhj4CfIBPE8KQnlDph2vQA9hndmmS+Ufo/BA/1aWExOgFvR+pw7sDgcRI+e
         WaDjVmTUTKxSYtPEq8F4t5mVgmfVTzbWFzRVQeDWRb9nsg3q+RXuo7Mlb6mAHHSYJe3S
         GDU3CD9PdjoV0PmCCOqOAOn/tLR0qI6KsaGYsW6YP8sCHDls/Lhww0Vt/1TzRi8Q9v6B
         QKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ez2ospXstMfaz5xWAd9V4fEufsJqKgDo0LH3emCYfnA=;
        fh=O2Gh/s1OHvkswmlgOGp3KnVW/IJOJMOHJsP/oYjt/VQ=;
        b=bVJuPKwaKDhcvNibNvJvPH+AgeY9tKXVtKlMuuqGSJ/1SDIU44D1VpMDB6mPwuVAj+
         jH3QJlc8v5COct6Xep6WUEAY1Le1tia75e/kxedMGqBRfsj3hcf4k18ywmKc7aNhTBhK
         83i4vgetlN7LDG/tyizEiHKBSUO9irP7ux58u6o1zo49hwd96yayruLC1XKXq0TOU8CW
         f05U9ZMjPJmFHuPLsmcxyjDKbFs5nd+hCWmnDeX7nRcsxXPPwJousHVwvSwOXThxUUrH
         Tq1xQ3eWr+C5/z2lWCYVCqL4ZyVmYUeJ1+QFFsK1ZdDopLtm6FspEG4G2jffOd7hf1kN
         nMAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187620; x=1781792420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez2ospXstMfaz5xWAd9V4fEufsJqKgDo0LH3emCYfnA=;
        b=kNpb+Cs5tKm094cVt0t8jS8RakndkpFAwyhM5iemGCcV6Is9XNdU31950Mu8Abmn6T
         FhAcUauP407w2XbTbOYeabZlFpwtpGjPtzICJIQQwnvaXMMsR3at6vXQ4Om77tYudxB/
         5Qi2PJ2oNEbz0vTNIWeVnDe+Hm6VO0b5Qzugc+xTckEcYIsMi+LHH4DZCxNSUdYu3XSt
         YJ8fafmXc5Gfc/WGz2hEj1/G+m8Rt9YJ/v/3HcY7S7qO40d6glZCC9sUERrlSPdpuZ+J
         wJMIZbTObjikG6+GMvAeHc7e5dnAmAX4cmOn41OJpFnjNhKcYrev0WjlkWZaNgOr2JWY
         5vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187620; x=1781792420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ez2ospXstMfaz5xWAd9V4fEufsJqKgDo0LH3emCYfnA=;
        b=jWhLIhEQUsvp5Dv++/tiezgG+X/idf5fC52ZzaWvWIFSwJwMhkwGRV0yduz+fCfoKC
         hbtxwUxxeSmovJWI1ffDn0lERnZSyZ99n/zoGi4yyLoX2hH1Oiq30a6DmnMhnUhFdTjT
         zuhMDpNouOYRWYvDrLuDuzijIosCGMhTgCuI2OiLv7A83apEF9b0usiHr9oJosEdfZz2
         okJnebSCo5SgXvMcgFtiaiGX41SHeEXYbq3XpnGoijFNFC9mkEFXKh2D3OxAjCpwL86S
         jX07QPcfpDVIMb6CUZ1TvnAsiWGd9LuST8QiYHyWVsJ54u03OgYR3pVC7bsAS+h9l5n7
         HzOw==
X-Forwarded-Encrypted: i=1; AFNElJ96AK7e3AXDcG4Nr5o+xXRxGWf+iOwKpNXfiM+Lz5F+DLKmsm3ipzZ/sQtkjaXr/W1RsEhB0EEwqaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDw0I5Kat99RIiC3pBXISRlRNx0h1div4veNVMQsBlFA8BYYf1
	vfLt/LNH/Oo9TXMnfZAXNR/hX0TyWVRjMWSJ8ilJvFoODW7KH3DfxOyGH44ej40pNI+OfEpjb6h
	rsdfTIi+1awGe96R8LCECm2Jv+oYeA/c=
X-Gm-Gg: Acq92OEF+rhLLYrSSNOGbs7/J8KOdTcm+6RoRYoWKqc1U+7DwSBRuLCaPzKstiGH1UO
	2S8j1Ma0C/w9yW8yfOi2CgKwm0LfeKBn2QDL/0xuH6qa8xhi4sv8GvXf7EE0iLEje198COOVsPM
	3cskLe0YRPf80EwOVnN+PjfhNBdDH9jAFmGJM2qOaya5tCNm3RbvrkgZvvxRuWe+Z2lC1HRtDL7
	6kzzMs8y6CyWY0xs8cmi8T9pZB5x98dA5yGxaG52x/foJXvH4ZXZt5yh1F/BjVIm6fK38pmJ6SF
	Ol4mwnfHqfMJoJRGa0HJVISEaoakUmbDWzHZ6jIcDTeJx/bPSAGW
X-Received: by 2002:a05:690c:6f12:b0:79f:d961:47bf with SMTP id
 00721157ae682-7f65500800cmr32328977b3.8.1781187620254; Thu, 11 Jun 2026
 07:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160326.45123-1-m32285159@gmail.com> <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll> <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org> <aipatjyVcltbspRJ@ashevche-desk.local>
 <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org> <aipfPwT4RJGdA4TT@ashevche-desk.local>
 <aipfxL3ttO1-7W1T@ashevche-desk.local> <CAKqfh0FQb6tSZrrTHGWcoQqPe-OwD-mW02GOOn9y+ysstRPVzA@mail.gmail.com>
 <CAObtm8zDk4s3+pmGSxRoVHq7ef1y=_cHdC8YRH6ycRNbjzaNkg@mail.gmail.com>
In-Reply-To: <CAObtm8zDk4s3+pmGSxRoVHq7ef1y=_cHdC8YRH6ycRNbjzaNkg@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 11 Jun 2026 09:20:53 -0500
X-Gm-Features: AVVi8CdA5UiV9a-9xqLq6QTEun-nOvIwOUegZFB4I_Q6rVn0HPvtIA77vYZzJoQ
Message-ID: <CAKqfh0E702ANWwXYzcCHQ3V9G2+m9RMRPQA0k+q2jLaQTZtOSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
To: =?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:41=E2=80=AFAM Tomasz Duszy=C5=84ski <tduszyns@gma=
il.com> wrote:
>
> Hi,
>
> I've been trying to catch up on the recent discussion. A few things I
> want to address:
>
> 1. My email is active and I do read patches (when CCd), but by the
> time I have a proper slot to sit down and review something, it's
> usually already gone through several rounds.
> Chiming in at that point just for the sake of it doesn't add much value i=
mo.
>
> 2. I get the impression you're thinking that since I'm not actively
> maintaining these drivers, you can step in and take ownership. I'm
> broadly fine with that, but I'd want to see more work and patches
> coming from you first. If that happens, we can revisit the ownership
> question. That said, do you actually have these sensors on hand to
> test more invasive changes? If you've already answered that just skip
> it as I'll probably stumble upon it whilst going through overdue
> mails.
>

I don't have sps30 or pms7003 but I should be able to get my hands on
them pretty easily. I did get an scd30 though to do more extensive
testing with that.

> 3. I've managed to carve out some extra time lately, so I'm happy to
> be more involved with reviews going forward if that's useful.
>
> In the meantime I'll go through the remaining emails to get better contex=
t.
>

Ok then, sorry about prematurely trying this. I'll see about doing
some more patches for sps30 though (I've taken some interest into it).

--=20
best regards,
max
