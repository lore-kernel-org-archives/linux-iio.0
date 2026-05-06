Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790772580F3
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050951; cv=pass; b=tRExzHZZVYm15bmjmWvFYA5FnulYAsxSmcrfJP0Rrt78aQdR6C5tUXQvkkqMusFBqart4IArakRuA3F3dmKp+VNn6SwOk2b1MFQx4bq7ajXbKpsdnhfYWDi5/yWsFqTkswClSNYRSLc4wE9X5jz54GYFdnckYOf54H0lPTOnYHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050951; c=relaxed/simple;
	bh=gd5OzAM2ftQk0ee1Wxn3NCyYVCmTjWJiAYCrLnKNfVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chSB/djhqxjRhp8ilbKigz7PfHLqh0fkhIY/AMI/uyxrhjVzLn73zMejyzFmHotCELl5qAjCS6uUCDuft32HPI5UH+3InCC+3DbliNkdY5DvYy+Js62AUnXDH+G3rMcvZBLnGJzUWbnto0xPdPKwC905uRNRgTewMTRrpjpwgto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dISYMAzd; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dISYMAzd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-448528f4e69so3561145f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778050949; cv=none;
        d=google.com; s=arc-20240605;
        b=A5gYt8hVuZ4Hy7XgvSqkOY2OZy4+uQZUtPrA7e4WwUaUOZcGrqh2R2PVwf/3zzVYQA
         wf23Og270EPJDhEEpTyAXAigx6sm/INkqgssjiGteEdGBKngsfs8ylKOJ7zQHGq2iq9N
         0I9DfbWaLiXlpFVECYhP0U2V4MrOQpmVbeFmFxAov7t2eUjXrcl8Fj/OkiOThPDdZ0d6
         yt4+Kb/Ar1bEirzOrWdc4SdS5ij76+Diofo68N/9JWoycqTjqUf8MVaJcb9DKtBoimVn
         0COsYvI55agCqwV+VvdkWxS7GkXI3M/GFSnNsTW5Fxw6pJOv97vG/hsTWI9f3qCFBMsC
         wO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rsOpgFGPIczB8uWhAKMP5UAc+gXO1ZZc19lWhTV70JE=;
        fh=xmw2ksjAc/xDUf+NjqsYsW64rIOO0cl0hMrFJcugE2I=;
        b=WdKYa571G++2svas77R+I9pNd5iK5G6IWDG58yQZVO7Oe683yWwBr79/6pQQgolY98
         MriCKBzl55S0pSxPWVGFao5KBrPuRSHMvGNVVlGgG2xbcgOj2H5+Lb8G9cGMke66RyZS
         kvWM7LcsiAxgq/a6Va+Q/AqndY7qK2ISI6y20QUvXhHN59X3oGlGLE6ANSNEuQkBcJww
         B3pVxSTyls1sg7xTdHImRC3QfyG0Mn/YjDD6TZ1SukgELtWBm4aLRsRue/dnoPtlft+D
         DznN9Lk9dr7ZBlAJE0HLd8lkQg2WOLrHMmffyeLebYDFV87YCF5JebrBZEzZPNBR2VBs
         sczg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050949; x=1778655749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rsOpgFGPIczB8uWhAKMP5UAc+gXO1ZZc19lWhTV70JE=;
        b=dISYMAzd6LQOzFgzb71gkYjZjfbLAXHkfH1lQbUalFgsocRCezstJp5FEpS1+RtFR9
         23vMKGeh8dgX6fS0d4dd/GK3JonhQn9mCv8TMhHnHh2mUaRd4GO2mstDsxDCh3AeeZ4Z
         vWmAADSG2FYJu3UQWSSAW118GbiQzIcUU74Y/n15QkALmYQQNcgVdgjltRIVqyDiHD5n
         M1/b77zDR/I96cs2VUIVOsEitJ8sKVoIwU5RuTTcpUyjmnOUp2Gi6EbLm19rQWFz7sBX
         ps3xpzzt/1Fvpy+1tmT6LfY8KYt6oC0S1kCbiw3baJ4x22d1bsDgLw7Ib/v890qMHEiS
         td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050949; x=1778655749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsOpgFGPIczB8uWhAKMP5UAc+gXO1ZZc19lWhTV70JE=;
        b=W2uMpzjlGZ+KZLr9zE4XgLrbEP59OqkFbgy4aeOEJhu8wUSj7qiPCpXR5Dho4zG+oF
         KqczFUGmBeqHm+WXyGeRHkLBP8XsP1Jrtha1ZxsUCE4cDxdxL/3LXgFXLMdEezrC/mSx
         /RYZ8YtWQnLNFlw1H0YMXgSCGC11pdTlRm/qGoXEUDlPih8mWZlwzQiK1Qf2iVmR4OzK
         lDocauksomc3KFfGiHPYlwqBHs2UIqK6rhtqxD7z3zUZU+qZ0Yc47oqiSPoxu+E1DZ3m
         SQRtGWhugOHyiycDMbf+BJ0dW3TFPwpqzlME4JTwT0ZZJQGsAN44SL7Ngl38hoyZaw8E
         mjEw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ti56vW86hLLEuEXuTxHiFVkXC7yUK/KUPnZzxYmWTISAIStgtTNW39RYFMwdlE1wwmurg9X16QDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cMOXcwdhuEtZ2JjP2i1807XBn5qWGWnyUMzQv4FqsUYFH7aZ
	c1qjo044fRoU3Tz/VIqXZCcAZTBCx+NHl2mZDecaj8qWW/XDjg3hQow8A8V97pFSKj0sm5kzN1D
	hgzPPYund0YRicPfm2fH3J2B/C4yiTCo=
