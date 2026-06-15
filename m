Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D330E858
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556729; cv=pass; b=Rk7eihCel6V4072drd2fFqTf04zz2C9OnUO7MmXqBBuFLbCPCuOJKBBxdAOIelfTCMz40LP3QHiVP8wbC8dvmRF9fWoeUkwZH27UNRTFG5Yq9O6r7NJDBVRPvz4dKTGMl4hYr8kKq0/wDT3zP1eb1Xy+pfbzxVKh9vjacgESstY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556729; c=relaxed/simple;
	bh=n53wEMLgQdF1DIOWV+HHJH1Nvff7nEmKSXNnMKJkCUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLcNHRcHoBoJOm0TInseRsLpB8Qif1PhMDEJLNVR2R5dWGMxtDfTmO28D0XBwE40l+ou0WNVWjAYr16PpWvBxWZObbteEjBZogV9ZITxi8JekaPOrHJ0NYK+g0GkRxtpX303jbunG/5Mmag+n7ECibNmBpmwQtT5jaUoTTyzAdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck1Fwwnv; arc=pass smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck1Fwwnv"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4877a7b451dso495571b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 13:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781556727; cv=none;
        d=google.com; s=arc-20240605;
        b=MOhuirpTR5+CbHoDdtGYGPKGU5hmjnJb8kdxBD1FB1mlv81DCNBpib/+N4HcQ6uwdE
         xJ2Jqgiy6jC5YCM3ITfCm+SarSoqqtVt4epaGYTRmb6wwi4m3+C3wdj/fdOpi3Nrc3de
         WADDBJi6mCxActcSO8cd/hV6hi+XojUm4zafjnWXjy76uXML1Aw66qlRLwRCRwyMXdkO
         uDZbRW4vcQ7WW7J24mNDwfGKTBatI9QGCUuAZxMR4QgefnJyt+Zg5bhQ1qBRw52ZNinW
         RAycinUuPXd17q78FNMUwfm/qe5Wf9EFGD0mueT9VQIXjd78G1Q7uur8QEzsDNF+zSMJ
         CtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n53wEMLgQdF1DIOWV+HHJH1Nvff7nEmKSXNnMKJkCUg=;
        fh=F+uZMUcVXa+2exz/XEICW659HOhF3chefokvZYowhuA=;
        b=LPtMSNWHMDqtNWw9epCywRB7GMB4wt0hRi6dESQhstO55u5F/87/VHPWVkrSkfCfgG
         EhkbjZf6JY3xmKqUPGTotiiU3p5COzKLp7RNg7vWa0fbagj51zL3nisPq5S00idNlhA0
         naxzkbgu4zzgNPd3e9T0p+cqttfwcSRAMihOKNVYoxOdCn2UCjAs+6GtIrjuJ4SC2YOu
         Fk90YnaPJkKncWIhj8e04T8wD8jfhAbinx6XmhjEGF+GaoRmXhnUjm+2YNI9ZBTQEMSU
         fy3CDFt51hqTvE5WSMdarAqgfvcd5P725NJ6rUW7FGrEMmkvyLkhtW9mxQ/1bTBc6oxk
         V2OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781556727; x=1782161527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n53wEMLgQdF1DIOWV+HHJH1Nvff7nEmKSXNnMKJkCUg=;
        b=ck1FwwnvD1+GqYtaSoaEzIAQyBCZyhZE6p9hnLX9iocOdPMJoK5bzVHEXsZhoJUQlx
         cNEKXWvYgKtQ618oFe7opgVS+YpcjMMr2/Z65DuFPLBpqaOL1d8Nj2CdODkE7srj0RTm
         nm7xEgO1V8SWMyRrwFn8ushPT4INvS/2lIJ/vUKf+OuUZI7PU8kiFiANh6+Ve6uF+o8p
         /M4n2SS2zvKWDyGZ+k0Y6vmXQuk/joeKLXt0TaSlL678BKQLs60d8k6FRlp4T9i+zBBy
         vVkSAqdIHxpAvateWhLmie2xD710XJBUn4d8WSvBi92DotLuXmG1WXVYC9TYdy29UamV
         d9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556727; x=1782161527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n53wEMLgQdF1DIOWV+HHJH1Nvff7nEmKSXNnMKJkCUg=;
        b=DBKtVy1Ue6Ecn0vaSdBOaVIuFs0peL2tB2xluucP11IFwa4Mkn+uwhg5m5bpU78H/e
         VgjykdhKLKhuaSJZx20nbjIy3lLadB9bdygeRXyBKzTUPJ9KEs+8HMo+NZzsqzuhFPU2
         zXAA7V4ynGr4JptHIrUzNKgDbwDR/FliaxVhDSHaCbO4OHkR97TBXCHTDVKeHqGzF+0S
         6mBAiIhwZqxlwARa31hA7RwDU7arazJTeUawRGM4354eBLtqdNw8yer/w8Xvmw51Rj/O
         8FnwdCjubnbAKk4nkEN5TJt1ZRutq6bo7RMbCyAaZPFI24dGRGhK7ONsY6dMUtfZ0s/d
         gr3g==
