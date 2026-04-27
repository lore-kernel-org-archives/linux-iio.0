Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAC306B3D
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289502; cv=none; b=BAoZRyNCaE3skGmkS9jzARb48zOsrdkkMbj52+EcU/xwt7LyuL1u0xe4hbIufT/QJRT4CIZRtXn21s14XMIPFGnvgmt0fEjuMGFE18MNRE7FTpGj25EEve+3rPOCpVNR7nElGyQ11dBx2IbEdgbDI6lIrDlWvRW7f0CxxHiBRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289502; c=relaxed/simple;
	bh=BSKeNmldHT4Gnyu3PoZpB2N+yepnrwlBw7UytxqJLDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJnOMAwurN7Dxei3tGFphCIYZ3FkrWkwm8jQsENjmgi7uTKYiyWdkekuybHUOR+78AzlFnJOUyriQSiEGmPDCUPnWbW5457lYBPcl9IhYG96Vne34dW61aXev88+dLYCNTdaNHvT8OUIXTA+NGie1TG0YjW3Wf42OtT4CRdsS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2PS94mM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2PS94mM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so93294915e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777289499; x=1777894299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oczoMnPReZaIdQXexoCfPQETvMC08e4WB9/AECl0kH0=;
        b=b2PS94mMgMzzACiK70mb0ZWH1D0Vs8ne6WWmA9RT8Ev7tOHbNY0RqtHV0sXXsj2D2P
         kqYb+Xi4OAKLstwB9ol6sTalNCVhdjMN4Aiy96X5RGlhJD4S052mHWpbPGJlnhc3nSG1
         zhqGi4vWEU0twTDDKM0GzyATuU/L4hp69Gg2ROJzPQiDRTY5T2Kb8Dy+aXnJySNW6YaA
         Kb/kVX3beKMXq7tZBrWWei28dMxglf2O25o7fEbY8MwLKr/3dg8sl3AQtbRr3qA5b6xK
         2p0RYoOiScW557p38VFppwzg76pz2V+gh+SR7xg6qjf4+JkoNma5D7htj/dcD01qnaWR
         K2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289499; x=1777894299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oczoMnPReZaIdQXexoCfPQETvMC08e4WB9/AECl0kH0=;
        b=MbYfYcaT/9oJSIo42oyvASnHla39PTgcZvkf2AAY1vQkI15SYjndQmDm/Krdolilhq
         q9NHo3JCu/KvJQR3+hrzPlplTsdKom1LDcHDRtHEydI/a9u3YPavLG661wXDD/f0es9r
         n6waomvs3jmbtSA4wlLD9BoLbeavEjZvzFX4CPIdqVLoOox1GDWYkzoXzN+aoiQHAxak
         3hJA9ueDnYgoF9Ve7sFX8XOzx34mPCFkVxEPp+W0UNCnoXW4oIFITwzxz4qwaJ9Z/f16
         j92nN2rmvAU78resVO2IRGZtXBdQvICrbMKZwrucVnqP5JJ/d8X1Vct/ZMqhbyHyOmBG
         XMVA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xpjs57LECKg2jt83Bl6rDrCwRPDjhKqngEswJG8krPP1BK5m3xJrmfXgmRqY4C2mr9I0PQrQS8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOt/oLSVRfTh9Abl2GuEVypwtsUEkx21dCv4VroTxitoEGJr1
	hpbOfz8vNZDk3RCxWEsqGQ9G4xsRnNUHL4yTF1iF2saa3H7Kj4MTluqv
X-Gm-Gg: AeBDiev1f8Siyl7LSKSTgbHgXxf0xlS3yOIivTAA0VCUV4WswERyEvfem/E2dXsMazA
	zx/YNGrQaN8CPc+nMJfh+fCI1UbMLTfRdC2KNJKJGDIrUJhwyIYB4yAYR+LxEn2yt7jAHv5fEy5
	KIuqaPhF4mpK7WYckNIhnm1EGi2NKHcrgjAJRFXRay/0PJjJEBvvXPX957C5jm4Xs2G4H0nF0u4
	Y5jbvNtmy9E7HmuW/4XowmBTIi/hn06v0CeJYsa/lIax/36c/Sw+8DJ2H2aZP+1QYstfwvnFaRB
	wgPus9aW41oNOX+6PjLT6rkSevOmoBF7HCo0Kt9KqvCdo+Y3uOLiJ8r9MppgiBkfuhORkjr1Qmi
	6Q5IeUTnIbh2z9kNKKGcvLfUeD1mPgl8hICcl6N+SlOPAekO9i5SqAOJ84Vrqev3ffMpGunXROL
	GMPaklIEEaDguZSNTsEvAvkwRNlA7VM4+xMw==
X-Received: by 2002:a05:600c:a31a:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-488fb785b7emr456261975e9.26.1777289498891;
        Mon, 27 Apr 2026 04:31:38 -0700 (PDT)
Received: from pc ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a59816b71sm221145305e9.1.2026.04.27.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:31:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:31:34 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <ae9JFucpXBPwwGzr@pc>
References: <20260427085458.38546-1-salah.triki@gmail.com>
 <ae8pAGBGGOvsURka@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8pAGBGGOvsURka@ashevche-desk.local>

On Mon, Apr 27, 2026 at 12:14:40PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 09:54:57AM +0100, Salah Triki wrote:
> > In mt6358_read_imp(), the return value of regmap_read() is currently
> > ignored. This is problematic because if the bus read fails the variable
> > val_v remains uninitialized.
> > 
> > The function subsequently assigns this uninitialized stack value to
> > *vbat, leading to incorrect measurement results being reported to
> > the IIO subsystem without any error indication.
> > 
> > Update the function to check the return value of regmap_read(). Ensure
> > that mt6358_stop_imp_conv() is still called to clean up the hardware
> > state before returning the error code.
> 
> Sounds like this deserves a Fixes tag, but the problem is that the whole driver
> is written like this. Why does having this fixed make it special?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

You are right, Andy. I noticed that several other functions in this driver
share the same issue. I will send a V2 that addresses all unchecked
regmap_read() calls in this file and I will include the Fixes tag. Thanks
for the feedback.

Best Regards
Salah Triki