X-Gm-Gg: AeBDieuVzjEngv1S8tflg8LXHWMp5ZnTUllvkHywGGZ+dbVfdq2YQl/nz7I8ydoIJ3x
	Bbw2sEJzvNx0lFfHKMF1wY/99zLzdKYsnEi2hdZzLFTV+5N6vyyoR8zPrV7p23z7JoGC+eJ06BJ
	Sf6jt0bGSh+Wf400anSZvqwfC2yNNwTLay2GKQxqfZi7C7q+Z560HFNWUgI9cXhkslrgt+f3hoN
	OqNb5+JETksux0gMkA7PB5IBgjbB4Qab0yCWaW6XbOjifr67PSLTz73GXJcvlTi0vViZdGTYmQb
	ss4lDgzagBIJiXi7OQ68aICRMA8kBVUCvfyboxjppjJD1H5tk7zeYM7od/Jd0r9pI6utTS4WDXr
	9U2sh7Fax7K0H4Kt1OfNDzBc66wUP+p2Og1slYnEVGBiyHqW5NnCYIz/UuS+8SgNV7DpyBk+M6T
	0Ssk0wJLd9dTyxr2Ln
X-Received: by 2002:a05:600c:8218:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48e51dd386fmr40409545e9.0.1778050948669; Wed, 06 May 2026
 00:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com> <afrg7uXqyKs9il1Z@ashevche-desk.local>
In-Reply-To: <afrg7uXqyKs9il1Z@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:02:15 +0200
X-Gm-Features: AVHnY4IwHuZLcCqOtmX64pv2ViyUDh-7Jw_gldA1zFjvt8KV1GzwTbuZuYl1sW4
Message-ID: <CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com>
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Refactor wait_conversion_complete*_() helper function to accept poll
>
> functions
>
> > and timeout values directly as parameters. This improves the
> > readability of the code and does not rely on hardcoded macros.
> >
> > Besides that, fix the home grown and obviously wrong in some cases the
> > jiffy-based timeout.
>
> ...
>
> >  static int ak8975_start_read_axis(struct ak8975_data *data,
> >                                 const struct i2c_client *client)
> >  {
> > -     /* Set up the device for taking a sample. */
> > -     int ret = ak8975_set_mode(data, MODE_ONCE);
> > +     int ret;
> >
> > +     /* Set up the device for taking a sample. */
> > +     ret = ak8975_set_mode(data, MODE_ONCE);
>
> But this piece does not belong to the main scope of the patch.

Fair, probably a badly resolved merge conflict.

-- 
Kind regards

CJD
