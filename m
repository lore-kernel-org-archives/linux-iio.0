Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7633263F
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141298; cv=none; b=JuXyxxvLbDn534sDRYOF+Sa0yQV66shKGbkB6ZDXNRnoMA5UWsNsuNz9oeCPUdV9HvIlqxyrjnxw4iVlln9AeVvsKYrsppV3D4NcY+e+BSanNSvBvCj0Qr26VGZTSRlcFcFDfXwBca5EyVDwwKFiocRfMye6m73iH9UTYffx6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141298; c=relaxed/simple;
	bh=WHStmnriTucDSzlhm3zJI5gXQ5wDhIxA4+oc97QZAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeJ41N7EKyDH5HlXFvej0V3CcJPLm/Gxo7d5S9PPeABn3+QgJYVgpEPee9oqVMbnGS+8Ww7HWzNRAt0uCbroJodZcz/Y0rVVGXLYpM5VJuyKhPHwyYhrX2On2epX2UsDMdOdbRg96rIE36FSsjAaQDleke0stnWedFLuqu4KSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwFtRY9c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwFtRY9c"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so6672165e9.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778141295; x=1778746095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTxHUR+RNBGCtKD5zZ+4qHnSeo+jgT6o0fAKdMPVLHE=;
        b=bwFtRY9c98u2Tmn+5cFdRpGXhrWlHKyc88S722tSIX5Q2Vv48wblEGaiEJq2s+VAeJ
         0KVeU0tmioebEeaDsc663FAwCXaLdbBSqtX+8XPOrzrvrkDRPK1r/9H2j5sov4XhcNs3
         TJFclA0bbVH+FAPY69wwmA1yEzqbsYjnmGX+pg+1YZS2AtSKl/EN+o2Y8un+y6xpGv3a
         0exxWVY6Fxud0n/kITh7wuzg5CZ2+AONTXISprs7qDLiOpGM/voWz9/7UEhUAJIp5djJ
         EwQj5IiCLpFzJOg4vG0lktNo3TL90Ifh9rkXSgiWsBbc2GD8R2Ea0xw72NYJvYCdnKJB
         Ig1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141295; x=1778746095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTxHUR+RNBGCtKD5zZ+4qHnSeo+jgT6o0fAKdMPVLHE=;
        b=GL4ijCGi9kee8W76BO1pSj5tS6/oavO5gw6Fr49gQPpph5AYSF7aooiRNNB/0LoYHo
         xONedCQmfMj1C3FVu/5KUSs2/6v5ER1Jvyal1SFd7uuehscMRf+eWWd+R+RmBkaNNskS
         MwSnGDrebTTZEBzK66l44e7QVJ8hjNAkxSizobP35xgfO6BzQBJM5QtHH6dUexaZh4RR
         yE8YA05gkpxCkr2xm4KUTa8qbSdY5ZLnU/iPA/hdDjDNn+8kL1/zto5eD11TYDHSqgjQ
         5IjG3ReS2lFm+C/mWfisLQptMvqo/M/aWfDX0JCoTz0RU4+4os2BWxAeizD1+oYAoHpW
         70Cg==
X-Forwarded-Encrypted: i=1; AFNElJ/9GkUuo7cAWJUgkhF3HLtCzvpT9+cs7sZ1J38SyExF1oZtJAJ/UkmxU+QPtrBvobIglxvZkZkYxjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgM0Klj4LF+dra9W1ogoSitHYQJdu/UZ5hs96pgOpGtg+74G+H
	YXEYxKj2lITvt4JRouF5Gf5L+WzM/t/9EBgV8T4G+p2xGB/ZcTRr3uao
