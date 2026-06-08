Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2D2DAFB0
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900880; cv=pass; b=hC6fJqmk65f9J16RD27OtMLt4PjActra3kGUJDSOh36+b1Kok9zB1v2QNpf45KFbofwrjXndCIzwX4nEHzBVzt/qiFfcgrI3RcjDGrSFPCIj1ivNJD/wGt25AenxkA2iSAjHlzkwTTCxO3+U/5Q62aSJAHwVge9U8KMieQstmz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900880; c=relaxed/simple;
	bh=OQM/JImcjfi7wjn+4RAr7hfALL5l2/w4sROJP8Xbv6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKg8DA+RMVRu9Q3lpsVvR4sNrNx2O6G/4pnQ6bfI++k6rgLt3vISqoH0KiiuLUswVUVpA+lwL9adIHL0tRIGjCrbpDrs7YCSW0L4yXLpjhlyUasG3gFO6/zNhYa8+kKhDNomrLaLfEnWB/CAi7Ixk8mdE8Uo/7CFmoJ3asn31sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmAG50nz; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmAG50nz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b12270b3so23028745e9.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 23:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780900877; cv=none;
        d=google.com; s=arc-20240605;
        b=JwvDIs/TVdpeGDwX8mnaEDKoXt6laM5Popt9uupDZcOcbrleltVZo66bBAU8V+4m3L
         3vt0PCheS97nEDd9pKxYO8FyM0cQFIMgP3EWwV2UpRso40T37Srvg3PZa6W9f8CFayQq
         +0p8NKED0oM2ZEJIjsTA3fn0wYzGAyPZyik9rzjDlyi+UxZXeQJ7UueXUofEEQ82wUNU
         R/P/kmeEYR4unz1pD6V1J7pvOOLdrsnoAC9itWt9FuCxYmLbMaz0xo1WQRB/xsU04unI
         Nrm7GP0IxxejLuRHS15XWYfU46xMTnJ8xSqJeS3CyCKrTJWUJf2bYcybgRr8/SFvu740
         4eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        fh=3qC8zdXq8GKxRpEmvLkhOYftFNivmO+N10KAWgSlUec=;
        b=fjMwh5tEksY74us2oCp+xKYMquUcpryHLSUW5tS2MMRpXFtx86BBCjGbRL+VxExozj
         IX9LkWrGF7UhKXpkNrA7pENABvsc8OFq1SyeZFsfwnEsWfaSxwbiUiJwj8J/i4P2eTQs
         lqiNjQ8WLjC+v2no1+ZaEz3CMqLkW2+ZzQuG5fV1zUIn2w6C05/Ir8kycpfRUmB/3ZIE
         pYjGk3zT4HIFkvVe+ybKzFv6RNv9Gs6QX5bCNtLc0/ySrmeeJeSgKaB46x0xmPFd7hxq
         TU5YYXGnsJBBEmb/g6ucyfxQAoil6AFVc/3ghGQf2MHWExu9anEZl81GrwV49CGB9otN
         PxOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900877; x=1781505677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        b=QmAG50nz/M9yYl3c9417dWgUDXkoEY2kppsMO4BL6CjqCHOOkr19dh93S/hwB3l3RY
         ioI7Af0aqZzludJp8OwmFKzVJi6R3Bk25BdGOtryDLyjZ0HVqIey3Qguol8/zIOmQzv1
         0WfheI8eiDrW6Khaoqp3amDlVLo4EKQocJj/G4P2gqXyAXpTYyB62D5V5ELquXR+rqlo
         LukXM7ca9mD/lycW7f0gqoYcfVrj7PS55cXNy+c4c1mWilH89xWMHI/8q8xJ/PFY5bSx
         uuWCaj7yaYNJPuL2HGFyzGc0Mqk6OTlKb/jfGtLfw5De5vl0WBZd83GLG6Q1tGprHqvV
         SdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900877; x=1781505677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0TaOt7Y/rToPgZKPJf/wU2SzirryT8Q6bE6xjghko4=;
        b=O8kDNexECxN0V2OD3koRwCOG1ttPh8ekstZkniXv+E8i2JGSDbmdnn1GyRoUFjvEbl
         KUtVMjOpgGQu82EpLB94c6+/2m8D4BQQqegdtPNU2UybgXsDPVjzHo33xI91Ex+kh8l9
         wZWU3NCKumFygBvYYPcrEkTLtNDLPNjsQjlNNzHt8/uxyerydNl8okyAgGptUsNP1Slp
         S99SigoIrD69PMM4ZVB80JPbrXbRcO1WqNkIygcdkCZB4X8wqN/L1TlE/rJ8S7eic7x+
         +9JxjHvFhypHsSbsKAcwUGBCApVDfW92SlSysWBaMJeBSS8WyoO+loiwfdPTolLDCq26
         WM3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8aEop6Rs/kaN951alaewCy8tSJWsm75s7+BCHZwZPxUmnV9PPmgitQhSBHYrULEE0EE4/fSIn0e8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTrfuMjVVIA/XB71+apSNDHs8r8h/1ccKxwk5hieU2yvba+vL
	ugYfeKOxGodaPaIz4pHHVEu+8pHvBX868f2/ZtKDKffVwrj6xNxLr/DFkMl2yyQz4p4QXNWKIal
	76S/p/RWBhwmS3APrCe79wAyuDknX8kk=
X-Gm-Gg: Acq92OFs44LxfkV/op9iGJ1HnW2Ca6BcGcPY+a6W2TL3uUAYZUqS/+sOE90rUnv4dz6
	bF1MVHG6VVCD8svDnFXf9oQctLB+RMYU7Iz5aXBpomkzEc9ZNEQPm+cg1iCH1TQCGMgoC8N4Vpq
	lZVBvFkx7IXyAADeiU6VMfBmYbTNtd9RfvPG8tqlHJMQ4yYL6jZ2f4el8/+sUcfoLoKXSR6Slg/
	NkAz9h6EuNDxLAdg5PV1iIKq7V5ErwdTRrKmorrES2zCvG2EEW4/pQFDow13h+D2pZV4A3TXBjk
	T7enki8k7CIhe5dUt/Xfs+FFS5riC+NrQHQKgjrSjgKFx1PaN3vcTjNdvGslnQvtBplEiKR8341
	odxspCo+Xy/kjuqDXowfOGPhhuFPog7sA5LeHoR0ZKgZJ5MS/0hhHsGk5gj+2qO8452kCAxcfT8
	HONEObwhbH4l9nNxEI
X-Received: by 2002:a05:600c:1d12:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-490c26049a0mr234289415e9.18.1780900877418; Sun, 07 Jun 2026
 23:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:41:07 +0200
X-Gm-Features: AVVi8CdSwGkE7drW8dMoDRs5NIyQb5y_X45ROHHEWLYjV4XMOXGvV8vHbLCYnWY
Message-ID: <CALoEA-yasQhXE9o-iYL5h8w0wPMrP4f-iva-YOJ2KZV9UuGe3g@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of unsigned
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jun 2026 at 14:19, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index d72e260b8266..ae2fda8dc500 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -241,7 +241,7 @@ static const struct iio_info als_info = {
>
>  /* Callback handler to send event after all samples are received and captured */
>  static int als_proc_event(struct hid_sensor_hub_device *hsdev,
> -                               unsigned usage_id,
> +                               u32 usage_id,
>                                 void *priv)

Code-wise fine, however looking at this function, usage_id is never
actually used,
though not sure whether removing it would break the ABI... up to you
to check it.

-- 
Kind regards

CJD
