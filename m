Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AA36C582
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654175; cv=pass; b=hrBVVUp8Snhi3J31jr3M3RNrt5nhIb777O3jZEIPQE/5GhUS9pLXu4F1lUsSMsaJ+cycHnsKJeE/IKCF36UBBW/139Acit0sQ+2afKyPjrWvG0FMqV+2s+X0MIufWJlDdEoEH0zwysouSdM72LfA/ztZe70/dUiw8krKVcuWKV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654175; c=relaxed/simple;
	bh=vqCR6tB7arzlHg1VJbD1AlZSWQyVlRYI+eFh2pOl7xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIR1PtpvKRYDCIlzRK2NxYkt+FY0p7ZTdt0JmyCq2deidL1DxEKVfGlOayIdQHZqEczOdlJN2k2eQuPF3sTkjZcZJ0dbTM7V1goSe7d1Nkkynb0Dt5JThIafWDNdxAMOd6BxihBitNH/vc8fl2ZET5zQgN30LnoQFa4/zoZ0JZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvkDsGT5; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvkDsGT5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c16794450aeso48365366b.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 13:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654172; cv=none;
        d=google.com; s=arc-20260327;
        b=LGyNIBAQ8hVcRSG4ABOdBxXZCbtzkWER1MexJbb8bW5GujEx6IwS9pZxDgVJG9sF14
         NUpxYHvV9ZYqO5U933tPrFCmFDOIcwdPBBRtMy305eJC5YXgITJbWbKesRHQLBbrG7FQ
         bUywWeUyn/6qjiE8hC0JfENhPejGwZA32i9kO0Zn1/3S3Tst4k8F1WNj67fQoWyh9g8k
         CWrSqBCnoYkv+LxiMEO3JfirD894lDGtqtMyEFK9PCDgu+HhHh0OEL7hL2oWOyEpToO4
         iRF+icMn0PBr3DXzUBVDbWeFotrFN2BzZw4ScWkrzRkBE4m0qR2ZA1KDtxlYbs1c8dMG
         t/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p2Fdo7b/PmM6MsI6dYw/cb3qN13YXmyn0jdJFo7W7pU=;
        fh=A1fuN9jicr/wdU8839SlUIExzRLeYtQCrKCEnbCASPQ=;
        b=GQ6ezv1mM1KAzwN6IMIrW+XC+VP5DrzFrEbOI9e6rHPSRFflnKb12G3ZpyeVkWxtar
         ucWziPFeeiaUVNVwL6pSsDI23NAXlrdGOyRyixecjnSXBvDtC/uonYx+tlttnlfmczu2
         2Mgv+DHkEPlpJs1LXqdX5NE2ZiYefPj8MFpWHp6e+uLDM+wrDRLY/dGHCZ4/8H6sdsF3
         IuOHlA7Qg3yk01hm5QlZLII+k5LqXzno/34FG4Im4zEzoELIFe0hhGV5Edrq5h1L0HF7
         PlKZbIcfA8gr1FTZN8Il+PinPibShcPlnDsRgd4Q2L2+Yk0hsZxeKo8lhfWCEkGaYGXv
         qbRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654172; x=1787258972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2Fdo7b/PmM6MsI6dYw/cb3qN13YXmyn0jdJFo7W7pU=;
        b=fvkDsGT5D2wkuNEOy3AyP3SRhjACILGd5BqS5jZWVDvhln2y1y/IB1l/yzyKcalmOY
         uZYRmc9YBnxk1k5iQ7XtakDco1OAkj+j7d1Egd5y43/IrFRaqi1pXSlRKWZjVNFMNCnW
         AAFw6fjAsV2Th7lbz3jyeIj0Km2cBD0OqPut/l5MieJiKcLVYMvDEx9gx2lBxZy8/hXr
         6X1YjBUHG4+ky2TtMOi+eg5VYL0OH7+3JLQ53SCEIktiyesL6JO3mC63yiilL8Ud4/xj
         C+IbM/sk/R/hz26sp2VlbcKHoF0dlz1dupuikR5Bo57N+uDLYD/5HMVGnv+oCtZGBrJz
         3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654172; x=1787258972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2Fdo7b/PmM6MsI6dYw/cb3qN13YXmyn0jdJFo7W7pU=;
        b=WQ9WKD7nRjDNunbzoR6lP52rixpNrV3M+mtcd6aswSlpuVoiUJ7apP+rkLWBCahw2/
         e+4UVH59pgL6pMPSSyFei0LR3Q7VgQW0IPKS9cc+ennENqJ6PMScPSff5hlvw29Pi1YZ
         GeSbujs5CZLUN9bVaB12ypExltt66Zdu9xu8KSEjJzO29WSIIRjGHtRJNLroRZvJbL0Z
         hUfObGNMhyFvHNH/qTEj7djakW3s9RD/mihYuzdMnkIpxHOko3UTwIU9kMqBeaWuE89F
         8UnPpYzMZkMub+yGpfwQdXFxjGFRM0iYbsfWuZP0xGLGjEQnLnfDn260UPxIWbW+q44m
         IClA==
