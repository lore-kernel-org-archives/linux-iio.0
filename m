Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB83EFD13
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083406; cv=pass; b=F5LjNEbHaZdIBU0WZOadqC9owfInr6lod+3rR1u2vSsvUTWjudtngrPKYA2mOhcw9a8SxkvhXxrNp7Ac2vXhedxdXYeMYbTKSqL6DmbSjqc1IBq1tdip+IoogHalGBOhTxEEKbCPvDz+CK3zZZX2x6HmuCbjuI7SM7l36aEVmKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083406; c=relaxed/simple;
	bh=3L86WjSxvkhu7GMqg2J1BwXojQthzVXALU8GYUadx70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyCWLTVUo6phU09OQtn8E5QyJ8eYTO44ynM2T2tKy/IIo1Vs/fnuB8KaGNIvdup8eUYFY/zxXuozYlbbFYefxVq0VkqLJFth9QAXsuluqVGssL8JSxsNhdAHnXWmyrxCBU9PVQgL7XmlRDmsTx22VK0dhnPtFzggvoPiw3mKoZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htz5MEq7; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htz5MEq7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7b37d84a6b3so69485227b3.2
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 09:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778083395; cv=none;
        d=google.com; s=arc-20240605;
        b=T+7Hnz+tpKouUnzECi+z5kEbA5EJ5T2ikIwCRB8p/8aRfjfngh4vkW1pJHJ2zef5v0
         itZm5qHKHblhU6QIqBIYwVFIweiFimtSz7bAw8N70LFhXkVyfmFzEklL8JXSQWKwm1oE
         b6m4utTnc1opKERjYCF8ci1pAjShzbwEVWheoXrJOpirvg8qVDxXVMlViQFy8EjXcOb5
         jcaegSokgEbGfUSp2tHErQFBNu9Dt9S9IjKSe9MZfLgpS4Nu1rTmh5n0hy3zHh3oIod1
         8P5XWG2FwgR8mYKLj+X9z3CQDz6SV5qOVN1p7VQ3dIpk3o1ywu6/au8wKhIdEkjll+sL
         +i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsqJLj+tWwOdMRnwoeAumOhRN0s414FtN1yTOOAKDqY=;
        fh=yfRMuXbYybALpZk9a7W4cicEHoURb2hh4sh1WdC3Nro=;
        b=lVyIn1G3akz+dAhokKpnir6pVZlD37D8pJJh6cF5kVj87Vf/nmREQyOesAdgGpJZzz
         onmi3MD47F+US6ZgcN1jfENL9/04Tng5ZggyjBE7M1Ud81VZG6BFVkVHH/UHcw9FeNNm
         EsNqF/cidNRung/0l2+TzrIR3lBDe/VotneGjluWo77f5N1d9bHMOo/eejSkl2nhy16y
         HvNApGbMV5sO5BMYJ7R3aKcIz83KhGXHtmYb6WOL1c7E8P6C00XSvx0HkWaRBlUkcv3p
         pA/Izbd0wfRX4qgG9BQ31HL9Im0OZTYFaNOQL29zJeTYPP9ZO+FBNxtaMzrYfOpEfOW8
         mMTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083395; x=1778688195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsqJLj+tWwOdMRnwoeAumOhRN0s414FtN1yTOOAKDqY=;
        b=htz5MEq7Xmdk+oDbej4KxMJFJqZ/uM74i0CHfcU59FqMBOPPuv56ywDYApTss1GMxF
         hFIMxi3HQEfLAyF8ZcFyWZvq72wWUrIkoYnJt5/DFkCHDVOEvNo0MUmkfdGTrxAr/ie2
         lVUzAcjcXKtf0ee9fjbPRHRSGn/LTPana3cunovKzHhUinAa+f9wcHOReJ2t0QvIooxW
         2cKKi/fJqNBXrf1fVZGj0lFGTR0Ay9oF0sbsD7HQHL3QztCadLA87KSvVK8Gy+B4E+Yl
         9gyslo1eYVJW5iwicC/qRwuZr2HJWzTo76DjWsTtYcvcQfJSdCP/LhutpcXYp2/s4BqH
         y5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083395; x=1778688195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KsqJLj+tWwOdMRnwoeAumOhRN0s414FtN1yTOOAKDqY=;
        b=m76IyyfJYGpRmGzsNBZcAiY24NFNUMykdD6SK17Izpn0DMztHlUTVVi/DyVa2sLHit
         d7Gn7nVTQLG5j8gi13fJVEVTrRO2fe8FcpHkzMV49xtoV/UYXCj2Ki8gWHMUkMi98NU/
         fG9qllUXbF3zB9QZ1B16xFd7IvJ0keLq5thO59Oa7CHTiTxGPYkVFRMlWoVqeEomB3HD
         GNsD45l/BMKePAl9CvQlqAfTYRhRN5WzcmlDuaT9WvCALf/8j0zLR2jQ8dUfgWUAVOEG
         iiIHVSthGYwts8bjRO+/eD6sibauBCpl+OeL4mhCPCagbrx2zsc65MonJIlL2Ipt/nmf
         4U4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/8Mkzbb44oQOPopjLgzKbmSdDra+zueqbT0ypY9/bpiWP10sh8l6xSKNJowjl7krVX7pPfRMAhh70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQ1/m8ID8vrF4cQAjjlGLirXbjGHqmekcOQtk9ATDQxIuvWQK
	kHhRHoH//mlErSVQqUzeYdgcUIU6L5Ze92o2W9qDoinM4CbqcxvYpErxWbOWe1pZ480kZDKRNf1
	JPaVTUacmWL0rYLK3dmmx3uknujghLSmSvQ/p
