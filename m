Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A037DE9C
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599856; cv=pass; b=ePLd/zCvd+ksKCdLAtczPMRm9diHIKJKafRXRUGDar74/xG4CnA2EoKaFwMFqjCQWZip+MgZ86Oj9at2x5uGfUo6YWoUlYOvU8CgDzSCWUSR6ijE0pctZ2NdCM7NC2qCpkxI18wwvxnbOM6yOqMax1zAtUtlp7dQmepOorQ5l9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599856; c=relaxed/simple;
	bh=T7o5n9MEAOe7XTP5RbwXd1auuooTYnlsv+kjrxWvh1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7hK/82zqar6PAAH++bpyVPqBfOQl4bYZG92JB9eXvQEy5YpQ4bjycgEyXM6PW2sGgXI0KajGoNi5N1YnfoZKInFnVLFFk8O6TrRS6qp1cxfqHDemtK2tjuoy0E3fMu/ntbgbXXeutDrmsz/AuUgbDcJ1py4WlGcNyGT/kbNS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIG7vbfG; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIG7vbfG"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so6078490d50.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778599854; cv=none;
        d=google.com; s=arc-20240605;
        b=PVL4pmb+wQuv26dztnDRy2atuBYxOSvXkGs/ykm8pfOR0El9blvosFmgAs48glfrFB
         c4mpkMn93HAonFGuQlnY4cJutGm62QaNJePilTaaUUDsc6p5p1g+fHHW9TiAqtd8oF/V
         tsCoxXAAUVKCFc9KFuv/9rpzJQdM4LtLLJlOYhkZwlN3DiPpMHtx9kHJuru1uOXmlXrq
         wmZc5CLYlYejbCplmwQNi7ENVkrWGAxODg/B9zGJmEFIMCZUsfaEKgpSdCriQPoRwozw
         yOe/i6bHQJLblyv/bQSoETHLMhlQKaHZcA8q3IhNkJ4mtXZUbD5HTHGorfrFFWLP+fmK
         VcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T7o5n9MEAOe7XTP5RbwXd1auuooTYnlsv+kjrxWvh1I=;
        fh=0UZI3/OaYfwnikJK5tGQ2na8XFte2PzdQAdHualFTJs=;
        b=JxHsosIkooa+rjHGlLlVQOVcVkXog3lMaanGdVU4qxzQD1jHlKMzTXMi4xF+smuNae
         rf+Sai7dKWKemAFVtrkBszXfRTrAGfJcSvhVcdO/nqWSuVJmT55uMJrdJIjtM04/a87T
         FsNaapx1Jlw/dsr0OhUgfW6nL81X4CVGVUFlfdmMrUou6drJEPAgeFuCyamddQPNyeWM
         Qcxtq5SoqhSEZ+oJlkFhUnpKMLC49HzM6pti9kdbMXQEOFqY/5heeEQBrfGIMxg55jMU
         +yhxV8uZsWW2bczYGEI8WzLS3WL4QthpEVBVm73XSsAZ1eYtkUVMMi3v1Inm0tcPbkk2
         w2/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778599854; x=1779204654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7o5n9MEAOe7XTP5RbwXd1auuooTYnlsv+kjrxWvh1I=;
        b=oIG7vbfGhrcMXMxkxIGdAstHtSYm/QZQXyLkJH97tqDX0j+SBGpapbDdnXT7OUpXXI
         3slrASqMlJY6D6C3sH1i5Xv+UzzDlygxgiC93faGCggE8gKLyytF8XOq909qFawsRj4V
         zgj4cLkfRlkNqhEOG1/tJLJgk3c7jQhH/+hExcoRpV0kmN+orioRcd1OmDEbNKb4zkN1
         4ANz2yPzZW9eiGxZ/8GQeB1aGEQUyW9vyMVsdzEwA+lDtCzBg+1fJ5IpOvtMFc10/P5M
         LyLvGsA9y5xm6zg49TvLrYhw+tIVQWXJPh9WPPl7UDQLgyUolZ3HO6JFH8eDr28TAozw
         isUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599854; x=1779204654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7o5n9MEAOe7XTP5RbwXd1auuooTYnlsv+kjrxWvh1I=;
        b=l2FSBpTF+Hf9Fjm52/KjErZ7uwzzE3S96jDYkVK37kF9hnf/Gbd8rHAmzDScD1gtkY
         04uTKGJibWMtHCifbPoXgWmlohTHFIzn+NzpfmRQMIWfnroUzPwL2mBAV5IHlIU4OLe4
         lQg/g5eMfL9DoLn6IoC/ZWKEk/u+kUt4UT20qwpKc4SeNJyCJz6S2pEFaRHV1+97C1hE
         rfNAXCybifwPOQHzczLkUxS87tFFnzOcv+d8XC8G/VfEvNuZptNEMsxtMRrPbzs8AcTt
         WusMa2/FMWaGkdVcvQ5Wmdym/RFvaR/XjbCq1NZUS/VDta9g4v+os4Fqh8azKvsZlg3F
         I6hw==
