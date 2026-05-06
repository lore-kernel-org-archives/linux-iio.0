Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EA3B636B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052688; cv=pass; b=Rc5gb8wu8g4qS39Cd29B0jUYPBqM8VPeYtDu+3C6GiLs2nc6Ifwy3uvRE/97mVba9wT7vazQWowgjb59UL0dms7lRpQKrCIBr9ZpCKkLhVoEHMNBfwCB/G4gPxquCQAA3ayykwSsXniAWNigtPuGX97Wz6vEiSLfseC2v9hB+T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052688; c=relaxed/simple;
	bh=FxIkIlEtafdI6DRqBNZ8MW+UpRtUaC8hHgHsnsnAjA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd/adfpzfdXUFsJJ/PxdOmXwql1JS/h3FYMmQ/1LZrcLFzwerf41G7Qjp4wbdLxcPl7RGKBdGQVuRJMfYmWvDEkHLiFRvxNbCy/rvf3qUK7i6uicqJhe/ULzwErS3foJu77r/pP8gjRiUnPh48ALuiRI42xe5/X5DFAop4WmqLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPZyq4qW; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPZyq4qW"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3654812f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778052686; cv=none;
        d=google.com; s=arc-20240605;
        b=D7CVBiPJZa7Z+9SFIIMWaOtMKLTFy4KIvkQzowUbRdbcnNdPia8WEYeUT/xADtdgjB
         /deepuXIFgEVSerHvUS+McMkYHj2j2ojqi01Is7Usw4bi5mN8ZhRzBKoR1Sr7p04jjnN
         SKg66PC1/X6iXSyTbPkCfIrfu+HfVd8vNAS7pRaS2xLJxTyicW3+LFLAEgF9eq1qFhaS
         xJ6T+DJnhZ2w8t8VZe7GllhvbhmTBTO7zs+N0gSEMeFVhwbnOhYbT/CUQ7eXiVn2LQHY
         YcE02sD1ScosV/fryclm+7vcNwddZg9uU9vJ32a+Up7Oz+vbycQGOkPFiRK5x3a+TuZr
         tOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxIkIlEtafdI6DRqBNZ8MW+UpRtUaC8hHgHsnsnAjA0=;
        fh=VuuJKBJmsqcn8eaUq0boxvs54GWuLjPSHYxendb6eX4=;
        b=hMkzpcPZfK+IJuyKDnHd5slf3MO5PlvRNmVv01Ma+3IJ+zGjaeZYB38F7ZrircaNb6
         StlgyYe0B6WgD1ClHcjgaF1PoZwPaqKLcVq5AvnWXCP4Apv94ft/v9FUoB3LlmEO3qke
         FV5KiGYENNv1sE8PVDQHtDPOM8aal0ejXM925IqSya0OnAS24exSA8wQV5FZ/EEElzMF
         f4tnVkOsHmzbgaWgkZGWHVTQHZsC0icTEuqe9ghsvqbGcC2je9YiVOUSy3OWWzmlGJb3
         zozZuruJZ74B+bUkMWybr2nFaL5SP6ddHchkB31LRzG3CejRpOrZX71jrHbLQu34Bk2d
         KMjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778052686; x=1778657486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxIkIlEtafdI6DRqBNZ8MW+UpRtUaC8hHgHsnsnAjA0=;
        b=OPZyq4qWMdMAKQOCc0eT72+nrItcM6bwxxTmiqytbNXNGnIfDAKdDByNJE8RxA+b2L
         MwRLTExThXLS/hItG4oyaMkS0Bh25T5CZHo8gV+K3kIrtjfRT1KPSLT30PWtlqUhZLQA
         7jhXP4yJrMwE+2h1lXfOpvfDLZkFMwbYx4ZedNwlBXkXHlSWRn+BGSI0l2eONeRl6a1N
         0XIgloFwc1VzI+KZKTe/yIMw7pC9yZSzCIt83pjkgEIjpsmtKrNHh9BH0jtqZee9l5tK
         z2dq0iIDGQpcfOiv9JKu5MJGNmY7MCJSqBoAJdRLb9CGRdJ1grQtur7J3Zq0GlHkdFzA
         EbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778052686; x=1778657486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxIkIlEtafdI6DRqBNZ8MW+UpRtUaC8hHgHsnsnAjA0=;
        b=tBe33vjAbLVg0HAri1F2I82m1Dqf+7QKU7G69Z5ZcDdOmdtZtqX+GrUboIAnl93vTZ
         tyjGYO9e1bSXYK9LXymP3vjl9upCWBzpjKq8qkIDm7tqUXqtg+IJzfPb9KtmBQtwOz/u
         GNT2xdaXWwuduQLnSrrmeG3qN+OMdXPaMnHE40ddVhkfR+Zkdu6lgBusa94fFgr0VAgF
         4Qk5FP8oGHeppqiRG/IPvHMxg7gBZT2bnz8OR9uLKE5NGrHIRFvozXkb7fTeY1bhOAqI
         GBv2hYbXnhqtu0hC3cTrMIEpUeSOtTiaEN4M57+PBnGFnVgxICddDjxImNO6zPAp87VM
         Leyg==
