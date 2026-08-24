Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1F404BD6
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565908; cv=none; b=G9ySJVdUiL8/lbDUScmqfqMgv+pjryf5iQeUUDtLySelMwSQYFR3A7XknpsQwZ/ZRx0kwRvsVXjO9cwUPEf0cB+U3Wuvl3ABI5jAwyQ64VC0Mg0OvqG3ILGbnmUmWU0nE+zIddzSUbBjqWxilJBQQGKYDbuOMc9KGbQbcN+hchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565908; c=relaxed/simple;
	bh=4xoXCbNGlN10FuM3GEhNrlWFtjT9eS0prUXni7khHyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHPybF1OtXkM/cQg4RB8eNdlcCM8OS+/x28rKJOSlndYDK58BBcW5rOXDc3i8f6NOVsQgxz1sl/SvR0bB/JXDN95fo64h74w0y5YhMSFTxmniLrpTLztcIj1bAso12uL/Qa1EGEJ949jqDRPMKcfVHLd7WpJPJAncCsfVAI/a9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5ML1+Sr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5ML1+Sr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so4009710a12.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787565906; x=1788170706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DtM+Vfg2ZdicgqxpXz13xQspfer34F0/ocD1+tZZquc=;
        b=B5ML1+Sr2oKDRU6OhRc0KJZeHXX0UvqkP6I8x/y+RRF5mKwEED8j0wRdhJv4grW7q4
         YPj/EpoF+52PvRNYc/ii3ak06Wtwoj+ev8oX56A5QcupbM7/1n4LQiB0q3DqVD575Ka/
         OiPmNgT4yBXIkPAmKwONsg07Cj3KFYUagHkw4GpIy9IoSY9bPazDt++3zBFxnDjXOxo1
         LnkI1joggoECzco6nP2qmMu42kfC8A4ycM+APCFeMXBO6YD81GlyxcqWFKmRucFE05ha
         PEcPY4heeO8t/pW1kbqKSCvQEF8RHjq+0MbeamNrnIVy/KB9U30ZYqV00Ojq1F6VeoMV
         0M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565906; x=1788170706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DtM+Vfg2ZdicgqxpXz13xQspfer34F0/ocD1+tZZquc=;
        b=AED3M5IoQxugLeUNqxei1rPp5u4+WDj3gDM5duidrBXctMjhaazLnJ7RHNI0C4OnrM
         9SdAJSUtngQer8ZhjpGTakosFgzAc/TJgVfa1POArDPMGzghzLU42poN1K7gCEw5UT7k
         JXCQSE06MgzX1oDVKU56vE/klmu2itV25E+Sdh4zWiygnqrwyVwRwAVuqhGqbgwh0PKW
         dRRArkpXkk0HxcGvuDGxfESDOdEeJGPCH7ISKKqTTM8fzAEzba5/i7plUtpFVb6EW27h
         x6jYEmMexwIebFPV+hKgs607edTxNeQKes4Aq7eaYCFyMQ0N+agirGhYIRG1c0p6sTdy
         r9XA==
X-Forwarded-Encrypted: i=1; AHgh+Rpd6K1RtwzOQzjUK803YITKTcebfFWK36KSV5VA3P4t+66OQrXqjappIYmCTfpKekHEk/QT4kJKwhI=@vger.kernel.org
X-Gm-Message-State: AFuF++mRMfmRndjk9+H0wB7vdGmi1gQQDvQzgkqnhWPDvywWhGV7YrV3
	9ESrjjxuq52lB+hAy3E19wqadY6heWqXAspz1C/6bBJfe15U3IRDDk1m
X-Gm-Gg: AR+sD10w0K6GJ6WABhLMsl1bNPgjbMutqX8DaRE7yIxvfgogZp6UkHdQKVgI8pnIRlr
	tvrG1fLGDeYHgcd7tYCK+cIPAvinjmm2nuHhmEcK1OTZqPmLiCWzsDAdz5bLON7HMSBj0cGKyCk
	Ej+1OulBlIOrI27/XfDGhmZW8Gjumy5tueJlQDauLh5emblkEfOjRfZqcVSZZrK0IclNaaTs31K
	s0tfcyj8Vs1suIh/w+pjk5Z0V0mey2DjsCz70GzbyPQkBA+wXfsxOPWpBMQrdiVesbXfIDvfdp5
	EmtV3As5KcwYPHf5wyPXgFqX5alxoU1ia3xbRUcQfRhsZW9Qwl6CoL311B2pw1JGdTGQ7Pvm3nc
	gnHBVnmOuQP8EVjsHwWVlcge6VGIbSDpITey/Pw/BvLeOcnnEUl/39Eg75XnbcQ18OahnuolIji
	u7mdzl4GjxV76ya7j6rgn+zFLxpIB2STo0EbNbX0a86L6KBjtJMVZ5iPOw/DxQ2DQ0BDsUtJIE2
	yi2Rs054bokh9xZhPls4fN8f1LIwBw4XZFVpJvDCUElDQsXFn15ps6/AD9ODamUqQjYpd6bH+4x
	qs+jsmq2zLt5NQI9g7DhoACzT4I0agYiDBehwUxNSIhnnSDQUBzwCwz8p0am24pumdDD2qv8gbU
	CXQeT9zq6AaghQml4AQCkOmbT6519WQESPYxKq6riGDq9/E0OK3XW8O5DW+uqgEbCoE8ezg==
X-Received: by 2002:a17:907:e001:10b0:bed:9a7:5ed1 with SMTP id a640c23a62f3a-c246a30f3ecmr1964088566b.5.1787565905638;
        Mon, 24 Aug 2026 03:05:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968ba7b6sm1127221366b.62.2026.08.24.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:05:05 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:05:03 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rishab Madhugiri <rishab.madhugiri@gmail.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
Message-ID: <20260824120503.00003500@gmail.com>
In-Reply-To: <aowVI_n7s0VAmN3D@ashevche-desk.local>
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
	<aowVI_n7s0VAmN3D@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 12:55:47 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> > Replace deprecated use of BUG() in default switch cases of
> > iio_get_time_ns() and current_timestamp_clock_show() with
> > WARN_ONCE() and return correct fallback or error codes.  
> 
> Why?!
> 

Because BUG() and BUG_ON() shouldn't be used anymore, no? Linus himself
said that he hates the macros.

-- 
Kind regards,
Joshua Crofts
