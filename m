Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E83603EF
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284611; cv=none; b=sqfjVEyXwpR+fSg2Ima0ug9T39ceJ79Hu0/f6JnRbeTW8D9IVY2r91OOBix+3e/n0VNvFVgWxuIIpVnnBqPOSTQpnTXt0IOWWUDiYskEzQ8P1iLRUWlbQtUo+fvxpJIkcVD7dnj7JgGL8K/ScRq6ta9DM8iF9y7+931FlSDDXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284611; c=relaxed/simple;
	bh=/X33/iICLseFc95wj7pD1FOKdI6flO7WzOt3aXw43zg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3TgRigDiG9occXV8h0pCk57uuzO8+sSGlFRjYGAHhqML8eBZTlrArvqhqDs6VbB1oF0PvipFW13F5Ye5oyG1ObTpECRgHJhaLGgtfGpggVu4ARLBAxfGcPux8IBQWAo9bk2+RLQoHdpJ6cl3voBGvH8x6MogKiHaj5fdC31wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6CN2w5R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6CN2w5R"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso12408478a12.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284609; x=1777889409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5/W6QM7qivx8frrgYshHL+2rWPwsWfWU5UIHVZZNj8=;
        b=r6CN2w5RvoQD6lntOdJwA5FIv9LaWZpJZIN0qqEMMw8QYolaYIYwMSG97yitePjya/
         hIj+7qoqw0GHwdqksVpc1Lfc5tWQxWI9PZAv0tbF8Kq+fBBGiBCygrGAoS7FlBsNa/io
         2Ip10wPaP0lyvFyp8du5TRM+vd8n5XZs7cVivuiZd9rCdpRwe6tJqFla7U4huSqG508n
         AeGSSNca57/H7xLfIsDfrJz3BqteAiZElpAUV5HH2DUzM8QQIaTcmoQKN4UrvSKQUOB4
         ZmgcMoQngz8bOcpSuIe+rsPbv3A4ckiMXNPuL2sODEOCpaqWbvkDf7Sj9MjJNVsklGvx
         tV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284609; x=1777889409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5/W6QM7qivx8frrgYshHL+2rWPwsWfWU5UIHVZZNj8=;
        b=r2FMSdSI5N5WYQ/maTlE1p4fqeJFUqm+KqD4I/+yrxNIPaIXMM+jEhlrjfLAlqF33v
         yzNZYSZUOO6X7Qo3o4op7BThpYtBHXH1JxNO+Hy0xImLqsaTwi9K0Ps/AYA2VXArQZAm
         KoOxLekRyMOlCmLCni6vqRmOu43OHBWD/dQ5RH4TwGvB3S5SllwVzT+5RiERxjQJLcv3
         +LKkNNrq1V1dRtaMtt8Jt9+U6Xq3CLLgH2WhzeFCdqAjupDrIOgPkxL5LzVAuBZFJL9t
         pnG65fzXEZXwlgMAM3s4TlYqseGUzxplQC48OI+4AhnVrv3jbUBnUKhLkdk4Pln8yk3N
         zUIg==
X-Forwarded-Encrypted: i=1; AFNElJ99IFDNNiGzsZlKNxGi/IMzPDP8qhxn/5eW6hymKqgyiCnH/Oz9upHX57EWHzxNbPFCFLTiWjYhBFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67OU3dcaXOoXjlxAIGIcv3jNmupA4xWrWFXClAfd6Ifg0De8s
	4JFR5W2aDyr48PoRmJKbptTyPp3/K75yHGpwoSuyX6spS2PwcpC3D6YO
X-Gm-Gg: AeBDieuyE/Mg20wQAKjdB0HVOj5HOKWiRVpm6VloHecagwIvk5rpzH2YLvg5dUyjvLa
	TDxZoWbbhuQlGPYJcuSh+4KUzcpVD8jIUZAbVnnyrza2qFsfNoRB0ts7j2d4LftF+Q6guCzuHXq
	phdzQcp3DaFZpfK0/H4bdPU1rLwhq8iC8lbixAdW37WYF3MmFYRDmsle3gzEPMVxcWALpNtdljq
	yhmCPeJ/NsisFVpe0XkeAY1BhpNkbkDuifQF1OCnUuATt7jYowL1k3illZomEdKaCp/mTHFxWzp
	hQL/1bhF+C+BXjSmnrfZ0YSvjBBU/TUzBmcGhHetUaln1CsWOazEVZ+D4u5POaVR97I0ZZeRh+O
	+V+l0YksCbbNRXhKUfjNwuM+K/LZZO/QiNZwqlxZ++5S8hkZvLjfeKbwIhbT6X27MJL7VZ91EQr
	c3DxiShRkzGaIVTXouzq8tLBWyezvw6c30e/VS9xp+abFg0cW+MQEjNBCTBu1NvxYqzOU3YTDBg
	SuuHwByQ+DuUtavLyKJid3509ZhhRmR2itCd9vuMakpM1RBt85WntHKX0087M1nCSRjf4xX
X-Received: by 2002:a05:6402:1e92:b0:674:ae37:ee1d with SMTP id 4fb4d7f45d1cf-674ae37f0e9mr15162404a12.12.1777284608426;
        Mon, 27 Apr 2026 03:10:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d51820sm7089652a12.22.2026.04.27.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:10:07 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 27 Apr 2026 11:09:59 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/10] iio: dac: ad5686: remove redundant register
 definition
Message-ID: <kjqs2ucnoqud3o3ilex4kostgzxhvx2xphr2akeneiwqw47q5l@veqdwbx7xzfw>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
 <20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
 <20260426143211.1d0bc12e@jic23-huawei>
 <20260426143824.463af045@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426143824.463af045@jic23-huawei>

On 26/04/26 02:38PM, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:32:11 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 26 Apr 2026 09:38:03 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > 
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
> > > and that is because they target single channel devices from the same
> > > sub-family. There is no reason to separate them and it will make things
> > > simpler when refactoring the chip info table.
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > This one stands well on it's own, so applied to the testing branch of iio.git.
> > 
> > IIO is very busy at the moment, so I'm trying to pick up anything
> > that is ready, including individual patches from larger series.
> > 
> Dropped again. I didn't read on far enough.  The fixes in this series
> need to come before all this stuff so they are easier to backport.
> 
> So dropped 2-4 from my tree pending that reorganization.

I am getting the fixes first. But I still see commit 2 and 3 in the
testing branch.

-- 
Kind regards,

Rodrigo Alencar
