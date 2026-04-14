Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2539448F
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163537; cv=pass; b=QOB8M87P7k/I9W4vI9kI0epxtwdV/O7WpQjVg7cLl5C7JSOf+YxzpXVHZZOticjC6P8kHqqv2J7gc/LYKmLlbE3VPU3GuyYlTlTvLY6Lu+sABiouuwuLAy6EUkCsRNXugP2JQMvQwCpcTquLEm6D39TL2GRzgiIiNsUWvDtw9oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163537; c=relaxed/simple;
	bh=9c8EfOBKVWCBWGoY4hxNZu+bpMz4uZpM+955z4w3WUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcHZMXRUKqlRV2IDtEZvw58wYizHrMZ75PYeRZFuH2wPJziMXCumkvu6FCu3SiLpa+64TA6xjamJlSRuvMvUGN+Do35Xy33bD2+vXRmMHgoylzieUeiUeOoe9L7ojaYCXTozqixTduoU1bZsgbiMKFEKfKpMZ+IraIhJIYJGE9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMqueTSl; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMqueTSl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7650202fso1685526f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776163533; cv=none;
        d=google.com; s=arc-20240605;
        b=O1smr5ep1Ta5icAfJW0e6z8aMGwkGcSLSCFnHBBf1gEQtEqIS0ZvOX6Q/8L9za5M93
         xQBPimwgaJzqbUpIoL31uiCFvSwxZgB/a1eOY6HNT2gg/ivHzozdARSIPrQsBnurxBN/
         1vMb2/zdpSaGGanVnvjwFuccB5IIcsyqlHCn94aEsiPNYopUkaZLForQS1+7HNY8mKf9
         p+rwa0CI5fPj3qb8oeXFpGH1gJAUD3CKaXoG7Sbp3IzVtZnG9AV0+rXvlWmnAsL53A/E
         jRr2EyQOS3zge5+uiE+4VAmwWh5CdzS2JuB/7STtTQsxfmxfoVeWTjpjijWRXdli+oEy
         zWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K7OuK+aVGpNAh53CpkmCGmxWFR6Ssi626NtJfL4RDaI=;
        fh=dizBg+WeuU3mgEM4I66uFGJQw9nLQDtNGWtAaJWOMMY=;
        b=WMuN8dKUtWEM1TXtLKt3E9pcUYIf0TckxWGnvggV2hNS2JOKtN/vcp/G+LcYp6pQoX
         pUX66UKZyJDFDIaoVVJ1Ro0Fjp/q7xH9Tn+uo1X/zbAPuQ3W4FcrCgmTZsYdzno7mY1K
         aKTdjasKRECzo0z5UGIXLXCAHqjMiOrJ7cSOi3tIdOnMYHSga7vC2+Bw3apbYw005DQn
         lbyVMjpG3kVIhO5vswM5MDkr7bMi6YAk68kcB+iKcY57hZ+/B6J8z6Av65ZdEickRqq5
         8UooYyLryI40EfSdIgPfu9o05BUJfTbOpB9/HfDJx+BUMQc3NR1rcufmFFw4xk2dacH+
         h56g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163533; x=1776768333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7OuK+aVGpNAh53CpkmCGmxWFR6Ssi626NtJfL4RDaI=;
        b=OMqueTSlii/u3CDrDKY4eCaF0zKEQzFAVkMt8waiCzCxHtWDQVksahK+qumvewzQjK
         0W6uu+5N7ohE7bt8MzSm4Jh0yCn50tRBGwCSgMUd7kHhZRtQIA5zHSHjuQHtFYp8CJaj
         dujHxYdI8Pd5fpN39zEUYKI+oJV6Mmhgc2iADXyevLcgootrDwvttPytlgyxRPtc3o2O
         qAgVhzwjlqq6x4g9GOQBHkYbIBllrpzGWXWXz2PO8XCnfOprpFbMOyv26/r7BnlfP+ld
         Td0CvZwOdewMeVUgFrIbJvC0fI2YnCqqpJv5o75FyzwaMy1nkFzxcb/w9j4NyY2GedLq
         cqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163533; x=1776768333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7OuK+aVGpNAh53CpkmCGmxWFR6Ssi626NtJfL4RDaI=;
        b=U4rKNtvbwnr/eEf6MNZAt9wQc2e6BOOKSFTk3KjgygssbHKlY69gAMWX+jgLpoqPLK
         TzDh4CQBh0PGMlcfJD3iG89o6SLW1+W/DiY14UKNbPYKlNW2qRGDWUKZaVyiEMLSK08r
         ANIs1q0dsxcK7mCHqjeawGJM9JRhlThcSFYBmjhHPoFxg9pPSfjXEF7YPx2kJqJS5VUr
         /TZ61e480bSxwE8egDqsVpW8xQ+XPdjBqNhdCyQBRw3tGM2hkeZJoDKaEDt45BIPFBLN
         j1PNDfv25feazAGZfcEZHtKwhc3edAbz80jqlacMyx/vxFvdKVQksgoBeJOnjAK5Pa6U
         oFGg==