X-Gm-Gg: AeBDievzZu39bCF9OCFCECxLDx3fiemGrLSM3B5bEMy9la8jISNQdKhfKY7UnxLdPKH
	Igps23LntBIpU5wq5KNd1pFMtkzzsNYe+BzR126LNDZLiKqwxoqeBLrtd+cAGNyxalu8IEU24Sk
	6oc+vkOLup7fIRzsK29VfSRhgI2iie9BAeOhbKZ66cQOBnNqjFFWJR3c042JrasMoLUIJqNUMBg
	z3q1L9eihBPxi0AaTJWdvwEIPTMfnZ3agZukyZr6X4w6Pmi0nXAlz5FZHYoRKvzcOmZdcBMy+12
	o02B/mL8KCseg+kqSCV1UE6iQznLmxg=
X-Received: by 2002:a05:690c:c50d:b0:7bd:a6ea:c508 with SMTP id
 00721157ae682-7bdf5e65db1mr47967267b3.24.1778083394819; Wed, 06 May 2026
 09:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174943.94093-1-salah.triki@gmail.com> <afr-KvM756ZAn2hh@ashevche-desk.local>
 <afr-UujhzuwZWzhT@ashevche-desk.local> <CAKqfh0E+4WUBsMHH0Rj1UH0MFdGo7E1crmHzJ+E6c0XXz3qvCw@mail.gmail.com>
 <afthm7L0j8VZdkUk@ashevche-desk.local>
In-Reply-To: <afthm7L0j8VZdkUk@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 11:03:03 -0500
X-Gm-Features: AVHnY4IXfQ734B2QnVfGt-zfXx2zhsa1wMT0dJJ8hx13NmD-39hkAv-O5-xx-BA
Message-ID: <CAKqfh0GZVdvduXEOusaARs2w6Oj4A4Q-hd-nyF9OJiXroEoxAw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality checks
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, May 06, 2026 at 10:02:29AM -0500, Maxwell Doose wrote:
> > On Wed, May 6, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, May 06, 2026 at 11:39:11AM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 05, 2026 at 06:49:43PM +0100, Salah Triki wrote:
>
> ...
>
> > > > > +                           !i2c_check_functionality(client->adap=
ter,
> > > > > +                                   I2C_FUNC_SMBUS_EMUL)) {
> > > >
> > > > This one is now wrong.
> > >
> > > I meant this *indentation* is now wrong.
> >
> > Did something happen to that when I sent the email? Or maybe I'm just
> > going insane...
>
> Sounds like latter one? :-)
>

Probably true :)
In all seriousness though I need to slow down...

>
> > slightly confused,
>
> In short this is `if (foo(A) && foo(B))`, and foo should be indented on t=
he
> same column while their parameters on different but still same. In your e=
xample
> the foo(B) is indented as A parameter on previous call instead of indenti=
ng as
> foo(...).
>

Mk, thanks for pointing that out to me.

best regards,
max



> --
> With Best Regards,
> Andy Shevchenko
>
>
