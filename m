Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C347AF6B
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949620; cv=none; b=HDLR6aCwKcGUTo4e2zB83UgAakI6enO4YwZbhv6OD23PE+tAQLDT/+vk+dMBF0hHCt3IEyW+o07Gd7UoHHI9VC4VQTN6/n/3Npo/0vo0M6CcCP5Xg7Auf0hi/vC3//29F2UVpCesaIgdZzmbkAYvFgi910RvL8bAQSDjAWGDwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949620; c=relaxed/simple;
	bh=m8q6OK/anRR6LU8bDyid2t7U6ZwpjLrM3FKrURqspZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsq78WIO2r+foQjTX/3M8pAs2V1/LWgA+MEsreiRxkUesrRtD7HuEevlJTWEwLAahQY+vCYH4Tt/TPBZTe6SR4F0vdwa7ieAePU/ZLxLL5y+OzexYnWaxdYTsI4DsVnhmt+CFBvcHHdYKIJaBkVz3wJeCmvUYPrxUg3XoQonvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsYu42+q; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsYu42+q"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c92c389so70784985a.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785949615; x=1786554415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wcCQ5yjpmgh/+ucZRtqgqUFJTrSq89wHY1nMeO3mD/g=;
        b=KsYu42+q3tt+0iiTxfKwjivK9ZY90Er/7pNhJEcE0WnfYN6ctkGNMRNcolNjUqjVQy
         Cd2DMXHuMGlzpifuY8fz8qKIKdt0bf/NqmHrBAAqZPOI3SkYzHH1Y2yP8Zm+7N3oglFb
         bPt7MwzdqRBQeGLDKM6JmhCKgYY9i5aoslo8l6uFUkf1wGV6tAoLn419wInfF2HGyF/D
         8BBBJSuwz6zuoH/o0s67OffZJEcX3/U+fN41RHdgQb4YGFNOtbyFl3E3wbfjZ8h0OaHC
         u7Go54Xq7vTqtXkSjszwt2DOpPjFjVxw+k1bxhIV5+kxPaRLXVOdD3r9G+pcbOwUCmQZ
         VNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785949615; x=1786554415;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcCQ5yjpmgh/+ucZRtqgqUFJTrSq89wHY1nMeO3mD/g=;
        b=gtyUCppIZsvenD8hQkZCCPnizcEk+bPNmbe1dpRkzsp/50eymiXw5wdKRfYv5RiaXr
         joBkhrfmTRqjI/C+D9KW6BzdGrkQWU+wtvverXZLfl2OuRvnnot5XGIqS8wkSAQQeskC
         JdNw0q/gLgUd8JS4b2mBtFlid7D8VDJbk+tGKQ5ozegp3Pl9Z5hOwaL3IGzfgRg3g4R8
         FdQmAx5UmN22TXhSvAjHpG9nSiZJHYIwcayxMQbgYXg8SROz4EWYvUqZHsy0OaW/Ra9L
         hDhlZDjPO/UaZ1pkTbnHWfpvLxg8FVzEKK3N/qz21fxK9rw2TVz0RUYFa9Rb2DzTMHI2
         SjtA==
X-Forwarded-Encrypted: i=1; AHgh+RrfmvRrzKcw3MxUa0mDIvd2xZI0LjgnURU34p3nBV1OA0s4+hcPDUQ0xTy9MLDSiRp1w+ebuNDgtbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfYWUrQTMW/YE2L01b7+YAcrOA0/sFd6SYnR8Q1JoHCSDFX0s
	MYCJftgdPv7WUTgJBjwlHaCNt6couLo9ok8/nFfJGMNp+eX/dAfCwtx3
X-Gm-Gg: AR+sD12xE+owSv1/2aISHU/D0qQ+Mj8zfK1+8qOd5ijoCCOEBS3tW3zQt8n4NZp8eqt
	yjxgQRu3MuycaGE4u/jWMwkFoIsTTuFF8y8lqlh1uF0bWjynKyBZRcfk7bQhrOp25V7iLZmM6ba
	XUSq6qTjApUxMXGn+lLziTwKJoZAr0smTuz3btvL5ZtfenBUmntyEeWyt83Ot6ngORjKWr8TGSM
	bSQekvNt8EldupWq6DYrVtOYDZ98PCQFi6tI/8+EywL4uDp5m5NOCaxj573HeBn17/FvLZGRmPM
	yF5V0otC9iXoMOe+H95vL0wgYr5/ARd4rRSpUlWiUnyBU7FXYklHB0PdPYQeh1Kvy+X8QnaNm7A
	u9VC1lZHxaNB/hPDa1+HccrXTVTDqCNOv5eyUbmXxGZKhY3ppMsCrLXLlXCbyCCvYMiUH/DbsRk
	6y0nclGM5ZUAZbxEjjqoNIgbDfIcKwZlApqdM+RTgYv7kdX/OligxPl8y653I2M41xzSAxGEa9o
	GilHI3Rh29HSA==
X-Received: by 2002:a05:620a:a502:b0:923:7821:dc0d with SMTP id af79cd13be357-93649267a9fmr689507285a.33.1785949615468;
        Wed, 05 Aug 2026 10:06:55 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a3fc9bbsm196220785a.10.2026.08.05.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:06:55 -0700 (PDT)
Date: Wed, 5 Aug 2026 13:06:51 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260805130651.4aceb71f@louisarchdesktop>
In-Reply-To: <aisNMmwMREF7Iga6@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-3-adamianlouis@gmail.com>
	<aimvBvJp8CsNKlPU@ashevche-desk.local>
	<20260611151026.4abf8804@louisarchdesktop>
	<aisNMmwMREF7Iga6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 22:32:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 11, 2026 at 03:10:26PM -0400, Louis Adamian wrote:
> > On Wed, 10 Jun 2026 21:37:58 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:  
> 
> ...
> 
> > > >  struct ms_tp_dev {
> > > >  	struct i2c_client *client;    
> > >   
> > > >  	const struct ms_tp_hw_data *hw;
> > > >  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
> > > >  	u8 res_index;
> > > > +	const struct ms_tp_comp_consts *comp_consts;    
> > > 
> > > Please, check with `pahole` if this is the best layout.  
> > 
> > I will correct the packing on this per pahole's finding.  
> > > >  struct ms_tp_data {
> > > >  	const char *name;
> > > >  	const struct ms_tp_hw_data *hw;
> > > > +	const struct ms_tp_comp_consts *comp_consts;
> > > >  };    
> > > 
> > > Can this be simply embedded into ms_tp_dev (and copied there if
> > > required)?  
> > 
> > Copying in ms_tp_comp_consts provides no benefit over
> > referencing the pointer; the values are per-descriptor, not
> > per-instance and never modified. I'll keep the pointer (same as
> > ms_tp_hw_data).  
> 
> Okay, let me ask differently then: Can we use the same data type in
> ms_tp_dev instead of adding basically the same fields as in
> ms_tp_data?
> 
Sorry for the very slow reply. Yes, for v3 ms_tp_dev will hold a single
const ms_tp_data *data instead of its own hw and comp_consts. This
drops the duplicated hw that predates this series. 

One thing worth noting before I do that: ms_tp_data is currently
private to ms5637.c and will need to be moved to ms_sensors_i2c.h for
ms_tp_dev to point to it. I don't think this is a problem; it matches
how ms_tp_hw_data is defined now, but let me know if you would like to
avoid it.

Thanks,
Louis 
