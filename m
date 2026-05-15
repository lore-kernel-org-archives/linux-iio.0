Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41638758B
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839901; cv=pass; b=JtKv0hSCxJC3AdSITKuyxaXQyC4xgGnY/aapCjh82432Wrdeitgrrbm1WrQt5xj3u2No58GImTyWVeaU9MIQnyilny7QkRluf8HtnwIWoBzpVoWWIECMhQ7ucNoQQ4WPdC+BI/xHZUhYTOAABkDBIugQwDmn/Q8tQA7MjADE3gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839901; c=relaxed/simple;
	bh=utVbCxSx4wQLyjNHnWlnBe8NHEco57qRKSUCWgZQVP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPwIX5ki9Dx8RPJHgbVEiE38n1C3K2DbdMIC2Nlgf1UmVyv/ndvGP6xlROjelMPZ97c+PpmpJZrZvWeiY908pBbnzh1nbKrVC/AMON9beSYbA0jRRr42FxnO4o6Kiq00OYgMy72v2Xct5KLG0S5kpWI/667EcowQzLK+pPNi0cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHhdvcyn; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHhdvcyn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-441209fb77eso436066f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 03:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778839898; cv=none;
        d=google.com; s=arc-20240605;
        b=j51JriA4m+b6CDuX2VAnRE0hUQkqJ70DI7fHn4H+x0vrEaSH3eqi9tl7X7RHzJTxey
         LYoADJwZfK/nV6RJOraiZFJbooZwJPfLkrFJAZOBQNicV2QdyY3lNijbNOHRroykZkZb
         CmySPzvK6/+7lAinMCvHGdFrk9QJadu9CHq3GYQbm6i50XnpXas9FmIJ6eNsBbIR8A5U
         ycu1zbJ8Dqt0GS1i6Q2Fl8umQKyFjQZDmYgEn52ui6zkfxkSbnQImttT/pKBUB3rXrEs
         MHl4BbfrKyR4a2lh/zR2M6QVdBEdjhR5bO8kiTPXYGgz3mlsc00g55qZ4G73ru+QAPn+
         o78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        fh=T8XNH1flf1iVXP/fcupM1Y6B2CaTPy9zzFJOkpR9mp4=;
        b=N9Zj2cNyj5DbPmxTnkBh0tOx0cKx9dmmCcmzYWN+H5WrAGE4A63ajGFDk6cy45uSZT
         bQ43z7JuS8Q3yGWkSAoNLIcBkkYdCWddPGkCZr80BeBpXFB54LFCUAszpaZc4Qe4pi5/
         kC+FalncbMwIfNDyJasCaxcewVPvkCnm8EuODlkMEOqgm5uJFJk39oUP/K9Mh4RIgBDe
         TzJ4+cNapD/l1D0ULiRGrpKAkJtFE6rUYC1v4h95Zer4XDzHIgrEqc9nL7KHT53eoAxP
         t/+6jbBZvCyF7gPrWcC2IKr1V9CepaIuoXBONC9fx+MSbD8BTMrMHurhcD1pDHCooIxu
         /koA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778839898; x=1779444698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        b=MHhdvcynnl0+otgFbZfpfIFMCqaxRouWqFmcFeUbjOrHX50cCUcy9GKgUIeB2629JM
         hFKihB+SPYVXXxWzZ9bzFmUYxvvjDJvejQA6wByBGLXJYB+Gw2UZPTv/CNhUCoXEhYr+
         SJg34wxqlug24OudrcxOcZXuHy1CtmvYkfkrqKQWykBVE/c/kvuKMantwCZ9oufiGv0+
         nfNxCHvZiVpio3jXokh3M2JlGOZDXWqKHObTSA48oy5f/2jV+vr8nN1fQmbN92gBMHVu
         NDq+26uBBwY7B6fIF5QDz6Y4lu3XMcfuT1gBk3R2p3dRAzsPB9buFMoQ3Z3UdSu89CdV
         sCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778839898; x=1779444698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        b=Y8yvkH+CflZvMmbxTPZh8F7Jl1Aq4WXjy2sZwSgtvmN3UUghK+j8KtIW7oZDdDMUeD
         bG3SthmwEaFUrvilvShN1DVb5gJ3Vv4Fq5evAOqZF4tyVsqoxi/OIJ4bhggx81sgLqv/
         jwVCljAxSkxybPPsuR2UvkuNxb9uTHvWNhgDCoEJGbiDfum9z+1ms2DMhZyByN51agm8
         PklbSh2z+Blvl5ENhKDmi0eQvggwnlLxqcUm93ufCiun9/k9GOvtnPIBVzCXdM39t/u0
         0tPC6WSX11PIP12u2sma1X3RvFRtvpjwBLL/4dllG7JDbv2M2/DDCcv86WSyRKLV6Ajq
         TxBg==
