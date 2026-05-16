Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062652D97BA
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951111; cv=pass; b=tsXxw5t1HTzdfwpzzNsQoHSiTiZkZyB+kE0fFlY4nmBnbAlqWfjeaZW5gsA1co5HawPooZxssOjGXFRhzUPJjQgAoNsutY3/P4dpNcXOzMxoT6mXskkdGEarUI9vsKR/eHYg1BOwq/En3KLJo9gtrhtCn/abT2uQvI6yqpeZQwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951111; c=relaxed/simple;
	bh=Y+jDq82jL1Z8n2IUfcIILlMy0Vj6CqQTgvIhLkj/ODY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4y9/oCPdgkxKzIzaoElwNY352MNy4RlVtaUYqCjvUL6qKUZYITVFntRwaF/rf6yCwnTIHONlyvEGAXz2yZjlpmy1vR7kgfrreu2JitgXSR5gE7IDcjqiw0K5pkjHe7gAwx+qcoFzjj7wjgCiY+51fOSY2+fojALE9EN4IFSfmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX7aW7eT; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX7aW7eT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso10416645e9.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 10:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778951108; cv=none;
        d=google.com; s=arc-20240605;
        b=a8ictxGR1ceoUzAl5o4ZezKUyrqSmqJiPCLa3BDyNpCjHYqjWepjngKeocrYdhvETw
         KQ5XtWZnvWuqbyT+IWuspc49amOOxnBClv8s/533rXVVq8W6jc4IVq38jyo6tWX3YpCv
         cGOZZzAzHpAe9VVBQWPvjWJprQ2tAClUZiKTQzK8+enzuLojE7S/tpD0bUDrqKz5vhyy
         eNy+aSepSnoWseuIRMi5kH+xltKVG5ysh3jN85iC48iN+INy2xHfD2Qzl8hz/LAlgKsj
         IATLlbORTWwcNLBFAyyr9wCoRGtdguPo/5euctK8YFCgi8wQH0X5IDpwMyIIn8NpVgqR
         8xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r+QiKQ+ENzghaBs6mB+ujok5fwAtrRNePEuyRsXj8kY=;
        fh=YKuHY4fUAO7Uls4j4xiXiGyfCSxRVtV0GHSWX+KpCc0=;
        b=WA/NNwIIX9eDE9dp5cxdSFw1VF1AzvDEu0K0YHyQ0btxH+fzhY6Bux32Ri+jL7QBHS
         CLp/44G5v2yDX0UO/GWX+QljsNvtEYMyKpjnUutfa5t4NpuVJpgwYfSxLNXTa8W3QQOO
         CbppUAbja+QnD/i1usl2ouTAGYfTng3jGg/EenXJuyF+3a2zJxsUMrsMbrlGFw+SmMDD
         Sqsor025gg1zqeF7QxWGy4F3wk6JZKpNmCkliQJHElVECeHXHgG5vnlIWI8L9kG1Boar
         HxJ5F4vl2h/5dM7rs9y6tLkoyjkicU8sC1qFVw5TnVnQd7YwJRNqU/xKIL7yUsntKHG+
         AhJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778951108; x=1779555908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+QiKQ+ENzghaBs6mB+ujok5fwAtrRNePEuyRsXj8kY=;
        b=jX7aW7eTFst9Qo9LS2hVKn5TCa+gBNwPG6AbXOEG7FEoM41jWdumNPLBTtUH0A3DWq
         0CKHJDUDEOcAGodGrrZ4j/gPSi83qFQRrIfoP7rwtK1oyp1ZIxVXalTvI7pcmaeoFQMl
         fcVW5h1NU1tMK65pcpTr6Z+/R1qhPKiROI9UtRpQ714yXcG2k5GXO/bngwqoCeJSCnK+
         /4mcnIuY+UBNHXBIVm49htOkoRpTK8cg1QYY/ApOjN/Dkmx6jU9P0lZtOb9XV6B/97Iq
         /GsQ9bAYYyMFOFKBg9qKwLL933QPdimoE219hs3AnqS5yb8mOeAu/iqqxevG7UvfZ7aG
         5ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778951108; x=1779555908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+QiKQ+ENzghaBs6mB+ujok5fwAtrRNePEuyRsXj8kY=;
        b=PHd/ao5m+OkayHmSKPqNbDwthMZaHTR1+dp/0K1fGNsCt6IrUyZKwk2V4eyV5brs3h
         +NEneoPVHXcu+EB/INSKOk11JL9WXmMKsj2nesuTOWvlTtA7Agu0Pr2vb041U2290H1Y
         BvEm7z6aDMdg4nUhcjSpKeTOuvz9n68lrLFPrk0ZQhgH35huGOzHM4AA8y7EOy/euNm8
         CUziFxgs+Ca5xwVTO1ZrN8a8UW8wszj6HkckGYFu5K7d3bjT+xsFv4pTPemvszViT1i3
         Mbk5biQvqYYBb2NkV4PTeSngBxgD38yGlpVX9whzoitkPRBL3zrYZnt7QCkyNho0EX3S
         nXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ93DNQ4Bi6KplYXCfzvneMEkOP58xckJ0S36siC8gpDIrYlM2GqGy1SO3ODiM6EEg8sgt0nGYY0v/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyPyP09Xcl8h64vuYfc1/YYpKw/GzB4GlTL1kSM/Fy6bYBVHC
	oD21PQvTdFqc+l2lGdd1jKalX0eKVvu+mHIHJRdcqzpp0jYtGhI1OEE7csUgQ8POyGeqChGC0FP
	l0uUsDNrhHZIHwOhS40HW9I4PsGZwWTU=
