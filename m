Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28C26FD9B
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580553; cv=none; b=sARx9B+OibGWEqMrRwCZjPNCp5UTUVMHoUEpdwo55hiAOiomq5PswIG1/zju8FPYCVQZ6jlnjrdjNrxA/n3zVCKDxzK62xHa3zAJQyD87lNjaTmxgw/HC7lVq80qJ2aEWz110d2gnt8LyLp957GRvjHOqPHMqL1gAVFYHAENbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580553; c=relaxed/simple;
	bh=YkGL+8OWzfzNL4BL82YnWACzyPonv0nntW1Dn6Yfw0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzNKS+MpTfjJqheY1x5XfZutvK5/ubfaDeEF0sFGVZeRjF6Z4TGRqDYWIye7/lc52kU4llXKzHiK6q1rPWzuVbpGfI+DkGwS2HpI4+V6aPGDUYY+K1iMwOfKg+uJFTzZI6G+JOrBdBNkv9FMeWKiOY5Anscg+B9r/lqf31S5yUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pD7O2HSv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD7O2HSv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c998fd549a8so151928a12.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 17:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786580551; x=1787185351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AF8wpPuyX4sWfpPVXxbI9o1gqUbanF1mGwjEt+cOwvM=;
        b=pD7O2HSvqHmKTN8VfqYZ1GrPUkVVh0ZPIZYKVwo+Ki/N0RM0Z/TRJHhOFSrE39t4Rn
         QyrY3EDlh6pez00F+rvoXWFkhdoHinyy+6wBwfTzNH4ASkmCC04bYhf3Z/Bs2d1j4+Qb
         zC/oZuT3ErphPGu5JSk0pZi3YR/W40SZugW+WFo1AtyBbflpkymI059j70R4ejKZG4XL
         Z9Tjz/G+N2d8z81so4mwVpQA7AfNuooUECZOwiS58g3HZSN7AvswFWmq8IGKUf8UtNEJ
         CytQSRrhGODEr40qJAtisJw45YBrzLDIfphwqdhOceXznWS3PMJowzkUvl58dj3QqLdf
         EUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580551; x=1787185351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AF8wpPuyX4sWfpPVXxbI9o1gqUbanF1mGwjEt+cOwvM=;
        b=oWXdaa391CHxKSNkEjMx8VLwqdmq8xvz2JmFPWuj2c8yMNkBd3EloRXllKuQV8whwz
         hLZEv8nbi3noMjLprS/aMV+98raPW/f4pHOxhrNqhV8gYDNyvNqqsccsmGsO/aL2t3Nf
         uPZGAwxmqRI6i319rD96sGGYrl994QdeLt1C4s1fDqBshjAAX/F7/tHcjNX11Q5ybaSF
         S6umGk/kTDFzO3T/SEnHsZTiGTURwLAyozPyEHY5DpclrnswQzCXmgvltMaVMFAu6XQz
         4eKMvVrTtjnygD6NzIwvmuIMpnhWJkLlCJUi06WKQFr4o0XQeodV2eaefwiBNQ8ELxwy
         ZsYg==
X-Forwarded-Encrypted: i=1; AHgh+RrF1ieL30DkkZJvyIqUbbsjr7WmUlbuzSW7lxLBeAjZPcFSySFCgWTTHudomp7zT+NP2QqH0a0H4ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqs/xRhmwliTU5WvomgRUnUuQrcw9RLnOvqMLwIwDVxyemrvv
	rOZQCD/IArctiWg0mmsQLGTStg5Ph22RX/1XmVjAFEn5FtDlNjB2IbsM
X-Gm-Gg: AR+sD13jpIWJFZRqMoMEChB3f6aOsBa+4h8HPOK2lDmJGazA3b+/QlNTWIVG7cfT+PW
	O+vVx4dfpGEMY9LOa+P4ajbLGh8hntLk36b+5tQFPC+lg9NIWbbSYFWXkJvHuDyC+hpCdy9V+D1
	HzLFFfyDFaVTOAPYv/pGrt2Mc34xmibA2nGcEaO/P3eQBOQeP4JvNAgydx97TCwiOklQhdkfOjx
	BeimREqpnUUuo7Ygc/sS/DU713TuJxv9sp5q5G2BIi6mM87VzPR7PQrvvVoa+MiIQRngO0lVnSk
	MHIyFSDJNdocZKJyZmKVhb27kULomnwu5wcXttfxQCN2rRj0B7zwQr7uGPR4/f8gWXSMPYdnhcB
	8pi/xloWGW2FmFBOxyKF3FyQRzG4xFUBzx/IOoEXahZ4s7asBM6X9XOJVsavTSR+fs44Drkfp0X
	+LPCTR0GqcgR025k7NzDuFQf/mxzQVW5Nlgi/m/vvJngQWteGfOFHKjBV1YV3QCJ7KAAleZQr6T
	hIGyIVIwfPBZ/aAVDjsRdE=
X-Received: by 2002:a05:6a21:6007:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cc552420b8mr2822127637.21.1786580551381;
        Wed, 12 Aug 2026 17:22:31 -0700 (PDT)
Received: from localhost (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebfc3ca41sm1073365eec.21.2026.08.12.17.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:22:30 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:27 +1000
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: use correct channel array size
Message-ID: <an0Mx5C2MMW2pvUi@fedora-1>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
 <20260811-vcnl4000-v1-1-50e7fb657692@jacques.com.au>
 <anrxEpjjlPVOnR2F@ashevche-desk.local>
 <20260812043914.4181b413@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812043914.4181b413@jic23-huawei>

On Wed, Aug 12, 2026 at 04:39:14AM +0100, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 12:53:22 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Aug 11, 2026 at 05:07:24PM +1000, Tsz Shan Chan wrote:
> > > Use ARRAY_SIZE(vcnl4040_channels) for num_channels to match .channels.  
> > 
> > I was under impression that I have seen this patch a few months ago.
> > In any case sounds like a fix and hence needs a Fixes tag.
> > 
> They are both the same size == 2 I think.
> 
> So whilst nice to fix this I don't see it as needing a fixes tag
> as such.  It would be helpful if the patch description called
> out that the ARRAY_SIZE() of the wrong array happens to match the
> one it should be.
> 
> Jonathan
> 
> 

Thanks. Will update the commit message and send a v2.

