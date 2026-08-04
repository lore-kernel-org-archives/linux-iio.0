Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0E456E09
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840996; cv=none; b=Cp4p2QYoM/nUV0YK7GP8pyAIc19gv6gEvvlc0mm1xjksVY0a3ojYbO6PuM/79kln1evXXsTDQAsh476JaBdtc7AP8xun4OOX01zMJJOANgxCKOJaTcyEGu7q5vOfpPdygk658YldtHCISZgfMy5A6tzhZbQWdc24FR6E9shh7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840996; c=relaxed/simple;
	bh=tfG0Z0jIMdFAG9oiaWmU0MahhS2UILJuEyqDEjU+XCs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpjwznA5G5TMV8/k+Cm48uoL1l9BNtIxYP5c35HrdIWUlYVs+OrLN7lZlOJUJV6FfXS2KMyxHJUVfa35KxWUTYko+MEurzeavnmTg36DJgN4nEwfW/TgyRj+zREzHipK00zRf4uKkobhOvm8RsNUrHETOL1WItmtxSfeiNLHcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVfumHet; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVfumHet"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c169ae1cb26so136371566b.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785840989; x=1786445789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nk3LyOamE4sB1BfHbMoeJeRq5q4+Y+ZWeLxrJz2kYbU=;
        b=sVfumHetN7651IkP+3C9kpo/k/exwbhkjEiqofVtSngoRgVzkP6xVz8P2zQcKjeuFz
         zp+QUrR+htWI09pd5pt2v2iIs4lXNAlLgZO0g8b9MApJXSQM/4yPu2wy9Juw5yZT0Szj
         w6KHPGcLw/fEu/F4ebMT6myDC8HHZHASRVFWnxWNoZNRJWEf0LbxNB578YNN/GZMMGw2
         +BWaNSg/gBGEWf3VD4xfhSAwqivvJpVcNRFlbSYboChOLg2YVsT7QdyCWSqXTxzGpin2
         8m6gAbzIK3TxdP/m4dQc4C2Deo3r+uhBXqRIIXgaE1O2UOWbpu6GSzvlqhXTU30kVGJX
         rG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785840989; x=1786445789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nk3LyOamE4sB1BfHbMoeJeRq5q4+Y+ZWeLxrJz2kYbU=;
        b=CJEGmJHaegc4/WA68xAzt9DYHOgOCBVNCXLc8IjXUggNmfmIgw9stm/ZTXvrDylNHf
         yxwFnjBeQ0iIpek/oxqcRS9Wzg/vp0dipUj/du37RK+lqt01gVQjdbNVWpYeP8DnkxBH
         o5daqWDCZEpuMXFy0KBwpIyUkKL7kUqPj9mtMMOC11kkWJJWUPZRAmTu4yWnLc1lQ53r
         yZJ/Jc54vyHCDzVcVRbpKThwyn1tCi9aL/s00gwxLNT4AClxD7jQf01ThL0utWKsLNrR
         Dmed0MUen0RVTOeo75YQJIeoD2WlpMVf9JXMBA0MeirM08Et3V2Q8OowecsCBbz+FpL8
         8rWw==
X-Gm-Message-State: AOJu0Yy3FTf438Z7yJAv/vHeRxsAfQrKgRgXBY+EmOcKeJHKjwJU/FX1
	qkvIwkEuY5t0Vi1h6CODXeIjL15ZdhnlDh6Iuiw3/lzrkSv9HVe6SOM/Qzu/nHcv
X-Gm-Gg: AR+sD120BAG3F6NVxNutn2SPfJbiK3Z++SXmrbFrU+GkUfNNVskiz0Wg0FZDQjbY9gO
	2Tw1SYpYU+w5TLj1AjX8zkgvB+qg2iZ43htuaQL23BLB1ItVPI3xdhwTSdAfU5K1uC9MOzsN8nh
	r8wANY2fS8WDt8utJqOpUV+33a3uenAgR7qAGA0e3ynSzkuIlZws0BR3O+9L8xoCbUlo4MM/lmz
	y2cUHsTkraSaE3UoQoRODmgnzrw7EEdoRmXk80wq+Yn5i1ghMNAarhprXTf3kkQbvwzlc8r9Ipz
	mHP6rCE8R5PaOlB8ViICShgHgo6N52TRWLvkz+vF/RtSoLiPq2LDsbwFFnkuVD9G0zgMqtTQovr
	IIMKcUV8R7wnX5/bnXgdIvxbho4WT5enfvsrUPSlavKFiJ2yYlrAEVkC4eyKP7BRINhMiPp3cU4
	HKkZFHaNEwoAlZDgDFBZ52kpCBjXnR97YfELXTpXP1QZHem/ch3jMEvhkXHZgvgNL6ZYU1Tdf5k
	aZgbmFWgY9mg6iG/XEMkMrYrcUB/iwc+ZSuzIwWxDx5v5tcM7oXFVufGrTT9J3S
X-Received: by 2002:a17:907:3e07:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c20244fb9a5mr341232766b.1.1785840988759;
        Tue, 04 Aug 2026 03:56:28 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c9e5adsm657578066b.23.2026.08.04.03.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:56:28 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 4 Aug 2026 11:56:26 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 00/17] AD9910 Direct Digital Synthesizer
Message-ID: <q2t53ly3vl73kmu3ehvntnj75pxl2smntctcuxzjuaguihqwju@adzts2ezpg5x>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
 <20260802010959.25f9f4df@jic23-huawei>
 <20260802015846.2be354ec@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802015846.2be354ec@jic23-huawei>

On 02/08/26 01:58, Jonathan Cameron wrote:
> On Sun, 2 Aug 2026 01:09:59 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 29 Jul 2026 09:25:27 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > 
> > > This patch series adds support for the Analog Devices AD9910 DDS.
> > >   
> > Series applied with that small Kconfig help tweak and a bit of fuzz
> > around the new channel type due to the flow sensor I merged earlier today.

Thanks! Let me know if you need a v11, I suppose We are going to wait on the
mul_u64_add_u64_div_u64() fix anyways.

> And dropped again :( See patch 11 reply.

-- 
Kind regards,

Rodrigo Alencar
