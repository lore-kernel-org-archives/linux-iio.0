Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EB373BFE
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052077; cv=pass; b=ucirChWYeZF1dVXw6F/gI335NUWyQhpfpPS72vHt88sz8p96gC9908uhiv4+B5Dwf0VjEKsFWdob8A6+l9RPdgR4bXjhYE1EY+7qByy0Q2XypS9rnqSMZOJnhCMzHTUNoiB9yGyDf8oL7K1idYIIdQy3fvTWdN24Gy0gd7mawcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052077; c=relaxed/simple;
	bh=evbKKt9fyTw5pbbYtwWcyodPmzw/1lsVIlyoeuBDn6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX80VqKKIDjhd9eJ1i+1vO4OXCPqugN6jBxB9OBqZkuHe2kFkZsqr0zs+0ZFABK+u0l6JalBBUgB57Uxid9D3dFMc0YbopvG5dUh1SGkIETgGebc5tOJwdet9924wREFILQ2T3SsLOUo53fp20gC7yTHmeh4rUD8fU5uMHDmrCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E88kSrai; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E88kSrai"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-799001d73bdso54744217b3.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778052075; cv=none;
        d=google.com; s=arc-20240605;
        b=f8I0phTctq0S5dofPszswd0+tX3gE3nFMM2rDPEx68jTtXhglz0WDCGW84B75BGps7
         RvE6Xbo86CLZy3CMzz/PTOANsEjfF+bhxRICf45isTWXOp/DSI/KLn9XmR1dYRsO19mX
         RzVi5lcL3fNVfB5IoEKiBK/HMOC4NJBO37jaJfMy9TP/sjbhEgKPFPJDy8Ez24os08Iu
         mhYlvoBOm0LOjTHPAZxAW8QDIjlHGU9+G4JPZmbMcB9BtdRYP/0BXw5jk7bcsi5Bv/KL
         B/JEQIhHIfI4daNfIY2VTx2+EBH34kZpUJnZNfgJnKmPHwDr01wkqfoYyYo9WuO0XmcC
         ZKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evbKKt9fyTw5pbbYtwWcyodPmzw/1lsVIlyoeuBDn6w=;
        fh=zBBtXQG2dA6zTP9lGV9GYlN/Nl613Nw9FaW1663ZwGM=;
        b=QON8dlzmdKb4cAjo6BqrhJRldXgOdERquaOJnnZIcGbK8dnLHNYl1eG/Mq4yUW9Ule
         K4hNUmohUqaJ+5XP9LoMizvbmQwYfJii1CBOv61gGI1Y6dKHWcq1qh/F75XluaO980Nn
         l3lCOXCQveQB6/3r+vGvnJKHNFpnd552DQlSgw239lI4XMG7smGrTMlUtmkAIpO4s5vp
         X+BK+qIqCppOwid/T818DkYq5wuYAMCLEXC9GoO54X2KXToEFtbka7ZhAdPSGSNi2BzD
         rtj3jz2MOo4J+Er9FSVTI3c541Pk0w96koa3iX0/DJUrbgInsYmLJgUKOcRTkmn+QBul
         vVBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778052075; x=1778656875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evbKKt9fyTw5pbbYtwWcyodPmzw/1lsVIlyoeuBDn6w=;
        b=E88kSraiNjd7uss/cCKTIZD7/jOTbuMNm/AKgbDiCP5OZkF3Q9Zxw8/IXv9fW/VV7K
         p7O9KsjQTo5+zTTIjIhNCF+h2bjWsN/RQNF6Q7j3KPYRF53mHSxqMbrZ33tnqowOLbEC
         HWOMdcWBCjcr1g1/TKMy9fQ4TAnCwti8lI1LGnsv6DcdUOsf2o6WEAAIyE5z8pjHLGtE
         /eZMggdvrLKNS0F1CimDGmkTW4tRBUoQ0+m1ogcJfYENxDmU4GsiciYJAR9l+E1hieHh
         YG/OBa7qsWXtdbTLZrKle9L//sx5Q7+lzI/BgoZEj7xchQK1hUEEBtXtznxU1SA+7z5I
         aVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778052075; x=1778656875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evbKKt9fyTw5pbbYtwWcyodPmzw/1lsVIlyoeuBDn6w=;
        b=jScTaDAPdLm8djR+AwB/NzMIh0m/3uudKsRCbZqWoxLlxg0WmJmkmFT/RRtfjLsWEB
         fUTYEo6kRzv4LGgx9Ewgq57xQmdnPBX5J84J8WAelKbOcBkiOQgq3nh6jYGLFaO3ijQ+
         ljMk6g8UTwwaqAUyoTgCFXJgfwFFv4+2dTu7v0b8nY5WA9SQ82ESA/OjujB9GiABnJ2i
         PZ62RsKmZLuPX57jaE862QGRcwRdmNvTIFWkwBaTMsm4DqYGlHYWsUBsLzackKHwSCqz
         Jd1u9lj9+ZjZCLz5Vb6YJ+bskfUXFUtSjjQN+UFbsneQai6BBIPYCp2EmzlhZ+4SoL+P
         ju5w==
