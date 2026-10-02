Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD5483820
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948169; cv=none; b=JV4EkTHjjyGC8YEwTNRsEW3yCGMiR0pg99ZX1HSaH01OxVLbrJwys1MNDC/bCgCHIn9XXNgMtjDLzgpifLkXkTB9r3nC7bXXMckhEHerrYL3fy+SS7RxUAnIaOtQupixvQjaBp//jI7T1r6R83tSuy1uFug5RCv+oTRXQoVvdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948169; c=relaxed/simple;
	bh=OchIdEjn+9zyXsSLPqUkq2D9FS6GCeBw/7jZURJV5nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmLA6n3TV87ECxFX7wn2dpAylOg/Em0rr/XF62Vhcxof12PFxxAIhKZhSPUOkN5iTbGP9g+eacnVqSC39CvEJpjGqRX/6Tp5FNxxabFJ+3A5x1If1WcJCtg7XJcIFjLWSideX1gVN4BLD0Jy+fD2LaI58gJVD7FQcRh2KDNkHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbJK+yVZ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbJK+yVZ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so58332505e9.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790948164; x=1791552964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPonh+5e5iUqQrGjcJ4XkpAlG+uU/Emvxd2vkVAt8dQ=;
        b=GbJK+yVZxpOQ4P0CpiIaS/SYNidih/LTvRCtLNFO/kysXB5hkGBJqyAqNzwXh6tx+e
         my0Ywsl67OsnRnyTqVac/lq/TWRMwd90m+uF3QIOqvwCHX5I6JH3/audKgRqFLl5VE8v
         4DJSnCqTa8qI3y+orjOCoGoH/exoZAC+EjdVCj1JOoOIKWr8tMfKwJ9sEZVRhrYJimSz
         HMfgv/e0eQBzzE7y/J73AGP+/54C/hV6HzF20XvRcOTCRO9Lcf4wfvrYIGUVCVHmmSeC
         0xKYT7BvgRGrFMcDulNQhqS1GyFfxUihcAtKBPF3EM8vBoTo7jvHb/zxdQv+9ZqOjkrv
         p2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948164; x=1791552964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPonh+5e5iUqQrGjcJ4XkpAlG+uU/Emvxd2vkVAt8dQ=;
        b=hU2cjb7m7b4wh1xRupmT6KRibTTVDnwXPRKVctUeTbjETMgYjOXkfg9pA+avAg5jrf
         vAs8T6PtjOd6v3/eMEaKrVxCq9Li2PfPR8G0hyU/ho/vGDK1nZq5q18/30lFZUPkYdvm
         RLixUo132LFQb86voXkFfHBh/9XsxOdwD+LIY5LhoA25zCUT8fPIzK8MoV95DXBh8Y/8
         ONTbtBwwgFy9rpyrqgJZouxx8IhIaO3dCK8ZSoNxUol/Abk1ZED/dVqlg1eak1iKjRj3
         AKjXlAS2LG3mHvXWRKcbqFkolYRwccQnnga2ZKipUnvvAuHO2MlRr29LPET0AtCB4IMa
         orEQ==
X-Forwarded-Encrypted: i=1; AKwUvByOnggslcln8dFBZxonQT3h3y/0/43hfN4ID1D7M2qiHSle9xmgp6TodyT1sgh6N62O+no5AGvDZ94=@vger.kernel.org
X-Gm-Message-State: AFuF++lSQNYNztxWqhv0xMzS3yhRAVV1ZftTUuWDWkEecAd581yU3qwb
	r2QyfxUC2lo0R7+10J5PMAqE/y8eHxa1xIgnqh7+p6KwB2luH85/s7cv
X-Gm-Gg: AYBFou0oY7DsWhwlEWeFxEjxVfa9WK9FbVkJDPk552Xf1TRfr0I20QlP5SChtFA6hB4
	4EOuGtJguaGmb4DANRMC2BW/9mZnblnfj5FPRugp49W9CqMP4FwyReE+mzFSX8IKK0SWgFBlUef
	eoEg0bHygI29SKuu1+LsjDzr4f43rJVNQfrOnGS81H5ZSRMYaBENTK4Nhqqtz6T1b/NpBAGwKmH
	18z33TwkEW/Z6oa/9hA2zwT0qIrsBBzB+TEsIF7of0i9n8yfRxRwNfsGOyE4+PvEF6dEPoc0Dyq
	ER2k99kQPez5JTtD/TmpMxZOk1u6xkdDoB+AlHPi9KZVXUNwztsR8v5j9fOAXai8+U2ipAo/HuZ
	AIkx6hjdsjFf85Mt8gYXw6WrHKGQr+a94YCnW9+U1nj5Y8ojLagysYplFLj1J/31JRIe4j5utQO
	84ilM56DaDcIvF2RC48eJaQXXn7ah4L3CKy1btUBL+wLZQX1NNKEzDPUZ7F/h6TzNLGUrUwHNOg
	P8bvdwZCkHSZ4hp3W00c59Aq5n2sy+CESx0xdFb5vkFznHChTedUteSHYdxZz4eC0Q2LurbbUEP
	nUmOO8A4b0PAXGnZPUoWpwV5c9EbAcoXdTYddkylhDNNFkc0c+5OfLo6RFu1YZy50rHn7TyTRMn
	LlY6W+EdHPuWr8e1rwiEzl/hmDPCMpqrc2By4b1Al9TevQeogd+0RireTNzRBbz5noPAvFkqFe4
	/igo2/
X-Received: by 2002:a05:600c:3b01:b0:49f:ce72:e930 with SMTP id 5b1f17b1804b1-4a02758eed8mr51757895e9.34.1790948163749;
        Fri, 02 Oct 2026 06:36:03 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm98428015e9.13.2026.10.02.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:36:03 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:36:02 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Liviu Stan
 <liviu.stan@analog.com>, Arnd Bergmann <arnd@arndb.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Shi Hao
 <i.shihao.999@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid -Wstring-compare
 warning
Message-ID: <20261002153602.000032fe@gmail.com>
In-Reply-To: <ar-xsv05s-D6a7Ri@ashevche-desk.local>
References: <20261002124902.3703019-1-arnd@kernel.org>
	<20261002150425.0000286a@gmail.com>
	<ar-xsv05s-D6a7Ri@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 16:29:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Oct 02, 2026 at 03:04:25PM +0200, Joshua Crofts wrote:
> > On Fri,  2 Oct 2026 14:48:51 +0200
> > Arnd Bergmann <arnd@kernel.org> wrote:  
> 
> ...
> 
> > Makes sense.
> > 
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> 
> There is an ongoing discussion about this
> https://lore.kernel.org/linux-iio/20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com/
> 

Ah, good point!

-- 
Kind regards,
Joshua Crofts
