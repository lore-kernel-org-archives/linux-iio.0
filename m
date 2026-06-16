Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF645425CF4
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604143; cv=none; b=saGJ2EMq4tfPIftwtdMZD7r7C5xsDUy/ARFSo6kNcNcX0XYSas5R0SfWPV2MGPTO/a7oZewNynsWU2BvEH0NKPMSypB63o9o6CYwocMhfU2zwp5PJ/tvJ7rJEu5YGdvUIUKPoyusA8QmpalDfroh/i36LjLWEDQX68EdO7RWxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604143; c=relaxed/simple;
	bh=i6bosY+B4cjxEpF+3mF54+/6GhbEdLbvsBZzhRr77h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6dSJPnkd+dKmKr2EWno74U8882O9TCzXuYQS5uEIra7h5UZO6fO+pAbU/Bn9VuQfDJUuDNqimxBNfyOsnzjJ6yC7Zv7jxtDXpOxKhCHlGSnIiXaP90C41gTupoxbv3XvTmTmzHvLhCj5Ht/mly0AQLkXmwIrws3zclW2ScbO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzZ2qnph; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzZ2qnph"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3220913f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604140; x=1782208940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FBVbbNx8x7Z7B6UeBxppHM5awP8f4QZk9Bz01k7j7Ck=;
        b=MzZ2qnphnZqNYYwXMoNMy6nzQZ1lvgR+j3BQ0zONFNYBdNFEg7wdx5htUMPlyG5bjl
         lqnpXhdVjWkbn10wfaT7k4Gl+G6jCF+98JwcNbHzPKn/3Iqgj/+kUuI3ykHoFMcdFlhL
         ERUJA4onEBJZBqA0BQTsnI9t66WBl3F7xs9q5cVICOfOzWdYoL5rYYDYYlN/qi3gaDUF
         VsTDlsK8QccCEyEnYyr7g/Q6RB5vPmezAcm+mYmApjCWzrBYdDpCjrEJfQqGAMqO4i/S
         8ze10wVYdHNDiTg+ld7LuBEpTaQW48L803OS3ImRQnxCk0bLJXn6RZIGgO71aohf+5ZY
         yT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604140; x=1782208940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBVbbNx8x7Z7B6UeBxppHM5awP8f4QZk9Bz01k7j7Ck=;
        b=qdOJzpLThuNJ4uTJj4LxmO7JI/Ze6uw09Oyr44hzye04VG38SexguJ19SiLyLkyZDH
         2j+ADx8kksmpevezrQa+OV3wOxDoT3VKfkm/zHBZYDdy9frOg3pt6ACuXTH1NBkdHssP
         JJV9ni3oH/Sevu8a9YxVVShhUhxCIuT9fr9maRKFfNyaYHTLK2GmD8a6qdzTgB3d7exl
         zeZISXbgOaCwaAK+6MpaVYrABf8NkToS4+CJ75PHb7rPlJfikX1UwApBaNYCE4YQxFA3
         NiplU4vdZdOhCb9qQTEB2SLdvQ4iz0M4uRjnH7LT1LG3lkXt0aYHShJaoqpt91uvaY3n
         XP+A==
X-Forwarded-Encrypted: i=1; AFNElJ92CjEIq4eahbB2f7+zfqJv2axCnHlXD9gOfb19B/4URBUmyH8zvfWVJA8lgFfQ0FvxvN+NSXXqSnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KberH3VjXx0dPPPVVMGTqQ64K/y+dEJkiKM0os2QKM7t4taj
	mExDLFqus6XNR/8gz54sSITM8NJzSbjzdY0UYQNd4fWzJjfrJZv6Su9V
X-Gm-Gg: Acq92OGEOj8hooS+++neoqFCkOfx48Ys12pWlWd82SLSCcVYH5lKnFUGWCHHNwBEAzB
	UzeFBOVLO8sPZXB6UfxqSm9y8BvSuG8emlnxsdTs0L6NajdYmaVJ9juNFW89UfDDZqCHJV7etF/
	HN6QDanC6frMMsFYwJPobzb4u8aMLL9qjgwFWkPf+ZnSijwAZq9TzbNJl/WZ/qDiOPOU46dHIXv
	yWtAbnVUoIijA35L2m6gTGA6aWi3uHt9sgfQwGRfb5QaQdjyroGmNXS/ottnIgNsu4MDgRQSqfT
	23R50QC4DEOc6keh03Fg+l9Bq8MCrs9fftZZaERBZiyt9iTxDcxQ5+xeV+4gPMrCSbVb4Sz2I0b
	Q6f4wv1ST8T/lwvs7pcRlUgLb7GgpeiKxBWFNCX3YgZaf8YxicE3g4AuGYg4quiGKYzszkws5Ub
	z6HkLvVM1GAuWFKZY=
X-Received: by 2002:a5d:688d:0:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-4619f3133c6mr3730064f8f.20.1781604139935;
        Tue, 16 Jun 2026 03:02:19 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm42184667f8f.33.2026.06.16.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:02:19 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:03:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "David Lechner (TI)" <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Message-ID: <ajEeZWj8JWoJi1oP@nsa>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-3-e6bdadf7cb2b@baylibre.com>
 <ajECNvjntVg_GjwR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajECNvjntVg_GjwR@ashevche-desk.local>

On Tue, Jun 16, 2026 at 10:58:46AM +0300, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 05:00:01PM -0500, David Lechner (TI) wrote:
> > Implement support for the programmable gain amplifier on the internal
> > short SYS_MON channel. This channel is used for calibration, so it is
> > useful to be able to set the PGA to the same gain as the external
> > channels. The gain setting is implemented via the `_scale` attribute.
> > 
> > In the future, we may want to support different reference voltages for
> > this channel, so the scale_available table is populated during probe
> > rather than being a static table.
> 

...

> > +
> > +	for (i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> > +		int *scale_avail = &data->sys_mon_chan_short_scale_available[i][0];
> > +		u32 gain_x10 = ads112c14_pga_gains_x10[i];
> > +
> > +		/* NB: slightly odd arrangement to avoid overflow. */
> > +		scale_avail[0] = div_u64_rem(div_u64((u64)NANO * 10 /
> > +						     (MICRO / MILLI) * vref_uV /
> > +						     gain_x10,
> > +						     BIT(fsr_bits)),
> > +					     NANO, &scale_avail[1]);
> 
> Oh, what about temporary variable for the inner division? Also note one trick
> to avoid casting (and making it shorter).
> 
> 		u64 foo;
> 
> 		foo = div_u64(10ULL * NANO / (MICRO / MILLI) * vref_uV / gain_x10, BIT(fsr_bits));
> 
> 		/* NB: slightly odd arrangement to avoid overflow. */
> 		scale_avail[0] = div_u64_rem(foo, NANO, &scale_avail[1]);
> 
> Now, with much more readability, it's visible that the first division is just a right shift.
> 
> 		u64 foo;
> 
> 		/* ...a comment to explain voodoo calculations... */
> 		foo = (10ULL * NANO / (MICRO / MILLI) * vref_uV / gain_x10) >> fsr_bits;

Did not looked enough time but also looks like maybe mul_u64_u32_shr()
could be used? And given that it handles things nicely (even uses 128bit
when possible), might open the door for more simplifications.

Anyways, agree with Andy that in the current patch it's a bit of a pain
to the eyes :).

- Nuno Sá

> 
> 		scale_avail[0] = div_u64_rem(foo, NANO, &scale_avail[1]);
> 
> > +	}
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
