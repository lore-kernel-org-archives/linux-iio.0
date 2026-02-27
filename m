Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D943DA56
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213516; cv=none; b=s3caVTToYyPNv4LemMbsVRSdnJCpx4IEX+TAnNPpnJUL9cIT3O3EiF4r3ABCrz6g3lmxz62R3qNJlpQJJbiXDFwdlXfoJB3q/zD+tOuc6tv+JcecDfrNH1mY+/EcMmX6+HdC6YIT/hVHXEvQr3DNV7vdWnq1RzGlRHZvmV3jFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213516; c=relaxed/simple;
	bh=jw/s/pmKWEhmoD7t7aQ+CtY5TN0SN7m0nJ9Xg6Tkuv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+IHpQ9kvusgpDdoR18NoF3UWVmAgcRytYLOu+HyMimgxmsp/GHuPHw+5h0DclZ8JMaSRIW/6oWoK8fEk0d39XHdFOjc3UyIRG/32ZkgrHIK3jXE7HhhcppDnFQ4mVDhkr5SSRIrDWdvMQnN0zgiujVeTDDl1q9m/xGsz4Essls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPsZpIvX; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPsZpIvX"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a88bfd470so1712301e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772213514; x=1772818314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAky2kCQVWEtl6VMaguRiQZeQV4DBOQjkcY8czVQl0k=;
        b=hPsZpIvXs+no3Q3jFavWMAqAEVmf5kwJBM0y+K2GzdqLQK7gRR620xWTVBmyvM6PlP
         9PwugSCz9PAlrtF/Lhlv6lv3Pcr9E6Z+kT2dKyMSi+3Tj5y9I/HEQnFEM0h14wbK8EBM
         OhnMu5KYX5s8XhME/+FZMTR+h/0Q0I0PfEDH/+BXlMd/VpTqWvH3Os6KL7m96ESEVWJz
         1anqJ+K+bgDSgWSzMmSKID3CJmLNAWGw0/WA1CHJTPsd0+zg5Ju3jcm/M+s4lWKHgbjp
         ARMZsjitBp9QlQjZoK8isBZs2cEoSh+MX/YlrW7QRbmqR/GzuxrKtYFDBXcl9cI5xM3b
         4V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213514; x=1772818314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAky2kCQVWEtl6VMaguRiQZeQV4DBOQjkcY8czVQl0k=;
        b=jVk00+9OJkgl0I2vlovwWT6dKIp2APeMDFYlx8gLWn3J38jbURjqpiI/5p9QCCw0Ra
         g1iup9qbo8oMiflTu9sxtalUUlXamvHIJHF6I4bb76lr1tBPUAqoy7Vh5cleFWzMRTXb
         rr+YPyZfodR1sDJkNdfiIin9vji2Sr8+vUWm9NUcKe7jpb3WDDA0j15J+YWWaFDm5+Ow
         70av9xSSHMvGNaEMoCepOfzcFq2F90v4CWhSC153xoRUIWplexT0Cn6xZaJGVFuZ0K61
         VE5nAPPVAP0Ks5OwXGAEK31b37xXWrP+LvROL5PyJcT/fv5GoWGDakmZZE5WpvdiFyON
         LZLg==
X-Forwarded-Encrypted: i=1; AJvYcCUK8N3esluarEKHmpjY1u2mGnaoAzIlbR4OFiFplgvCYnisnk4dcUhR13JFfm4/ePo17tHqP4nH+j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79DAoOlza86+zVtAifV+eKjvCrTxbm1nGHKMgJKI/RNSID8L7
	B1vSoC6diaXHBOi472A66Uad9Bsfp71HwCJPQvcw0jI+Lq/OijH9TQQX
X-Gm-Gg: ATEYQzzh417SyBQJsc+F7OkemuJX+Z9sf1FcQc+9MI+r9l2OLA7L2fVjHYRM7gaTUz9
	0X9zDwNWv043nZg9C0fN7wJK9qqfpYxedZJseSiMIox1I37lfKMJk4xUgPA/6IUJIi2P1Kd+xQm
	snNlDutECndgNw5VwQDpuZCzeYgKpswG6gxJXVC5enITQJRnIgqMj/jNsUEasxsszwJoMup6Ff0
	QnowveOWiTdzOHnAe9Bv1K5BJu8cyuuFq/Pdjd31apDcx3Yt5oWOQop0X0g37xzK2/Vrmdm3/A4
	5PLuOXZCHevPdubKMlH0hh9vu0mnxvFcM7uNltwsGGuQpSbtP3Icj2wof/zzDaBq27a0PR9nxMW
	oy95WIXLvwvxNOz1hqFhmtvwxdzZriezIMey0sG22IeuoTmzPkeKJN2zcdmp3hp9x6T1CDj58IO
	AB2EVgVPOfNw8Q6d2acGy7XQ1H/RaT+c6gOOAMob7OyfoADJiEtW7DjcmUb4k8weD7/bTGvSbFM
	rMsm6V8yy7fCqWQ882JGuTyM8gayFSkvjgbcTlAocu4oaP+vwCRUYYFjveiEyzGI6Dl4BuVyRmr
	ZDaLmPPNDkZfF1u+nUmg
X-Received: by 2002:a05:6122:e22b:b0:567:2200:a6d6 with SMTP id 71dfb90a1353d-56a90a01002mr3817218e0c.7.1772213514423;
        Fri, 27 Feb 2026 09:31:54 -0800 (PST)
Received: from ammar-VM2 (d66-222-145-193.abhsia.telus.net. [66.222.145.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630a0sm46252201cf.6.2026.02.27.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:31:53 -0800 (PST)
Date: Fri, 27 Feb 2026 12:31:51 -0500
From: Ammar Mustafa <ammarmustafa34@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs: iio: ad7191: Correct clock configuration
Message-ID: <aaHVB1lLuXIw3pwt@ammar-VM2>
References: <aaG6Rds7GAf9ZtF8@ammar-VM2>
 <aaHA8U3HrIbg8D46@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHA8U3HrIbg8D46@ashevche-desk.local>

On Fri, Feb 27, 2026 at 06:06:09PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 27, 2026 at 10:37:41AM -0500, Ammar Mustafa wrote:
> > Correct the ad7191 documentation to match the datasheet:
> > - Fix inverted CLKSEL pin logic: device should use external clock when low,
> >   internal CMOS/crystal when high.
> > - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.
> 
> ...
> 
> > -- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock property
> > -  needed)
> > -- When CLKSEL pin is tied HIGH: Requires external clock source
> > +- When CLKSEL pin is tied LOW: Requires external clock source
> >    - Can be a crystal between MCLK1 and MCLK2 pins
> > -  - Or a CMOS-compatible clock driving MCLK2 pin
> > +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
> >    - Must specify the "clocks" property in device tree when using external clock
> > +- When CLKSEL pin is tied HIGH: Uses internal 4.92MHz clock (no clock property
> > +  needed)
> 
> Is it active-low or active-high pin?
> 
> ...
> 
> When I see such a confusion in the documentation I propose to replace HIGH/LOW
> to active/inactive or asserted/deasserted.
> 
> And no need to swap the entries.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

I haven't seen anything in the documentation to believe clksel is
active-low. I agree that assert/deassert would remove this confusion. I
can resend the patch with this change and without the swapped entries.

Thanks,

Ammar Mustafa

