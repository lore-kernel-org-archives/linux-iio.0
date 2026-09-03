Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F83CB572
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418932; cv=none; b=FEboqnAKHEv1ZVuRNRtudtWChK2TDIK7aKUhj1w0ywZ7nMMQ+weIX538NMMLHCeCCDpoWIsjeG++aIHLW+PufkTZGDyU4H6sloihsp7siOHq8o/Im3TiwHFiePoy4wShDr3z9EvMpUtSWwE9ZDFnmnkgoaqdxLXsY4RoREpBnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418932; c=relaxed/simple;
	bh=URiiWCSYW0GjTxFe0It1760y7ZZo93z00xWsGdIXJ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWPGF2/hcWY0Z0gjjHnrh70v7Z7xAHj0pux+bi5mO3lA0ffAswShJ5RJQ5Rk4X2mI+U7rPsVqQfboAdrk0a3sILZjZL6m42V4N9Gy98qFz0aM8nRzTip0mT3qNiPFD121OJ7l+mBT6KSqdvhyllH+F78IGbKjXSz3eYZ4p0O/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwpwk+Af; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwpwk+Af"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b3d66515so2584963a91.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788418929; x=1789023729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WQWNPytw1GI5Bz7KWMVobnDn5jK6I/E1tnjkaIqtCQI=;
        b=Fwpwk+Af00Ygg/YnI1dO+pv59/fFkuMvNM5X6m9U06WKRnWNnKS+2bRXHSN0UUBiow
         tS6F15Ny7neuSncGdwpLseDCUIASSVZufeCZdkjmoFjaJfJHBfxzNqPYwzEeB5EtbUHE
         f5Ut7w15/TmZpKbfET9nAL10KPgH1dYnPMqolAx1LHIKKQYg7/kAHJ4IsgPsZ3/CNDBs
         gp2C3yDseussGd9y13b1vwgVuGPIYvseuXOTiGjjYk/BgiB+kSMdy8Zp1q8Fcix2f2Xq
         FUVfXcP1A/N2L6C7IGvYDUrQ6HIb4daqPMIaN5iiDjfG/o0CQ8XbVDIVKPw1X7CcpOkF
         JJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418929; x=1789023729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQWNPytw1GI5Bz7KWMVobnDn5jK6I/E1tnjkaIqtCQI=;
        b=BPksPkDdTRQRVQPw60SjYtZz81ct0/ZepzW0Xv+/dZeNeGAcH/J3k7sg9v5gTN8Fy7
         Qq6DeMZE77snmW9Los0GabiYPGCOiHsGZq6/z9KsIENyXy0+v7YtRf+qffLGlBWTkjD3
         bE143GN9whC2ER72V/cG+wSxwEUnY6Ow7bjhWmGh18EjlLYEmSQh02mTq9l81VxoWo4I
         MhATAYhtkN4gxnJAi8x/ad3fKMa+yNV8oBkFdRsJOqhmesEeFFSh+Aw3w2v7p6whhDLc
         j37i/hFpRJf97kGRxXHF+Lo/32J/HYLAHsmaWylzSbxDWD4R2yaC2tVp3m1Ans7nmXEJ
         UVYw==
X-Forwarded-Encrypted: i=1; AKwUvByRJvQ3uUmw3/Qo0zOoVYam+XVOYWEThWC0oqSchDc9VG7of2om5L32IIx0P9J85jkP3g7TqRfrfi8=@vger.kernel.org
X-Gm-Message-State: AFuF++nWsDxbyluciLD+wzjeze+D8iUu9y1bb021RyxG+HiaI6hUro2S
	vaqjvROEO/3ifNMrieCKCBDoeKJEbXDSEzTRY/O8slFMSMHSo4TXcF66
X-Gm-Gg: AYBFou23PzkvxcfYz2qUvGlwIITyz6+gpyGeyaxZTAnKrWXJwH3ayNpdYUbGxfM6GW9
	/j8LXlNG/UEPQJ7jXshYilqqnYRghkp0MdI/Tk65K8+PDBWJ6iorVR7nLXOK8vrDKpxH//+L109
	osRYSxS+3wyzf9bBnoAgFVjnXq93N3WTDbmZO25r19+9UGWw86Uyyrz7fGdf8l5Yfc43a0Mp7yW
	3XRwhp4gBkkWb3e1ftBlzAA7/60YmE34K9WFqq7A7LJ9D8KJ13YmqBSZs0zTQsC8OurbOAh6p5B
	KT+t9J3mDC6NE+jVTJwgmVX9HASdE9J7Za78G/8Xwuo/rLH4N1U4UbXLw1Mt6v2e0R3QPv3qh4a
	Qn7G5yMoLepywFZSfrBT02Mrbrrn0RCEoVhRfudl8s5SVNwRMhNH2c6hs3v7a8eWJOWnua6btp7
	4Cvi2JxkzOhB469ZlSeslIX9iHTs8Wy2QT3nxlTHAok6cVh7Mvyv4wxIootSCyRmjTnazCTliJx
	UJdUlU8QxNR2zM3JS+GBw==
X-Received: by 2002:a17:90b:33c4:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-39aedf644damr13780688a91.5.1788418928606;
        Thu, 03 Sep 2026 00:02:08 -0700 (PDT)
Received: from localhost (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832b85bsm3439567a91.4.2026.09.03.00.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:02:08 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:02:04 +1000
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH] iio: light: apds9306: fix default sampling frequency
 definition
Message-ID: <apkag8drdFFofWFT@fedora-1>
References: <20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au>
 <apkWlzZZIIzVDz4C@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkWlzZZIIzVDz4C@ashevche-desk.local>

On Thu, Sep 03, 2026 at 09:41:27AM +0300, Andy Shevchenko wrote:
> On Thu, Sep 03, 2026 at 03:38:47PM +1000, Tsz Shan Chan wrote:
> > APDS9306_SAMP_FREQ_10HZ is defined as 0.
> > 
> > According to the datasheet (page 11, ALS_MEAS_RATE), bits[2:0] set the
> 
> Can you add a Datasheet link? (Or at least the version and name)
> 
> > measurement rate:
> > - 000: 25ms  (40Hz)
> > - 001: 20ms  (20Hz)
> > - 010: 100ms (10Hz)
> > 
> > Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
> > for 10Hz.
> 
> > Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> > 
> > Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
> 
> No blank lines in the tag block (at the end of the commit message).

I'll add the datasheet link and remove the blank line in v2 commit
message. Thanks.