X-Forwarded-Encrypted: i=1; AFNElJ/t1UVOcy0BZpDRj9q0NIhZG99ObQhfPDiGt0YnxsJi7zeiPmYZwxxU3GLMFg625HB55Tn4N6TNdTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyQbOuKRD8G1v5yOHY2rffR7dTLTzTbOf7ll0Ogg0R27xInml
	B7NrDVB/NK4Pl/PDjqGX/bP76y3A3Tbxc8bj1VPNE5Zugyd1RHhtGga1iO3qrH5eb4juzLbPnjQ
	DHNtupp7QOCD+B/wtQ6i38omyWYt5N78=
X-Gm-Gg: Acq92OEUALQkMcY+9jXsxSFerxB6Z0nYWEaJXDgs9fTLEURqRUVyZLbz+97GgVRQDx7
	14X71ILC3HT8g0xGeZ0YbmCCJULubhwidc2DUVePgwnS22bMHVmRpx+z8sjS1mSMmHrkRBLB/dM
	Lkr79nIXQPa0Wk0MPmfEtDbDFj6HKhbT/pfI5g3TQTQausrZq4NX8mU0yj8eonxnmXW0l9cCQ0L
	ynPmcccQf0y+D7fWQeQ2oMrYeH7rPZZeX2zNF8lVCDqGvJy4NPl7Uoj59p183A30QHggz5dSqfM
	GwfsAYSzYzASbT3IqDyGiDXIvH+/EKRgNtcJPe9pjQ==
X-Received: by 2002:a05:6808:1819:b0:479:f9df:ab35 with SMTP id
 5614622812f47-48741c968d7mr8362379b6e.42.1781556727280; Mon, 15 Jun 2026
 13:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607140018.59586-1-dennylin0707@gmail.com>
 <20260608184154.72a88788@jic23-huawei> <aieu-h2a1qqAzHnX@ashevche-desk.local> <29343d3a-38db-4f28-aed2-59e36d4354f8@gmail.com>
In-Reply-To: <29343d3a-38db-4f28-aed2-59e36d4354f8@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Mon, 15 Jun 2026 13:51:55 -0700
X-Gm-Features: AVVi8CeeVIYlRntcStEgW9loFncj-5m7sCPSJq7MiVmd1eb6v3CK9DYw2VN11eU
Message-ID: <CAGEkeHfoNiwSD2g+uzOiW0OJTjvNyNW_RtJz0BiEMMn0dugkRA@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bm1390: replace short msleeps with usleep_range
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I don't see the value either, unless there is a real problem the patch
> author has encountered. If there is a real world problem this is solving
> - please state it. My stance on fsleep() Vs. msleep() in ASYNC probes
> can be read from discussion (bikeshedding) between me and Nuno ;)
>
> https://lore.kernel.org/all/14a23df0e1828b72b8b03c358980fe08a12bb216.camel@gmail.com/
>

Hi Jonathan, Andy, Matti,

Thanks for the review.

My motivation was based on the BM1390 datasheet specifying a 1 ms
reset cancel wait time (tSC1).

For additional context, I contacted ROHM regarding the timing
requirement and received the following response from their sales
representative after consulting with their engineering team:

"The engineer confirmed that setting a delay longer than 1 ms does not
have any significant impact on subsequent operation."

Given this feedback and the comments in this thread, I agree that I do
not have evidence of any real-world issue caused by the existing
msleep(1) usage, nor a clear functional benefit from this change.

Thanks for the feedback.

Best regards,
Hungyu
