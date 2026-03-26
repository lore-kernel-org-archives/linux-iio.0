Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F594331A49
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562699; cv=none; b=BrmQEy8aEZ8z7DjRicx8vZwu6GpllLyH6W+GsgLkgUKvAfnAXyOi6yyfqxgC41v4Mzs2NAfF7QEe1UHKIiyRyOiYNUSvT+uaHdL8YuRVELFcroVMrFfPGglc5Ytxbs7Ul2U8bZQNbuwWWzkMvowaXbuJAZuaYOiHvbisSqJ0Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562699; c=relaxed/simple;
	bh=GBY4i+7n97Blol+zZDLhEwkVkvlwAP0FnHiMpSo+3uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCVRar8CxxiPRL6TJW6/Fr330WQnwc/vg8c2dBfLiQRIyrC/Ost3gsSGcPnwLu/LbrzIp27fok0tFdPUBxLjQb391n1Y11NyViPyObzJgfYyEw0MgC84cv3OzLi5VLkbOk/89OQdvhjikt4xySB5ms/EX7Gg8ej9vgGA5wC6J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDhSiVDp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDhSiVDp"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2d6f9d00so14376481cf.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774562697; x=1775167497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RrKHhCFI1+fxT243Y633zvQyWdh9GMd1zgxuWpoC3M=;
        b=GDhSiVDpiYWK1JY6gSIOea8QanGOiHJaeDQhXmLuNTljg9Q5gO5xe8y+uHogeo8lD8
         mEvdQ+0TIAaGW+gZVm8dokt+eMNaE7zPU2CRqTeA8+6tXypZkeemywyOgbizyB3U2Z6d
         m1NFUuFVmGgMNLtEtyi86K9eaebECvXL4cBLW8J8YlEtPflpEZ0BCDmQwr48OGxVU/Hy
         77Nlc7zCF2cgy2jzWR+RBnf18ye1NRn3m2SG6XaAOKpXJgxuZQ8JGzRoZvXTNeEV1MSX
         ty3i6GDNhRK8TuKIUGX3+Ng+h2BclM/0yZKf1Rvj1UOZ3JNZpu+XMb+esgEVr5/NT1Ud
         QIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562697; x=1775167497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RrKHhCFI1+fxT243Y633zvQyWdh9GMd1zgxuWpoC3M=;
        b=IQiCBL6lwJApRmUYyQfi3eg/0zOXHYL3QSbd7p/zkIK18bYhhCwpWxn0biVCz8yBpU
         /F3db2BSXKMyt6HauGWbwQAwp6jwxmdx5E+tAQBwrph4Xbz0bhv08dBhTVqvbfHwolTu
         c6Ox4vGaN583Y5GWknnMLsifg2GpID/i3Wh45xBJmKmbY9olD58n43ckYyu4Ob9wy1KX
         8qu4YLcGQhTpsZknaxOXocnNVD1eAjjO5r5hvPBn9l0fzPJAF5kI9FcSf6zrgjhzTEUJ
         H+oHhNznA4V446PLP1WoxSxVWacSPfjF0pJkpOmJ7cTnszaOi6lNsD7SgLhgAtRrdxmH
         NXkA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNCsWC486W86R6Ps3gTNbd1pz05Ppqt2Ve8xezPBVI3SrWjw2s/Z1NK6chT70AzlAq4EUej+4hAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQqAcniGa14C+ncJaqS7nDUMmoH6dTTtp15RcLgqUikyTuayQU
	1mGBlxObhm1jrAPQi7hwlXXZpUd3qQTljvFcu6Bm73XL5Z8ui+rWEM3IBLB2EodeY9k=
X-Gm-Gg: ATEYQzwkw2txluO35Wse8Sfxcy6giXBCH63rQegQDDlBaM/3Jq/74CW93flGnLZpuyk
	Z7bEHb7SiQCgOc1AzUWvcnZ92tITjfmzjWqTzMkswXowmFLlKuhh5JU+nM0rSpfWcsApWq46jK+
	tGFThD7zI16YR6tzCzHkZJ9qW4FDTJqc0bM5t/YlaqOscw6BWvDiH091UlYKSr++KrmX7Cq5nkK
	OreCDK+vnvCZX14oVymAQgHSBecjBXle8hjom0i1SurjaskVLQRWYQt+2/3uxwYZfQSMcMHkmrU
	JSVx56eb8Vkm7nZ+RIeSmdoAT9UfNcTMig7Tpkr3Hy6wXVnOt6N3MtdzWcHGaloXr7OTKlWrEvN
	4D9D4fGmoLV5Rwb3/K4sDJqbKnjnOutUlEd0wujXCNfHpw9jZhE40UiSWIKzC86xWUdDRTthcQp
	MrRfWSRkieI2bZi/wp90KX3/Dk/n/I9KI5B5vwvuKkb7Fs4EOtxjyb+e5eYH1OjcUIPTlag7va+
	h5SzJ6a2YXHctFmEb4Np1RTYS7Bkbp68UDme+4xUKAb3nYXn9dL
X-Received: by 2002:a05:622a:99b:b0:509:34df:4f03 with SMTP id d75a77b69052e-50ba380a874mr3457191cf.15.1774562697200;
        Thu, 26 Mar 2026 15:04:57 -0700 (PDT)
Received: from TARS ([207.219.48.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5aaf0cesm36120126d6.47.2026.03.26.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:04:56 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:04:53 -0400
From: Ammar Mustafa <ammarmustafa34@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <acWthfEL_HGtVykN@TARS>
References: <aaHrsTS9iG-PEfue@ammar-VM2>
 <aaLIhgJjrNlp3oTy@ashevche-desk.local>
 <20260322121314.0143bda3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322121314.0143bda3@jic23-huawei>

On Sun, Mar 22, 2026 at 12:13:14PM +0000, Jonathan Cameron wrote:
> On Sat, 28 Feb 2026 12:50:46 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:
> > > Correct the ad7191 documentation to match the datasheet:
> > > - Fix inverted CLKSEL pin logic: device uses external clock when pin is
> > >   inactive, and internal CMOS/crystal when high.  
> > 
> > high --> active
> > 
> > Thanks, this part looks good in the below documentation update.
> > 
> > > - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.  
> > 
> > I haven't checked driver yet, but is it only for a single component?
> > Can you double check that _all_ supported by the driver have the same
> > in their datasheet(s)?
> > 
> > ...
> 
> Hi Ammar,
> 
> Just a quick note to say I'm going to mark this one in patchwork
> as needing a new version given Andy's questions have been here a while.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > > +- When CLKSEL pin is ACTIVE: Uses internal 4.92MHz clock (no clock property
> > >    needed)
> > > -- When CLKSEL pin is tied HIGH: Requires external clock source
> > > +- When CLKSEL pin is INACTIVE: Requires external clock source
> > >    - Can be a crystal between MCLK1 and MCLK2 pins
> > > -  - Or a CMOS-compatible clock driving MCLK2 pin
> > > +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
> > >    - Must specify the "clocks" property in device tree when using external clock  
> > 
> 

Hi Jonathon, 

I replied to Andy's questionm not sure if I can attach it in mutt for you,
but we found that this driver only supports the AD7191 so no other 
documentation needs to be updated or check for this issue. 
Let me know if I need to do anything else to have this patch merged.

Thank you,

Ammar Mustafa
