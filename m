Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6E349CE9
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725586; cv=none; b=CCLKCb00eQIghJ2OjUqbku613+XUCGZ9mqh3bssUTz/g28m8l//Ew6bbiTlkPEr2FHeNSoCL46GNdyBf6yqz1xcsNnVIp0GDkexaa16y/65TNj3erPOerLv/Ik3H5RpuRh25O9PnPrSw6kLWuPHkrHmlb7DLSrn2zv5kqluEX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725586; c=relaxed/simple;
	bh=s5w53t4HZEfOpMWOAkkPTvlM5cQcOCdRUzSMehtyGEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBgwXSfg+kMi5Gdpiwqhefc5hhJVTs+19WZqxeNyr9QSOxemWOTmdT1gpCHGr3wvWsmkNaEq/I+h4NV2XK2x43WSZIrU0q8mwT1rjT74mjFuQ2eMmSxdcOrM2/zgrO7MpnnDqFa1svfehs0DFGRFJo3EKl9AK5POkxJKrh6H5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS1DMu6i; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS1DMu6i"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d75312379so8147466f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779725583; x=1780330383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PrUkFmsyhM+H1pzZoLfPMsL3Oa/eAQefGicPa01J8aw=;
        b=kS1DMu6iT6wKVRxaPin7EgPS7Cw9/Pt3WcjoUuYVh9fpumC5IoI/6d1RkxVJfBuVtS
         VWVIpYdKK5RzWqtObG8JD5M91ESXgm9MROtxzeVHJu4FkMcK/tRAPBJOt++CjlF8bOrJ
         viTwzjeTTdLZ14eluw9HcGFfMkic6lDfqgfzxKVuFzQ+Joa5uDV30/AP6Nr0Hwx/4urj
         k37EdlUQoyANmWVkoQRyMKjYhnppCQZddKZK23UH4Fl61SX7QuBjSQAfOmN+mb7TwtJi
         hwL4PW0fyWVAsCsxD0n9l7gWFKnuFKAn5MLjiZHnFXsbvq65wC/xV2LmM3nAbrJ6LGb9
         CIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725583; x=1780330383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrUkFmsyhM+H1pzZoLfPMsL3Oa/eAQefGicPa01J8aw=;
        b=KfAfEpY663MKC6vixyfYf0WOqdmRm6CfY172X4/Rw2JUWN8ClHWl0hKGmbA1se2pD8
         I/tw5JZrBATaGfCSr/u82aMH93YtBQ5CZahL25PTf4U8IctO/52idTksDM6HZQxkyKAT
         eLO5jBp2ksvL8zQSF8BFjw1HvBEs3cFe0Z1lY1RjjcZRF1mqxoSClZ3RiulWwoIkb9/O
         bFclFjJIwDs/y/y0noM2Tj8XsL9GGULA4t/BvtF6y/nmSf2wpqGvugzQWPlUOP1ywjuX
         KMi7tsprSxy+MdBggCxyovIW3olYDRvLJvMzCFoVSY8p1jqC6aHhzFnrKxwZDBciceUm
         u4Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8bufpEM0t2byZ2T8TZjQOulcf8K4iqrJmGV7O7xnFwD3E1b9GYK4IbfiUe3M8tYdOchfhfEH02q30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMsvt8pY+40EuFOsvSYenqL4ozq3XZyMyiiKEt2ibiGhqN06R
	TfyBt3EB9nENZIh8dmeWyeJI03AZpQ0uVXNK+G6dzpxgv3Zncr0zjAQH
X-Gm-Gg: Acq92OHmBZqt1XobThnSXz3PVsoJ43GLC60xnPC09THyacP4n45GRfLs3IeddZ3VhT/
	EY22KmVC06B2ChX3R90ZlZVlGXERUTucVsumJFECZMI+m7VEbiNrycNDD2V9SU1xENDazJckzAf
	vdBqm7b0ZUysHXOWbd9APOBEtN3xZD/2ibZlb3StP9S8gBhWuXkYJlp6lBjgi9jTuU9xUYF46rQ
	hZ+UpyjGAukPkujGca3fmVINP/3PTu7MVGMdv0PmhgDONkeylxOF8GWWKttW9FIGDbL6sTOesGa
	jUFT2Hm7ItQBW2IQb8L9AqJASsEfD2Me9Cur5bLnQcLodhU7JeXYeaHiBjfE54IJAQUf9MbosNR
	4kbYSFV/1NBd4kHNKkVUyXv0Zc9Qqc65eu65rJAxdskJm2fgy02gJCPMfHE267Vq7kW10Uzmt5N
	QphkTKhnuhXLvXHfkHuuKUJhr3s3Y15/qXuw==
X-Received: by 2002:a05:6000:1889:b0:45e:8edc:dacc with SMTP id ffacd0b85a97d-45ea31ce398mr31640895f8f.27.1779725582779;
        Mon, 25 May 2026 09:13:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm28136573f8f.19.2026.05.25.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:13:01 -0700 (PDT)
Date: Mon, 25 May 2026 19:12:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix uninitialized data in debugfs
Message-ID: <ahR1CUxzMkYDwVvO@stanley.mountain>
References: <ahP3S9nOYN3pG-Fp@stanley.mountain>
 <CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>

On Mon, May 25, 2026 at 08:17:28AM -0500, Maxwell Doose wrote:
> Hi Dan,
> 
> On Mon, May 25, 2026 at 2:19 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > If *ppos is non-zero then simple_write_to_buffer() will not initialize
> > the start of buf[].  Non zero values for *ppos aren't going to work
> > anyway.  Test for them at the start of the function and return -EINVAL.
> >
> > Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> > The original copy_from_user() code was better:
> > https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is-complicated/
> > ---
> >  drivers/iio/industrialio-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Codewise looks good but often times people will prefer
> 
> if (*ppos || count >= sizeof(buf))
> 
> over
> 
> if (*ppos != 0 || count >= sizeof(buf))

In this context, I feel like either is acceptable since zero
represents the number zero.  I have a blog about that which I have
been trying to promote.  #SEO

https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

> 
> Regardless,
> 
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> 

Thanks.  And you're other comments with regards to -EINVAL and
-ENOSPC are obviously correct.

regards,
dan carpenter

