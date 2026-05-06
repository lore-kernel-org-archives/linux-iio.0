Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C830B50C
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051154; cv=pass; b=EKLEY6ptZepMRrScF2/YhIxrKUrphNvkKWf6eE4qQ8JFTI2KK5PdMVWDn5uvYurN6fwt/KqwT3skwfZXMhCgEHfYOZJ0trBk3Sc43OfJU34XlLF5IBGYKXnOB8SHtVMBrmvAMDC8A4UCXjdAxj82TW8eQWJJ4vxgsxz51ewAabg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051154; c=relaxed/simple;
	bh=OjsHFd3aO015LrwOVCOQvGhW/rg63n4acZpZt3pFnMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WST2Gctb3hu7aKMyh56nQO2LE4Dp6KaJmKkLWz6W62+NSRZn4VJol0u3ovdU6MeAK4uH8NXAHMJbOIfruiivRd+9luy81JxVr7vONVQjbj14+Ny4LVljuxJhSzuQQAwMTdyHqsYfJ65LOnFXAKTO1kTKUQ2qNhdJvgXBqtnir00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNdvoX37; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNdvoX37"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so86440375e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051151; cv=none;
        d=google.com; s=arc-20240605;
        b=kKwQV5B3Dg8eQm7p8m3iXMI5BwlI4U1sNaGaAPTioZ8UMuuNuQSn4sJeWJe6LoWjn4
         MNEk9w1TuHGQjANWONo4Z4nyqmqaPvN0PgZ87Vd7cDDYFUD3H8JzjyiLjTMs4TYkNauK
         L0yktxv20lgF3YkUvFSwBGnVP/5E0HvZNcz8zJPTjOEfTmluXQ84yBOv+K9VvxoB7pyF
         pq7fRa65Oual8p4PwENDU++qTDrK1XImIMAXt1Nml3bP8nZv6RG0cOqjrzBlOWATqKK3
         C6b/E9Mn6ww7puQna7oXqSKN57GN+GvqVF7jReWon5dARVUszxL1+ewTT6Rekid3lZWn
         FPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OO0gwvgIsuomeSKjunFh8e8J6h5oVj5wtNRg56K7XQY=;
        fh=ndIc+Mdd18Xta0qgcLYwIl0MYq3pUx26RF/S0HPx52I=;
        b=fvgvOvO9sKFIPYBqsFTMFxRAGaHiiH26V+PVasAtQ9v3X2tYpsATi+EA15FsdHlG8g
         DToKLoDbJoWkCDJZuYqp/BYwei2D08IdCxpt5XnhQe8jgA7x/o3UJXiRWO0g5unfEPHK
         kIeAKeTrYMeT0G6Zqnd2tu8oyx2CkGVKww/PKS3CsjfRjbhjhz0Atq+aBFa2EfPtHGUN
         jRUiklwL8wqvy+7xuU3SGtW6CJhnbP0qo4KFGoiZCWYXDrFGyBxhdgDEek1CdgTMcd0e
         QVeJOe1rFXIEDp3fPxFiyKKfA0nFnuxOEpv4Kp/D8TDBrVNHrXJO60UOn7BLxOKl2rda
         NzEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051151; x=1778655951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OO0gwvgIsuomeSKjunFh8e8J6h5oVj5wtNRg56K7XQY=;
        b=lNdvoX37r0Q8vs4lYrPxdy4D6t0esd+9P+w0i3x1PQDdm42ixDdz2z3zxmnAS2xsl7
         qS3eZXvMGB1LneN3pZWKiVB9V9KigPnwrYWn1Am8gqQUT23VzMDGebZR3kkju5NRKCw6
         bYld8zBTkrHuCFH1iEF4RwY5Q17JmYOKFhjLPdgnzM4XF5SrKZILdrLwjxa+bMKdNlLj
         s4PG/3a9LUs95VO8l1dgmHeq1Gd9A5YKfhbYKABvBL1d0ZUQ3id05IPzmL2spMpdJy8e
         hGgGrilSWxieECSXxP6crAs+AMpfM3olNx5831fpkACZ70Qp/YwVEYVAq/ZG8IqMA4dR
         r9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051151; x=1778655951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OO0gwvgIsuomeSKjunFh8e8J6h5oVj5wtNRg56K7XQY=;
        b=etfDfpQwqo015xJFEu5oyh/B+XqvcFjQfcRlaWw7bdkQzO8M45g6C5IegytL5Bm/F0
         FfrwjSdJFsjQcwug0Um65wD5aHglt4kmui09B9H9Z5wxTO5n3Xp596zUFxgTNMuH3ufB
         ZQiMPOgo7lX1ELUwOH8JqkE+XZqKnADm0AYferg2ORHctpIrRKwqxwVqPxoHCAEK2KlN
         NyAFPhmKF+oas7ZlqQ8Gvx/p8Vl03AVs7kjkvimsGRWYx8zYdnxKuR5E3FxPqokBsIZb
         8sVC6ZEfieWm3lsLkWNIA5ANvn0LOf3Xk4h3xxk/cNdQMhWtMcwRBd5727Dwc+jnzKDO
         9brA==
