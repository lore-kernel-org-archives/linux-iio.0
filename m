Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF682D12F3
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494700; cv=pass; b=Dik5BMYOZr1SkeI23Sn3v55juSRtm1lkfVdrICYt0Fzn7g1jYk9JzKUIvRC3B+8ZV/O8IjGn1zC4az8h8h3BRNIubanDMXc/cTMUPT+8H25JqmV9NHG8+Tt72c0MSMoi33RGiL3YEmCZ+M6WvQvbizcgIxwcJlVBhZBXM6h4Mas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494700; c=relaxed/simple;
	bh=Y9w9QrFkE1SM2n2FFX5oMk0sGJkeCcgXEawMzw1JDzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/dhcv7AwWZ/CwyvGG7dxPhv5MmFdga05ZvpowlE+/peuLtyNm3Uzxrfcoha8gqfPKsfcl2sPLqhxEfgzL4xZ8bqLBNedlcuNoK1Fn4gW9eDbaiYaEK34uAbZEjVN9umqeJIuHTpPh3rpuxWIUMLyf8Y37k4ybVvMmOX9CxyKhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y71j7cvT; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y71j7cvT"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-45691990234so216511fac.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 17:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786494698; cv=none;
        d=google.com; s=arc-20260327;
        b=n/eUSzfomQ/rpICG/wmxcXJw06C7W+xHPlEZvJLIZ9zUp3Woy/qfeb3HsFpBSXVCjA
         995cPqeU2TGlnmiGvtlTWZwj1QvnD7HrVp4kSpPNG5mVk83Xp/xb9TTVjpGcestJE3Yp
         qlBgkX/4S5+YXe0HGOQa7Ogb8BLojLve5BwshGo26sb0cSV4j7sgMRJ5h5KCXe2+fMgf
         nvZKZbFpbZyjBF8kNdJOuvpmDmJYW5kk+jqYwnMyxN+XdJ8kfHUYmqbanbBMIOQuYODZ
         NxE1tMd2ZfKEDljarqiGEfBmYkXdKbTg9sZU7y2NSydXfL8b5nYwZK8AO8TNzOlk+Y+T
         2YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y9w9QrFkE1SM2n2FFX5oMk0sGJkeCcgXEawMzw1JDzY=;
        fh=FpVl0EbShxxyruJpHWQVisELNJDra7JGFQMGOxMK65E=;
        b=j3NCzX/77jCXojx9SOj2sAyxtkO0cKMeypXJc8ZNhZChsnLEQO1f8KX6YAcW43BFPG
         N8jcBOoJVoLb9fFSSjYii5LjLY0I8l+gtqQuvbWmh4e8b86Ou8Fnyopk4swd7z0+BSi3
         mpeycIylmizDWAYM9n4U+0rfycbsTK/cGLoXe65nmDotYSy1pxekj77l+bgZjJ9pBbQY
         UCeVOu34tKDQeIGx850JW+erCGZHmJb6r4eOQncpe1Uuhwp1Nnty9sw/aNcb+yEGyvip
         tLW+eQWAQj35kzGboE0Gk4rxsea594zXbqtgsz6z9RD0zbVAJKRQ89ULr45FXV86N3v9
         noJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786494698; x=1787099498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9w9QrFkE1SM2n2FFX5oMk0sGJkeCcgXEawMzw1JDzY=;
        b=Y71j7cvTfLmwEVR3tbHExA0hOBENdWMJMz2AehQGoxpS7dVuGBpj+YdqaXI9fJDCi1
         6PKJV4LcmgNqGQGezozttU8JcPvZVv4ChheXwdtAwLToVWKH/ISHJT2BE73Nf2N8rmFR
         XLDnVid1MKq/8GKP8TsS1a53FqskMkPwKy8j6X5CG1H9/UIw6MXucS1J8fshs5R5puWf
         7kcS9FDgnEnDvtglwxQfdTnCeeAdb8wYDVG5wRuHaUtwnX73lUcv7xjNzg29M7+7crGj
         6/x4dSh50UiwvSydgCOtmMWctLKxD88Ipcdn1kb+ygJY/HHumwclVmAfx5oQWFURajEk
         z4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786494698; x=1787099498;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y9w9QrFkE1SM2n2FFX5oMk0sGJkeCcgXEawMzw1JDzY=;
        b=OJxTGeeqQqF5Ic7X7P7B5Vgnn/EeFk10330G76WKr3is9brIHxPX3smzt7Kzk0zjaw
         bjwAMDjx7NYVc2vg7l7MAEraDjzEj+mnEB0trf7JRyt0LgHQd8D/brK3z6DHBfVjFYNS
         k7Q6i5t2OsTXt4nG4mJRmJmWpKOil2rXtBTHVkd2tATGr3V5jWuDQQobdAVpc+nN0feq
         m+KLiIBcIDRZbLdMg/7KGPIWIdco/jw6h38v7zHYDSJH40/MNurABqVY/PkIU8kIrafb
         wuDVec4C4gtNZcRwsJ3BuL55q6W3cvRo71MZVdouE8KBXsMxlamLoshRRDiUbmh+Rxm5
         7CZg==
