Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B783FA5E6
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535384; cv=pass; b=SloNNrP6dK/3wt8y5Mgguuc0sTffo6Q1nM70GBpOJ8F25wbAm99F1vgNdtpfJrNVLaLyPExEXGu/3fTKpBW7RuLap9u6OgbQSLWwOGhvpEbtfvbXrdZGx9tW02czo42TqxwrOSLq4RGN4BOiH609kljYrowxl8Q41fOGp7KRric=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535384; c=relaxed/simple;
	bh=GesvDtptbW9YvNxQo5vegJ5YOJJddTAokzDf9ZTy6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcRH+DpczQ8Hh9kHbnx4kOSBRRgRTMRvddXrAVjh12c7cxHukHCL8J3rp+0WnwzSy8LmUlKJBNhCnpBdjnPbFQvsknA7r58xAh5FOxuFtOzoRKpHV4PhFK18wEtirVj2a2QTQn/659G9MzFQnL0Bz3yx+vzDTOXY3GAsMTgbLH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXCQMhlD; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXCQMhlD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso322363f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535382; cv=none;
        d=google.com; s=arc-20240605;
        b=CFrIZZ39+WnIWyMG+SsD+Sj+qqGoM01Wn4XrZoK9c/XzL5REnTbQF5CkTSUt2DZKli
         PNzAdtuIBMKdjAPqB9VC5JgdHqiwCdsT2nU8MpR37ba4gUGK49ewtOYPLMqzYEpqxaLg
         Fk8bWB0Lox1zBkrrz0V4R942DUvX8qfdO1iPmgZnDri55piT/Mzq466tMEomJGbzo0f2
         ZNFumfn1vWHs/PSUnqmhYjSNsSAQT16Cl+vE5YJUKs9DH5XMtCeiNCBuuyGpCzKF4UyU
         Hfel951tgjTS1lWGSh7jz8+AsRn7tMAxViyebKJj9xsDlloHHqlh8yhW4+My2AgfQOVX
         52nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d5DbT9+BCukLGL3ocWjsM6VkTcoYegRcc0cCOttkmEg=;
        fh=9ghYIruN2wRRWXV05EYslBRGeRCn9/doivUTw29Zgbo=;
        b=Qzvk1kFTeq0NeP8P1NM0QZPr4jpg06jdC18UxACZFl+owp7Wv0RmsnbzCWl9QkFZVj
         vOzifSCl/DCYJXuOqTFWImX5Rz9zybAF87yLxIgmpikq+VPuJ4eb6h2DqXzI+M9SiMWV
         bUAUVxjiRnm0oK19Z5pdySfoUQdhBJ+9jbldsE/1+m9y6dTkFbN5xI0nTBakYvuQb//+
         lv+K82zRSx0dS4PBkSAUgqU1wYvlkKu2Q4v3PdjPgZnI9/md8K9GtOImX6nAq2BYasoR
         W/r6hVaEhNT5W14/eRIRr/V402dyhFriLpRfL2cVPSO3i2f/+E21SHg/THZDfi8us5lE
         k/TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535382; x=1778140182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5DbT9+BCukLGL3ocWjsM6VkTcoYegRcc0cCOttkmEg=;
        b=pXCQMhlD9EeiJ9jk3N0kqJjUnZn6V8p8iGQs16BYLlgdv0Qf7xcPJ/GbjYEhKwj7wY
         zxVg39JAppQoNSPsWkGaE3SncwKIMlHApe0KO28WVEcuH0rp0oeEjX/qex3Turtv1scs
         xBLHVODWtkHpR8Ri01jM7hmV0ejfhFYy2qmQHtkxGLQB6EPavRbQjV1Ov2fxkkoHZMQ8
         DXD0cimVDN1e0UkWCi4XRfHFJU0Z3B4r3GeSeCeLLDL7lVUTL76gSaaM+k7RPXe8KYzm
         WE+/0HdW69NseIMSs1P2t+/wkaIJH/F5YCDnuKZMCVhBHz+FRQWYDLnL8LOna7L5b+VN
         BPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535382; x=1778140182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5DbT9+BCukLGL3ocWjsM6VkTcoYegRcc0cCOttkmEg=;
        b=iHk1j+ib3eNOPZiHrtHtWCyriyQ43MpWFz3FI/lWlF1+5CSKz9YrBlzysvWp46qsK+
         0BhzBNefScncOZrwzItHdQ1Q5ywfWAmucdGPDVTCEJKMrbhwM5AiB1i18IRXRpLpWNKw
         HUKhmouvi4G/BuoatbZBtbuztGttak3blJeKlg1D0Rj1GKQlWAxyYq+Z4yAixnBBP7eu
         0crhQZbsnDt0EZkOMxbNW/o6lEiVZ3bG0QS/f3q5vfgGoCvs1wSgMn/vOWdeXPRzQ8+6
         K8MWi3Rm9QqEpvnzf3ZNplVHW+V+dyJzPJ3I95O2fhctOP/65zQJcbC76pzbo7C36ZEN
         bDeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hWxsuJ99YPF1RZkGU6CYfKEWfrLXmLbWWMfA1kQtaFXTa8dc1lkC6Y2VQIEVlK1VORp0NTW9RmJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/tYY0BwksVSnaJDtlKeU6nTmMe4UAkPr9lOWc4hHQ87nxvjt
	3J44lcvgSgQq+4TYFI2hSYSa7Z4gD7XqkvolwzZmUFOKC1/olYE5wW2Ds8R3CvKELiAhiMr5jzQ
	x2lLtyLh+Xrn41h5IHXSFvCq8NRig8Fs=