X-Forwarded-Encrypted: i=1; AHgh+RpDxqLIl+Tk6xTEMuJR5CJvVClHIBEH00Z9f/f6axkYKy2klgdRgLKCCbR8s55faqNb/ALh709jTEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZMB9MZ2e9cXy5xa/LZNd6vP8KVTG+mDrYkNR3M0IVJSxOLnC
	U5XlFCyjxnLf3TRdmJZSUPXViwS8Nl1WXMQQ8j5w/i5C5baGYGxw7FRi5OTua8dpwB8U7SpKtmD
	hWJ8p63JLw0Q1rAK+paRFzmCAS1KLcck=
X-Gm-Gg: AR+sD10wxU/XulA8kdCF51hJehQBdsohukkb35RQ1SYgmDsPrdPLSSE6K9bOzKXYO60
	YRgumksCMSX9a60V54C5Fm/Bm3pD3v77ERx6jASdgmE9C2KZgFY5yYvA79UxWGKk7h9lzfg5MgJ
	4JQD2nmlIqDTwcHVnUabwBr4oapo4Nw5c2G+ToqZm3NyyvGOwf03VMtPLZpiK4OhhUxq4mlU1vv
	YknUABWWvfEIjAsGDV8RQ3AheAVLN2zwgsbj5+krpz12DRfNdQUZmOCCQbHNdbERSeGU6PoSX3S
	zyWb5AwgxczfXkhYrSSXgEfVtHA0gjU8Qb29SIhYTbirdicZY/rp9ec2nWplOV8TR/7ZdXiyoC+
	FAsMuipDrxh6AYKa4rkpD7oAJOeq58jIPYQirZlvfVx9LGWC4WwVaPAHZugm9U7Jf19N2V6mPpG
	dnB60l/LY6qRFCYVvWdoDR8qZD0GvuZA==
X-Received: by 2002:a17:906:c109:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c2129ab666emr50256166b.4.1786654171749; Thu, 13 Aug 2026
 13:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-3-andriy.shevchenko@linux.intel.com> <DKO0DUO31PNN.33ZBMHQWWAXWG@maxwelld.cc>
In-Reply-To: <DKO0DUO31PNN.33ZBMHQWWAXWG@maxwelld.cc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Aug 2026 23:48:55 +0300
X-Gm-Features: AUfX_mya6n9Nqva8_h3GJyS2BknF6jO43s_RsEkF4n0_pHW1pDwf27fqLybWPts
Message-ID: <CAHp75VcpmkF-P33qgixJAUTbt2AAxwcDaw2owSHDDu2Xvo_gpA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: imu: inv_mpu6050: Unshadow error codes in ->store()
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Tomasz Duszynski <tduszyns@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 8:57=E2=80=AFPM Maxwell Doose <maxwell@maxwelld.cc>=
 wrote:
> On Thu Aug 13, 2026 at 2:16 AM CDT
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > +     result =3D kstrtoint(buf, 10, &fifo_rate);
> > +     if (result)
> > +             return result;
>
> I suppose result is what was being used before?

Yes, its semantic is the same as for the usual 'ret' variable.

>  Oh well doesn't seem
> worth it to send a patch *just* to change to int ret.

> Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

Thanks!

--=20
With Best Regards,
Andy Shevchenko
