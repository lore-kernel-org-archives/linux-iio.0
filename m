Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2328C869
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450598; cv=none; b=KZYLTSMacTMF/YGJgAHJebfc54Ktlt8A+2D7it776w6nh1+jcysFLjNJxLqkY4onCkfl4lR0QlQNjOMgcu/BAt3Xm4MhNGyw73m9owDoGuntrSOSXPQZTAvJNcTsR9Qw5uj6id/0bZEBBDne9UF6OBKgAtVrTLTstPBAbfLm9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450598; c=relaxed/simple;
	bh=p4Z+LkdfxNMxnSbynDgzXYzNKdDdBUjsPk5nyBozNS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhRGPwwMzT7Zkan8MvdPMm4jLQhZhhBJCiQnYWMsWWzHUhK3AO74tlXq0J++EvZwpfROH9iY1/cKn4MvMyaBEqT+7zrS77tSGx+5RTLbso4/Irn98gRE4rtLylXMJKseRj5xAdEi46R6pTdDohIPr8AomyZMimY5mpfv1cP5piY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv9lj16r; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv9lj16r"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so8388169eec.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774450595; x=1775055395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wLnGR0a4kOSYaA+zKfjvV1Pl1oVPkgUObtZwH/qq2M=;
        b=iv9lj16rcDDZ03mf9pM1tNkYiUd0ZkCcJaKoV5oZfimX2KcwiZSCLwrNS++KVI+xh+
         CbBPtRAOtP9HDTcPWHjjkavclaWWzuArpczTXyIqGQJUUbJ2RkzlUg92oWK3fEotnkHF
         0dafgzDsifZvVkZPbCNUiCr0sgPnPYw6q1VIpCkc/eeHYfYbVPV++EGMBHyaVG4spfDg
         kKn0SWrJV4uJs+FSTM4FLg0C9tydi/QGhYjil3ngQtixJloVoX5vZ3IEgXZqqRWDuXy6
         42Dape+qVldnY35hXz8DAZ5JVlwGvX6Ke5DEAI9uXC5U1PG/14Sh0Gcs8K2xOf0Vq2Ep
         re4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450595; x=1775055395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wLnGR0a4kOSYaA+zKfjvV1Pl1oVPkgUObtZwH/qq2M=;
        b=s9gy2WYucdIRgJ57aXCF5+ZLr6Gp2kZODBe/fbXq4tV1YzPohG2kWis7Xhp8vgBs7h
         kiNnYkFAGFLiF24AzSg4e5vJJ9W70U4CaWw0vKFGsJ740ATV4TUN6PpOWZV0ysNmGcIj
         9MwEQyrLJvLdpeI8Fk2uIPILi9foEWvcQ1f3joi7w0zYxBBigCDErjZkJ4IYEM5Gl5Zr
         IUIYb0mty2XSpb1Op0i4kTz4zm8HObetzxhpKPC32814c1UHmKrgoob7Wrc9AYNmCXr1
         HrLKQpdbhrVU6FScas4/OLX/l0sF8Ph4NLdIqHWlqjedcr8wUesqQtSJSijSjMdFKKnW
         mAmg==
X-Forwarded-Encrypted: i=1; AJvYcCVMKtqsspq3XzStutArr6H1j9gMiExoSeDM9HzbnwDUVrlATxbOd58RDTrCtx4IOrZskKeSRHbNsc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FChPjd+00dA5ANU71J8WQ5qbmGxse/XLQy7trPAb7M/NWihK
	SexkuS6JdBV9kEv95qieRPbGsPgbr8FKgWoA5Qpetw1XfDKwRnl6kHPY
X-Gm-Gg: ATEYQzyrH6YdNSNFBt7wRalUiltW8eCPUmnlinkfXHCQmKdZbOMx+390vX35jeJUSqs
	duO0ZvgyWTIi2YzmpUNOCGioMCVnUr6vMAdjQixRR7MOdQC9yNHd3kJBjTf4zYQBON7QkUaLgXz
	bQFC+Phai+2EdG2qFXo+JahDmPWk7rhx6E8siuyICaepFb36mTwpHmuuDYGTqdNAGhR5BWSQ90j
	qYK/s0cAN53d9NRd6Hbn/5nHMKRXdQFRzybuhgBJXyOgoVkPQ0oEmcNqwTC6sWun/gi7zJxkvXl
	/G+p1cy9bDuTpqzELsXd6Vm8OWB5PHikQ8w5Li37gS1b6B8oDizKNcmAHWw8KRx7WUw9LWolV01
	ZQnBDDB/jkjsioO0wXtnfHxiRNp9Yaz/j5/kvHcgNyn/fcxm/8T08c8qNNEqAJQ1gYLQtbBKpaz
	bohjfeEF6o9vnTYO5UJbdadwGUrRMH1Lx6xPTci2x0/poMLz/XvPPnTqNqjv0fRJCQ
X-Received: by 2002:a05:7300:b505:b0:2c0:d04c:a6a6 with SMTP id 5a478bee46e88-2c15d296064mr1960160eec.6.1774450595217;
        Wed, 25 Mar 2026 07:56:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c99bsm18578637eec.1.2026.03.25.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 07:56:34 -0700 (PDT)
Date: Wed, 25 Mar 2026 07:56:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <acP3aiLCZkYEXhqc@google.com>
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
 <20260321210539.2de04bc0@jic23-huawei>
 <acBtUzrkMGK2Wd19@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acBtUzrkMGK2Wd19@google.com>

On Sun, Mar 22, 2026 at 03:30:21PM -0700, Dmitry Torokhov wrote:
> On Sat, Mar 21, 2026 at 09:05:39PM +0000, Jonathan Cameron wrote:
> > On Sat, 14 Mar 2026 16:12:24 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > 
> > > Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> > > when writing the timestamp in the rx_buf.
> > > 
> > > The previous implementation would have been fine on architectures that
> > > support 4-byte alignment of 64-bit integers but could cause issues on
> > > architectures that require 8-byte alignment.
> > > 
> > > Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > Since we were looking at this driver, I was going to convert this to use
> > > IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
> > > have an unaligned access problem with the timestamp since we are
> > > ignoring the first two elements in the rx_buf when pushing the data to
> > > the buffer.
> > > 
> > > Unfortunately, this will cause a merge conflict with the series Dmitry
> > > is working on. I don't think there is any rush to get this backported
> > > since no one has reported a crash from unaligned access. Since fixes
> > > should go before improvements, we could apply this to iio/togreg then
> > > Dmitry can rebase his series on top of it.
> > I've done that. Applied to the togreg branch of iio.git pushed out as
> > testing etc. I've also marked it for stable so it gets picked up in the long
> > run.
> 
> Cool, I'll rebase and send out my patches as soon as this hits
> linux-next.

Hm, I only see it in "testing", not in "togreg"...

-- 
Dmitry
