Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE6307492
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660892; cv=pass; b=Z4gQNhdUvvG1INWY4dUmH/8AWTpKcpV5+9Vi+lYOVz+mk3HaacB2ieg1UsYEX0f/DV4of0sSmfadHxyhJsrvNRZbkS/ODLZX7dR8+vqz5I1EdtTt+HVKEjNfCcjCZM81P85d8Ml75ZOdR9QwH35BXiRZYgyu3mV7BsjSakWmmHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660892; c=relaxed/simple;
	bh=aycn5/ArzIBuJhPgOWFdfJEM8Y5jvtrt7AY+jLlpJ7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkZummSYEo++bKeJFIrx1RIEtrHtN9CSepIMWbRCL9mzcXSidcHv/QDG38NP63jomx0c4S7ShLG+Y1JUa16WHMwE/YyXYOwm/3fqbqR3UP8OVMtkRMdEJ03vNQymEFPYj/niVDOyfGWQi/zb/Y4Qd3O0/rekMmTGBoN+r8P8SiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+sr9z1S; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+sr9z1S"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so1423781f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777660890; cv=none;
        d=google.com; s=arc-20240605;
        b=BUL51fDS1w2TkUYY+MMQ8ovY5mZafJ7yREVL+ZDOIs8KKHvMKaweHaNMokYtxThYFE
         zbdaRvZqxyIIfmTEvoUquhki+OGZIz5AL/LwYziMJByIT6HaGwV8yNDfUTK9N0y5J5ZW
         1b6QBijM3pEVQcp3EmUJZbDliVRPSRcwKkpkypM2XJV9z/QnMBoKcXWZeLKCfFLjsmn5
         cgNnGFuuoAI2aMdH+c5t1CLDyJ+Tx9X5thU9rLYNxI7rjiv9qn3Sj7Kp9dvf9OppnmGD
         8Y/3Ia4xBW3W6ePPKlpa+zXOyNZDkOzEb/JEWkvmjSatx9iueSVwPOGPXrotDPihX/o3
         dP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZyjxxXiBuVpPShEFtMJ6ChgajG3rrg6b1Tu+XWcKVg=;
        fh=hF84RhMIZ0YrqPB+ZNOTMzoDTzyaQMeA3nj30FdkRMo=;
        b=SriOWS8FAR2OiL29nomZ5M3+y6/1EBxw6VpXGAelvZrXfmwPndaL7t890IIsuZfu7g
         Afkj3FiDsMSjdXhddIkLpN82u/qs0uxMZu0f1WtqUouXvFcTIj8tDTxltWIridR7z68L
         b+Q1fQIiK15yq2qfbAgc1+HAYZJDl2AarFEthj3z1apMQG7u/yt3dU9rqoo/RDyVeVvu
         /vNPVxRmbB0ilIbL+IfzCUPmnz3E2c+8reEu8GQHo2LyyLarDcZ9q4c+uF19ut6wQwiU
         ImeIw4WkPppcO4hzRaLmWSvolCyFrqK80t+PMpb1SuEiZXm5CzCOW2hkixfEteD7ZAxV
         frbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777660890; x=1778265690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZyjxxXiBuVpPShEFtMJ6ChgajG3rrg6b1Tu+XWcKVg=;
        b=j+sr9z1SpEUhJ+BX8viYDtXJ6Py6kqNcl/5q0SJM2cfmw0CryRPXibPbnum7p32ncV
         8L26IwRlJggay3IAu2/XNINllWdgy5YQ2OKIwLXFT+5rjMOExEP2OdKL5BympaJFr2bd
         9JyIvEFHU2JZH3Ae49aBvIPMYFMFOqcI+mb/CdklutlkT0wQdFIzDr2o8rIKxzoCvHGb
         Ham7/ydYsQhnKWKgKePiwVKNmuq0T21xNEB/dm1Wt0R1GzcJVkekOhy7TdqJlgWYB+R/
         XmUi26sjul1CjNi1x50WfH0d3hIyGQPwoXrFaiLiIU670zDnNqmZXNHTVg8RT9BLxot9
         cJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777660890; x=1778265690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZyjxxXiBuVpPShEFtMJ6ChgajG3rrg6b1Tu+XWcKVg=;
        b=Q55SEdd6Zwgp9q//vwv5BbMruL09HdfS2iuAS2zgtPYG39lHr426WTN9UKCjnx0/X8
         AOYPM4+cerJAjTGw+HtbV84FjAhjm37wg7xSWnKg4QSPlGXf1Z4n1mrh9rXzQBN5wEkS
         TgnZ/s+0ODz2DEXO34oqcE4B1BGU7HZnrUYMk1wMuC2Vm3VOKTiD6xl9WR9w8uq8w3us
         uKfuTY8DdsB0oiabSB2dmq7ROOMmN4aC6EEjuJ/RaYjlaUlY0MFT7FhVRXSzQ+/+WVMm
         j1lbIqdGcMG4djJLXVB7yR2jZyqH9h4xjpJxub9cXQm5L+GZlDa5xMVXLEXT+d3dMvQ4
         4+dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8W5YwBMKcJtb1vnW2s06bsAurZGKPz9n/1YjSj7DDYP5Iy/7OvCdUB40L/TGoBN9ghWcgJDqGqreg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqz0X/L021XN/YK67S8rmaLRLs7KN2+YEKh+9Eoswdll1NFf+/
	lZIUwVfMxcVyQVV8XLfo7zgTfp+16qsA0jq/N5OTyLeV05vB4ji2luQLKDT0KXO11ucLIsdXhAZ
	8mZDSIJwdCpekzC2N//LPF2SOJjrGZL4=