X-Forwarded-Encrypted: i=1; AFNElJ/+138KsUUd8rapL1gTm9QEBNon06uKw91RLP2jCsPQlyFVgJmXwtBsoYuAaN5mt8MCgPQDR/lGybY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IoY8kLzIrfMCSmPnneG0X3T9vD3O8MJTrDnSYFtogpFj2W1o
	Z0Axkt5myZoxEKNQY7IoVlTYBs4c1r9EKH7lqGsbIt6Vc8ex3mrkU0quiQ7rj0VieeN+m/NXqnW
	+tIEZJMlGs8PYqLr7eP3AlCo+sQUtd70=
X-Gm-Gg: Acq92OFtcr1q2js2xMytGJxPgCsVI6lz7XOvYjsfU1jdrxezM4MphOB1Bw5AFsODZeF
	F/NknNwtWM9ewbbJfzMcquOF054iyrSqQ7bZTZin5hW9n/r1IWUVaUkf9mvLVmotLpjkuiQVMKb
	JkeeI5O/6HgWQhQO4L0lzGPkLhomuK22whPFg0YBQ2U5okEWDwnZ0ijawF5e2aJkJFiE8vhyVlZ
	GBNJL3WSkQSpL47J8eQGdGzsQ7subiiR7j9H+U/ZME4dttWATA7otGazXVY4o7keMfFg+h1XQly
	/LrCa9G0oQ==
X-Received: by 2002:a05:690e:12c8:b0:654:a000:94bd with SMTP id
 956f58d0204a3-65de12e6c93mr2935575d50.57.1778599853589; Tue, 12 May 2026
 08:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512120356.40839-1-m32285159@gmail.com> <DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
 <CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
In-Reply-To: <CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 12 May 2026 10:30:42 -0500
X-Gm-Features: AVHnY4KyqKslBynbe2M73er-aGuvb4ECN2y5YTNm4jOXrq02u41JlXjmg5UX1I4
Message-ID: <CAKqfh0FyELOpgB1W+_nv4a1G1tuSjnVxbEFrUeR2+KCT2Q=-Ug@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:25=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 12, 2026 at 6:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.co=
m> wrote:
> >
> > On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote:
> > > A Time-of-check to Time-of-use race condition is present in
> > > kmx61_write_event_config(). Move the mutex_lock() call above it to fi=
x
> > > it.
>
> I think you want to elaborate a bit more on this. Id est explain why
> ev_enable_state needs to be protected. Not everybody is willing to go
> to some site to read some AI reports and interpreted them.
>

Can do that for v2. I believe that it needs to be protected since
later we set ev_enable_state to false (basically right after). Could
be wrong of course, but Jonathan did confirm the TOCTOU.

best regards,
max



>
> > Reported-by: sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159=
%40gmail.com
>
>
> --
> With Best Regards,
> Andy Shevchenko
