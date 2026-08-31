Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE383655E4
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204312; cv=none; b=OjUAvUI4jFykKl7tDfEBjtVrLwiGnm4Fs4kMeniUc76t3mDvWRn6a2y/2gLmmTZ5sl7C1n5sJQrO5IzrMhxWQtUYQ0EDG/CWMEUNKVbkA7JAbpdTeNW6umuY76t5tmlPxiKHZRqCRa/BXW0MFkZIP8xsD1lGEjP0taMPHrZQfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204312; c=relaxed/simple;
	bh=bJ8ViQ1poQtyyU0qQxN7jBxiUZmQXeRKiW1gHae5JGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2q32m0wei0h96zC7npOJaaju+f1NNHO3nZEF8JpOPEJSBbTl+Gg4+Q5xE2PTkGvH+ScZXw5yiJ/PnvVfQchMoXPtG9jdxpyHV8g08WINth/fu5Ien7Mc0Quel7DwKR9b2ApW2fhq00e/qstK61rPMziBDVGK26Km92ASyFQI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emR007vp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emR007vp"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5218927884fso54461951cf.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204310; x=1788809110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T90xAUdJeBFN8hspKpt1rQxG0oeWIpOFQ7BBn3k1l64=;
        b=emR007vpv1wzsjJJOlnbE34LGjcMUhMFiHnM88zV09msmpEFOx8vYrbxBFmzBrifgq
         zNxnVuQqS9UhKRclzTEI0Y5lNm3aQT5WGV4SQ/mnX0h0kvNl3JKMeDO8zTxPixHu7UIm
         7LHquTN5Y/UqDqs/xCVhgJfr53ua6XIVuf76AGoeOYrIDnrbXl/WpdWh+m5iilsDIbXs
         vwpu8N08/dJo3gdUXb9CHrebfkxToJ3j9P/UepaJv1u+8e95XxfwQpjlM/UhSkRplTzB
         brFYnE+402OsCs3a6oUIqOtjEsXzibfeJXS4rOyQa1KxTlLVgo98v+GP5cDYRhAkP22S
         oSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204310; x=1788809110;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T90xAUdJeBFN8hspKpt1rQxG0oeWIpOFQ7BBn3k1l64=;
        b=ebjQHX7SFh86EXj0PcyfloliLJA+2+dkumxMsYTvAA0kKsxcp6/bVmbhPcZ8QgvQ4c
         hzKzAaos0QNJIPgkrSdJqqzG8KhnfTdFcbyK3uvFEOAAOoBfzXpgypP8LPX+B5AhLSed
         demoqsDwcjwrsQ3eQqvPc0JwMl2hFN67twoFlOYuoAqm9rGDp10VArteQitN1PIuYHs5
         7aLQDQUNdoeC8IqRxcHkJzC4TZYMVmTpsbvYd2DwYorjryngwApWqNn2dGAhBms8OL81
         2yNSeZlBtIkzFp30gDesCWyD5W/g7US+BsyOFiwtFFBcbVtFOmS+yKuZzkqM4L++pOv+
         4l1A==
X-Forwarded-Encrypted: i=1; AHgh+RoYERGBwk6CNDqhgeWI6mWVnHQrDSiW+32CTz/BR0CL6wmB1+gKQMj0c0KK8LfQlZJcoGkHjMMffMY=@vger.kernel.org
X-Gm-Message-State: AFuF++mbPj1ZckZpxXLjHlAi9CYBB9ICl8EySvV0YCFkQWW234YDlbgA
	NiwMx5M5M91VTpyPeRojP4/rKpaqmXmcD+hmO3Nn0SsCU19leqv93nAvgIKy5Azq