X-Forwarded-Encrypted: i=1; AFNElJ/XsSpB9xgdrhFcHH5U3GjdWOGrJvOCvGNtyRY2GIqAbm26s6BYLsX8Gg57Dii68UxTcgKjHwvcRi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYqC7LToZn6GIUuBSkE3k1PeVtfVR0rOKUee8Qb3dqJPj5QxV
	HFZ5EoWwl56TS/qZ8g1iWgPT07uCKts88BF9P9ertmLGwgjOVJ1RSiFYRlx05Ce2dV0OoZAE26K
	nWKQtic3xRpsMDlYAXyrdD8kHTBrCmtg=
X-Gm-Gg: Acq92OFe0x5jCY7qMv8Ma+3Q3XHMLbdqW0e5o3AnDD0KEcxgANRoiJhwQf2konXjieU
	eM4IndTv7+3xNoh5uOiMTHVAEgpYRJpVLh/B4jFphWjSrCD1bdhUs9mYSIYcOkSq53YrPNqdDUH
	9p0++0fungfUME6kMudBq3nKEDTioUuUBU3dg1tpJR6mE1teEvWT6pBcAPPsLyit+4xdbt1Calr
	DXf/vr90oX1VeDt8DQ/2/Q0scfMgaPN/Cth7JOH+xeedwKGEpwP5G7n6ofZIQIGCooOY3vJHW/i
	oA9gS1SOsFN0lAS0R5iRSxV7Sn0iJOlpHRaEQFQFVNWBVh+hehGnRsA2SOYc19rq9HltIrnhgt8
	v9R7j3zHYPikOB+2Y7PefE3PXhcrOsViPcj+iamAnJi5y3Tuye0FN8JSsqNUcM8IpHg2P+LLXBw
	t9h29QDk611oDZuJlF
X-Received: by 2002:a05:6000:2a02:b0:453:dc4d:9265 with SMTP id
 ffacd0b85a97d-45d90d76962mr8672926f8f.10.1778839897695; Fri, 15 May 2026
 03:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
 <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com> <agbskYwLK31PCnhG@ashevche-desk.local>
In-Reply-To: <agbskYwLK31PCnhG@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 12:11:26 +0200
X-Gm-Features: AVHnY4K85mkiuponRLsT_djJoxDAXdjc0diERy3Mb0F8d-LQP8_KqR7kVtdWyyk
Message-ID: <CALoEA-wRTTZHDFEBBKZ98Vm+5TMnd8TPSKbn7F8W2LsEBuADrw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 11:51, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, May 15, 2026 at 11:00:17AM +0200, Joshua Crofts wrote:
> > On Thu, 14 May 2026 at 13:38, Joshua Crofts via B4 Relay
> > <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > > -       if (ret < 0)
> > > +       if (ret != sizeof(fval)) {
> >
> > Hmm, Sashiko pointed out that I am comparing a signed integer with
> > an unsigned integer, which would result in type promotion and subsequent
> > mangling of any potential negative values... will fix in v2.
> >
> > https://sashiko.dev/#/patchset/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf%40gmail.com
>
> See my response. That how it should be in your v2.

Thanks. Checking the driver again I found 2 additional places where an
I2C read is going
into uninitialized memory that Sashiko missed.

-- 
Kind regards

CJD
