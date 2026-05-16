Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D54405C53
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950668; cv=pass; b=Tpp/3hdrEqTenODmYBzAGX8asgQt1djlNq0ouAhCQi8Uy200nc8e4msRpTulopfbEoYgjtI3s7XNr2jUEQj8pZdXTmr4y/M22RgER5ubja5p/C+przwc80iTroFDrDEys1U0FUp9k++R2t9MijGZoWTGmy07aM2QKJrQNs4bDqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950668; c=relaxed/simple;
	bh=YhsGto6x8mACdIV4OuGBKAUaG7CXqMeWB7YXN0STD0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYC+Y5eUH+FKPYcCoegU0Qnk3LQC+sUCX4QESwinNcYaxEObp5zv5OqmTaEs9fhHnUqKYPEdQVMjnqBykpsPVbxlM8O7ZMwYmgGnXotXxrXmGkyARc2XV2I6wB88mk0btu6lcLFAIeFwJPwQfeb5ZeS0alHYdnSTWm4nKm+9HjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+RwZDlW; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+RwZDlW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b150559bso6451205e9.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 09:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778950665; cv=none;
        d=google.com; s=arc-20240605;
        b=jqfoYdZMUNmlylxhwC0ZtU5Ly5RJL0lFEdSIwVE6I+iaWh/aiTadtJrSwuKNrYo/d7
         GnhnMnOkwsihuHV/QkWw8yoV4s+BbH9Jwmy09DhvcBZ9uQKFUeMQQscRljOFnHpPxU8+
         3ZTfurIRXkmaVV4uNWkpNoyy54o5mmoTWPZ8pdj4OUUbXvXF4xsbIpsmkdTV2rYbravA
         xFzUy9mvRxDmFQVtl0CscrKL7WzhXkqG3tRkWSK9LVdZJ8YKlSgbImz4jcWJqmim0nh8
         KrUg6n1Un7G52NSNLEbNxkaHKvL/KqSn/MgGtXfoJpqjvqUWtU3R1W2Xm9zxZBixMPx0
         cKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WK13bDKIPXJVw7Na8O1xTLghzEiMpkVxTdoE7IN2/88=;
        fh=ol/LUulWPhnpcZea3ctciFs7DK0i3DwN8uUMSN1c/ZM=;
        b=IkQZA8ZpwPczelupvHFuFGonxVR2KrRgfGXeRrmMttmyO0Jx2ZjEnWp2AuMTKi6Bde
         7BrHu7J7sQ5QQCIHx3Zxp1HavJk2cDj3d7io1uudAhyE0Q6f+iSLfH22Oo1FOgXd9s+J
         1voj2+TkaqtlUrdTCZGezv5yEKalAqKd6upsbepQf7NO+55AD6Jg6hfvEZp+lpXm0o8k
         X+FBIa4Vbp7DHVLo0/0DGghqHZoyTGHPL3ai1AN70gb+lqF7rR+ujXA79a8+zVHodkjr
         0Uinf0db+bsgrtIASTD5XLWu84IG+/g2aF6vZ33uQ7HZV5e5R0lWQcUmWWZ6xIwPvRDv
         +wVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778950665; x=1779555465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WK13bDKIPXJVw7Na8O1xTLghzEiMpkVxTdoE7IN2/88=;
        b=T+RwZDlWYm3IC+i+PqEn2nenQF/CPbk5unOiX+fwAFVUeMqJZOXoNfXuD2BUDOW2kU
         5vhnuksuH0PT0nixPV1u3nw+SqvLXTCp42wuzvjdr8sqzokf9wudbHAU5W56/n1e4BY7
         GZR2+zEkEAHFpEwu5dZ8oITfpe5XB2I1r8DnZkPbJpJhmSzOkFIs/hI8rXgAo5fENjzh
         omGg1Z29tN1+j++i5orHUn0NrMl1b6H6RWcGQUifwybf+709IFe+JAZJOU1XcffgAa+z
         sy8Q7iRG9ihVipZiAc0J8jL8FuYOdJa6Vrl0jRtghaCT/Z6Ing6zi16HT2FCiKsSbow3
         w2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778950665; x=1779555465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK13bDKIPXJVw7Na8O1xTLghzEiMpkVxTdoE7IN2/88=;
        b=soUmvWg6tifiv2CrcTHdnd7cjjabeN2npL96iBbW5wG9c5k4P89pqm+RtaiGhiI4+K
         52HZdvRVB/pFfwJ8kIbWtKPDnOJIT+Sd36yrM2cPg0GTwGNdn8PpZGD8pTdSztPOhYFA
         5BdgL5/7SjHYkJ2CvYAm5nNpikZLqdNDQlQvUrvR8afK79gAdjua2jsXjqb8lrB7qQsc
         zWbJKTQKtBUGXdzaAUvgnuBRehN+zKHQhxOtjoRxq60s08NGQxZ17FZ+6zUGnzrsMMxm
         OLRtJh1R9/nVy9bkwXXCMA+gWmWIXuGNw1Eqc/pl+t3kHnajJKBvtcIcsvSOA6l91/T6
         neRw==
