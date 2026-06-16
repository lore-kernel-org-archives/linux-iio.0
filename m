Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C223EEAC0
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602408; cv=none; b=ZvQnBPyquBiQnhJJZKugPuK98l3lgLOHC+tjt/3tE6Gl637v9HZJBrPcRDsYu091hnMmYkGt9NSKnRjWN9om/sAqUhZV8hVv+15s+HgzjXRS588MfPUQAEPCjp0NLSXSIKPcWFUOcgAO4R0zJCC5aVpL/FPIRjjot5V9o0iFuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602408; c=relaxed/simple;
	bh=zcSczsjl+oUTupPg0K9goQ+v/ljMWZqjCyJlP2xDGRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJltJVOjOoEvi9m9Kb12gwuTKS6z+Ft67Bv6DTdM6p5FbK3fWXmN0IEf+296D0iyEdWvUKq5ipscXNsr1boZ5pykvFsN1bhnRTjuKYDh7mnH+JG3yybjXF6YzwnoiK1eexCRqCZ5SLwCu/q4Yv3fI7kLp1Djp3KHisDHOdAWWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5FQ/phW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5FQ/phW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46013161068so2153189f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602405; x=1782207205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwhTbpSf3S7rURBKa5GxlH2Q5fxRXSJEjfD06CTwETQ=;
        b=E5FQ/phWhY5vmLKA6S4Qj945+TwjCqMTeU7AHc5bI6EGUS1ss1ixzB3XLt0r0tvYEQ
         WgZOWMn16j0PXgtK0UdF6h9/WM6cVk5Bk/ZVQBK2KsvlVFupdAfnyji4+qokW5W+G1T7
         AxMfcyXqYVPzac+YsnbMljhIa7l9dPzadgn5e7wzG6gy5JJC08UXRf9clfbKMSAhVBk1
         TSkOQyHMC+S8rfHxYh13+Tg8cW7g+pwt8roiU0IASTiFi689DjGCx9hC7zDviZuTpSM5
         hqGlJqf8PDVGmTtXWI4M/FOP4AErkjiISY+CTCHWs5abkLJeZ0VRFDkXAgwdu+7eLmRo
         BUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602405; x=1782207205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwhTbpSf3S7rURBKa5GxlH2Q5fxRXSJEjfD06CTwETQ=;
        b=iex01rEOZBggTFC6ai/M2gHzjz0Ad8F+q8aCfgHUcT1QmGuL4uoNNM2bRZ8oG4ejYk
         sFEAfotD8eHeYqyloLty8Z12nPAo7BDftzrD6+jf7p+74L6PzTi9a/loSu9eHVJU/HeH
         hEdAtxObZ8NGtEIPpMYB+7omfTfg/PqpKV6V48KWWXENk8VdynjA1B0tuanrm9X6GoNK
         Fg7KQwZhNvumLYwISet5fT5YsQ8GTJi3Pkh2Z9ASz9lNr8tJwIK+xQ6sjmuJtvSebsDs
         EHA8H5y/VAUSOv3igPE0+Kli/OBJ5dwveMqney4R8MMbzZTLKIVX0055sZ1TFDbgMxgz
         aINw==
X-Forwarded-Encrypted: i=1; AFNElJ9GhX+GVsB3dF1owfwOo9TuF7kkBUTZPPyUr+dZ/j8zQwnALxuTzOEaTBCBn0TK/EKUkAGXxgKRtv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGHD/YnTvX4baMVGm8cVcjjf3u1bjvHlvsSaqthfW2tuuFYOB
	YXhceWZ/ah59uYmKXGyLmQDmX5/kVSM2PzYU748dz+48ImPshrRPaY4Ka5UxX12v
X-Gm-Gg: Acq92OEKZQVih0W3HiNt20k+hHvctUTJrpmA2tm3ioXeZmratln8AOxjB/j9oiharX1
	c8TJEsLnMK7s+MqFe68pAlfg0HDfS95E7NssKVoSEihZcewe5hJ9QkqQzQbVn5J1P8biMOD4Xll
	QdvhU4OxCMFD+SQHa7DmaKrKsISficyhh0svaH3LV6EGTeVIRmayhtXh9wHCRyRVtW/wMBPeQ29
	WeabE06nGREfDceEG1DzO1T/xDIRE0XkwiQEzvvOCw21gyjR01R89AwFXyaZdNwk6rkcLw6FeFt
	jPDYJR7wHKxYaWIsOspcObgJKQjJNt0W4Z+5DiD/aBxMTz6rOj7KkPmTHVK9AGpeo36/llsreAI
	GhyUZKtmPMkz21cQazA6aQrcBxHWTikNXHFb/MuIaYORWMHcWGZqB3LUi+Xy1r3A5mhu+pmcRil
	b4bxkU+s2Mgqkhwy8gvHHcRR6kZK3biQZt5EmGvwfNlk3hkghNVkrfAP7hDzoBpyGyx54SHbWRB
	CMIdUx8LgxmDIfI71bVup9KXOgTfvHKGpUtk8Mz1nQF4AWfg+vKRyWC06Emhbxvb/T3QNVpluiU
	JxxaGRQRI8/YyF+ut+e0WbBUn1veF+sVWbvLgZ1ztVjPYqymb8hC6wEUD4+fAWMSHA==
X-Received: by 2002:a05:6000:136e:b0:45a:e3dd:5865 with SMTP id ffacd0b85a97d-4619f3871d5mr4200728f8f.13.1781602405394;
        Tue, 16 Jun 2026 02:33:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d9becsm40724271f8f.34.2026.06.16.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:33:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:33:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 05/12] iio: dac: ad5686: add support for missing
 power supplies
Message-ID: <20260616113322.00005273@gmail.com>
In-Reply-To: <20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
	<20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 09:21:11 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>  	st->use_internal_vref = ret == -ENODEV;
>  	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;

I'd use a macro from <linux/units.h> instead of just doing / 1000.

> +	if (!st->vref_mv)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid or not provided vref voltage\n");
> +
> +	fsleep(5); /* power-up time */

I'd recommend using a macro to define the sleep time, removing
the need for a comment.

>  	/* Initialize masks to all ones */
>  	st->pwr_down_mask = ~0;
> 

Otherwise LGTM!

-- 
Kind regards

CJD
