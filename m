Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B94212554
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646106; cv=pass; b=BgFAyHSiJgdebYj0ZfVfho43CaIbsXK4HaStPKceRZUcFbGvmQOA60SK93FD9V3L0Df00ppPsZv2ElNA5q2VKzo2q0N/UgpJ43Ozl7Ua0o9syAEH4tdK+UE0kspSGDA4cwyGSAKU+17JPKdnxQ7dqAl9vjyWhzvi3lMCdrQYYbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646106; c=relaxed/simple;
	bh=zGveT+m1+kYMF4XAWfmtXr1JzlDNhosfjkXLhv7Hzv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UT9caw3eUPD8im6OYxOnKvqM7xSwUY47JessDEdpg/jSQD0YwdONbowjRrsGcayJ/ltRlyNXoiD9y1DUFtUKCoq+PLZ9HouP0u/s9xWemBndkZ2JklYcXTEI8N2tmTfvN/2jONuyCgl7JYzcYT1PlR8r2nEda6r8rEMNMvAjE9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gayJRSDN; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gayJRSDN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so25406375e9.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 07:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777646103; cv=none;
        d=google.com; s=arc-20240605;
        b=IaxfRV7cPEVE3sYFj7D77IJDK9F+4nuzJ9zEzmZsAPG5CVUOCaQDpbG0Wywyuzf3dJ
         P0FF33ZoSe4IfWIZHAnu74aXcY8F55HkNWJbNzJjCRAlhEhzrzn+chEQfoW/zr37O1qt
         Rhq3VLqo/eNLiJhsu2xfTQsSawdevkq1z9hoMAy/1RrLe04wYmGsGHJ9N2RFxKfIb+6G
         POvdE5NhFWWhwSHcAxq8ErR/g2PY/AoP7kdB0BAfbR0E2E9PFbQ1DkWRZkT4v20kOMF1
         0RvJh1F0qpmKqFqyYQJJRqlVLYGsOwSFYi9BIshoz+qfEUZnX2clpTq9u1mHDlUj/MWT
         4WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CGZDOYyLbzpvJVXo8rpWgscDxIEXGMX7uZujEmxR8yk=;
        fh=RG6sbiGy2netvFWExHwG2hqo9hUGUZHzMWqbscUhjVk=;
        b=FNO9r5G6ZZJPgEudlIgqcPZ+KtZ0UDXx1GIZjHvBLio3qKQtY4Moxn79846p1g9zPr
         hMCMc2cU2B2P3vVXHd5OusazMFMoRgfUF9MfCRBFpb3iTx/jD6c7hdVfENqbLRUjfW3K
         gqr07Jeq5qhApJmWtKbVnMOeg609BIGw2fwlidaalkrWVPRCatM9MaYVfmxpIBbTfuCW
         rao1HDCfDb96scUhbYQZ3lNiHmAsu+i48qq8QqtWK7pVpVN5C8PLB8ID5nrkLYnr+O6N
         ldZrQ3XVOToYOG5rOySBCkcGbZIo4dF6uB4f315ZMfUhKo20Q1Z3tR74+nx3mPE9Fb1f
         F4VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646103; x=1778250903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGZDOYyLbzpvJVXo8rpWgscDxIEXGMX7uZujEmxR8yk=;
        b=gayJRSDNhALAJsDFy1C6y6CiU60aVCTmzL/m5AjVwOJS6VU1kiyU2mSrAU/fgLWyKx
         hkFzbCBWiRoIfXyZgFZyEB2olOQV49y1U4bBpBJJBkR4ivJaSm5W2iL+bwYIjqC1POxh
         Qz2TN9yUPmb20C10G+1Cq4eP1hl98oiFIrRaTsJM3FSeCldYjEhBKIl0/lBEpfM39PXT
         Z+rHCXAk0b/yu6k3d2j2TZi+fAgXq0L2fnoMovZYcYJpf2jN//OIUcpl6G3D7SfTQ5uc
         ZylYFu69SdmrDZU1u8eBxqpaLZ0nFHmY05YR/ARvggJOMviQxnje3E1NiUdaSnJRRuHd
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646103; x=1778250903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGZDOYyLbzpvJVXo8rpWgscDxIEXGMX7uZujEmxR8yk=;
        b=rVDmtbjJjlIKjrFZc/WqvdIb1HK1kA9fVXXTPD+xCCpnkLU/zWRobFFf6WGX77U/VW
         z+tg9DL4L54iggceHiZWg+Imvvxfl94ZNel3CyRBdsVsj1fVKx1HbEUnFlGXs0zP6PLt
         JfhZ6RPVzJ80HzsRtj9aCBtIzB+x0qCLDpKH/F3iuPdLOPNHDRs3nmnO2pJUXqibfniu
         jsYXfxz/Asd9pPTJTpkY02JObpWz3zUK06Z2tF3UHlHNMCO99IAVokULIfS52SJ9/Z/f
         vRTHQN3Hh39Xt6wamjVlOhYebz3KxysDuAHQ2FvEpoguYTZoa9gSPJSPkSP0c3HtG681
         CFiw==