X-Gm-Gg: AeBDieu+r+66nHk6IzvKik8kaPEIW1AXXF2GlY8NTXmKvF8o4GMIrEVteRncNmcnxpK
	zdr8oDAbqkaTMv2FBE+9ozL3Rsx4Jn9HA/ktkpUaIcV8SGJLeCbTiRwZGKTYYeQtBgbh7tcIkGV
	gbPrD2X2wm1HNolVYDlFcfBICLY/SNI0E1fg9579UmzYI5hl1Ir8tiYiAtznSgvFk1Bq55qGfFJ
	Td5Xh0VBIZtSGciqb2hFJKXhmYEolBnD8e2byQiv/tFU5r/zJMwFexBKnRCLQ4CNHMaNPCS/R18
	eoH/FflX7S98LvadB9ztHEF9x51NW+OdkV0k4a/ow4J/G/cZhw5K0sbrdK4quMMu4ufPDABDDPy
	PpXPDVAGgXCrU0IJbPCjbFWwLcAxcNAQwz6cvtz49XsQq/+fFg6OO6nrjdR3G5FAyaU6jbOvZMg
	ToILGPnIrO7BbtYKM=
X-Received: by 2002:a5d:5d10:0:b0:43d:7508:c9c6 with SMTP id
 ffacd0b85a97d-44bb62073a9mr906920f8f.28.1777660889834; Fri, 01 May 2026
 11:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br> <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
 <CALoEA-ycuys-pNg_HWZVrkoiAXVToWouS5LV0GX1UsWz5G_Mvw@mail.gmail.com> <CAHp75VdQuy1P=jiK9vsCVP444hUB-1aNDCtmoZK1YU9gH0yTDw@mail.gmail.com>
In-Reply-To: <CAHp75VdQuy1P=jiK9vsCVP444hUB-1aNDCtmoZK1YU9gH0yTDw@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 20:41:17 +0200
X-Gm-Features: AVHnY4ILTDs4lntUMVKIExIBHWgovOMZ66-h9u8ueq-UEl5zf81L9dSO01srdIU
Message-ID: <CALoEA-yX+NoGF2-9dB9_+LV2YPCN3LskdR_hWBPeBbbO8bJAwA@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rafael Lopes Santana <santanarl@usp.br>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 May 2026 at 20:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> I am not sure I follow this. Too many parentheses is not a C language
> style. It's not LISP, and we only do unneeded parentheses for the
> cases where it's not immediately obvious by operator precedence.

This is not a case of operator precedence, I meant it as if you
mention a macro that takes a parameter in the commit message,
it should be styled as MACRO_NAME(), at least that's what I
interpreted from previous code reviews. (same goes for functions -
function_name()). More of a nitpick though.

-- 
Kind regards

CJD