X-Forwarded-Encrypted: i=1; AFNElJ/07fbf95HpgPEF7I6Wc9VDtaQmjY6fyB+c1pVW7CLxWJ+9I80jjPVUTkBDIJMfhv+P7IKfMHLF9eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EmuzIoI1/tApIo9JimKtkNIozItV9tWUBKVXL/TeBaT5yg65
	49+NWswIMlNVsYjsomUFlq06MNgqsJjs4YD68isUH0hZFDVwI4SvsXnleC2Dj71+qh0yH5XJMsK
	kB7rB7aKAmMCKpWAeYgVt1QbaqXPElyw=
X-Gm-Gg: AeBDies4/Y580ArTyY4rSJ0mwQiAMFHMwPgeYiGVZkIr2l4+VffhLMBSmL+aOuWKpbp
	onORj/sWWL74S7Z0Vnqv3auppSbGXoyR+fy99/hTCI+gulrr2b+Z9FT4kBy+H1DkCguA8l8/dAm
	G7R5Stp5MxcwdjfxL2SvymC+FN+qq7Mr5xUbNs9AftBa4oe1KgAhi/TH4MN3TUtiQ5wCYvdUZhE
	WnMka0J639j8ZeAiAS+E600Sh+06uOXVQUgHb0QQGVXK27CkDv5bnVIgM6byjRzuQiI67yxw/0t
	Csg0/FW0SAmrdKncq+DKkwL9wwEdMPF+EsZ5zmlt9/GzWCzQPwsgsQaM4kTwPhmsojHJBMZH5oA
	J6SZTkI4YyPSQW6nadvDTruFBlBQrw7k+E7m3rAQf3P5G2TqmXfyQa7nrd6h8qq7AeNegNYKLre
	VymHivUrLxW7cAmmh4
X-Received: by 2002:a5d:64e3:0:b0:43c:f52b:8003 with SMTP id
 ffacd0b85a97d-4515d6bbc06mr3366792f8f.36.1778052685612; Wed, 06 May 2026
 00:31:25 -0700 (PDT)
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
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:31:13 +0200
X-Gm-Features: AVHnY4JPGSa9G65dIGb-fDjLs-Wp-xbz41ofQp9R8N5W6LHNM58dYLcEG1olohM
Message-ID: <CALoEA-xvn1zrV_TshPyKatLVRoMxoxN_TnL69s2ztxp_GZP2+A@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 at 09:16, Andy Shevchenko
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
>
> ...
>
> > > > Actually, timeout. Sashiko had a good potential catch here:
> > > >
> > > > https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831=
b9b5550fc%40gmail.com
> > > >
> > > > "Does this new error path leak the pm runtime reference?
> > > > In ak8975_read_axis(), a pm runtime reference is acquired via
> > > > pm_runtime_get_sync(&data->client->dev). If this new error path ret=
urns
> > > > val back up the call chain through ak8975_start_read_axis() to
> > > > ak8975_read_axis(), the code jumps to the exit label.
> > > > The exit block unlocks the mutex and returns the error code, but it=
 skips
> > > > calling pm_runtime_put_autosuspend()."
> > >
> > > While it seems like a valid concern, it doesn't relate to this change=
.
> > >
> > > > I'm going to withdraw my reviewed-by until I can confirm that this
> > > > isn't a problem, sorry about that.
> > >
> > > Why?
> >
> > I just wanted to make sure this wouldn't cause some crazy regression,
> > I think it's valid to be somewhat concerned.
>
> Yes, but this was the concern even before this patch, no?

IMO yes, even the first error path would leak the pm_runtime reference.

--=20
Kind regards

CJD