X-Gm-Gg: AeBDietMAuR/VilvgCnwxtp7x6lZdOC9xfy+STi+FV/MLyz1b32KQT03/7VurMMzmly
	/hvYSvMV3H1Tzeay8Rwl6R2PoA+F+w1P8FQJf017oUEUZ7hTjOmRjYFaKaVfdXHF3MW8kNtqPQO
	qLn+KQd+lV+/MfxzTClXrNBbAZn44kA17IZVxXKnwukoGDwGEnneKTo5VG49/21W5UNedU6oLIs
	oDlDBwQb26c1noVoyGHqUShm2M0P0eG8ABbtAS38LC43KP8Crw1/x1wxwyJYwicHmj12NzNKmvQ
	Ob5kLhaua/t/ygaknx/oGSSeEfSm6WRCZ06/95iPzDgCMAb6Qrv/D4uB0FhiKTDDwULK6qbsL3D
	uNWIdMy3eZxkliiDwfgFgUgpF5V2ZUqJJW1gV/qbfMKR44UwSG9DWK8Gghbkv8R4aF9DHBQdE5a
	s8kuVJTwfBZE2ezXpiX7FZpdJcVw==
X-Received: by 2002:a05:600c:35d6:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48e51f21e88mr116960785e9.5.1778141295386;
        Thu, 07 May 2026 01:08:15 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm191166735e9.0.2026.05.07.01.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 01:08:14 -0700 (PDT)
Date: Thu, 7 May 2026 09:09:08 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] MAINTAINERS: Update Analog Devices IIO drivers
 entry
Message-ID: <afxIT92xmV4bM-4T@nsa>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
 <20260430190642.3434650-2-sanjayembedded@gmail.com>
 <d859d9d22fea4af4dd23221d407aff055ad52524.camel@gmail.com>
 <afhMWfXd6yVUsDDo@ashevche-desk.local>
 <20260504172247.58e833d8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504172247.58e833d8@jic23-huawei>

On Mon, May 04, 2026 at 05:22:47PM +0100, Jonathan Cameron wrote:
> On Mon, 4 May 2026 10:35:53 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, May 01, 2026 at 10:05:11AM +0100, Nuno Sá wrote:
> > > On Fri, 2026-05-01 at 00:36 +0530, Sanjay Chitroda wrote:  
> > 
> > > > Lars-Peter Clausen is currently busy and is therefore removed from the
> > > > ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.
> > > > 
> > > > Add Analog Devices mailing list as contact for the ANALOG DEVICES INC
> > > > IIO DRIVERS entry for coverage support.  
> > 
> > ...
> > 
> > > >  ANALOG DEVICES INC IIO DRIVERS
> > > > -M:	Lars-Peter Clausen <lars@metafoo.de>  
> > > 
> > > I honestly got the impression that for the entries that had individual maintainers,
> > > we would not touch them but maybe I lost track of the discussion. Anwýways, if we are
> > > just relying on this, then I need to put in here given that these day I'm the one
> > > taking more care of the mainline stuff.  
> > 
> > > >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > > > +L:	linux@analog.com  
> > 
> > My reading of this patch that you, guys (ADI), have a public ML / distribution
> > list that you manage now inside the corp. Whoever is in that list is
> > automatically will be a potential reviewer. However, it doesn't prevent
> > (and I actually fully support that) that ADI nominates more Designated
> > Reviewers and/or Maintainers.
> 
> My intent was:
> 1) This entry one got fleshed out to add the list - given it's a catch all
>    that 'should' get added to all ADI related patches (similar to the catch
>    all IIO list adding the linux-iio@vger.kernel.org list and myself +
>    the 3 reviewers listed there).
> 2) Any ADI entries that due to stale emails would have no one listed,
>    were removed so that this catch all was the source of truth.
> 
> I'm very happy if Nuno is willing to be added to the top level ADI IIO
> entry now Lars-Peter is off doing other fun things.

Yes, it makes sense to add me in there.

- Nuno Sá

> 
> I'm also very happy to see any additional individual driver entrees that get
> more people on the hook for reviewing :)
> 
> Jonathan
> 
> > 
> > > >  S:	Supported
> > > >  W:	http://wiki.analog.com/
> > > >  W:	https://ez.analog.com/linux-software-drivers  
> > 
> 
