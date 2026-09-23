Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333C46AF0D
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151244; cv=pass; b=sGIgWh1uANFFucqo3GBFR6qkWjxriP8H9vla5WUpFXPhgKpcYkgYRnLvY0KWPkz9tlhaSp6rW+K3zrPr4/0645GK3sJbK7gpSnrcFXR8lHKHFgMKu5jpxBvwPrUV2gQGVXpGjiGo+0H2MpKmCuJZxRJdgwloLU+M3Xps8e//Emw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151244; c=relaxed/simple;
	bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTV/lc8dmJHnDHsJDl6Cw85vJXCY05erKP0OAxBsgD4reVLFbVqZJdgQHIa6YbTaah2LDSsiKPEEHKRIew6ZJET+r+NRQgmMGp1KWw5q0ggUeUxTPXP8W0X67De7MoiKVC7mAJajrcJBWI9IcYs2M4Uibw/acHdXU2hmXn0XzxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kaskz8Ew; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kaskz8Ew"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-79022baa364so196213137.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 01:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151241; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQ1ovrw7eSDd2rxYJTWO1eBcr42lQlgzy9mdVoy0wvQ7cnht88spfzU3Bkq9zG4Hwc
         vJx29/xSfP8CmXbPPX1KotkdSRnSxXhp9jGA7ZGC66gfj6sTBe2jDfuGddRA+6jPSs3q
         SmEYt6VtyWo7fCaJpk46uyfUiG5lSti625qhVUjpYzxVhPvEFM5oYCYiPp1WOlYY/CFz
         pZW+9FZmEhnv6Y3fUozss5h0L4Xs+NRlVV33CNd9zQlHTuYq6giJcEx76CXrlIM7SYso
         kciHxxNVx5onuUnoiV6ppdlDDqPtiFpherWCDecNJdDOhqkCe4ysgHXbLZ8veGldOMhb
         CF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        fh=PB5ciGc4+g6R8s97h++KazPRf1dsGUH32U/3YdycTcs=;
        b=CH+RAoEkxiLunsRBvfYN8GRGQ5UXuEUw8sWsGATMlXU5z7FzyFD0FiwACs0+SyFRqD
         swfxVOh7LDzHuCCpJ5U9PP6jUjJ5AM17FwPmtJG+FpfOS5q0J2ZJqkjgEwiMZijdmCYq
         8Na6gIINXJBj5SPTZwBn+/b5zRXPAxc2l4GPqV7elxJxXeuy/6VE0jbSrsWdPjyj8YQV
         BpfNlbRcsjXidhbPyIOEe4PLvSEo8y4/5WyQFArOSe1phq3BLe/gWykrWy19/e79A0pY
         lyZq6wY5wmSXx5BTGupA+gaoohSMtSHWmZA+HarJLgRAdI7bstAJUpSnQyBbh5rvMq7D
         kXCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790151241; x=1790756041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        b=Kaskz8EwzJ+afxaDUNKLop4pDXpSKomt6wSPdJQWN8dOaRpULv/gU+hr4vucy9nnDV
         RKVKd85lNizWo0ass9d5Bdwg1QDrUyoVFMQwWLVBLHmUOc92GI0rjAP17k255PU0W7Tn
         tXmYta4wSW/WyNMHchZ7tHnMMnBrJ1qFCBS6Ut2cSIUvMEClIGXY7v4UuCavC1TrY+ab
         YK6d2T/GboE0+ZAcZcddfZUarr9dbMO3lY/SgAIzxZk8HdU1EO8NAwZqtYm236wtuoCl
         RUr5FnEKvfFhnWNkVOrCaiYAilq/A6V/6B0xI6qv5nKMwbOFMNImvdh8MJHGL5rSFDVX
         geLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151241; x=1790756041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        b=NAnq1V40z5eN2VRKJ5dI9C05BrgGYSNHYzVt+iQsPI/gtSVV6TCMlLaOASWLAlnhYI
         5pfvCO5d8NtNc2A0rBPCwLiKydLcE79SebpLtW/n5L3a4Atby1p1hejspNR76bytA8HA
         4m42wkmNqoL8Tcfq7xGR9VgC7tgqZyW2NIs4Y+wo6t6WyMIZVmO/zuOBLk3KKD+bHGu5
         MR5Y2eCIe7HPAz7TUPp0T0OxsGfQoI8uSt+Xsw5bZ+0DO279B7emHd4vWHDseaL1xuBr
         qe0OgclPnOKh83rgN4jFntW28YZnZE0h1oZP25HfHgt/b4cShJiHvVd3d6Ts3TtVeEp8
         4mhw==