X-Forwarded-Encrypted: i=1; AFNElJ/01lF0K4IsulxqY9shpyoaQRq4VJBDL+SYpS1yfySztjGTh3TsOColks+ThUt9/zZvxgAl5tfoLfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIqsqWrSVi1PagXoRGoBEqRb88D0bK0U7fy30cPSS4t5zX5dN
	vZYGVZqrOqPOb5pQMxqiz+iWEG8PA9dxSpUfB0w5IxGy4ApeLbF6JGsonIMxscPEY1bu9nNVkK5
	FEQUB9tNX2sezDYgd5LFGO+GYNLiB6LM=
X-Gm-Gg: AeBDiesSD2doy/p//JOgzs35ze3chpTkSek1Nqxl324jOj9EwQIn6f43kf19pWhA7NZ
	QTFuLxjSU9vjioYrxXezGimDVZmz6AgynsqUVJQT9aWhOkjyfEW55am2rtKLwsBTVN5beJ6caOe
	3VM4MSqjnKEX6iSvkqGEGC1gCq+j6ZCHT8GmjQleyP63JB/qhJfAT85EsX4gg+0/81Iia2BhA7B
	zMjgcYuWcE5njjHMryZPnBrpXZjQws3A245JMMXlCvOQgmtvNBYOGSG1QEOfiUugm9j60BVDLsC
	M5qU5WeTD+MX7doyojykr0ob/5yNomdOcxicY/zAGdsRjE+fTF8FiUO7UuwG5CSEsWArfrCjwI+
	TPGMLephVg6OCUGLiSwnFyX1E0bLoFUMjiOMHqrm9dWTUUAoi7awcWNPQcbbG+ZSfBwlwnUaRiq
	arr8qzn2Y4r9R2jl2X
X-Received: by 2002:a05:6000:2d05:b0:451:68e0:c978 with SMTP id
 ffacd0b85a97d-45168e0c9c6mr2197966f8f.0.1778051150694; Wed, 06 May 2026
 00:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
In-Reply-To: <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:05:39 +0200
X-Gm-Features: AVHnY4K48-o0k324MqvPHLfFYL9gMvVE7_PFWKkRlXJtHXzQce-b98Zt0es5BnY
Message-ID: <CALoEA-xjRYTHT51_nh=jL4AOEu7Y9w+6hx=fFq_ZaMdcLfG7eg@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Maxwell Doose <m32285159@gmail.com>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 03:09, Maxwell Doose <m32285159@gmail.com> wrote:
>
> On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Add a check that ensures that valid data has been read from GPIOD. If
> > not, log an error and return the negative read value.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index 129c98c97071b4cf8efa3abf2364a3abbde129ba..b3caf5f3ebf29bf701bb214aa480fa7afb2651c6 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data,
> >                                timeout_ms * USEC_PER_MSEC);
> >       if (ret)
> >               return ret;
> > +     if (val < 0) {
> > +             dev_err(&client->dev, "Error in reading GPIOD\n");
> > +             return val;
> > +     }
> >
> >       ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
> >       if (ret < 0)
>
> Small nit but I wonder if we can change:
>
>         if (val < 0) {
>                 dev_err(&client->dev, "Error in reading GPIOD\n");
>                 return val;
>         }
>
> to something like:
>
>         if (val < 0)
>                 return dev_err_probe(&client->dev, val, "Error in reading GPIOD\n");

Sure, but it would go as a separate patch. Given this series is
18 parts long, I'd rather get the existing patches merged and
work on this in another series. This driver still has a few shortcomings
that should be ironed out.

-- 
Kind regards

CJD
