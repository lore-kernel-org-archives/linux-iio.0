Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187433E49CA
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653386; cv=none; b=awublv4ktbdEg4jTFvC3h5y6QiBeH81kWROUc8QRUlCEEGTR6g6xKI9sxCsyk79sm09fR2aphsPkRGXoU4uAyVk1H9mn8Dua3odYWdmInZikFhk+XPH0rm3CUll6MMJ6GlmJUiAMk7hgqg00y2JLLaeVe5jE3SjjaBJo/gqrqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653386; c=relaxed/simple;
	bh=5x+8HPjpXqhgvYAk50e7uP9DNSJ3/TXNvQ39Lw8wTOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOhxVaTiRNPolWRns4LmDu7COeKwj0cNZ7a7O+pkqYLj4tHYoYAPaK+sZiuMsN1EMn2y1bXtUV6xVQWSMsr/05PHWifi1FdCTgUEf/5SDLrYeCwPCxuztuM5GfTp/Hegtqzav43IweGZMjwJ/inRHoNihii6Qum/8wYZa0bP5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpjovjF1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpjovjF1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197e7e4e94so800613166b.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653383; x=1788258183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4eJ3nmbGLFNyyQbwsnCHRPDBdQQucCu/IaTUqHFSaw=;
        b=BpjovjF1Xth5CIN/kg9NWMefP342vj56Wmri29jTjypi3oN9gohT2xRfn0jmxvnvwG
         3YWSt+B6dBGZrKcxdAzbV+GdxHTVww59xm4vVqUodQNwHmmZfRNrNxr3rMJw1qQOgvKX
         4eD2MMS7aXeE0C86gxlRl7qnXiIscgN3U9CR8FvwPwLPuC3qg/T/8yQD6P/3MAujZRRY
         F1o1KzbbVmNN1y+hRyClVRq3t6OG+QKkGbQuWC4afWRtCs2IuD1Lw/CBeDZ/JKVTGOuK
         bsZzQdNC614HUST1LLsycYOrFDfXKZnXF6NF2Fd1pz/XnXSe4xdDTnNfAoHJrRFXTEzI
         54vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653383; x=1788258183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4eJ3nmbGLFNyyQbwsnCHRPDBdQQucCu/IaTUqHFSaw=;
        b=cNF120TWwmzECQ3bFxSZqmE1lMw6/ZBh/NkofJF2lVaz372t92E5P7oFsSCe28JxbC
         Q+5T69g604uJbErvxNWgrQo+8tzeAN7UzHNocfxbWmyYSMOTllzRk1pKDCQrN85fWoh1
         w4nuXOA+SqwRxWeVtajSc/BNNBlLyRFb6vHHK1lxt46KAdyP/55BdAAXLZrbH+kkrApV
         ZC/PAzNMkFVi7MmOpDOo3p2RAymBD0XIMgNDfassT02y+Zbbw/BDvsuGwFz4JA/FTAYt
         JGH6vbp78HeVcYJ9pb+iB46wL5oICjN+CyF/s9cdHuzrXFPApOxK6/sbU7qchTBzYJdf
         xXzg==
X-Forwarded-Encrypted: i=1; AHgh+RrMgNM34qc5xl3E/hiph61roiYqjazHuhR0ItEqCDws9y+C9eK3+PjEbMwL/qS5aynHSMuCJKc/yLM=@vger.kernel.org
X-Gm-Message-State: AFuF++nghUeyntdwuS4r4LVYonFj+AAUjXQMa3O/0IzepMxsenaEVqNX
	vrzzNviU/Ugg1sxGWHe/TkEPhpFpj5xhF2nAAA+5rKZEyDZ/K39kGMJ3Qv1x1QlZ+2EM2A==
X-Gm-Gg: AR+sD10lRG5kHR4zT/kVEBz6v3roLlSxf8NRu4T3FkSsTrmVRn5TW33NW6KN8glff6s
	HJCjTbFGtR8dxv0S+6+y9dO/TF6Q32kJjo5kQf6bm9eE52nmCk2dHDtHhT1qs5hG5C2LBGvCMXk
	LizjTFFiKz/IXtT2zxNlh4DxyYObDfoDZr704bzmblzSBoQdE9gNjIoo3LLDrJs9S94CcZT1kym
	HnS4vvZ6WnJyJnc7TcxhzPaohD289RRJRbans0lOZPC/6xWhknx8y2ZPhIDazY1LA/WpX6DFUa1
	svMqyD9lCfF+4Xi1ONFyy6WQmG3r8Kwun1ob6wJzoRHKB3Y9GXxeeEgctcbsyObhz/Us0CwH2bS
	DMgqwV4rkmwa+ACDIsq4B2QC+OZi1ERk2/S1QQO/O8HauiGfjxx+RKtZ8/ooQh8hN93RGYABZ65
	eCodp1pAVQZXDfgx2VTdmlQC3R46V4LHWjeo7CRPfgNCYfSHUjRNizKsmMXiCJFBZVVoAOKwU+j
	cb6sCYnxxdM5etRUjJ+ETcZa9lbF15+fpTwMdIefZHmUCCoqhJeh1Ti8EHAX9O7B8JBmkmwQGkc
	Vlf4JTntAsbQG8bQSsqXq+/arSkYRZ3bmML3zs4IJml10GEOeCbugZK4EgvbtqdM38DYsH0NWO7
	k6Cw4sgKWk4CUOdK39i3yReQnwaTK4kmEkNVSMxWwWuOHIVQTtc6p1ZsWj0jIs08s5cEqEiY=
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr2775291266b.6.1787653383180;
        Tue, 25 Aug 2026 03:23:03 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6b48sm1773503266b.33.2026.08.25.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:23:03 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:23:01 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, Christoph Muellner
 <christoph.muellner@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] iio: accel: mma8452: Use proper error code when
 missing device model
Message-ID: <20260825122301.0000531e@gmail.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-9-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-9-9b252804ee80@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 10:27:47 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The device is there, but we don't have data describing how to use it.

A bit of a weird commit message IMO, I'd do

Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
satisfy the IIO coding style. (but this is only my opinion).

(We recently had a few conversations about -ENODEV vs. -ENODATA and
while there are a lot of uses of -ENODEV in IIO they should be replaced
with -ENODATA when checking *_get_match_data() results).

> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 4a1eb196589a..42e3371cdb1d 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1595,7 +1595,7 @@ static int mma8452_probe(struct i2c_client *client)
>  
>  	data->chip_info = i2c_get_match_data(client);
>  	if (!data->chip_info)
> -		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
> +		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
>  
>  	ret = iio_read_mount_matrix(dev, &data->orientation);
>  	if (ret)
> 

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
