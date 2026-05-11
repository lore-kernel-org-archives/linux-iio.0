Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57A2EA154
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512800; cv=none; b=dMYkBO3NM1GqCQzNFb5Mx3UKrr8w2Pkrs8T+DG3DczNdAvRuwoHx3WFXAyXIWmLJkuJ8t04iMIORuDd5f0hUDf0NiCPrIc5VSkmKUhUbsw0LyP2uCZWxYr59m7jpfpe7XtWE9I4YmglLowJVFYKDfrLZx5gOaJxgPtoMBhPYzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512800; c=relaxed/simple;
	bh=l1AKxsU7Vv7r5hZe+yZNlGPNtgDDr6Rf4GCgb5WvzQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esaq7aBKq3hgszCjSNSUGlqmsk9b9KZ/G9+NinnUSsQxfcfVMIko1uWdtVapvpgxr3oKivJZGaTKkOdzL7kVM8n/9IxG6uWG0vywj3giDIN41iAB+NbzQ2TnWJ98eA2l8+c1/Qe9pKZ/UkwlkSayHKjckLF1llPZbN9UZrJ2KFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC987Fpx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC987Fpx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso8634665a12.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778512797; x=1779117597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72c0mZVwmJDnKI60CHSdtI6byXZvr12pO3foJDjqiso=;
        b=CC987FpxU33Ew8lrWODVd869JJfp3VZLZ62Eb5qadYI/EV7UWwgIuTnApo+42aHTEe
         NMUS8Mr6JjCk3nYjtmEo7uj7wVOBBs+DI/uxCRR90Yh1tSY5rDuZSBuCoEfVQ5YAGXSk
         A7gkJ3vAVy2QXnq6qTCe7xu/EZuU/C/zpmbVFfhfqh0MJGERfGC7mbA+GTMlo6WxoPvE
         nrKkgUQneqfyKS2hlcJ30MUDP7mLVdiykojlcicMn7YDgi1vkRFPPxlFDOjCe0jS6t6w
         i2sv9JEdlFy3BGx3uOmivTHBTgWFbySCfb1av1fVEAZ0m9iTk5hcaAvq5dYe2PrH1bqJ
         eJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512797; x=1779117597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72c0mZVwmJDnKI60CHSdtI6byXZvr12pO3foJDjqiso=;
        b=ehH4ypqP5DrdxCeqOtageohp4+n4S9acqKmQFfE4xdqeBTqgwah1JDredVCPSR1CUR
         B2QFVW2wXUwPKlYKUCGAA+lh8wF0NXkgi9C9HltF3gfb5oD4ws8dowPb/SxRf+2c5TJe
         GCN35MWCF9J/ll0JMtAD1lWbExty6FdZl4tNf7x/JMuR9+5anQ43V47XZ7Q96NhtdX6F
         GiYEkUT8OieyGBi166mE5ANGrljA4mBTeGtJRcE+nW3JU5+shBKKOnQylQ+Q0icoPYoo
         XWI5AbkqBYrnhIwl0BL63ZLLnIYMllsSHTyhDAvm6AgWJ5MIYKyJzNvNfZyvN1WRBzhS
         vteA==
X-Gm-Message-State: AOJu0YxsMXD8iWOxTk07P8z0DJzGfUj7PnPS+L5r286Yi1XWkKeZJCHK
	RnSSTDHREIVyyRWVac8ZuJhM6wvRyYgTgRxvjADuWOR4bMc+iNoPiImg
X-Gm-Gg: Acq92OFHlGS5JrpVdptphLZATfgz6IL1/q2fTiFKaUho496igQMKmK4/gu8feJpwTID
	FPjs1prep9p/EGUIWZc0SFx7zX26zrKatQyTW013/bFFarqFEyBiM+MAQehXWM1dN7cF8QavZLD
	3Pp27WZijLHpooqs6MScC5ZZs912Zsm/QHJcqoOKuo9eBvJ0fb3FmEnkvimek8X9L8ororkHVXG
	XXdHVE1i2oSYrV48xSr+fl5j1LOlPbYwh5BiHjxGDKzrrDCVXQEHiQ7eV6lEgLl3HZXNGQ1BHn+
	OeB7i0zZZ9ID+BvdsdRcPDlwvpJ7boQaIWLSHRwJmXNIFWsNl+kdKO7d92Ct/Ez4YDJVkoIenRd
	sISGcnr56c6iyZCRtRAl8jJDP8S31Ff9ick/1/aPvFNlczBNPNdj8iI5EaBW3iD2bAsM0M+Nj1Q
	yUcj07Nk2NWbu4GATUEejG4hGEPHU=
X-Received: by 2002:a17:907:868b:b0:bcf:9dd2:f79e with SMTP id a640c23a62f3a-bcf9dd2fa70mr327636066b.29.1778512796650;
        Mon, 11 May 2026 08:19:56 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcf15a034cesm213822466b.55.2026.05.11.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:19:56 -0700 (PDT)
Date: Mon, 11 May 2026 17:19:54 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 0/4] iio: light: add driver for Broadcom APDS9999
Message-ID: <agHzLu-W7MBNXxmx@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <20260511132112.66246dc8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511132112.66246dc8@jic23-huawei>

On Mon, May 11, 2026 at 01:21:12PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:14:42 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > This series adds support for the Broadcom APDS9999 ambient light
> > sensor. The APDS9999 is a digital proximity and RGB sensor with
> > ALS capability, featuring I2C interface, programmable gain and
> > integration time.
> >
> > This chip is considered by Broadcom to be the 'successor' to the
> > APDS-9960 which has technically been discontinued.
> >
> > The initial driver implements the ALS/Lux functionality using the
> > green channel, which approximates the human eye spectral response.
>
> That's not normally a good approximation unless it is also has
> very bad colour curves for green!  Better than any other channel
> on it's own but still not good. If we had calibrated sRGB it would be:
>
>  Something like: 0.2126R+0.7152G+0.0722B
> for example.
>
> The lux vs white light and lux vs incandecent light are fairly linear
> so 'maybe' it's good enough but it's a bit of a stretch to describe it
> as an illuminance measure which is what we'd need for it to be measured
> in lux.

the datasheet states: "Approximates human eye response with green
channel" and "Uses optical coating technology to emulate human eye
spectral response."

that's the reason why I chose to use green channel.

> So I'm on the fence at the moment.  We might be better off teaching userspace
> code to do it's own approximation if it has an RGB sensor.

I'll also add IIO_INTENSITY channels for R, G, B in v2 so userspace can
comapute its own weighted lux if it prefers.

--
jose a. p-a
