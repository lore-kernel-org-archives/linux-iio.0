Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FF476689
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062282; cv=none; b=AZsgEmGddZpva39VBeaHKwhNmJVVDuKF0p8HW7qBFKdJvavZKuv5fEqa6rXXBLTU8LxN2yGBg0FQL1z6almddUkX24YiZaMHBygLu2d+AekMean2apgKOzEf8EwY6M6PQRgJD1yEISeafRReg3qZSyv/tB791sH5OKzXZYKJKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062282; c=relaxed/simple;
	bh=FVx2/MBTsPCiR5O1d2m/Ofot4sfwNxdwCH1Jiq6p5Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g79TkbLUp7dZWCTkV26P0tVtp791BGcrwcfQUS76JQmfHdsr7X00ESA9C1tQB9rihy5WH3xmKQ/p/LbSgjMbMuzIEq18Igenko61KQhwRwUJZF6shmBtygnKNImP8dJj3SFiOrzOFG/6w/8yY4Pcf2x1Qx9g9MN6bvU0z8Wf61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS75BY9A; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS75BY9A"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499840a2575so35401735e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787062279; x=1787667079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gmJq5kdfed99Tj/tN4LBJ9nKv2g7oPVCdjFvdOWLjhQ=;
        b=qS75BY9A15vzJ0t/BfzqgnhrrUTlbCFBt5MFWSkNBajCdi9P9yBV97HbtkdJo85/m7
         k25d4PIvaQYZ/nivYc4w4/vSUQ4J49xPnibkr97XkPJBBW8c4FOP3CHJ7ADOXrwTzmbT
         KtLjQ6xFrZUeKLK9WLJJ/v4RyoB+VDIt3nOqOrtkMSGF16owDdc81t17fx4k543yul7M
         YsANAxaSSEJm75gd9occMS7E+2S//yMZHSkHK2ualJNlDj8IPozXoN5Hh7YEC3S9Nq/Y
         J9qhi/WzxgrU5cfbJt1N3oD3e8bIuDodEKnX5BFsZ0fKhuQ/vauti+KbTz0KjzJfnKNw
         lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787062279; x=1787667079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmJq5kdfed99Tj/tN4LBJ9nKv2g7oPVCdjFvdOWLjhQ=;
        b=JR+NRhSMK26jpF4IE7JJzcgsHvT3p1UcrU+FNmIZzRkuAqSbu2fCjiQU+8yA8Xs+bK
         IRLOllC7aeRzz6cX1Pg9tpE+UJoq49oTklA2CgoZczY1VAarhO5i7NQlpTV7H6TUgwa1
         f1vT7DIyvmNvvkemhgwBu+ZT47yCkRLrLxjUcKIrvvU1tgkDi9Ws+y+lHgWLea07Pqrt
         o7xs2U2TyGbCWLcDLumwOAvks3lShF7+0vElpsteaZe/UToDOZdTr3Q9Z9vcsN70m0z0
         bErzvUBa8QsAw7O7oFV8zTqgsc//DbPJ5jZZjAs7KDh+5A09pu6wHZ4lZjL97BhKJvhk
         8ImQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLYw5RiDfZbA9rirzUxhNO6Zokgfx5UKe/6dN1ZHwNxswRaP8zodzGAbdUjeZUtOkTTaLLL3bsKos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqMbzQcFlMUlVivIaNt5tau2fR6HfcUufuGwA5kOK73VSrFr2
	iM3U6hJbh0HzxYAGUXleFM6Wgw8GQCb82tSBDH3Q7n6kD8vjBdTeD+MQ
