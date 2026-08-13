Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25683377AB6
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654072; cv=pass; b=RqWeugNnjhXxJG+PAOFyIlUXHVDfx0hOci2o1+wONzxKrKr+CrSFVQXSUh2K7ZX2qc8Nq89sccPkP4LTaVXWmYQ6A5TtLtgEpHP+so2RHDxIrdIok8rW45CzVcPpg3YuK5MFuVoT4NEp2EDa6XuEBFrjtA5Fo0tHP9oRWbegRPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654072; c=relaxed/simple;
	bh=Frt8BzKS7ziCjXCxP1luf7sUV4rMT4uJbMK9MvJkhPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHHan6+1cJ1w/mkdnGsns6K+V5ZPttMzF/LVqBgI4iFEsOWOTAsONy1L/jhK/3ruW97F6GoT2D3RKPkE+/NgJUWvebtRQ1V00AAJFIjz+96g15YIZIhOenCyPn3/iF69XiIwfWXiVCISfMbNKbx9gIosj3K8Kvft4zP9AkPFc70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/YAcbC0; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/YAcbC0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c26d7e951so61799366b.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 13:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654069; cv=none;
        d=google.com; s=arc-20260327;
        b=CyLw1+kamgQEb5K/jtyMYdSSDVaywgW1QZHc4PrJMX6ISozbdcL7eKLTU5Sgd8oa6d
         7ZiSMxmWFe+Z/JYaCxA32v3EJ2m0cN1/29GOzl+5PgZq0j/x4MYOfJjDQH2KmxvcKqPx
         65Y4BVhLPXr9cAKbdhp/9JAh9ws0w5Ctb0PVg906dB3FbZk3bir4fCgXHaMzESgdAL0w
         m3MiObyPaOOxR38Ws1XMaGpEEmHicSEIcJzYObX1G8bpprcOgwnCAYaNr2GSaokM94Hc
         J7853LyDi7qxjNKoSKBr8sipMx7w33HdS5WEeJIYMuQeek5I3R1FmIaubDILjdL23DhL
         gpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STdKSMUeQKLiG9SBax5juetFgJP5Ilc+agILLu5KXuw=;
        fh=B7OnmPEu96Y+kZaC4GaS34AkLcASe9+V/BYMmUS2z5o=;
        b=B1+/hI4vg00nDeMVNpJd7fKnqHQmiFcUZ3fVE5iV0Z7aXm3yw0EiFA6FpOEYqSQb5j
         +gJT6uuu7Usuhx+KCqyaFKXiM35KRuvds0uiVeKN9XE2PNe2k6x0tdW0afy+M8bVq6JL
         4vae8rHpC2gjkUq4PVDTV4/YDmzebYuAV6F+lioseSszrY6DjRBRy+FiC6uv2yAG0GoZ
         OTuwG4FvyjUn9xZ8uyNvxVgYfgJVLJ8oKkRd5t3nCW6IBST3ds3eTWsOR6DqMJ3ishay
         kByZQ2Q+fP4KwQ1UOq2P8eVCOqeLZ3YRBq5RjhNU609LfweqhfxghTwyOs03dpS5/sVD
         93eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654069; x=1787258869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STdKSMUeQKLiG9SBax5juetFgJP5Ilc+agILLu5KXuw=;
        b=R/YAcbC0jBnXP0puRQR4wnL09We74VgQ+9ry62FL7ZCs6y7EdEHwrOq2efnDPWN7Y8
         W7XtJjQra+8GqfgDNTTdXpkZohpZ46oAJW5LjtCCK444EZfAKRJFOlV9V0XHGiGQKAMS
         DQq5R/GEFUgEe0omYI7wPRRRMmmTbVNW+kEHS5QZPxc0d9sTLc59IPlH86fxXX7JWzRw
         zFqdEdNiHNDdEXh12+yTtkD9Gm356iXOVBAeiikBHNmHibshbyTGdNfxGLYK2+t1LSbL
         zSqluUnA28gRMNsgD5DjuTYLtjnG9Q7mfVSdfBEK5mnf8gC6oRY8pGI/NtI0CXOvIfxe
         2P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654069; x=1787258869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STdKSMUeQKLiG9SBax5juetFgJP5Ilc+agILLu5KXuw=;
        b=ESwORJ/IwXS7/paF1ZzhbkLKrCZiguE9mvq/voH5MEhwjLx6TJAv+BuvhXtf4uxjJ0
         LSpscLpM7Zf+uZVfPkq3W/OBxi8D3x8nWpbxUFsy+Hu1Z3FTnRylYESstn8hRLAt9uWl
         feU1fmx7q49+GfrPSPIhm4kR1y4XF0XFpnK1rpqDZKAtA/kk/9JtcKTaMahBEaikmSUs
         2oHt7gQexm7fcY6Un1ckluE6YU5jFB9XUW7JebEwBu7P7yUgvY8JqpzZM8n/6PxwMz8g
         NScY1fDoC9muh5ph+padpMj6TkNwobjvB0/H0224W4lnzNovtsI1pOaezqJ/CvETpYF9
         nCwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXD+mLxjkByw9qKnPRkwRDiHOGgwqSfDCHPcIQGfkd2ZCXgC+Nrq0JAf5czI+jy+5qcN6RzWhVX8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3KSf0HPf4Pr8sGYcEW7B2fL9WUdg6AXxnhcbOwhBmBxUNOuz
	Lm44K4T3y1ztazpnmiPg0R2QnETaVDQU1r8bPoUllKYVodN2yJL2ZwPteDAcEtMQdGxIWi54Thz
	G8aQjnw9v9khtZ3/pR1o43RPhrdPF+i0=
