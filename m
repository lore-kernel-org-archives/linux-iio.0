Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CAD3B7768
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670419; cv=pass; b=QBb85WKtBACu5QyghNr+iPYlv+FcyWH2wnr9Ld0b3Hw+C481F5kNPCLfSx24j4qhwVNKl8ipXoXJSgK8eoLDylAGl6nT3bOZO7Hs0BqXXLdylLhujesxLwuwR7Lp3k/hdnapfq6sMW3K5F5qcEjVLACxhpFnR4R7guUpABdMt0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670419; c=relaxed/simple;
	bh=XudTaUobkCqpMUk/mD4J3kCOpdjuFbbcE/1FmyL6ub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QglxdeyF5KKifOeY2HC1eGIRvUsI5JwgWe0zL5u4BlYXv2OYLi3HgFU38xcYsf3hX+LaSquR4hw1yZt29ZHKU95MQcw7CrMo0Nx2ZQekhr4ij1WTVnCV1o6wJ2hIb93AHKRj4EHkSaktIdKSP3+O/k//EpTKYYXFgS6E7O9X4D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl5c//UM; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl5c//UM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbd25309f7so22404877b3.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670417; cv=none;
        d=google.com; s=arc-20240605;
        b=YOPnFU+U7sUBaqWMeCL2pWbj7pLnf4FXPRhXZs0qLsK5l7FrJr7SZRJCZ8Ugu1gtH/
         2GaW4MeElGfCm9AcD85MftjIKXIuLthZ0QvQu4yaDtN+4YGpQ/17boZsbvkMz5rQdbbH
         YPI61ZWgh5jckt6UyjQoJQUfjHhdN8m5uu4yWKrUxoGsELtSBTWnqYFQLq/ETPvADVbl
         GMOTOLfzDNoO/3+9sMCUQNKZfQC2cHicYvaWMUgEExxq11UzhlXOqSlXqGw2+Q+5T1lr
         XhvG3rZDo1V79VSBGhnzxaMoL7r9T83nig7wf1LUvCvyV3Cetp6ZJsvsXMFTPIU4776Z
         texA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JIBuaMp5eVSsZqmc6zEU/S8/Nh91rW1LUCYzFy6pAg8=;
        fh=iAiWlPWdM+yAJ+wTVSodhfKY8mgCG/8y3cMHkPAmgUc=;
        b=bqZj0bNydV5fLMop9HEGJSnu2eQL7guWQHwe1g2M7Bu6o7RZX0WZ51FHhb781IUcA0
         2M67Fb30BfYSKOPp7GxYNjo7nShQmrzmgeS2yxuByqWDVrd1E8UDw7SC96Jr0FdVARRz
         f3jIMUtS5UiGZadiR+IA3nS11AQpdypxUKaqPDAb2uCa86esHnhpRv6IR35kOhfnp4Sg
         q4d+Y1o0I+kzdApU72hQdi+OCKJyrONDWdkKP1etAUEiY5qnRtpDzMaO7tdnK5H2oFfl
         xRapW3bhZwWfYPVb4xFgzPaORzMhsCXM5//XEUtty3BPCUahiT4CLzBSt2PCBb6bkkYa
         IJDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670417; x=1781275217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIBuaMp5eVSsZqmc6zEU/S8/Nh91rW1LUCYzFy6pAg8=;
        b=Fl5c//UMzpCP5xl4NzvS5ZIUwnUMF/kLYMVm2gqZpGY772v/YGJDHdh/trRj18BuST
         +hzVD8UZreJdUn+3XoGuzrHj2DTk+D7ph73+KxhT0AasyiP6o2foh1oImJtlqQs3+KDP
         1Fq4hWTnul/PSlWacA+3XACO1dNXwpNmwJa8ErdksK3WHfNdTADaFPjADGfa5ajdMWMe
         1mrMJLUS/aEwn/wlupftsABVcMWoHoxJy6U1skvytseNMlBvgMvIe6fqj/RbY6XWM3Zt
         82SlkU3N3b9Q090/Ucy8s7GUet+K5en1gBIi920oa68EZ5ZPBRBmYzu0FAtIeDfMKh7Y
         epAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670417; x=1781275217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIBuaMp5eVSsZqmc6zEU/S8/Nh91rW1LUCYzFy6pAg8=;
        b=OuL3PCxMr7OMtOoMTCA80jdeJQYlrTOjqPwHrrVVi95nVnk8nKkfkP+il9ErNCi/OZ
         /kqUrfdJ3rH6LpfJWrAHkaxyQcdgjX3teWtqrx0mPQeY5RHe9JXgkKBEiX5EyUQ4kO/i
         8TFolEZMM/rP7o22m2iRP2jMXj/b/Fmon6RGOrSFVm+Y3TCgB4PoihUWFmqxLve2uyH2
         kPbyWxpdrH2rQjGv4B3MR+xgurHweL6dIuZuWpRSm+miidTSI0W802WY+A5Xuqi4Bnee
         9+qO3lBf5YfrL9//nYP+ciPaGzlV9Df28ay4u5zDF7UgFydTFLKMzqIGYXi3/Igmm1dq
         Fxug==