X-Gm-Gg: AR+sD12SZx8VGKkrvHoE/MKY/ES9nbZBty2BMPMiaxyZmourvMgU/0MY1kRjcB0XL0k
	NbUSCvSMcmS0bLBeHjdmKVSEbAGMFpAWYUSBjUnefcD+sIdpjzaibcCKxVV4125PdiVIhoJ2o4M
	hTeJ1ZQmGbWMapIOOoUPuSaA3TrnavoV1TMbH1HiyVDEBAG7N3NjaLXmt5WsoleFgThN5Jj9HWj
	gbqpNAVk3m9+Wn06asgOrZXj1KbUyWq5jP8RFjyr+yzDuxheSAlnGdl1M9VyuhiiLbAPVHNhpXK
	HHb3iYmwGrh8HZUUBY5ShgbzO/OKpKjEPnA7O8pR+YcLiYLiUqGBmQPGm+8MJ54Ff6dVg9CHzpn
	koIbQVfhxFrwsV3tR5U/g1bVt37znM9N+YyUnFL78cH6iYBvQilwmbra7xlzCgR2AHMUE6NejYQ
	QcJkodUQ+Ked0FjmYQ80Hl7c5gEjbnAUm3yGqZE3IVt+G7PLiKdPOie7aMtgA125tLu1I/iT6xt
	bbxJ5Ev4q129kUSLM/mG3FCxjvmhONmxxI8JCgxaNRFGqMWewzl2bhLyUWiiTUA8vHbkoSeBjqC
	kpMScMdMNLET9oacje1u+hqSA87cxmd1bLy/0CjLQ2X3CWo0mx2xaG++JPFJczwu7DL2b4ySzIc
	PvPSOeBul7EmzP+QwAE80utOB5foIarlugP1ALxTv5D8aM7VbRKx2Yg7XuqLZ3AJMEMFiKw==
X-Received: by 2002:a05:600c:4614:b0:499:858f:2653 with SMTP id 5b1f17b1804b1-49987929193mr356449025e9.2.1787062279156;
        Tue, 18 Aug 2026 07:11:19 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a31543sm13183148f8f.4.2026.08.18.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:11:18 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:11:15 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>, "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Marius
 Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Message-ID: <20260818161115.000067a4@gmail.com>
In-Reply-To: <DKRGHVP0FO9A.1VS4B0R21J97C@maxwelld.cc>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
	<20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
	<DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
	<CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
	<DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
	<an7OSM04kiviu9xL@ashevche-desk.local>
	<CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
	<an7W8VKXrIKzl9xt@ashevche-desk.local>
	<20260817035414.496912f4@jic23-huawei>
	<DKRGHVP0FO9A.1VS4B0R21J97C@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:12:56 -0500
"Maxwell Doose" <maxwell@maxwelld.cc> wrote:

...

> > Absolutely. One patch per driver for this and not more than 10 ish
> > drivers in a series or out for review at a tiem.  This stuff is still quite
> > tricky to review, even with details on why each header change below the ---
> >
> > Also precursor patches for any significant reordering to put them in alphabetical
> > + block for IIO headers just to make it easier to read the patch that cleans
> > up what is included.
> >
> > I've done some of these as have many others. It's worthy work but slow to
> > do!  I'd suggest we leave it as a newbie task, but it requires more understanding
> > than typical for one of those - so if you want to take it on (probably take
> > a year or more to finish given review bandwidth!) then that would be most
> > welcome.
> >  
> 
> What we ought to do is start by removing all of the kernel.h inclusions
> and then we can go into each individual driver and do IWYU on them. Not
> sure if we want all of the IWYU stuff (including kernel.h removal)
> rolled up into one patch per driver or if we want to split patches into
> kernel.h removal and then IWYU (hopefully this time I can get iwyu-tool
> setup so it won't be *as* gruelling). Or in the case of we leave it as a
> newbie task maybe we just add it to the TODO (since this is probably one
> of those things that happens over time when we revisit drivers).

Well, removing kernel.h is essentially IWYU, as we have to include the actual
used headers we were pulling in transitively. It should definitely be a task
for newcomers, nevertheless as Jonathan says it's not exactly easy to do from
the get go (and automating it with iwyu-tool can also be a headache). Also,
I've had a pretty good experience with AI when it comes to verifying headers.

I'll probably send a series removing it from some sensor type subdirectory,
just to get the ball rolling?

-- 
Kind regards,
Joshua Crofts