X-Forwarded-Encrypted: i=1; AFNElJ/Zku405CR1bMHOnmlCqWz7RtLYDcYBf4iXo75FDpoKHTqCWpzbqEUo/pUTI8LbgHI8vf4okF1sP60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqjEHoqwRAeVh5mjbRZJaDSZAQP9xaz7DJ6YQC6itMwCA1bRt
	I8NdXReBSAM2eLsm1TdByGQ5G0jntStk3rZhC9/MtFwywFBKbnQMKtQIX+ATsM/Ok4uEA/cygoR
	TR3FgSgr9UKs9SV6hsY7IpjWKB1uUjsI=
X-Gm-Gg: AeBDieshHWYhS0FAIJr9g6QugKUS+53DhEMqtx6zPVhTSzKMMUSt5e07A4gz8KYbZOh
	Y/SnMCPhkw+JgjVGSAV2w7ya685Qi4WDXs9Y2kz0cBpNWCMh8gsw3bPI8F7N+0TqB8tw4ESOviQ
	EJh547Gj/U7O5dK67gdsGGlhB76ocik0GCBgy26ZvFnkqUqkhHoVz8UX/rNvJKoRFcsQ5WCOQvd
	AuMlKDLgCoceqA6MqCkJ1/6hzibApw7i1LfAnc0KdCHIdT3RAfIfjC9kQP9yzQLCGuzlosEgIgH
	gM2WSu+C6rmdBFB71c7ss4Way2QTOEIJSD0beCpTEYbel85YprCrs1yGY/B9jv2i33bmMmSYPYi
	sYZ9Z1I1YK7pY9EQdeqsHzbyK3WtDwH4lCi+ts1NWwXbGvgVKv4172o9iyObqwSN5GizHVgMPmf
	R4NkAUudQ0fojUXmRr+Owvh8zMHJIdschHFtRbCTB7AD/N17p9Ng==
X-Received: by 2002:a05:600c:8582:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48a8eb88473mr39427285e9.14.1777646102994; Fri, 01 May 2026
 07:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br>
In-Reply-To: <20260501011548.15369-1-santanarl@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 16:34:52 +0200
X-Gm-Features: AVHnY4IUZJGYBlEyJY96T_twzloJ5dfUmvY1o0Se_MrMwQmj9UmnwRxADBS2wgU
Message-ID: <CALoEA-wzsykL5V675HFYNn-xZpuCa+XEOa-LbJ0KqrVSR=ZUnA@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Rafael Lopes Santana <santanarl@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 May 2026 at 03:17, Rafael Lopes Santana <santanarl@usp.br> wrote:
>
> From: Rafael Lopes Santana <santanarl@usp.br>
>
> Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>

To expand on Andy's review:
1. fix the title of the patch - you must add the subsystem + driver
that you're contributing to (in your case "iio: proximity: aw96103:
replace manual bitfield manipulations with field_get").
2. you're missing the body of the patch message - do not send
patches without a description of the changes you're trying to make.
You should describe what you're doing, how you're doing it and what
difference will the patch make in the future.
3. the macro used is FIELD_GET(), therefore all mentions of it in the
title or message body should be the same (no field_get in the title).
It's also preferred to add parentheses to the macro name to imply
that it takes a parameter (in this case, FIELD_GET() does take a
parameter).

The first two problems are things that will automatically get your
patch rejected (no matter how good the code is). Also, wait at
least 24 hours before sending a v2.

> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 3472a2c36e44..a8a6ae02438a 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -591,7 +591,7 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
>         }
>
>         for (i = 0; i < aw96103->max_channels; i++) {
> -               if ((aw96103->chan_en >> i) & 0x01)
> +               if ((field_get(BIT(i), aw96103->chan_en)))
>                         aw96103->channels_arr[i].used = true;
>                 else
>                         aw96103->channels_arr[i].used = false;
> @@ -643,10 +643,10 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>                 if (!aw96103->channels_arr[i].used)
>                         continue;
>
> -               curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> -                             (((curr_status_val >> (16 + i)) & 0x1) << 1) |
> -                             (((curr_status_val >> (8 + i)) & 0x1) << 2) |
> -                             (((curr_status_val >> i) & 0x1) << 3);
> +               curr_status = (field_get(BIT(24+i), curr_status_val)) |
> +                             ((field_get(BIT(16+i), curr_status_val)) << 1) |
> +                             ((field_get(BIT(8+i), curr_status_val)) << 2) |
> +                             ((field_get(BIT(i), curr_status_val)) << 3);

Is this code more readable than the original? I would argue
that the original was better.

-- 
Kind regards

CJD
