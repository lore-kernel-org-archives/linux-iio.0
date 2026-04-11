Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2827F01E
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904776; cv=none; b=MnwYuRF6rNIgPlbjHCuTWz0Lmd29YcFvONopc8eu8vMCvdUayG6Gq9hfezOpUlpnpQOiD4PYg4/xxEGNXwwWfjKWUtWQYdRAniy0t8wKez5GcsitYFBXVkt7FX/AQ8Zg2xrY9N6GXsR46doIunoNZnrDPpPBi4i8GFds2Mp/6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904776; c=relaxed/simple;
	bh=A47CdT8W/ldJU9+4ePsSUJA97lg43ee4+6ibcowyido=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfVQYP0LLcsiQd01IXwmCKpgs0Aiaj4T46Z74jbZDlaWsTdUO5Y+Tl6Ytrbreef9KrF/gm0maiNqe6a/LM2DYJXOCQvhsRxbvfz3y18sgwRXlDWVqMFKX7Dq5OF2HkzYMWe5a4RxPv5vxHlV79MfHXkCkHFmKnDoYRL5McdE6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJooQ05L; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJooQ05L"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d7bdb5ffffso177258eec.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775904775; x=1776509575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/greMxALxVYb9nwCKqf7fyFdZbMiPxwcLxeI6dJ8WwM=;
        b=GJooQ05LDaE+O2jp52uZT/uh2qI4qw+Agvnh7gaPOtKz+wdY/XtvyAaxkFtGBs/rsQ
         +uFKVwbYp8eFgDWmBCy7YbOaAelsLWbOE6dIJVzIPfyjFgfEtrQUHNwxVl7cM4BQPsqB
         nPcCixFKHIV1sKOLeUpJFvTbK+XhQBEh4kuy+Z0Nhl9thNNSDfcP6tzL13RlhNrMpXZd
         yFERM1gbd6rG08NNqNvz7XcGC7J5P6R1tMmJuBzPbgAuZLpgEGSuqy6lZZEXjXXVIHcQ
         8myT0/MAYx1l0f/uBmTXfY5lrOo/H3usv4LGl1dztwwSbHn2JzRHZBTPoOvLxs/G9MGM
         vaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775904775; x=1776509575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/greMxALxVYb9nwCKqf7fyFdZbMiPxwcLxeI6dJ8WwM=;
        b=E0XqrQkgcEo1mhVucxDXe6BPEq67418Wje8AX/6NcBHlFsTm39G348uumFcOzLy2oh
         3v3XtSf4062B0Kzp/VmAgtxiR6MSFYEjxEAWTlu75t0fq7CquNqBg9Mlawnzw0OZD2dK
         riA4wlsfSL5oggrvloBhfBRLczGYR7cqKE4cIERYOiwoo9a7W3CCFt5GaIfsKtmLK8hL
         /QXUaiArSh93kOuIvVIpP/8BXQTa6fqKTiEKbbdnDNtliaxTWHW0gbSrMXdeaO5Oyxc6
         Nhexl7i3qdiWCfbzs0fbVLDGZshcRMDNXG7mzKIMBVHG5p8jHZ7Nho1KTcE2Sdmnxrur
         bDew==
X-Forwarded-Encrypted: i=1; AJvYcCW4mYBGIxTq9jrKF9rdOQc5aNO0B1IQcctqijmFnpO0G7nCuMhJ4raZ0UeSjmTl3NBqV9nBOtAhvks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hG5RPlDNvYMKvuqt19/9BiPFRcBk/J7MKzIQUUMOzGbu9byM
	/onxVTAEBKc7IwjQU5o2yB+p+epqjH7GweR+imcmayXhjdp+wDb4mXJb
X-Gm-Gg: AeBDietXrlNKthxtev1+UhlmawYQMc0stJGOuxxuMb7Uq7rRo/A/XG57ZPm8FadgAUC
	bbjHevE2A8WsWh4vbQI/y4D7Rx6eXoYFM/DnmxjEUH6RsgOk/11d8Pi+D5tljb/g/48ZSXSxQUx
	pkwPTePmucchZIp0NhYzA8IoE6nD/h5sR0hlR9Fluxq4CRHM9AbeScqeNkfuz6CkwvKRa6m+Z5G
	3urz/RNx1pyFoqr1pD6pQroBRh1Cb0Krc2ey6BQp6hThyMeDHgynSgmKuFkIuAx6WnUxUmlkZeo
	ZN0GFttFKiMtMhpdJP+PlhX0ZYSA93CJl1zIQBDInhQsukR0/nthFkenrnvzyKWr96uogJdzCGL
	rwbYr3AZ1+/nSonCpxg1GdDBKGeYgSuj2aa9XcimKzbpeum6U3aiYBUKqXATm7LVb5MX8C9bPdF
	869czgzqggPzJ/298=
X-Received: by 2002:a05:7301:608a:b0:2d1:d434:d001 with SMTP id 5a478bee46e88-2d58965f555mr3946040eec.17.1775904774543;
        Sat, 11 Apr 2026 03:52:54 -0700 (PDT)
Received: from localhost ([45.86.211.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm8496011eec.23.2026.04.11.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:52:53 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:52:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise
 math
Message-ID: <adooAFmov6gF416x@stanley.mountain>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com>
 <adokoNfP-Ueg4yQ7@stanley.mountain>
 <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>

On Sat, Apr 11, 2026 at 12:47:42PM +0200, Joshua Crofts wrote:
> On Sat, 11 Apr 2026 at 12:38, Dan Carpenter <error27@gmail.com> wrote:
> > >  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
> > >  {
> > > -     unsigned long long freqreg = (u64)fout *
> > > -                                  (u64)((u64)1L << AD9832_FREQ_BITS);
> > > +     u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS)i;
> >                                                            ^
> > This extra i char is something I really dread as a vim user.  :P
> 
> Damn, that's embarrassing... Should I wait 24 hours before submitting a fix
> even if it's this trivial? Thanks.

We're not the boss of you.  Do whatever you want to.  :P

regards,
dan carpenter
