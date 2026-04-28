Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A23E1CF0
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392831; cv=none; b=GUB4Xaq/F72sTtdtQUBKnkSYkA/OivxzEeij2B4ndunF/I7o4DMDXhpDrpMQxgmK2VQR6GLJqQNgZQSHvnemJfbWa2ZCm+CLfJshD1kfanDz3vBvkjMZFD/1LLT1IQuD4JVmTrVuEdmE16KZHz711hKGtGudl536T2DXXiSwnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392831; c=relaxed/simple;
	bh=IKjtIqjdI0KroHbshpR/qVO/AeGrXLF19RtAI/DwFIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpwUJNjrTqqbmPolG9v78eJduPHDkZ261rPZsVtdogDCaf9rp+K5OT/e1mul0Mp7IJBrv710NMQQiyMZZx++JZ1+zT7xN6B/RsZnzxMbswRYz003FwHehzRoFMmnOYYQ5CsAr/Tb2hDxtFW8NNQ28YL4gaK8DPJEIFSJg5oZnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjPvHXEn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjPvHXEn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so81970825e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777392828; x=1777997628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6PUWNGK9QNuvgnwMGetaAkISiEjmtwUs0udSoP/QuEY=;
        b=kjPvHXEnDLgeLJd0JxzsDztuB3zepmh9D68nBv9Q0sjrsld0zzFmdvAk3uHziBMzLn
         1HBnB2rX/voW1tREzbMrzd/c1KQb7XJSX3dik9IDp3Sw1PLAH0UXabQQU65noD0LwLOr
         i9/+fDKitvKurGIwCFKNLHX47wLoaxQTX0bIPIjFRbaeDRNapTf43X6GyrW7zQFcoy1b
         pzy8N/6MHdhrGXexyY1hkST1oMbECLXuNyzd8iAFZO2OvwfUh4G/f33FaQwN90PXGsXg
         O6XVWCSUIQGD2CSdI3JQKrb03jrdmiJBTlrBEAGqDHRDnxwxBh96zIbw07jv258Qqsao
         jRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392828; x=1777997628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PUWNGK9QNuvgnwMGetaAkISiEjmtwUs0udSoP/QuEY=;
        b=emdLh9yM2ixiFgYaktWLyayCwtxWxVo0778QtnRZPDmiCwCVtUREfvNuBYYlIUobCL
         iQDduVL8wmp/cMQIaB09oOHceQbyNybFJ5cXczJ/zqJhz6UCguWQRofw+h9+HkvfG1iv
         8Efw+tdNI/4gTU011R3tfQ/URd6TFre9VRRdhE1ATAcHXJbMpf3VsWRxypO420Y+8jiO
         k91GDqQm9/lCUGZ9SUxPMOvGMJWyORiBeYAn7LITXwIqkrA2ZL+5wh7WY+pleHcDbWjP
         k0ZVwbizlo7D+A/9KYi7oALHquh2HG4q3THxjnwPQehM/i+oco4VwA/HEj+Squ3zE7Uq
         oU8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EcuBvBdx6EJXZjaGYWRnsMHXYhRHxB+zci6VxIAxe7zcmuRLM5hyD1ScaCtg+vC2i7XBwe3YEFyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxNIz8CCGsHIwws0O0B8VYSlUCkvSd7PW/GzM5Dmag+x9pl/S
	zAzPKZxtkyxSAc13jijf8Em98iFnLlWwaHGLCG1/d6hEpdjdr9QWp6tq
X-Gm-Gg: AeBDiesnxHNvN7HWP1mV8kWQVWN88hPTj0/4I5a4vaIyp7n9nGqawL8nJlqwhMVsHgA
	W7DDP5ERpeVGyd6kNw0Ms/pOOUSc4hjQkYNvD9t5NsfCITn2SmznNZnij8PSyOeMvEb6pCe8w9a
	NavLZUfWdRwbHg58bWV3TU0vYlCPaeTcb9rKqFH29NwdIoQev/fRrbv6dZVdii+IdVxElzhH2d7
	DZWf3dVfHTrouj9YPcVHE3Jx1hHk+EU9vg2QIdC7bQY+u+CytRdc1V3l3v+01SJzufEBUb23K8Y
	7lkqVwQ3/Ht1HEeJTvBn3N/ve7/EDOw46pS4fC0W99rScP5/+9B3l0rsZgX1QPmIa8CdNeKiyQq
	l1kWAaAH2WKb45h5WUIiiw0eMWR0K3eTfKHlhtsksheLc5MuQKnL8mUh6VRZCN4YQshpe5oUujJ
	mRVCmmI6X7zIvhjZQBsrfBPJg=
X-Received: by 2002:a05:600c:3e19:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a77b12a61mr64602415e9.14.1777392827523;
        Tue, 28 Apr 2026 09:13:47 -0700 (PDT)
Received: from pc ([165.51.114.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b564c53sm3354945e9.7.2026.04.28.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:13:46 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:13:43 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: max30208: fix wrong scale value
Message-ID: <afDct-PhksfBCFr1@pc>
References: <20260428155349.68019-1-salah.triki@gmail.com>
 <afDaCLfAH2RHtqQw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afDaCLfAH2RHtqQw@ashevche-desk.local>

On Tue, Apr 28, 2026 at 07:02:16PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 04:53:49PM +0100, Salah Triki wrote:
> > The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
> > leads to incorrect temperature readings.
> > 
> > According to the MAX30208 datasheet, the temperature resolution is 0.005°C
> > per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
> > 16-bit resolution.
> > 
> > Although this is a change in the ABI, the current scale is objectively
> > incorrect. A raw reading of 5000 (25°C) is currently reported as 25000°C,
> > making the driver unusable with standard IIO tools. Given the magnitude
> > of the error (factor of 1000) and the fact that the driver is relatively
> > recent, fixing it to match the hardware specification is necessary.
> 
> Seems the analysis is wrong (as per Jonathan's comment in v1). What are the
> user space tools you referring to?
> 
You are correct. My analysis was purely based on a misinterpretation of the
datasheet's resolution (0.005°C) versus the IIO ABI requirement for
temperature (milli-degrees).

I assumed the scale should convert raw values to Celsius directly, without
realizing that '5' was already the correct value in milli-degrees. Since I
don't have the hardware to verify the output, I relied solely on my reading
of the datasheet and missed the ABI unit convention.

I will withdraw this patch. Sorry for the confusion

Best regards
--
Salah Triki