X-Gm-Gg: AeBDiesubhx9BcdjFT19YXwWVdn1q+HcnTaXvRUY65aYSv+xlK4W7dMiwDFHZsVm8lJ
	oTbl7HYBZaMDKV+3n/DoeBOje+IXO+655tSgDNUPTTYYZL6BHjF4Mpm19EqrlIvRBjEN0zbtlwA
	jnkTfMXJJH0uS4i307kyZmMmAEwDa3DkMIwPHm1p5Tfm7brV3liNlgqVsLNPOgX5E94KL1mqkcz
	ij5rtxZA2L+D6TnsPMp05EURxQsgadN4Tp4m2xwvogdgcGdv5UlwG0TF4PZXpy4tXi6savrpcxJ
	P8wKi8Nlqz/OnDYru6ZliaXz4BOw9v8ilNTwbsBzzHWWKNtN/01K3Bww0rbyYpCyV6XmMVvdbgO
	kIIar2N9ljH/NItnRuM1KF0WLxFJB4AC0isG8YMar/fscSCc5USFbocpunz8/p96v0WUHlQYBTV
	2dhdsoSRpkkJpO7k3b
X-Received: by 2002:a05:6000:2002:b0:43c:d665:3830 with SMTP id
 ffacd0b85a97d-4493fed6748mr2300676f8f.32.1777535381945; Thu, 30 Apr 2026
 00:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-7-469f21d960eb@gmail.com> <afJaymMR32iStbyX@ashevche-desk.local>
In-Reply-To: <afJaymMR32iStbyX@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:49:30 +0200
X-Gm-Features: AVHnY4J5MqaNwB8LhWmNel1YTKxPpDN-ifSNE0HTrMooAvckz5KDledcPzSo_k0
Message-ID: <CALoEA-yx=NNoOzoYQ4kjg2ZLn4U1kzY2D21RZssVU3FLnYLyDQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] iio: light: si1133: reset counter to prevent race condition
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 21:24, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > +                     /*
> > +                      * reset counter on err to prevent sofware and hardware
> > +                      * counters being out of sync
> > +                      */
>
> /*
>  * Respect English grammar and punctuation. This is
>  * the style for multi-line comments. You can consider
>  * this example.
>  */

See patch 8.

-- 
Kind regards

CJD