X-Gm-Gg: AR+sD10g7kATL+0xu8Z5UNX45Y+rbNsB89zsL7YgvDm/0rGWCRfSFEpJ165FTXz2lNj
	xPjvTXwlr+GhZWmnDaV/6PyyvqvXQdRNYrctPV0+3VuBpH+yZKGBQWEcDxcUcy2FLwv/iIdmv5B
	D2V4r3LJ3pFIBsk6mgM1HJpG70yUP1U5mZjPVYiP6Xc7pSxCbWd9yCVj3puQXQLFGq7HGtOHetv
	xzrTij0y1Z8p8sB+HIL9/6ZjUJ4OUJiO3BWrFzuV8nYucBROEJ03Buoij9p4ruysv318/eU2B1a
	BUNTGFXq9++dggui/k24JIfSe90abQFwa+ztuM8oXCtrtkkeWp241cNOmYv/lKwGMzTcyROzFWN
	mEUPBEENGEhTC5stUY+CyjjWbdCjCWnVNFMvgkOfr8lrgZ7JC8wCRIjoM9xUF8kTKbdtIk9zq0Q
	ZO1p9GHMK7o8KMv0ovyKNZDgHgw64QQA==
X-Received: by 2002:a17:907:3f09:b0:c15:e118:9b99 with SMTP id
 a640c23a62f3a-c212aa4d8d5mr37175866b.23.1786654069349; Thu, 13 Aug 2026
 13:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com> <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
In-Reply-To: <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Aug 2026 23:47:10 +0300
X-Gm-Features: AUfX_mxyuCIuM9CDW9EDDaUhKGQzx4uADVjgA0kwsfdDGNz-r1j6Xv6ENKsoR2Q
Message-ID: <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tduszyns@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 8:52=E2=80=AFPM Maxwell Doose <maxwell@maxwelld.cc>=
 wrote:
> On Thu Aug 13, 2026 at 2:16 AM CDT
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > -#include <linux/kernel.h>
> >  #include <linux/i2c.h>
> >  #include <linux/errno.h>
> >  #include <linux/delay.h>
> > +#include <linux/kernel.h>
>
> Stray change? The ordering's messed up (seems to be case for many of
> these drivers) so perhaps we can send a patch to fix the ordering.

Not really. I understand what you mean, but I took a step just for the
k*.h letter to group them. It's slightly easier to follow with
kernel.h being moved. Note, that kernel.h shouldn't be there at all,
but that is definitely out of scope here.

> > +#include <linux/kstrtox.h>
> >  #include <linux/string.h>
> >  #include <linux/mutex.h>
> >  #include <linux/unistd.h>

Thanks for the review!

--=20
With Best Regards,
Andy Shevchenko