X-Gm-Gg: AR+sD12elkj7pGXOmrd1hyNfGE3ClPlNlmNPOlpe49ObQXfWuZQopabwURgTxwX5NxL
	pFrH4qhQm41qbc8lCfDe/+ceMMU9+8W+I3AFKZt2jZ7u4tgjeKICjH44zFryDC1kSZnMFxodzAz
	EUFQqF4eESwr2b7dBXzRwxVkPUMR2tX7hJyJcPAuXgvQmHf3z3Unlnyc1meG44g81rT+IyElFvf
	xsYZmZ6kc2gfSvfKDBKPz7Cs5MqVPXCyfw8yS0z9X9+eYHEt+dpmiXfezEYEfapEFq8P/i/wrBd
	ryuzIsCM6D1G3LTNiekeHIPNgu01IbrAMFHGHhaecdkBMNk/yF+Af2BpcSYqJmdgVL3wFjc65kq
	C3FpxtKQKeBGbsFiGiY3++OFeUXzUOjMKsB8TV+wXLj6E2YBVokV7WK1wMApo2CgFCykJjC0NTk
	eSxlpotPpTHUFV8UFa5P5JhqWOKlI6T4WOmKQOqEluz1giEMuwIVaJpKZAfxsjDz3PHwCra3HsK
	Bo=
X-Received: by 2002:a05:622a:14c6:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52fb9655af6mr333069491cf.28.1788204309745;
        Mon, 31 Aug 2026 12:25:09 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:6adf:2919:5c0b:bce3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e58fsm90880756d6.8.2026.08.31.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:25:09 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:25:05 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: pressure: ms5637: Add per-variant
 compensation
Message-ID: <20260831152505.476826d7@louisarchdesktop>
In-Reply-To: <20260821020122.1c2cc7dc@jic23-huawei>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
	<20260820141224.23730-6-adamianlouis@gmail.com>
	<20260821020122.1c2cc7dc@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 02:01:22 +0100
Jonathan Cameron <jic23@kernel.org> wrote:
> 
> For this one Sashiko raises a valid concern.  The ABI is changing for
> those deprecated choices.  To avoid that will require a slightly 
> annoying dance with extra copies of the data to keep the old name.
> 
> One other question below.
> 

I will add ms_tp_data structs for the deprecated meas,ms5637,
meas,ms5803 and meas,ms5837 compatible strings, so the name there
matches.

> > +/*
> > + * MS5805-02BA01 compensation constants
> > + * Datasheet:
> > https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5805-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580502BA01-50
> > + * Pages: 8-9
> > + * Sections: Pressure and Temperature Calculation, Second Order
> > Temperature Compensation
> > + */
> > +static const struct ms_tp_comp_consts ms5805_consts = {
> > +	.press_scale = 1000,
> > +	.high_t2_multiplier = 0,
> > +	.high_t2_shift = 0,
> > +	.high_off2_multiplier = 0,
> > +	.high_off2_shift = 0,
> > +	.low_t2_multiplier = 11,
> > +	.low_t2_shift = 35,
> > +	.low_off2_multiplier = 31,
> > +	.low_off2_shift = 3,
> > +	.low_sens2_multiplier = 63,
> > +	.low_sens2_shift = 5,
> > +	.vlow_off2_multiplier = 0,
> > +	.vlow_sens2_multiplier = 0,
> > +	.has_vhigh_temp = false,
> > +	.off_t1_shift = 17,
> > +	.off_shift = 6,
> > +	.sens_t1_shift = 16,
> > +	.sens_shift = 7,
> > +	.press_sens_shift = 21,
> > +	.press_shift = 15,
> >  };
> >  
> >  static const struct ms_tp_data ms5805_data = {
> >  	.name = "ms5805",
> >  	.hw = &ms5637_hw_data,
> > -	.comp_consts = &ms5637_02_consts,
> > +	.comp_consts = &ms5805_consts,  
> 
> Is this change actually a fix?

No, I miswrote that. It's here because the hardware is different,
so there is no implied shared compensation between them. I prefer to
keep them separate but it can be removed if you prefer.
