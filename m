Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29206481A91
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577395; cv=pass; b=JIEPViOev99AIqjBYx8exI2hDbV9+xaZ0onzu2iWVlJgkJoNsO4LTe5Hs39E0nXMb+buHESWJVFL9osjMRCUTb02D3NHFz+UyoShsXg74ggRmNz0Yi7udZIceCcguhRj6kLvaIgKHcnijcnpUiXCS//ktUQOV3arOb1rx4rPUdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577395; c=relaxed/simple;
	bh=9l1Fc/MjGPqoP51paDXeo/wbqabwQQ9XspEYiop+A+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZVXml2uRXvuZbNLljGVS03jjYMZLYb3P+x7oAXWPGwDsnGqAnSWsJh5Tei6CSiQMKydXF8crWQJTbWkqv317dS1lhRa8p54AGpH5vmLS9E0xBt2bKZZi1DhI1aA2cjK1koKMblj8/x3JNQrcmZe8bHM4BwdbXADFyxdHTQvV+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvNKuXd3; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvNKuXd3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3308231f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 02:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778577389; cv=none;
        d=google.com; s=arc-20240605;
        b=K9+Xy7KphUhL8QQXpydm3Yw3gwE8ZE21Lyqt2s7G8vYGy7E2z476BLIgCPRgai8l3/
         0IPJzIgvAAPLk7Aw+zBd0VHap7Qutr3tt/QbxXH3/R/SRAs8zZ9a+WDVYMnAej/gVKPb
         tp88TEhhWi3v7kVxAGbiULBhStYn9uN7fAw4zMCV7xHespGp8g1PdV4V5CyrB+UNQkAt
         7eGzyViHKFBHTMK9p+t0tmozdQ5MDNNeTxEcs2dZrUtb+3D18inLKTyDmg6yibYYVDYw
         1Vcl8OILScF2D4/+bD7kQYCuNMfo5G9KXlyi6SzgmIKoVqf0BDBeG9M+uvMHM8cPZ/ZS
         QUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yxruczCTVY7zamLHCB5SU5EwAxXIBkMml16iPmxkzBo=;
        fh=p/pgc7oI/8mZHyhxmUbDh9xGc2bBfo2g8JNj57CWO6w=;
        b=kVUNP662aslhIwiqaPV3BN0dRZe049gQwcXd04VrNuvrVAOd7e8k9j7OvXjlTNyhUH
         jbunIJKvjvhwnZnfV2rul4Xy/NPLaEfl5bfbob+GblJXCFgiJYoimIl5sH9V/xPnHSNc
         o7I9PnCST6zxuEpdUzUrDe/Nr9r1rVWg8f3Dcwb4/LBLZJW7EyRXWGP3/tREQyFEj7dC
         83anyydxGJ7DAU9H1td6o5i4HBt8WnXpa5s73dAKh1dO62L5C78zPfrvRaG+O77jOt6L
         BGW02uJ6dcGu5mib33qQY0CSRahq8PbtjSN3BHc8ykM5Z60hVvAJ45PirZ1vL5xe9Q/X
         pcLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577389; x=1779182189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxruczCTVY7zamLHCB5SU5EwAxXIBkMml16iPmxkzBo=;
        b=OvNKuXd36Bn82lHSuGZBdCa7m7NaS9ne4KYb2coJfFPe5jLJhDGIs2i+EPDjk1/ua7
         evayzPf0DdzdDdYXumbJZ0SHyiLRMQC7myf26cAwgqhFSwElgIVqIHfu9I0VlRG8dZd1
         5eJdl5mLPbfk+bWfqrM2GIMy8S6Kzg7uUxspTddtb4tngwnWtUhOqPmF+CJtPbzIyLF6
         OBYxWY4QPNMWa5c5GmblZflThVCgWAk7XR/NkrceeEG3qOJtk38KKCxeWsvReqRUhJaP
         3u/ZHAA65d70z8+JWMzs/CwMqBxLDJUFUOOToVYvtI5xEJy6ArnIRYJQt/fN+dpyDF9P
         HLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577389; x=1779182189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxruczCTVY7zamLHCB5SU5EwAxXIBkMml16iPmxkzBo=;
        b=MI6vnpCweNAE056q/9UA+T9cJ5w/jozygqXdTvjcrfxDAn109f//OgjpZg1nQJh54q
         Z8dlN3XJueL1o04tRXa8liXjZNVOEvMx9qhn88kK3STshicyfXW3G0urhQGfMr4M0dyE
         Zgz9Tkyh+TCkkz7XVN1vUp+NWssWPLvHcpvEPVdujv/C7PKJKhHRw2bbwP6hrBV3Gq2j
         rXVZrFurInDOtuzlZtx1tcqNapTJgmpldSBbGUBDUZJLnBUv4bfjKx48y0eKCw5IlRWD
         S2xgwdropiv3EPX9sSyTxSlAclGueLKx4VIl6XnbH+C+feRuXi5lKZOJ6hefSYJdK5nP
         neTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8m5yD+IkiKIhqqXIXw/ET/NjL9E5KqK9rBXQxkQcL+82DqatfkuzJDxiFvGLDZvwgM7/h01E+Z+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQaK6KgmyrO3Nu06Zv2p8UlFnfxiq3cFE41gJZRyVzb7SDwqd
	S9Q1mGsnSKmZTEPeVEGnZUCzaW4ykYPWwlhTdOCZduYKjw/8SD3J+E4RD6KEnueCYuZMCfDzRpM
	G80cId3Cld3tNPfvyN38Nxw/iS2az1ug=
