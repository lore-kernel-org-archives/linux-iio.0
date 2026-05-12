Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA145BD5F
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584428; cv=pass; b=JSze59g188xEdzEHjGRE3cpKdHlOanHJ4Efp1u+Gn/34/vbIVZmDpvdJjlm0xexVvu6N1ZJUGaUnLt3V0tgX45Rgp8D7z1EJP57FWTnOuGpnjBH+30ZpgDD2HdL/pN+v6gatMZdMW3RBSZwXBxWGgCq20rK2ms4W9UYdns5SI3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584428; c=relaxed/simple;
	bh=E0VQ+XN2t5SibAAIbZUVCk7J5Um752qWqYuS3Vl0lgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvnGroNXSGJjA/it/k32o0L2yyyLd2LEsAdZjhCPqI89LTWjTQqI5xRRGgKjtNGwrzY3wXFkksx5jz3zr3gBlpCC5UY8AMTO98Aavmds3AzmZ9Ha5d/uTrDxgnD3/fvJLw765U/YtIX5jzB9IekS9emxt562I5dN3JCH7pEH6B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeDxPVOG; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeDxPVOG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891f625344so50588075e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778584424; cv=none;
        d=google.com; s=arc-20240605;
        b=TWENNC6m5jrNFjjJSAC3zTqjrf1G3TdXdr7pVeNbnLQ/ErX/p0lF2lVmacxrmbvT3D
         l1PsU1xy3zs2IxjJgHA8a2e2pKvXhi+RsgUVgvVrpouol/jLNEnlLMYLyiISsfNX/3lu
         tebwZP1wwnrOaGFzNfpQwMxlRIRYHpZxtcKc1mSnOZl6s7I+RAv0eN4MP/BUWAGtcc1A
         jG3rMtckcMEJeHGY6VN57H52Sua3eZuAbteT+r3dgQIBe8qjvGPlSgQs2kB0o7TzBRQp
         xZqDIFoAZlPH6Mc6UsWfY997bWZ8fibBmU4VMV2jUxENVWtygr7B99npEu3ipH2br+eQ
         3V5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y2hnGqOpC3haVJBTcSD5kcpEXo0Ennm/4nt4Cg7s2sc=;
        fh=4JJmZY4RgFISvQASKwezq96d7a9WwFU5JzjdfMARIJA=;
        b=T43K7tKYgnV2INOA17lmFTZ+wmJZJVKnZ4xV17+EbYCUJ4fiGy/+UMXFOHzQ4YYlFb
         0sjM7TfWEwpqUc4daWH57MqM83VBzeb3n9AN2xeh+1PAQ5XF717VTyk6TsNUPXyIFsIr
         QsvSJKauQrnwmgx9ePdBvnGNaUFM3mIDywkBnhi7iTOmDsWs/TGuidnOH46ntVNm1W5F
         xt5gXrBgszOv7b/3OsdH4Z+KKCEQYhNna319AnraNUkMFBa4Ln01gD9C089T8Ahcrjmn
         0I/OsQEdsupUiB1VoK2WxAn8obSRjam6V0q6dKHCG47c77fiGRd0Di6o3VwT5iUUVx9P
         BgBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778584424; x=1779189224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2hnGqOpC3haVJBTcSD5kcpEXo0Ennm/4nt4Cg7s2sc=;
        b=JeDxPVOGIGldoymUqxmSCzgJNk++PMoCwaWm5cuFy+A+EmcIaFLEy8pDLou8NFZiCE
         SGWeiX765cp0z2GQNFZDws3suGKGN0kFhAmrzo6eyvhXRqYYuhW/4ePHyE5eIyQqgFjK
         PGDVicFgtQtyJo2c93GLxVKCFh/bJSi15KwjQppKgu5y1z1t4vpdXqTGZaenxKn7AybB
         kioMT3JQ113xBfr2edWbZI5TgXTJEhfzzjIjKVRcxk+7DZMmMGC97R9b7oyiQWD8Zn83
         uC7CwJ4llj0XZYAZhIr3iNTuABUzsXT+gAPwa0UCdIe3xgRr0YAHl3HbN2mMVtfJOcNO
         hp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584424; x=1779189224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2hnGqOpC3haVJBTcSD5kcpEXo0Ennm/4nt4Cg7s2sc=;
        b=tNuVcFrohAitV0jkub0yFMGiLB1S2jj91T70zK2VzOX6hdhlpvhUEO1HWex3h3CaOJ
         4gG8EyQ693w2HupH5kX4guIuWTZ7hNiNI9o45nP4aOn+DRvdXETN4l3UKf/lfPK0YqoA
         l6qcvpDXM4yKhSkAqwKMA+DTi2n2ux1a4vcl1ygomZ8Whg05HKSpNlrZd3bqDfPxTYk4
         XMltbwBaXWjShnP68J4GPXskIB5hKIAR/HiyAWl4y+xVzjS6TJn/E0fucj/QjkccD1Wp
         4HkB7gb8BJyRVdUhCcdoPsIJBMu7R57TiFE4bwmDK0FREWz6NrDAmDTmR2PXyn56TOsk
         o6Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8H+j8oPHhggXpAWzCfz3gQz/rjYhpy3e/28R/XHiTbK6WZDxnc5Sc/mJZMWQ7t7ll1wLoKqn1XFBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhuIYCKwxCCWKtvYZZuki6gWnICl9uMmkeZNYw8awRcTL1k6im
	SGfFqnb1M2tDUoE3pqemSED/tguZ885vqTVjYQbR0ltHWBm8pubJDIGhm2qYwF2It7YUc6zjwyZ
	1fWPdfaBxjKB7jhWTKc3aw35oO+xLYkg=