X-Forwarded-Encrypted: i=1; AFNElJ9bW6p7tN3k17NwxtFiGyh6np4u6yEW+62UPksI9mqxwOAgTGiHLk8NpkWMneTfmvLJefb5ekzOasM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotvzS0e1sCY6davoo8iPgsceKZWG0FPnkjaofXTRFSg7qnRly
	JbYDGt7wqpWyTjQvcrzpPPFMdhaiKbduW4x08dByfzS4DSCOYHFFUGstc2w+JS0SaiFD6MOCGFO
	sxYoXqDx8u0yesQGxauqZK8F8rYp7nW8=
X-Gm-Gg: AeBDietNKOl4Jbl5ZVLebpKA7Z1ETEw6SutxmOVW2aDTKqkC4fdng2pyFSbv+cgNwv/
	+265JKwnz+a9K29jpIk2I2VjbEZB8lKexzmnQ0YftJ4EUaHphidyfjU6fUMAQfKPMelprj1gl/s
	PzBn1FDGU3Tc8YnnGZzw6Gms/eV3HrAOnxmHgPL3NkAOuxm0tizBdKR2N7jyyjHAHYwSBXyvKKM
	JFTq2XojAyqbtDtBVzdiU3YNab+oa8aGo0L1iZqcPp90lnkjDGPnMXWPolgZwjMIdLK7b50W6hF
	LbT2QX+eQRFfo9cwK0NAnpcTng==
X-Received: by 2002:a05:690c:6e83:b0:7bd:7b2e:f09a with SMTP id
 00721157ae682-7bdf5edb503mr25827877b3.35.1778052075233; Wed, 06 May 2026
 00:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
 <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com>
 <afrplquQwS2hmjEM@ashevche-desk.local> <CAKqfh0H1Cc1tizgYKFatEAVvyVMTsCAu1mb1XdSTqB4ecMvqPQ@mail.gmail.com>
 <afrqvtBMhlUR5WmJ@ashevche-desk.local>
In-Reply-To: <afrqvtBMhlUR5WmJ@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 02:21:04 -0500
X-Gm-Features: AVHnY4I_76nsBjm_CNum-G9rvqXgeK5N7f8Zt9UUg0yOGmXO-Ajtm87W6PoZ41E
Message-ID: <CAKqfh0HrvFxu=KXVYVGC=JWLJyjR2XFyJ_TObFOHusw1n5QHBg@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: joshua.crofts1@gmail.com, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:16=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, May 06, 2026 at 02:13:37AM -0500, Maxwell Doose wrote:
> > On Wed, May 6, 2026 at 2:11=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, May 05, 2026 at 08:42:12PM -0500, Maxwell Doose wrote:
> > > > On Tue, May 5, 2026 at 8:09=E2=80=AFPM Maxwell Doose <m32285159@gma=
il.com> wrote:
> > > > > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wro=
te:
[snip]
> > > > I'm going to withdraw my reviewed-by until I can confirm that this
> > > > isn't a problem, sorry about that.
> > >
> > > Why?
> >
> > I just wanted to make sure this wouldn't cause some crazy regression,
> > I think it's valid to be somewhat concerned.
>
> Yes, but this was the concern even before this patch, no?
>

Going to give that a solid maybe. I must've been tired when I looked
over this again. Very sorry about that.

best regards,
max


>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