X-Gm-Gg: Acq92OE29ftQtpcGDRqI6giSerPaF7SJ9odGJS+Ti+5zHx9H63MZCZYsiufUjpvbOkn
	JKZg56qI4to+cPZ8RPjhtEoSPf6iurrqG7BwqUfRh9mTjj6PShACHdMARBmZsWN39XssDRut1yw
	B1nBQOPKOYfA3efPXlLiLOygTfBhrR8Qst8JGbnx02Fg805S6k8+9rUvvzHvMgLIn82ohkOJHXT
	mu1KX6sgeo3C0Z+x5l70i0M319Bo2WVDAMrqIOaR4aNq1gFqZqAIgp64RxWwWf85CN4irdIYeRB
	H5YbGf5WeLfuXvSyI+9AQPvk7J8GuAXWp9/LGi8Mwz43I6ykekE0DPnYhYgDkxtkiMiXj2XSEcA
	SchPHkaZ5Z2dKK9tzaEbXOX7o4HVTC7lzyegdorTnWPOboXBQzM5neQ2k0Pp+muHVIHm9QxnDMQ
	8qYriBlFs=
X-Received: by 2002:a05:600c:4fc9:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48fe60e4794mr114945375e9.3.1778951108113; Sat, 16 May 2026
 10:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com> <20260512152600.764ff7c7@jic23-huawei>
 <20260516131017.3de30733@jic23-huawei>
In-Reply-To: <20260516131017.3de30733@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 16 May 2026 19:04:56 +0200
X-Gm-Features: AVHnY4KPTjvUT0SXQ5tAIw4o1dQv1zYydcxPl1PHNzcRRZ13JECf7PZhB6GweoI
Message-ID: <CALoEA-y+1zgrjA_KiTRJRiJepHGb3a2_kHfdJPa0VTPdopqtCg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 May 2026 at 14:10, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 12 May 2026 15:26:00 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Tue, 12 May 2026 12:57:29 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >
> > > From: Joshua Crofts <joshua.crofts1@gmail.com>
> > >
> > > Move the driver to use devm_* functions to automate resource
> > > management and simplify error handling. This also allows removal
> > > of the opt3001_remove() function.
> > >
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Some trivial stuff inline.  I'll probably wait for sashiko to catch up with
> > it's backlog and get to this one.  If nothing comes up there or in other reviews
> > I'm fine tweaking the stuff below whilst applying the series.
> >
> Sashiko did come back with a lifetime issue.
>
> I think it's a false positive as there aren't any workqueues or similar
> that might still be active. IRQs will long have been cleaned up before
> the mutex_destroy() occurs.

I would agree this is a false positive since the request_threaded_irq was
moved to use the devm_ counterpart in this patch.

On an unrelated note, I also have a first version of a new driver I'm working
on, is it okay to send or is the workload too big?

-- 
Kind regards

CJD
