Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D53CFF67
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789548; cv=none; b=a96V6slds9sd+2+wyTl3/qZ72Xm0B4RIt3DpEGo6TIRnLRhCWqDQRABSkMyNWKVwEydvZzNLPuy9J2cOCvwD2KXR8ayIV/EdlV3lM0W9QZ4j5HzZQjPgyC59YWByDjidZ6+fVO4uD7IQOY0S+GlZ1TbcLcpTQgx690VJDB0+Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789548; c=relaxed/simple;
	bh=vQkzABbgpFu7zVsXWnxe8cy9Q3NRoLN87pCu/DZh4oA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa+JEOGU4kIV+P1ZCORrIbxM54ycWmcZrkOtVM9RhXXEepm3VsK0lZG5vVM1+QQ5eF+hTjtExef+Ht33VnHQkbQbGhNeEwm7Nl5gxzz3gjyFADUhXIsvUPESnxslz9IwZTN5xUX230ZmTZ4qvkwRbsK533gkALy+UsB5J04e4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzMmg9BD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzMmg9BD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso5025175e9.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779789544; x=1780394344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLRYLwQRn5cN/q/sqko/HgmBpICy8QtK1o9ym5629xQ=;
        b=qzMmg9BD4fTQxd7pM4s5ooOjWLSuHp8jHAhUB5CirChfBtKNgxSCciz5+ehIYF7CLY
         J+dCOqFYJPNE6ks4oOK32Cm986F1qy0+EOzLuFvN5SxMLOIL6maYypsljGKoEku1/RwA
         q8FM7yMNSkYvQMXimgCAtMCEpnk0QfQ1NLepK663QQm6XJ0W2A/01TIo+euqPU+8LcLc
         Am4du0zavM94x0cwQu2ohAT7j0BTLq9T6arZzjAovESbGwdL4wT6hyouUYLE4M7WJnhl
         OU9Hxd2jVUZ5NejpEIr0rfmlFbVxRF98rui6XFfo6NNyvlgcIkFDBtXe4gbaX/i66jok
         COwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779789544; x=1780394344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QLRYLwQRn5cN/q/sqko/HgmBpICy8QtK1o9ym5629xQ=;
        b=TAmHpxiZi527EANyRsXTUXqcHjJshAUqq6xmvf/c1VloDQcrkxMVJO/XxRowora7zA
         SMfnrG06ftCfUi1MrTgH/ov4CyqEvSdHalMlOxDoH0AHNmhTqwb5lPRlbSsjkHNbvtgr
         3hJ+FAo1WOn6F6nFurPivXvTldxpppJZEd13U3R25gI5R9qplvzum4fBNvL8S5n72Zij
         8kJNx8vAAGYGu8no17bQ0F+AS/vpERdIlz+jwVYfAQ/ftMjSM44iEOl2CrlYgiuAU7GD
         wN9jB40Hjp22aRmlcrXqNiFOmbFOu1Nx6G0arfLpSLX8STL8AHF1C8k+RfMPvBvMge+W
         brzw==
X-Forwarded-Encrypted: i=1; AFNElJ+9qYJnFjWMrZXNXsLvWi5kjoYrUjZET4IKfjdeFw9B69JEDq2lyMUr+Vgtj0wc+S4nk9BKRUK8tsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjRSy08iwBgkkhYQFwWq2yZg17rZyqqf+8mbpUZml8FP+v/Pm
	WRtxeoqbGEZD4x8wa17E0dIYLZ7yR3x7u+YPmZMVlaLMh388q58qI0zK
X-Gm-Gg: Acq92OGfnavkspVwtZubkHTJP4nBBaULlGD4DIS5+3v6zMpxlBImXnf+FSz3dBX+c+s
	muDk/dxQ/3MSLCEdEDNoYSBTAc0bSlSW4XnKhbbQtT6+1UNCluBWBzaBje350ub5o3wwyslntiv
	/wclTJ47Vg5L0EIE/jCFpYBBg+O1AKq2/IGcMAAT20IIa+Q0trNDBqY5dJnBabrG8ZXFda5YpTs
	3yjIWZPKSdubqQg1cEnoEpehvhOmASM/Hj4ne6wamLwCQ2SeNF8+IMFnfPp+TQleuHZeubHa+5Q
	2B7FbCGE5sjKCIODLz3cIpxM8W6nc4yzZOyfBr0w/aQxpVjFYwYvlwz/AXeyutsqZbaiROhFc8h
	0yOvkJ1itLOEJipx61IZmNpq1+ZX6nlLwtbH27qaYKNzAT0qicbJRrKcuDA30WF9/SJhnEawnnU
	SQL5FGNN+fXzkoFTLxFiIih+U=
X-Received: by 2002:a05:600c:4688:b0:490:4224:e0a2 with SMTP id 5b1f17b1804b1-49042ae265bmr307954735e9.33.1779789543584;
        Tue, 26 May 2026 02:59:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49044f2bad3sm339178815e9.0.2026.05.26.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:59:02 -0700 (PDT)
Date: Tue, 26 May 2026 12:58:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix uninitialized data ni
 ad3552r_hs_write_data_source()
Message-ID: <ahVu497RZjJxn7dj@stanley.mountain>
References: <ahP3IjYJ87bNc1De@stanley.mountain>
 <CALSJ-wCcZ9XNTrcvq1TabT--vA5v0gritbpfNG6n0aKRXuSiKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALSJ-wCcZ9XNTrcvq1TabT--vA5v0gritbpfNG6n0aKRXuSiKA@mail.gmail.com>

On Mon, May 25, 2026 at 01:11:42AM -0700, Angelo Dureghello wrote:
> Hi Dan,
> 
> On Mon, May 25, 2026 at 10:15:46AM +0300, Dan Carpenter wrote:
> > If the *ppos value is non-zero then the simple_write_to_buffer() function
> > won't initialized the start of the buf[] buffer.  Non-zero values for
> > *ppos won't work here generally, so just test for them and return -EINVAL
> > at the start of the function.
> >
> > Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index a9578afa7015..6bc64f53bce9 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
> >
> >  	guard(mutex)(&st->lock);
> >
> > -	if (count >= sizeof(buf))
> > +	if (*ppos != 0 || count >= sizeof(buf))
> >  		return -ENOSPC;
> >
> >  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > --
> 
> thanks for the fix,
> 
> Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>
> 
> it looks like this may fix an additional overflow in case ppos is near the
> end of buf[].

simple_write_to_buffer() won't overflow.  It takes ppos into consideration
properly.


> But i am actually missing the use case when ppos is non zero, can this
> happen from shell "echo" ? Or some fseek/dd is needed to trigger it ?

I've never actually tried to do this.  I think lseek() or fseek() would
work.  But also the simple_write_to_buffer() function itself updates
*ppos so multiple writes would do the trick as well.

regards,
dan carpenter
