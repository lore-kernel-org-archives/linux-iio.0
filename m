Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1263876BE
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063568; cv=none; b=UY4SuD0J8tJqHuo0BEHqiKGd0ut5P6cYw3n+h5YiikvU1dorkcakWw+ndKrA7vns0SXw1FacVGvfrSmpB47hCETdPUuNexk9FsxeYoTMBeJWTA4jLuc6aGRibqwoeJBqNyuZ3jVzYefU5oCsZhWcWh9IMv57ISxG0SqM9mDD4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063568; c=relaxed/simple;
	bh=rrdShUp79rxvWzIFVrFNBGJifqRB7StxCZ8XxmDN3bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm4ZoAqNxh3ebeOaffhTL/vO39JHTEkLXre+NRNbux6oaaYfsmnWR2TdbdBwo2bZlCmtfBWTuwLtwcmkD6DJyKb+oHJ0hxu6Oyg5T7WZHdB7pKG1EGplYJwldbp1kSQ40dvnXgosawSTuDChKUY1bj2WkMz0bFkD7uhwcuxXqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itS99qB9; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itS99qB9"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5d42a0e3b81so217775e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791063566; x=1791668366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2PlYfS4hBMhyBFUeqYNN4qHPtrfiKeb7ZEk4GUiuPII=;
        b=itS99qB9zsLmOm6fpLinzUfGcUzhfqJ8/RaOPUsKfh97FUOwPNBxLyj1CNiQauqbgu
         Dsvmt68WrO+5jtlkk7sGV7+h1ysmKDN58TDjRFnpoyE76x+tuDd+G1nCvKuHZ06LKPK2
         Y+JYUp65KOPJxJGwdHjqbk4+48RK/z78himKjQk0IEFaw6b9sOQl/yDs/nLeUiSHE1UA
         6ld2yCobVS0CNiDYV2weeQWhXm78CTsin42DgV8TWqxlBthW5fQ7k34D0SIw+0sXxID1
         bF40n+RJGs5G5MUkS8gOEuWAekrmwX0zvIUDVQUq2CD3ZAJNCBqRdxPhrjwPhMiWKhJh
         5avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791063566; x=1791668366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2PlYfS4hBMhyBFUeqYNN4qHPtrfiKeb7ZEk4GUiuPII=;
        b=JgUrf6ZvJoIkFHdmbRVxIdiES9OKa8XlZf7pyqabp15upXJdg2NF7PHUat5NJnJy7K
         cC3jOjzBt5KPIcuyx52qSrMMgOFXZTaGsmiUDOlaAGeDVfHaX8VQs+h21w0zHLlbbRW2
         ma7iOZbqYkFvlKwTOMZwIlsMQijRCpUrU3JwaMEo4GOSoFtN0RRCNNUIpbcokXYQOSDQ
         PS6grSkFC/0+0+pu/gj6DtaY+ROl0izf2nXm1kruis/Cqb1SI0MtstUfPTa/8FPp06ED
         +P+ciQpJ7bWA1KLBTfFNmxT7OdosDrvLeFcxL4MjC5T1Z1UngIoNtZapva65YcLqgYzj
         ZM5Q==
X-Forwarded-Encrypted: i=1; AKwUvByNdoA3/oMFGxydmKLEe9anw2JNTyBOGxZFf9CUDij9USxKaKFf19M+xaSqWa4OLvUoZ6Kj5Ti2DqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUq2daCmmIHE72Ru724SPId4lFWTjRGVJk03Zy+VNJQI74Dt+k
	kgnp0PoURke+2KitX1+mlCyDdM9BRzRWqktoCE7vnqX7OXh7L5gJu9Yl
X-Gm-Gg: AYBFou2V2vuDYNbVh+4+A+pSOMBUxg+UIEsJ8X+FAic1MR3rvcHngVsDqkaKRMM2QZt
	8ZX/JMQb4ORwrgMo7J51koR7mnu3ScGb4sBCMqPMX3rXP+olQX/jtz0lMe4KUv/VLV3UQQ5I3I+
	N3Cf9C48a+p+8OH8WkKNPWuUm8pX5oL8ig7wWmSne1H/cKtNAblWjgUgsjO5X2cvtVxNkJMYFSP
	nf3+2wQ2nhAMPO5QtyA88wWjWOixLVli8vHIQ+438VYsqH1KfXeNH8Xm8PV0SGmraj4wAIgFDex
	kp724yurHZfUzVcHGXOEF0IRQpuNpxNLeB/s3H+zFxlI8UqJsBHONZlE3V4u31FDrBvtAgFIR65
	lIGy41KMnndjmNCDdKy9Nh7h6gjK9pz5URAWchpYJxYMf2yXsC/PIs1bLEt/PsH/wYe/uvCTK45
	tL2ZBWQ+IQlDU2UohCsfqdrBzoFYrHOY+VJq6RDLLoY1kposdU/vpN+8KwvFGwELQbI8fr0LZ/y
	zbZBpI9vuYD046EzEKaO33h6N7zMhuW5Q==
X-Received: by 2002:a05:6122:29cd:b0:5dc:e6a8:16f0 with SMTP id 71dfb90a1353d-5de69890df5mr867787e0c.4.1791063565685;
        Sat, 03 Oct 2026 14:39:25 -0700 (PDT)
Received: from archlinux ([181.63.25.200])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da5ce773ecsm8537315e0c.1.2026.10.03.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:39:25 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:39:22 -0500
From: Carlos Casadiego <cdcp206@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Liviu Stan <liviu.stan@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, arnd@arndb.de
Subject: Re: [PATCH v2] iio: temperature: ltc2983: pass leak detector type
 explicitly
Message-ID: <asFzGi6etTy1rseZ@archlinux>
References: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
 <asFViTtGq3hQUrma@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asFViTtGq3hQUrma@ashevche-desk.local>

Thanks for the review.

Noted on ABSOLUTE_ZERO_MILLICELSIUS for a follow-up change.

Cc'ing Arnd as his patch overlaps with this one. I'll wait for the maintainers' preference on the two approaches.

Thanks,
Carlos

En Sat, Oct 03, 2026 at 10:20:41PM +0300, Andy Shevchenko escribió:
> On Fri, Oct 02, 2026 at 11:44:50AM -0500, Carlos Casadiego via B4 Relay wrote:
> 
> > __ltc2983_custom_sensor_new() uses propname both to select the firmware
> > property to read and to determine whether the custom sensor is a leak
> > detector.
> > 
> > Pass this information explicitly from the caller instead of deriving
> > the sensor type from the firmware property name. This keeps propname
> > limited to identifying the property and preserves the existing
> > conversion behavior.
> > 
> > As a side effect, this also avoids the -Wstring-compare warning reported
> > by the kernel test robot for callers where GCC can determine that the
> > property name cannot match "adi,custom-leak-detector".
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> > -			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
> > +			if ((index % 2) != 0 && is_leak_detector)
> >  				temp = temp * 1000000 + 273150000;
> 
> A side note for the further changes: We have ABSOLUTE_ZERO_MILLICELSIUS
> that can be used here.
> 
> ...
> 
> Since Arnd also submitted similar fix, it would be good to Cc him. And in
> general, if there is a clash with the patches addressing same issue, Cc all
> other authors.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