X-Gm-Gg: Acq92OFHAz3fLzAH72QYQgQrqtsASG1SxchNv8SrhKSS9CgP6R47HF+CP1uhyP6gbCA
	7kCMKjRCmAxPIVkyUcQacJl3021Lf3Br6bR8p0qE7OW4g8P84ssrt6lyxq++KRN0CsAPUYuA/n5
	I4/i3ptkh3ibb3KOAPTraIaft7wmOMl4Jn9u6Wa+rfX37fRCTXHd8pI2dleIXd0602E4o7AVZd4
	hlOqfnwCFbZu+4HqEZgGJKJP0usEHqeWtn5Egwt11cIOvERg64fKjqlAZSReyoK7Xe+g7SocUtn
	2EjbVIBUoe1sfpRFXWS2HRRY16q4eUsnkbnXKZ7q08iOkfqGMJ8XQie8sUGRdsJkmzaDTRqgYnN
	0uDhNlqvmdkhxmi+w5Yt6HJHg/bFzL/kFQi+Rmrjp6LOYBh6Mqj00YUR/48/bhEdJRh35BT7rwi
	UpX3WvCw==
X-Received: by 2002:a05:600c:8904:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-48e6767ddf9mr199455245e9.10.1778577389093; Tue, 12 May 2026
 02:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
 <agLu6wF3JhF9zZDN@ashevche-desk.local>
In-Reply-To: <agLu6wF3JhF9zZDN@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 11:16:17 +0200
X-Gm-Features: AVHnY4KPCa79gwhZ5k83H2qfbAs16N5qyI_UngiDl0oiH7KuXQJzF4b8XfTdFqk
Message-ID: <CALoEA-y-bLur7tBnj61hXSnOdbJkco3zyAH8v_-y8+VFfVyEgw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] iio: magnetometer: ak8975: driver cleanup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 11:12, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 11, 2026 at 01:26:09PM +0200, Joshua Crofts via B4 Relay wrote:
> > This series is a continuation of the previous ak8975 driver cleanup
> > effort, as most of the patches were picked.
> >
> > Changes include:
> > - using BIT() and GENMASK() macros
> > - moving to devm_* resource management
> > - adding a scan index enum
> > - moving from using wait loops to iopoll functions
> > - various code style changes
>
> Thanks for doing this!
>
> Jonathan, the same Q I had in previous version round, can we get some patches
> applied to reduce the burden of the series? (I think of 1, 2, 7, 8 and might be
> more.) As for the series, I think if this version is still not good enough
> (patch 3) we need to rearrange it so that patch is going to the end (as much as
> possible) of the series, so we want delay the 'good' ones to be applied.

IMO all patches excluding the shared resource management patch are good
to go. I can send a new version reordered to reduce the headache.

-- 
Kind regards

CJD