X-Forwarded-Encrypted: i=1; AFNElJ/Xy4tlvtqezkDHQPrekKh8HxW+s/DPO9cr0WHa/WakUlQzxp0iBjgJjV8epYxW8AXuNHaNe+BR3mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkAPBnlviowugaRHDGFYH+dS0M7V3xD7AvQMiVA52wx5XnB1B
	PjQK6Hwrfvrfw3BhFjQWV5+g697QekYlSSinEj4PCfD+J8VBjNxASlh8jhRzH10bi753CNmI1Qa
	jMiCtb26rgXtDID+b1er6EoDFCR2tUTY=
X-Gm-Gg: AeBDieuxpOhqlxO5nm6ng7O/Q/UjJv3fvx0UKIhN8Kfjz9/iBLIMpm7ul2QS3Lc24Lb
	X7uaN3Dzd0IM1G/z4wzG3TIYszek7O9rY+7G8YoXGEiQRJJihH6ukqnFBdZYACFgR5IdXz0ky3q
	5gWn4sSmMTUcj7FwcGPPmjhZyOXOm/90kWMiJSiLuXsH+mEQjHU2TXBYSFTIhbkTruynK+rNKJ4
	2xMpcuFNmmuqOffIgillOp+Mf1ibF5sdEbqQxBGuI16fsy/LR7QUj6mBNrzB78R1T/DlhL5wFFc
	MUizjQ2qTGWhKCZ5+Q25c8citlOrmLx0XS8LM5F4ktkxC2PnAhDwFXCfAuyGaSO5uimwIRO6bKB
	xVgVWC8r6zgTLoxUqHPqKl0WlRmuIAgJ3uyp675Qe7piM34oObD/6+JV2hUYos7ETtsEuSt8tiG
	c/uhnWumWqlcIC4A8P
X-Received: by 2002:a05:6000:2888:b0:43d:7403:4b59 with SMTP id
 ffacd0b85a97d-43d74034c07mr13626973f8f.5.1776163532850; Tue, 14 Apr 2026
 03:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-3-joshua.crofts1@gmail.com> <ad4MbnpAfBEXKDzm@ashevche-desk.local>
 <CALoEA-ye9aKD4DyciFNZBW2TSd=pw162DD28rdvRw8O2OJvcqw@mail.gmail.com> <ad4PbCcHUMgjGMlP@ashevche-desk.local>
In-Reply-To: <ad4PbCcHUMgjGMlP@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 14 Apr 2026 12:45:31 +0200
X-Gm-Features: AQROBzBCYnUPKmznzAlZXKh20fQkIPkFpMi24LxnRlanejQbHOJKPxi9ADg3qrk
Message-ID: <CALoEA-wfx3=eVq=omiNmDeSaZpNP85KZd32A=GBiU-DVZ6btAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 11:57, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> It's up to you. (u64) casting here is not bad per se. And it's more robust
> against changes in the second operand the type of which is hidden currently.
> (Reading again what I just wrote, it seems I objecting my own suggestion!)

If I'm not mistaken, the compiler would always do a type promotion of the
"smaller" operand (in this case fout). By casting at this point we're just doing
the work for it, so I guess it doesn't matter.

-- 
Kind regards

CJD
