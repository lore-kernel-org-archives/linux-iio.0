Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE52D0C63
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256745; cv=none; b=tGZpp7PvjEEsVggOy2mNLwwy0EhYXHU5GRIipNGiIOWzB+46ym1Qdn8v7xKVJhJQtxAw5fR3zO9LqzWBDSAhfY/K70/BwXf/zWt06VplmfbwcVMXBfgVSlzIaVmELse43699/YN/ynKG4XrtIFW6SYtvmXO5StGJE99q841RX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256745; c=relaxed/simple;
	bh=AxH0H7SjWvdfFs9A7JYy9sQog4FFRFEh0PEtdkWQG9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8NQ7vofsTX5XebnhhmvBjVxotHmTciAFepsEOtDZLXvMuOW04Mdg1CRL+m37JaiStlVn+1VuI05A4g+RwMgonLkjP+BJQdCygqZPAt4gIjzh8AHSqVqaWzT9hhLy84dh3j3e1dimUxO0TT4ErWTUfVkcAEGlnPm+OIkDRHI848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVkl0B+W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVkl0B+W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so21302595e9.2
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778256742; x=1778861542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pkIoCWWdm7EHeG5o00/peFWmYkp/yOXcS/WrUgUk1dU=;
        b=TVkl0B+WXAWPcqCZD6J15/QOEmLrZBRRZoJMBwk1mLRdDuYcXdJ6IAzBGye794Tbla
         yHUnEHcTD4FrMztZ/MDOpRl9g8dTgCFeJj+wDC9Opgo4avakr6xaMuaIimmX63uy/wfM
         7yETR3J8lk+0M8K5fj/70XogmgyVcN3hivjfvbWQGitaFcDLtCemfm3W83CxaXu2hL8m
         555/IbylnI5AJOw1Aj3VHHoOKXhASB5539xyRW4Gmv/OjdSACzUKPcLWciwtA6PfHmnb
         g7uY7rp8dl7RJCw8KuTNtQSw0C6ZLpBepTfF96AIRRCtG4/Mw+icTT5EcscIj1B+tvdY
         ACSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778256742; x=1778861542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkIoCWWdm7EHeG5o00/peFWmYkp/yOXcS/WrUgUk1dU=;
        b=A1Ij+HhK7bdICG2g+H+xB9qSobKGjZxEqlH5yAkJgpBZTILVwGcR5oc7zIaKRw5HR4
         W4ONUUGNsfhZi8pj5Ixhp6T6auC1zhzu3454zX8819qxdmhW/Y7h/Y4IAzgpTOuK1PTa
         3idxp8+fC10yL1FutDXTa8xGxzeJoRgXJ5Hg2QeVgmS3UI5Muuci2Os2hKU8Voznl6fi
         dQGg0WKTjXe6m3p0ZAEydc9Zlp/X7+00dTkcYG/rUy/+9p1V50PPj095oy+vmPUBgJhH
         422ofxj6ku2jJOgWEyYYZvxhgJRDrgJIpThntfKbdQEdv7Fw6JkFqfFU8UA0OVKbnyy/
         CQbA==
X-Forwarded-Encrypted: i=1; AFNElJ/QLZniB6RhWmuZ4oCKQXHSvr+s33z0p7uoxYxztsgkGAQnL3+PnsmK0TFbV7m09xsBwXP5FWyjRAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/eCzZuUqJZvIGZmJ93f4NeG5kjEtiZQ5StTojGTEuxjq593O
	wE05WYB9dC51OB1vpCJuv4YB5fcCX4dgTAfjJP94h8qvSO27CZvUsizz
X-Gm-Gg: AeBDiet5RYQY7yVb4Y6m604oWJhE9bobaXtXfm0bhd5DpwB50F3Wb18khvzr2RDyHaJ
	U9dwsqfmeqvlCBmu1++Cy2HHMQ9/Kr80qLAhBNyOro9jNk9QpgdO5jlmJgLWgbkWlYxhQczl/xW
	GqL+J/W9b2R9kmCQKM6Rx7GDaGMXYAoOiVatPLLfmpOrCugy34Oe5fpILtfmLja0FYwKFYqW5sw
	KoydvGI8X86MULBk+p9qDM26Ap/hLwN7A4G7OsBAtlHQWPVLlcTnv2v/DMbLnmgQ0wo6nZ/Epth
	c1AqeH7eewKFae+BjfSPbfQ3m+PJj1af0YfkcR2kBmHhpLfhd9xUfWEVFLdRP6taNtk1aOXG7EC
	mNDATNErcrc3m6NlL6dOmtyqlSbrcv9IxH3AzECT1y7blUffs1V8yAu1iNYKP7rRUBSU8bOPvmt
	TSEfeD92JxC7M04TMlnwhnce13lg==
X-Received: by 2002:a05:600c:c096:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48e51f50982mr159339065e9.24.1778256741678;
        Fri, 08 May 2026 09:12:21 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm5771250f8f.5.2026.05.08.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:12:20 -0700 (PDT)
Date: Fri, 8 May 2026 17:13:14 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <af4LCQiqNaiMzFkX@nsa>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <afCVtXBHIIoLlsRo@nsa>
 <SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2no3bJA9MSjXvV@nsa>
 <20260508121441.39ad9f65@jic23-huawei>
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>

On Fri, May 08, 2026 at 02:48:39PM +0000, Stan, Liviu wrote:
> On Fri, May 08, 2026 Nuno Sá wrote:
> > > On Fri, 8 May 2026 Jonathan Cameron wrote:
> > > > > Will defer this to Jonathan but if we can have a real of the coverage
> > > > > given the temperature, I guess this is ok. Given that I think we don't have
> > > > > a better channel (unless we add one?) for this. Or just extended_info...
> > > > >
> > > >
> > > > I have no idea what coverage percentage means in this case.
> > > > Can you provide some more details or a reference?  Google isn't giving me
> > > > anything useful.
> > >
> > > A leak detector is a sensor like the raindrop detection modules, whose
> > > resistance decreases as more of its surface is contacted by liquid. In this case,
> > > for example, if half of the sensor's surface is in contact with a liquid, the
> > > ADT7604 should, with an appropiate user-provided resistance-vs-coverage
> > > table, report 50% coverage in the IIO channel.
> > 
> > And, AFAIU, depending on the coverage the resistance changes and that's
> > how we get into the indirect temperature variations?
> 
> If I understand your comment correctly, you're implying that there are indirect
> temperature variations caused by resistance changes, and that's what the chip is
> measuring? The chip does not measure any actual temperature for this sensor
> type, the value in the temperature result register bank is solely a result of the 
> chip's interpolation of the user-defined custom table.
> 

I meant that's what the table is trying to accomplish? That's why I kind
of put it as "indirect". My understanding was the chip does not measure
any temperature as well.

- Nuno Sá

> Liviu
