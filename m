Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121A3E00AD
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863369; cv=none; b=F2PRFEBKBBJ/sjN/SLA6liZjn1rHfBKjMhlweCEMmWKcrLWVI99XlZ78TE4tClK+n/+4lmvhFv3Ma2wECGbXZLnRSo9J0vT1HIwXH4zGkuoquinGRv3PvAhnBD0QG8Gazo58J7J2X3SUQoeHx3UO9yf20T1ES4cdXpcHMOJIaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863369; c=relaxed/simple;
	bh=7kQvjor5v4XqPvM2zH32NLsWXJydYn+5ezoF7CWh9VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lakUzfTaveaXOpRrJZYgx32Ft9bwWrotZoW9FVNCLFXN7phIkXF7cExSziA55eV0EiWrx9rMK+2yqOlEeFiZp5lYSVJUb1j81P1EnnsejyB10kCIcbwDKsfAURkkFIg02gZw8fUhTbc7RKAqOmaWCiT723p4ZRMTV2iM7kRbTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN2pHOYD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN2pHOYD"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-452aacde862so105f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863366; x=1779468166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6pK3eKs2RTKJdVg/qW7uXwTeSJV4j7AU1HgoODeg7U=;
        b=VN2pHOYDfCiAPPsf8Q+okPr1j+uCWrA8gkmObBsSQ9AQhyfo/RhU9x22oKdjOrR70f
         u9+GZCiIVesatk+R3+f/GHMWXf4Q0rMtFh2zw3etLudbqYuEumPYG3Nx5SeZ/izr591X
         q3Y7LIsrU+lSJMcj1VqToafydjPuIovPx4ac75maqokfJelYKxrZupSbhIAu4xz2upnE
         t3gPbZYsfArpPCTQ1L2l1kcwQxbyw3x/Valc+er2nzAxkKuNGt+ajxqGacNko77vKO7W
         9jObCM6UnPyztHDFt+H10nXwltnMOxya/WKNwDVyyLOfB10aQgaopihxP3CsriEnqV/+
         SLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863366; x=1779468166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6pK3eKs2RTKJdVg/qW7uXwTeSJV4j7AU1HgoODeg7U=;
        b=jJBu3EIVnodzrk4aR9DW5oo1/ONedMbbsYlmd2lvFJxBlPaF+W9hIOKXpPhrLI6Kgq
         xj6c7AgKGgjMf7c3MWUp+9wmrUFUrbN5nes9jGhl0h7kFouDWXR0qxhBye4KjaS9Q2Jn
         fV2iQIGQ55ElOAZJOw8evNu0LXJPQs9+N5WVwPe8J9jfYXBFYPvgrfCQHmCtPzESRHuh
         Lxyg5v7xrbb95qmDfAr2043obv/GGgokX7L3pZM4WSv+7XfsAzApAVuydF/B5rZbEdjS
         MgC5F6wsPyZV/HKEejwuPiAuOOUtiO2QrKDcvDFVimdtnXYXdUAcdY6yPJdZ3UmPyG7K
         Vylw==
X-Gm-Message-State: AOJu0Yy5BvoiDgSJ2mqlMYQNm1jMsvSGWFzNB114OJ7OX7MhCgF3jjbG
	RGspyAHeQJJajlaZhVHNUTd7VobQsVuaOm0tF3uFS7jL1Sh7a9puBmzr
X-Gm-Gg: Acq92OHklNdLzup6dUKpJGYNJ8tSp7ufrFVo0CYRF9cFunV6nNX1K6yCNaL5Oo0/r2B
	iwrlQU0mhvlvA/8fB8Ob79aHzQgAqYzH68usV6gHCSfuxymgq5iBXKZm8wn+LRPjdojuNpgdoMa
	tI8a1TENvX02liaak+DicsdmH28sS/G5e5ekHShMGe8GbQzzEnR0qMRPTzrAqFa79A1+laaxtQr
	hgixOz7tl7ij4TOHvR/wocfvw3Kri/vluUj/9n36vTneykLOzoOOV+aaGWXgjMZrlfxjMreOoIB
	8X7dQMBxzg9uzgOzVkHw3LlyDdoelTPZ3/Gypd38H7yJaLLm/QFBtqIBXiz2QJDWu2tvoERg7Er
	UVf0E6cQlI9akzZWOleMTnVp0ouAw83uyXh14WVzwTfgKzfJjEe364VeAmd9xe8f9ZuK5i73Rse
	kdArusp5ziWyy0TGxRshdr4Mn33sGSeDyzjVurex2rslBBIcwxzmuoSg==
X-Received: by 2002:a05:600c:c177:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-48fe66423ecmr32080695e9.3.1778863366175;
        Fri, 15 May 2026 09:42:46 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm73504275e9.8.2026.05.15.09.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:42:45 -0700 (PDT)
Date: Fri, 15 May 2026 13:42:40 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <agdNAGDW5yHP6QeR@JSANTO12-L01.ad.analog.com>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
 <af2QdVmncMtTS-Yf@ashevche-desk.local>
 <af2RPuqpuMJ1yD2M@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2RPuqpuMJ1yD2M@ashevche-desk.local>

On 05/08, Andy Shevchenko wrote:
> On Fri, May 08, 2026 at 10:27:54AM +0300, Andy Shevchenko wrote:
> > On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:
> > > 
> > > We have a request to support multiple devices tied together in a single evaluation
> > > board. The goal is to be able to read them simultaneously via the IIO framework,
> > > while also controlling them individually. Currently we have two ADC devices that
> > > would benefit from this, but there might be more in the future.
> > 
> > > To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> > > chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> > > is to allow users to aggregate these devices so they can be read simultaneously
> > > from the user space.
> > 
> > This paragraph contradicts itself. The they share the bus. The bus is serial
> > and can't do at all what you are describing. Try to rephrase, or forget about
> > this, it's simply impossible.
> 
> Ah, this is semi-shared bus... Interesting how the host controller looks like
> for this? It's not a regular SPI.
>

Yes, the only pins they don't share is the SDI and CS. The main
difference in the controller is the multiple SDI lanes, but that is
something we support in the SPI driver. Because of this feature, the 
controller can read all lanes simultaneously and put them in order on the
DMA buffer.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
