Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50930F803
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110036; cv=none; b=DXf5XXzj2wp2ot/kMksaNxWkipYZ9m6T6e8GW/Ayd2yMTLFdF0xsTYaTsRAg0tsBqyFtqk+ZKK41x2phaiV4er1f8vur3YJHXlqA/OekHwBuhgzgHeew2wr5L09y1ALFlCDDGFq2TDxUNatFWvV5zU96D8FUp6O9lpdTtfZjZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110036; c=relaxed/simple;
	bh=y0GciO2PptY+uLJh2hE0gUz/QaDDOUqegX2K+jVz2EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIz83X/9gBwtMqTOyKYwL6wNyjUV9MFBkwMx1d2zHd4ZWh8MvJZ/nQu4Rw5gpQWC9/f/Dso67Yty80q7vn/uVVRAMpWk2D/+P3tsisRAqT12YbAL3DVtuZrcLFWMlLBLwSj3V6y6b1fSAOoCl+/O+NHzwIVHQ5+NJXBP3sm3WoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvQWJz0U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvQWJz0U"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so1002710f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110032; x=1784714832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i3m9zsFrAgWzgJX2cCHjiYa0wXHpJDDJln72RbZhmYs=;
        b=AvQWJz0ULKUc7OWuHhozvdU6KFap2rr0WGWVWhFfuOtUS5OwnLKm1r55IJX1Bdel+H
         Ym0xZyfofDkWsjUDblEucfGXSRw9WXMzly5HCTUFsmbGINiQoc6y70SrtwjPyAmbIKv8
         jqQ+p63/i1Y0RHwRIzlB0pemEJC4zYZiV7BwpbrDZZhPIi90LVw7DgJ3pTqBJBgRkeRJ
         r8ySQWtMGd8OqJ/eObI2uyNMtDo1IcmxJgYgLq7AT2mvmgT76hpnGuQFD3qGy1b4FHGw
         C6lLYXxBLej1qh30LrlpzC4KAYcUDv2J/OmMIAF4kaFV5t6kLPZfzdcDweR8KlbQVhfJ
         Dk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110032; x=1784714832;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i3m9zsFrAgWzgJX2cCHjiYa0wXHpJDDJln72RbZhmYs=;
        b=O8dAxM55ANENpiiRRIa19u0UZqDZlsdTdFUrignYdM/325qb8iPrjpABgnB2vFliAj
         wBhLwS2Hho0U4i5qsD+q1F9dqEx8yA4hLKGlBNKR27xYHZB9wuTUl4mnoT+yqCLtu3Y5
         skyQAw+8QJhwRnJCmiqOaTw+in8BwhZn+sj4Saa/A00naXHiaxjkhNtGTLHQw1Ohti0y
         3h5MMKYHaRlTg/yWPmRoP/hDn62QgewkbgEwqKxH0K1B8A0xpSfUrkg6j8pzLYmWoxFc
         QKDHhXWQjDblwbmBH/6VkHSfDV3txj3T9mw9aYKcm2vUrAAqGWkAKSKfwbiuas+/wHO6
         tnxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrC8c5Z7FfmNAxyOgl4UN27HncbZHMHvbn489/NOYW3GBhK3Cjku8CG4YvjPe66R+S5O7I9FtVKfmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDT5dJLKVvSdNypCSXnxXbaiz9JF0HUIKOdGqXLCY5v71sr+Aw
	cvo6Dt7Es5Vf2Qp1lHCMG/3cxZnVNR30n3WLdoKfPDPDgfBxPu0HsqFSjX1hS/Ra
X-Gm-Gg: AfdE7cl+T9QoW5pwbyUXEWvFSjVwnu9LzYjEy3UupbmKbiOICEkIAYQgtzt8VeKaepk
	OTQNEG/bfP4Lh6G6AIcvMQc68ohtXzk6gFBQo6luWeicIpwpe0iQkIA6ld+9oOipQ2Pc/g+5Z8U
	oWL3U7qA26VHtstO8IHTT7bJ2uRFze+3z9EP5A7LVE8CuHgFBQnh/dLSPUwhKlGFkT8NjZgimkJ
	B3d8Gc/FL74eJRuDfdJYK8qf5EsV4L3aoGrsaPdnZmjrfI4mtCuHuQ2SvdXFX2OUAsK3gycHp6S
	sY7Rto3DCwbX337zgyYw95KmRGdQwuM7zCeRlKhH/KPhugG6pCbjasHKoBdYCNqQdpebo0Fu/ys
	JNCuoCpdK9pz9WSC36+qqi0RlNN4yn11Wwlx4bBiwBiZgIoKgJ0ubaW8i5rWZN6wZCdk/Pou6sC
	gDhDzs4Iy4quP6pPETe8UdIFRZi4zB1tGepl/BGuqIVFzBSB/Vqg==
X-Received: by 2002:a05:6000:2305:b0:475:f0c2:75b0 with SMTP id ffacd0b85a97d-47f2dcd7854mr20150852f8f.27.1784110031605;
        Wed, 15 Jul 2026 03:07:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a935sm14962845f8f.11.2026.07.15.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:07:11 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:07:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Duje =?UTF-8?B?TWloYW5vdmk=?=
 =?UTF-8?B?xIc=?= <duje@dujemihanovic.xyz>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config
 static
Message-ID: <20260715110709.74f556f4@pumpkin>
In-Reply-To: <alZs-uLJug_rnRnq@ashevche-desk.local>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
	<alZs-uLJug_rnRnq@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:08:10 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:
> > Don't populate the read-only const array config on the stack at run
> > time, instead make it static.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> In all patches like this it's always a bikeshedding possible of moving static
> data outside of a function. I have no strong opinion in these cases (when the
> data solely used by a single function), but in general it might give different
> readability experience (it's harder to notice static data in the local function
> definition block). So I leave this exercise to the maintainers of the respective
> pieces of the code.
> 

If global you start wondering where it is used....

There is also the fact that run-time initialisation of a 3 byte array
on stack is very likely to generate faster code than using static data.
Mostly because the access to the static data is likely to be a cache miss.

Then there are the architectures where just generating the address of
the static data takes multiple instructions.
In that case the on-stack version may even be smaller.

	David