X-Forwarded-Encrypted: i=1; AKwUvBynN2Kgmbgcx3QgI6NXNZJ/QmuyYYkfuekNbQyp/XeKyyPDVYagk5azfouYcG0r5HIAOsvfrvBRmfE=@vger.kernel.org
X-Gm-Message-State: AFuF++mtMtzmJuPfNPKyaeMH/EhwW7FxQfIxVxZjHlm8361SgTSFpj6c
	D4h3esRDNXVdjghCVM+0Ijae/Xk7dRbEdZGPih3enCWBeUQquq5ck5DZ513JmmK5PHNBer2/AMJ
	UX2jX9cAylj8V3zag4xkt3yaHchehUlju9RtSXtM=
X-Gm-Gg: AYBFou1ah4y5g4nzcOJylj/Z9aguUwdNHPzMzJGMP2ApRH19VxI5ruiibT3lZkV/C4T
	BhfcSLLgdlKOBltc3MzU5djdHiTvGRsVL9tGhoLa9I1UPP5kpcMgV4XM9gtC8Mwf3LAU+5rHUqY
	MclP3/nIGCZa5iNZeE3CFcZ1lBrc1oM1DzeAKarXLS/LAiaFXiSq03tht9kFutcKiAhCGehdhSd
	0B7fLO5rsRFWPGOIL6ztZmUQX8mk1h8Qk0k0kHkn9TYahCiFnE30F2FuuHNiaG1Vyp3mkWpGWvD
	LJT2jg4WNHkCfxTAJTWwQmEOxoswSGMpuiwwS7mOvpWh7W+TOtZsTv6BWt3gViStBOhSIul047J
	FR2vBwphV21ZHx9mvWaIJ
X-Received: by 2002:a05:6102:4414:b0:7a1:f2b4:dae0 with SMTP id
 ada2fe7eead31-7ac0d12c7b6mr1858808137.13.1790151240916; Wed, 23 Sep 2026
 01:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923041630.2553973-1-morbo@google.com> <202609230023.C2053303C8@keescook>
In-Reply-To: <202609230023.C2053303C8@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 23 Sep 2026 01:13:44 -0700
X-Gm-Features: AclHuK9CRP64XWkh5O-lp0iZIS46BhsaKQBJZ_3Cwu7viyTTfI9mH9peB9qjiC4
Message-ID: <CAGG=3QXNoR_EpkUiTi4Rh5c7HNZCsVVTFneOT+TzuPiv9Yy=bA@mail.gmail.com>
Subject: Re: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
To: Kees Cook <kees@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:26=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Wed, Sep 23, 2026 at 04:16:30AM +0000, Bill Wendling wrote:
> > The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
> > to detect out-of-bounds accesses to pointer fields in structs where a
> > corresponding element count field is available.
> >
> > In "struct iio_gts", there are multiple pointer fields associated with
> > an element count. This patch annotates these pointer fields with
> > "__counted_by_ptr" to improve runtime safety:
> >
> > - 'hwgain_table': counted by 'num_hwgain'
> > - 'itime_table': counted by 'num_itime'
> > - 'per_time_avail_scale_tables': counted by 'num_itime'
> > - 'avail_all_scales_table': counted by 'num_avail_all_scales'
> > - 'avail_time_tables': counted by 'num_avail_time_tables'
> >
> > To ensure that the count is set correctly before any pointer is
> > accessed or assigned, we update "iio_init_iio_gts()" to set the counts
> > prior to assigning the pointers.
>
> "Accessed" yes, "assigned" no. :) Let's not churn on assignment ordering
> unless there is some problem I'm not seeing. The only time this should
> ever matter is if there is multithread visibility on the object already,
> but that would require both counter and pointer be set, so that'd be a
> general locking issue, but ordering during initialization doesn't
> matter.
>
In a separate patch, Sashiko flagged the assignments being "out of
order". It's not an error, but I did submit a "v2" that reordered the
assignments (that Sashiko is still complaining about, but I think it's
a pre-existing issue). I can weed out the needless reordering changes
from the patches, however, I like the idea of people thinking about
the ordering of such assignments.

It's a small thing I know, but I need something to hold on to. :-D

-bw