X-Forwarded-Encrypted: i=1; AFNElJ+Q615n4Z/JZhplYm6nOT20VD1WaLMS8myTjXlYQMWj0pUIiX2mNivUROedBEx3DFHZl+BfLFT91f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsDRK7KorYtlzMsgfeDPqZuWcJlaDAIw4DrXckitvyOqvXh5X
	S4kYpbzNgJTK+BLRVcKBOoLtMxCNWV+/EgeLgVAVb9njfWiJt5UTIHgNo5/XKkaEKzunNHvbZj/
	GR/3KO+b6fLlJHL36+MO38ZmRmozoRaQVgbvX
X-Gm-Gg: Acq92OGyZCrbQLY5OfC3Ou2gq/jRUxbFkxuQdAOXc/+dYveWxt54vEx+n7BGhB2FIrZ
	YM16VcMefAOzq8P+TIemO9IRVbbFPraWSziDSIBhR3jlwojL1MMcPb7etiiJIJhX/36h4d1cEgd
	mX4IShqVl138qcqiEsfO//bcgluICHvekC7zWMudi0/12HgysYJrxXCukqH5IxDShZVrFQysvB3
	itex/mlduCclpp1Yi2PXSRglg5ME7lep4JvkVmg2mDqslDeQBzZm26bgWFJ5053GVRwYidkuWX4
	BI0OehXuRAtC3GrQsq4zufdSfb4s7M8uXl+iN6n9UrZIHV41Pzm4H3PnpQv57m4j0sWjMwhmQob
	aqvDQUbbvgxCwtJSWUNEGzy478cgCvEyoPtDV3kTuAgMA2dPGFQ+k5z+m/JL1N6N4PNp8BhhtWl
	LFnlMIjOQ=
X-Received: by 2002:a05:600c:3f1b:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48fe60e7fa1mr126687745e9.13.1778950664838; Sat, 16 May 2026
 09:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-1-8018cf3a8a0a@gmail.com> <20260516125628.53b90c7e@jic23-huawei>
In-Reply-To: <20260516125628.53b90c7e@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 16 May 2026 18:57:33 +0200
X-Gm-Features: AVHnY4JGm-oISWVHZdE2WgHHbl_W7-cqX9ldIeLyj999zLviahatFuISg3GC-PQ
Message-ID: <CALoEA-wakxKH8xKWvPWED1Afh0vTKASCOxsKYWF9ipAjBAytjQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iio: light: opt3001: move device registration to
 end of probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 May 2026 at 13:56, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 12 May 2026 12:57:21 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Move devm_iio_device_register() to end of the opt3001_probe() function
> > to prevent a race condition where userspace could interact with the
> > device before the hardware IRQ was set up.
> >
> > Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
> > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260511-opt3001-cleanup-v1-0-f7879dc3455c%40gmail.com?part=7
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/light/opt3001.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index 53bc455b7bad142695d9fecc6cabb934fb3ace0c..3c79e0c4ca32fedf33e318d047d6ab3f62b6c03b 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
> >       iio->modes = INDIO_DIRECT_MODE;
> >       iio->info = &opt3001_info;
> >
> > -     ret = devm_iio_device_register(dev, iio);
> > -     if (ret) {
> > -             dev_err(dev, "failed to register IIO device\n");
> > -             return ret;
> > -     }
> > -
> >       /* Make use of INT pin only if valid IRQ no. is given */
> >       if (irq > 0) {
> >               ret = request_threaded_irq(irq, NULL, opt3001_irq,
> > @@ -894,6 +888,10 @@ static int opt3001_probe(struct i2c_client *client)
> >               dev_dbg(opt->dev, "enabling interrupt-less operation\n");
> >       }
> >
> > +     ret = devm_iio_device_register(dev, iio);
> > +     if (ret)
> > +             return dev_err(dev, "failed to register IIO device\n");
>
> Sashiko correctly points out this won't build.  I guess you were aiming for
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to register IIO device\n");
>
> My eyes skipped right over that whilst reading :(

Yes, I've read the report and it should definitely be fixed, however
it is compilable
on my machine - what an oddity!

> The devres comment is also correct. So given this is a fix you can't do it
> like this.  You'd need to move to
>         ret = iio_device_register(iio);
> and explicit iio_device_unregister(iio) in remove.
>
> Then later put it back to devm when you convert the rest.

Good point, will push out in another series.

-- 
Kind regards

CJD