X-Forwarded-Encrypted: i=1; AHgh+Rrs27JOGurJQjTItN0o11GSYnxakuRmVsevQ6a0+2f15uiZvaAYBq7fmli7Q/emH43p2IAjmiRBHPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Df9+PH+8namqqwFyfOjRgv6ubrYkhmS/o7msDVRvejSqRlAq
	zaCG7D206rOtbOqeMjDozGyPGbhOt/XtExBAdY5aKSyqqimnVljXN0a7De9xjVJN7Ng3OpTt+Jr
	hSTI2/jOWSsPO3CLS/jDXZeSYzJ3+0ko=
X-Gm-Gg: AR+sD11Weuos5q24kfSYM2y0ODdq+isWSltxJ17cM65qvZ/7VPgc3dbutyTheSu2Jc3
	9wys6pgTwtsoGDW/QKF2lvb9zh0q64/uWxKq4t3/XDXc3BFyEjvbiH5T5B7LgI4q4I1Y+9kF/3i
	KgXPnp5AberNiA7wPYDUlTZKwS6OSGPYOxqpYsMqOpyzVLvvpcSKEbOgjz5Ug0Ocziaz8ypCatH
	xGdytm4pNK4YtAQPgyFmesLCgkzfwGjiH+5cl0OLIeLt4jFShSVle0pEK/Gek+Gaz63wWrI3HCf
	iia24EPTjopJ6ZGsI/YJ4FNH1QQ/v4wVyF/QoL3oPak=
X-Received: by 2002:a05:6870:21e5:b0:456:b32f:70c7 with SMTP id
 586e51a60fabf-45e3e83bd3dmr794920fac.4.1786494697916; Tue, 11 Aug 2026
 17:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
 <20260808090026.34187-5-adinata.softwareengineer@gmail.com> <anmPrjxK3ydCtuDS@ashevche-desk.local>
In-Reply-To: <anmPrjxK3ydCtuDS@ashevche-desk.local>
From: Adi <adinata.softwareengineer@gmail.com>
Date: Wed, 12 Aug 2026 08:31:24 +0800
X-Gm-Features: AUfX_mzFPpAgYkDnWVsiq_yU1XXeSLYuqN-rPxHMKzalX3KATUMvbTbI2paCKPU
Message-ID: <CABZ6vuA9eZfyW5ZX19c24_=e6QK8errrbAF6qQUoQS33rxdd2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: humidity: hts221: use dev_err_probe() in probe paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lorenzo@kernel.org, Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thank you for your feedback. That is suitable. I will update
accordingly on the next version patch.

Regards,
Adi Nata

> Why hw->dev and not simply dev?!
> Also in all cases.