X-Forwarded-Encrypted: i=1; AFNElJ+QjxSXn2xwF/OLLNpy21PkPJzLo30ZLvh0S5KPzGdvL+taX/KFmW3ilRb9MszLAmdYW08HfhiOqNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLN4/8IkqxP2EvUBTA7tpvoY9Ws9S9qUW3AUfxxB3gHdU97Pet
	ttbZOlFuER3sR7a6ZYB4MPAn0RgNfheBNrlfyzIzoQLgu6tzOzY3oS2EgpsjT0fySD6P+Ic0pmL
	XkxuuV5BoDdyq+4kqYrxK0qcIGY1af0A=
X-Gm-Gg: Acq92OFCOP6d0uZlV0vowMXC84XMwlS6fQvGKYIYT+ut+e5hWrxt9qPv6m51BXTZakx
	lTyBBr3M8XUgem80nE4/nBxAQdD+KwyDUz8Wk1fWF7GQDytYUcjlvzis4RX6MiVCodQ4lpepUjY
	jDTBqEHQJjvqzELd5R9GRKH7zf6k7QyLgizcbX4dw1hgrsYePXzCkyvYk/DUhuh+ZssrvZf7oQc
	lXZbk7mrEWNWq7nOWfwmqmoig9m5UIu791ZtgedAEMIF6SuSg8jghr+FvLPhekfAQzsx7JlGy6f
	v3O7L86XqNChsK69OQ==
X-Received: by 2002:a05:690c:680b:b0:7cf:af41:50d9 with SMTP id
 00721157ae682-7ed102ebf89mr38276587b3.36.1780670416478; Fri, 05 Jun 2026
 07:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei> <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain> <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local> <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain> <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain> <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
In-Reply-To: <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 5 Jun 2026 09:38:17 -0500
X-Gm-Features: AVVi8CcB2xdyAloYYt76tcmuErFY63mlZK_MqQnyHeOABHPlNJaoZTICrRdPL-g
Message-ID: <CAKqfh0FMsor4WnrdMcXrF4+G=m-Vu=nGq5ieDz8C=bUOvicT-g@mail.gmail.com>
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > > >    168          ret =3D sscanf(buf, "%i %i", &back->cached_reg_ad=
dr, &val);
> > > > >                              ^^^
> > > > > Uninitialized variable.
> > > >
> > > > s/variable/data/.
> > >
> > > With what I asked in the previous reply and what you explained there
> > > (thanks, btw!) I still think your patches are not fully correct. They
> > > will require to atomically write all or nothing. If we want support
> > > partial writes we need to go with that differently (reset ppos when
> > > we got enough or more than enough data).
> >
> > Requiring writes to syfs and debugfs be atomic is pretty normal and
> > works well in practice.  These are very small writes.
>
> Perhaps. In any case your patch will break existing partial writes, right=
?
> I'm still considering that resetting ppos is the right thing to do. Just
> need to find where the best place is to do that.
>

I'm certainly no expert on simple_write_to_buffer() but something in
me tells me that writing in the middle of a buffer is a code smell.
But you all seem much more informed in that regard so don't trust me
:)
