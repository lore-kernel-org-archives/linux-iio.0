Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B612405EB
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351513; cv=none; b=SAxAZIQ/zTCySPX6MY4ZHsFUHU+7z7N46EK6o4huSwmbs171B3gYzC4HdzkxLwbbhYjy7uVep9HF0blDC5vHMk9jHvwTg6yOsPJDl0zwj2IGPm6aTTxn4R9b0jiNWcmAu8UcfeUPAKNP32Hn7R7LwgCuwHdtQU056rMFtVXlcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351513; c=relaxed/simple;
	bh=bxNTv8nVWlNXzFWDfrSzCOjBKeU6f7DRLwGT4M8q05s=;
	h=From:Date:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mauxolTPR2IR7dzReR9l9xfoEYRtMhFg8E6ZduSuzSSeMvgjUvJebRJybJThhSQyORgS7Q+JWkdWDJt4PgaA/xAdAlMgGy7Gwji391phRcUr8O4c9GR69obs8WIllF9QgqV+DGomWTKmADgbUCq+ClBo+qUIHdDvjYhk9tQ+BXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxlX6Kov; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxlX6Kov"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48d146705b4so64557055e9.3
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779351510; x=1779956310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjMqMqxBru1i0RXnqlEY7QMPDGJQ5JmfXPvzliVZrkg=;
        b=ZxlX6Kov0It+DVCM5ZiR6aG6J6NJeOjQMZTYZ9561IjewPrTUsDW+cy0QfksR7TWvd
         cKTd3CvPuJtjvBr+1gFdXyk2V5qkCPF81hCJGT1mEcGflQcgZYGjhxUNfzyv+aSyHvbE
         Ig5f/cYc1oH5YPkK2JVKKiE4f6MbQyxsETukbMwRlPmHN/COgGuSYSD0TflkeyMnquxd
         YrQysHoG1sffKbJ6Y5AiK/Tt2KNZyPKprJ534Arb5hX1ACBsvH7BrmTnqTIHqyy9aXC1
         h9lUI4rdWc6YkqVX2hSOor/7ncXG8NLyHLoqUjLd0dzOKyTb93/3qAFAbtfZXP4fNHnH
         19eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779351510; x=1779956310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjMqMqxBru1i0RXnqlEY7QMPDGJQ5JmfXPvzliVZrkg=;
        b=pogN/otUM5bOLcnu7yUtl9f7VJOcI95O3DWmeEQQl1YLLxMs1yLebiTst9cymr48xS
         a/BQUv9xZAXDoX4iPBto0GmRbDThM77kehizbfqpuQsOTJ5LDxOShvTR9TJotKBfn2Nf
         DSSaa/xaSGtEA7Vc+yKH5fRrOf8GD9Vp+rkJgFzfgnXBHMBya5+LXXR3oYOvhUA44fGI
         luYQZTEfW/fZJkl1HUjtWTDu2YjqbOZZjuvoBVp0tA555dxQmbkXXNzW9u82M2r/8UX7
         qF87LzBHvoZIcGj3m5XRXL64REGAOFqbgGJrAPe2lI+nxqbVB0jMI2ayslZTHx6lpM/l
         L7mA==
X-Forwarded-Encrypted: i=1; AFNElJ8Fh2db2m0TEGO591BjgfRpDQoXPI7ra16MZJTL5vP7Gk8oYAgHndV3IMQ12Sakp24wxLeC8AvGP2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBA/E+NraDRee9LlptsYsKew62p0hGmLSNuS6tdTZiDh6l8Bz
	d50jKYRmLUBDwCM9k/qGMPAuR3RVyTOM03EFH5yNIaCOuC8cyW/4vNw6
X-Gm-Gg: Acq92OEsRAMr9BhveiX4RYEfysGWoH0Rq6iMb7bpE99OTEzDS+RaeARRg/87xdIaoRZ
	ltevnGqjlv/2qpykvrKh9e0wecOfvuHRNx6o8ac+c6xEi2eE1OtGYIKJNrY3NcuHqVM/oSBYnLo
	3N6f/18NkQEM4YvrntSkdsg2x/izYwKFOL6/7DvNdCuAjtJfrCAgb4ASCUblSAkPBmvsPPIaYXU
	WE+QALMuZXhzoWSZv30wPaI5M8cWHzXlMj7f0jtNvf3Cu6Aoa4GgrDGE7C3+tgEk9sO0fDjDrz3
	WRU0Bt3BPGzuLgnks3psVFGw9oCVShL0hDWm6VTzTn9fr846lgVtwzsMfXon4OwkgCx7o2+Z00B
	5TcdNn8O0Sgp4BaSfRp/0w6lPXJcBKueE/Q0W/a0zYvLPtH3msPmmFzIMFsHVhNTzeIbUNyCOSh
	weccBNqaZSMP/7ktFgj4FoX80qt1pN1crigZB2A/BvneSq5G8RUprmE3nDCHteTYshDrK95xpqS
	76omIDQZX+QmWpzfZlyv8aIrHgyuz9m80BW9mYK9AB7y4+cTOH90RNsnJW+
X-Received: by 2002:a05:600c:4445:b0:48f:d1b8:9aa5 with SMTP id 5b1f17b1804b1-4903605494fmr23706205e9.8.1779351509950;
        Thu, 21 May 2026 01:18:29 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cadc119sm6829125e9.11.2026.05.21.01.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:18:28 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 21 May 2026 09:18:24 +0100
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: update of_match_table
Message-ID: <ba4tnwmwcqkovyq67ootyqxyqhzk4xd3crohdpv6so7nidjdgb@kgv5zi6aw2nw>
References: <20260520175748.537850-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520175748.537850-1-grandmaster@al2klimov.de>

On 26/05/20 07:57PM, Alexander A. Klimov wrote:
> When AD5673R/AD5677R support was added, of_match_table wasn't updated,
> so these two devices couldn't be probed based on device tree contents
> until now. I fixed this.
> 
> Fixes: 477bd010c20e ("iio: dac: ad5686: Add support for AD5673R/AD5677R")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  drivers/iio/dac/ad5696-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d3327bca0e07..fb118a02f76e 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -91,7 +91,9 @@ static const struct of_device_id ad5686_of_match[] = {
>  	{ .compatible = "adi,ad5337r" },
>  	{ .compatible = "adi,ad5338r" },
>  	{ .compatible = "adi,ad5671r" },
> +	{ .compatible = "adi,ad5673r" },
>  	{ .compatible = "adi,ad5675r" },
> +	{ .compatible = "adi,ad5677r" },
>  	{ .compatible = "adi,ad5691r" },
>  	{ .compatible = "adi,ad5692r" },
>  	{ .compatible = "adi,ad5693" },
> -- 
> 2.54.0
> 

I am aware of this, but it is going to conflict with:
https://lore.kernel.org/linux-iio/20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com/

This is also to be handled by follow up work:
https://lore.kernel.org/all/20260422-ad5313r-iio-support-v1-1-ed7dca001d1b@analog.com/
https://lore.kernel.org/all/20260422-ad5313r-iio-support-v1-9-ed7dca001d1b@analog.com/

checkpatch would complain about this, once the dt-binding needs to come first.

-- 
Kind regards,

Rodrigo Alencar
