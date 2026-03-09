Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECA2BE7CD
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034564; cv=none; b=dwHQ4116tZ8COl5GIWgxwBjmUp8YLCgAIitpuUAB1QOdprVaeyOGBPAUcai3cSev+AbQ42ABtjHvukFWuK3s1oeGSipBahhbAUKYn/1ihLZd4IuIVpT1KLjvUJvEndp1pYZyndKHTch/ntNawmuCaicPsYiUe9WXq3dasL//LFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034564; c=relaxed/simple;
	bh=TstdYjs2JOslSfUoiNOZQUESbqPut/9hmyHHSOydmBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByoqeCP1D4vakL9Zl8wY2iOKv91o4tfQRIHq3UtsA2PmaPeCjw9O2p0WfZBVzCVO7xY/wXEaVyGpbYdewDVVhqPtIgqzPeR3He9qd0eFkNFk7Xj7gp0BZSoPtkpmBSryz6j6JKFUNaqeTsX2/27u0htLoXZw5gcaSqyJFH4Tqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjFeYRdL; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjFeYRdL"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be4781d2baso5986217eec.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773034562; x=1773639362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Skm7jjW3gGTyeCMhcxvy+Ck9FxS/iCqJX+/k6WAJO7g=;
        b=QjFeYRdLaVWSC47+W45iJZlr2RkgAZByPUnlxQWhsMA91TdgE6m+kK6EwDNXkmnceE
         pKXvgbtXBMz5JnJ2cikHcvFplbwVDucSH1X28Keqh2ZppBbFNRhDM0TGyybhRMKpCx4y
         vxMrZtFZI9mk4j5ktA0ItsJj9TpcDm7yvfJqyGk9KA+qzI6/1IwVUUtbHkn6mRFaYMqW
         vQgHRzYrqQXePjFPA9j6RPtwVgTnfrTmUnNx5N7wbgGnJK/HyPImWPX5fnXZSVB4c+0W
         84lTjMavxrSAwdo84x+8RqYeOzDGctdRb++rS2rBC0ZGLWNIUZgTTZkfIulHg90gc30V
         m1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773034562; x=1773639362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Skm7jjW3gGTyeCMhcxvy+Ck9FxS/iCqJX+/k6WAJO7g=;
        b=jbBLPb1OB2RJe5v1f1WWHehpLVJBhK0Lrj9CTWgH+AVhI2IthwSC1cs98jZgW/PRPY
         eORhqoid2ATxaGdkJL8iqZmvfoxgReQwpNa9zt/JOUdqPLYaWEZTdePWqMOYRGEgh0O0
         UzXwkDqNHUNTgHFtrcCdZcCwsNmgkCBGhBAgRB0MZ5IjQH2g3P7kd+/ELzq9g1vqUX2B
         1IelJPgCFPoV4u0NLhd8YAtVkCTtyIV/vTuQ2nfFrT1kixiJjajhc5ShpnD/0s7cX+rk
         ksbgcXo+8++SfkCCKB2djtVSLnrpl2nD4sm+axaj4yyJlFaZN4h2hq7yt8Y/Jl6t4zO0
         pq2A==
X-Forwarded-Encrypted: i=1; AJvYcCWUmlo+fmMSnw6L+Xka9j2OmO4A9kUueJgly4La1V/CiXfQ6Smzf2Uju9tq3ajVLI8mtfpb741Zyl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPYf62wLtcX9ciGgdp2AsyS7FRSgZhR68NMzprrkG9ckj4RUm
	YdvguIlHyL9e8WkHbQ4+i5uIjtg/nZBP0sGx3XhwLmvFmB3dGimo3f2Q
X-Gm-Gg: ATEYQzzx3zhvRRHH7HCnBUOXYUH1y/u+6rYocfNCM/6eaJAj9POdJTN9rCwafZ/fPXg
	fnuvujRiBiMdKhPnVnRR1Be/n9SCP6wFSBb5gH66PhkV5jmY49Jv0TKPUctTm5KfpkY3cHYH+u8
	Cv/SCWWhyjYJHKfjUabpSbvU1Ko0L6LGgnLCI5ncjLzX3LK4OInbK8qs+MF0czJiLYxX1rEW08V
	LJD2L2prHHnSDcCzHtithzCuDFgAHGxmY5UzocxoeBuTDlSvPISgqKHPyZys0KWbqxtnHkBm7vS
	gm+jXqImYbgylEpEq7qmzAJdhJVzT+N9Bvcftq5HFN+ldJ2kq+88d/R8dex29WQWZQf5VeKTKo/
	NBSHkk7avLgjHcb4zIkZQSeOH00nA/qsq5mlevs7VSTSOsSJ63poi7m0F3bUg3LlS5rFLop5KZg
	PV+z2g2U2cGIAv3UhuvYeFVQxQVnQmioU=
X-Received: by 2002:a05:7300:a883:b0:2be:2798:177f with SMTP id 5a478bee46e88-2be4e0672d8mr4132718eec.20.1773034562186;
        Sun, 08 Mar 2026 22:36:02 -0700 (PDT)
Received: from google.com ([2601:647:5e00:4acd:af9:a43b:9d9e:841c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm7490039eec.6.2026.03.08.22.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:36:01 -0700 (PDT)
Date: Mon, 9 Mar 2026 05:35:58 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Message-ID: <aa5ZA-CiIZuVkAdS@google.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
 <20260307114947.0b946dfb@jic23-huawei>
 <aa3czXB9tzLQgwha@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3czXB9tzLQgwha@ashevche-desk.local>

On Sun, Mar 08, 2026 at 10:32:13PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 07, 2026 at 11:49:47AM +0000, Jonathan Cameron wrote:
> > On Thu, 05 Mar 2026 11:21:56 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> ...
> 
> > I think this broke the ACPI case (where regulator isn't available).
> 
> Right, and I even have an HW to test (if required).
> 
> ...
> 
> > > +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> > > +	if (ret < 0)
> > 
> > I think you need to check for -ENODEV and if you see than then
> > see if the acpi route below applies.  Otherwise on ACPI this will fail
> > and we'll fail the probe.
> 
> Yep, just make it default without even checking the fwnode type.
> No need to bring the whole acpi.h into the mix.

I do not think this would be correct behavior. On non-ACPI systems the
regulator is mandatory, and the driver should not blindly apply scale
from ACPI systems just because regulator is missing in the DTS.

Thanks.

-- 
Dmitry
