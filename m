Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348546;
	b=Jmq8KY18EOtLQGh3pwkej00sopjoKDe3XyA45ROnFh/O7bY9p3kysHB2KIrpQM4ppvs/
	 9ajizEqrZ0pKoGJI+nn4KOyKAwWR5pfN2zciG8l43w+hjItG2zNKaPbKCVEwgWePDvMcr
	 TxXFUnzj3/mCSGR3hjyMU1RNovx9ysX8wsqZaQmojT610dfLVKy2N/vOL3eu/FBBIx9YZ
	 AUwdZyp6zh2od15He6z4carpx7DCGVYs2Z6fUQXHJ/xvhlPqWrYZUM//INZ0V6MbHz2D6
	 qVKcR9ToSQV9bA1M8qihcRkrzUf0cvQBOE1znk+bTxy9LlvkqVOyVGwHRW/fZhsOnJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DIShynWiIS89/lV1Gf1CIiRpO7YkvZ3/xDCYL33Wzfo=;
	b=Df3jTZkrj+zkWl1fycXg85MJQRdmWSweXO7UYQ3Ql8Xdm4R8RGnoFcV+3Otk02q7ld5k
	 tYDdH7WZzQnrZrilYWsgbtCe53RhwGxT91J61OuXhyyE2OVz8vmSdgcrwaZsjsH0GqDUp
	 3lFQobAFbf4ytlkY7VjxqMKCPl6CU07gklA8nt5DflYSqFwBkL4hzutJv4nPZev5JFiQr
	 Z1zXDw8oenB8e3usTGYqWgbbYrGLu4o1hZigAN6z9ZzYHj1GpUYiDoRzwBT3CypE27EgR
	 caEBWvkSnQA5PUYuUJdCiUohhl7bpUaKcn5Z5F+zskyflCJG8U1kZSjbmSCaH5CkBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1ZREggf;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810D606A32F
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 08:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5810D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1ZREggf
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so8363715e9.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793348545; x=1793953345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIShynWiIS89/lV1Gf1CIiRpO7YkvZ3/xDCYL33Wzfo=;
        b=m1ZREggfyTCtsChEl/GSqGiNOSP5BkUWTz/F+p/3M0HRrgRV0JhBRzRevAK+47vxHR
         YZaBZKHwKCUNv3K+A8IZzbizIb3BTTt0AppO3dYzMTzM2nACT8t/Nn60y1l9E4/5jlVN
         /UbHzGYSbtNKxiMRkv85Gv7SlUeyipKAJQe118OSn4M9gtK8TjUfpbyOy/4rrFxEr+B+
         ikVhiYacZQVrkGMxMFY6i0R+LI+NA88Is1ZONluXuUgxAORwTpn6SaL82RPJTVxY2cd8
         FnevyLCzq458HW0tTimEvTMxY9qly4HzuBGoB0LMnhOSSSNmTgTBSR++QLnwMhtsymH4
         CBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793348545; x=1793953345;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIShynWiIS89/lV1Gf1CIiRpO7YkvZ3/xDCYL33Wzfo=;
        b=Mbmvn7zvdIljIHkQBf6voY11iQozKG8PGdgph9lygSh80PX5YOgmI8vlhl7cSZmmi4
         fB2KpZnjWdHvDgnGwKImzFTMSMFS+1xZbIzcUCmSxIK5WTe8I6sATRmFbcXVEz0rJ/mb
         R0ojB47PLB+m/RSvSj0kDM+3v4P37j3Q5EZ6kpJ6UWWi5zawNM1Xm4eYqswyu6ahqxY4
         vO+lFokYRQW/Z9jMtgrZOskN1bX6WfrecSwkJ6sAoQBy1ue3r3z+2IrexHJKvVtFOdDn
         IM59Yj86hm60LKnpFTkG4LeHa7HmYS3ZE13MEbmyrpNcfiU05ZC0jGaaw/hVpS28Ab3r
         EuWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+GsDmuN5IiEK0NRJWUb8pES/5TmGoffByF7omxw4SShisbwlFMQpmF9Ut3OhZXnSwhdkD3S6j8Bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK80AT52m6tjpnVQzwqRyt7M5aXrZqItVFMnkl4juoD9a978mur
	iU4mCOpg3R2F655+oltefZvAOOv3t6teRE1Zt3VonOegJGLEkYYpYdq1
X-Gm-Gg: AYBFou0IZtojLx256cnEgOxpjyHaCfjMA28X+Q/bZQWYv/SeCiKxo+g/ykHdz8K6uyJ
	7MIEvzFFzvlaxdDg+pf/jl8lJ6CxOk/mFgYsmepHQ8++iDGdsk2RYnhcATKJoyf5okyz0g9etGR
	73LVp1xEu8FSXLXcgHuGEBFDaDKDm6yETUe3jVBdLXzdhlx+fwnyGlaQSKCfCVCPdAyoFBDGOg9
	s4KaWNAivCP/dbV4uRfJjbp9Xl8Z2Q3U4Yyq35oOULWOODRHTeJ7RAWHg3bzoiW8gTGrhXeBuPq
	XHIxEC6ZIfcHDVmb5sDivdOINqJ5e+vg/219tTKldg+ScnAQOUlQkh0rm6z+WQJWH3a9ak3abUm
	ywuxHqpWVkVS7qpTECojn63f1+AXnBK3yzhl1GgOqPImbuWsm7jY/fgMhRb8v3Nsim59Jig69RQ
	WtznnDNAQNq9U9Jr/4CQ2f0WVyv451K+Nfeg5q4WJAUZf3wBOTNzO+5geeG+wrpdL/9Kw4jU8MA
	227B1iurobgH9/dSAOPk+S1lJPL36ZNI0DwFC6mm2YZEvgI4nCrm085S+5NTOkAgjNs9OaNpwqn
	+VNT7StdMoPwDlVOjmNL66VCfVHaJl9IAyTTvhKF2l99CweRKHDo4NSuCrE7eBNWm9aDkfF6hi/
	6MwwfWaObcGfoUn4Tooyypglxdt+a8YsNCQVWsQwnQHooPPstpd1RjmDZLo7VsK08UH2cuGVnHq
	3Kgx6p9gYWCnfZFgaST1H8BNrbSpbKrAvhh2Lnq0AyBNrJX6OXJJFVJzruepocQ/ZN/66JQunPx
	C7wVmukCYHYl38XaDzecBuI+zQ2bTsARtCpOAA=
X-Received: by 2002:a05:600c:5595:b0:4a2:d6cf:86e4 with SMTP id 5b1f17b1804b1-4aa8a7ad60bmr85653065e9.10.1793348544537;
        Fri, 30 Oct 2026 01:22:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a1dsm1902966f8f.24.2026.10.30.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:22:24 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:22:26 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Paulius
 Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 3/3] iio: pressure: dps310: keep the user's settings
 across a timeout reset
Message-ID: <20261030092226.000005f5@gmail.com>
In-Reply-To: <20261029220635.18816-4-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
	<20261029220635.18816-4-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 00:06:35 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

...

> @@ -328,10 +327,14 @@ static int dps310_startup(struct dps310_data *data)
>  		return rc;
>  
>  	/* Temp and pressure shifts are disabled when PRC <= 8 */
> -	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> -	if (rc)
> -		return rc;
> +	return regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +				 DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> +}
> +
> +static int dps310_startup(struct dps310_data *data)
> +{
> +	int rc;
> +	int ready;

A very small nit, but reverse xmas tree.

-- 
Kind regards,
Joshua Crofts