X-Gm-Gg: Acq92OFqVEz3hbm3Lo3tiL/CWsmCt4UFLNBRc2I7tYkq2LVHfC7SK/p6Z9SXBulUzOh
	QNQaMooovv1dvtF9T/jICizNYTg2CPOa0qod8nfqLDOZK8QnEQum0VSV1qiWx71Qi8aWwQ1m0q4
	HFHiFh88WbZt8qvq6cJbPXQLs4w1XpuvGGHD+Z+PfGRpKhneTuoLib7rM8397R3MvNXxmXRsWe4
	JnR2KDQByGHE8TRFQw6P54yFYsZoVkxY+Xa/1UaHGJf/sO4Ih9ii7u7m418/IpYOocx1t+6VEgK
	Nhco+wmuTJYudZ/9khupOhG8Kuax9rR/xjOLNkeZzEa28Z5nR3QttnlOxE1HpuMmSDqU9bVW7tu
	oGrT7Y987sSVXYuF/oFpSf7OF2mrdC7xxozG7md4Shx6xD+l0AhPR0nZ9Ahs9Y2+XqE2Facmyo3
	0/fv9w9g==
X-Received: by 2002:a05:600c:3547:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48e8e1e6eb9mr47774995e9.2.1778584423450; Tue, 12 May 2026
 04:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com> <agMKd0GVvDxqs7Xh@ashevche-desk.local>
In-Reply-To: <agMKd0GVvDxqs7Xh@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 13:13:32 +0200
X-Gm-Features: AVHnY4K2Wgbbed-vQdsDIqOTVDWCXD3p56hif3lirYHT-u4kPPyAS7LCHjvgLr0
Message-ID: <CALoEA-wtBazysBZb7o=MEw_CfY_t9uDZrvKd7jX1xaPD-sHVjA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] iio: light: opt3001: use local struct device and
 i2c_client variables
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 13:09, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 12, 2026 at 12:57:24PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Switch the driver to use local variables for struct device and struct
> > i2c_client to improve code style.
> >
> > While at it, ensure that parentheses alignment is correct in functions
> > that were changed in this patch.
>
> > No functional change.
>
> Right, but what I meant is to drop dev member from struct opt3001 completely
> and derive it from client. Maybe it's done in the following patches? Haven't

Ohhh, now I understand. Unfortunately you'll be disappointed, my patches don't
deal with this...

-- 
Kind regards

CJD
