Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854737756C
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534346; cv=none; b=r9lBs+Aas319xkiILsGDgtrh7f1BXMiQ3rN87fWiPMYO5u+HKDgjE1FB8NKaE8SGKE81XYFO7MS6nRRhhALWFOqGVgIbJZQC5w61+jXvVK/+r/Dkm4GBw288kumDaVQuzdPyoz+dml719Z4Axd4OSPlt6bFxHtDbEe/L1lwlcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534346; c=relaxed/simple;
	bh=6cZ3vxxb0pI4C+y16nBc6h8C4ywhozxBzEV0QFhCG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxNKMv6omfVVPVtBFgiAdZrX9BLU6EOo0RO1cBJz4vvAjPD+nh6v5Hx84WJNoqo0sHAfEWpAxUNNPRT3LYAqVba0sV5Xq1t44hUpqSPOLSNiyKjoxRHvi+8Yplk+MTvcxijFj6glUxHOkfkZn8RmkgjyxnoLnMpQEOEQWBZbsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8tc/iN/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8tc/iN/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so659638a91.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534338; x=1775139138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQ6aUbygurrGv5Eht9Bc31IiCSe4V69xfJ6COF2gWAY=;
        b=M8tc/iN/1hd9TaqDFGlWg8lAGk8OTJ0yXdLCkrtgJxru4UJCBkPwXEogu068iB+jsU
         cMPpm05JtXVrbfNa3eAjh5gVvqEbjJ4GPORNbA0FXvtxvaC5lJB1KAXrMRRdpnRdSzPF
         eRgvdI2UcK0w+1AAdG6XhKHQQIAY5er5tKuYFRmj6VZW5FUPGXVSiaYlw8bs97TiSRV1
         cLneCX5tvpoPH6wSSi8qjITmVbCtvfrGzL2TIzoBQt2LoX6F82Cn79/TJy023VpWv0fY
         0pIOPR6rDNHqzNBVbtp/5AB8D2s6T1U6fpwXNhRYzooiJ0rDnxRHwdBVc5rp6nm+UO9g
         1pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534338; x=1775139138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQ6aUbygurrGv5Eht9Bc31IiCSe4V69xfJ6COF2gWAY=;
        b=qZQU1pUkB0sIfQ8zu0M3x5hcU+LSs6OUDXYEmFbJwoxtLwVhST2WLhXUhAafXu6ECd
         I/VD3OVggILXxviXK9wvP1XA9MSeSrwvnGugeON1u+3AeKV7ZOz6yMcfYV8fDp5m9I8N
         1/031u+ewAgfj5PeeFTR0kcc1S6hNxK0hNwvuOWnBIGxqx70fI//DNDndJdR5S0MzWSy
         cSMsOBO/tJ+keicvgna9j+7fJlBxSK9suYSoUuUaYO32GOJVPlTChx6NwQCEX3V9y+jC
         4/dpMkAsAeKqYYOyDeD8+968voFdhCkIVMljvSnEpkmooA++ST/cFc8S+innIQHy5MK3
         fACw==
X-Forwarded-Encrypted: i=1; AJvYcCUkkXMU0P+YXaqki16Yk9Cg9XoDRn1BK6STuPIesMaA/dO7dFKxVJ9iiNCZdAsq1VT+GO3C4MiIh4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFp2YMn0sUSIax3ldklFbrqWdCS9GEPK2EfeBn6cXVH7a5yGH
	FKNpnn5/a5qOhfQ7tP0GG9YqgHP7h+rVJFnlunfOWWyz492urbhWC2kYO2uTjA==
X-Gm-Gg: ATEYQzxKugkMAG/7G8CEnLTomzCVttX0poUDh6z4EY15s0zHguYOBtEAUytz9NKsjER
	8i5HqCYHK0e1048+TCwhWLToORk8M/vMXinCFTeDYmvaaV31rTx3yq211tOQIQPpNT4admVulMh
	iuAzQlWR6Tj61s4OT8zPHzkexwCDw9lSzp89+4Wj/FQn6YmdUpDwIJS3+VJODa0sPHT//2msA6G
	Ba/cPnuzntO00p6OOLwDOWzbi6OF7vRLXdaY67oevs8TddKpybaHmgyug78bYoDp4s7aKsFwAC2
	jjVCfbevDpRk2IEUJTwWG1Bxt/+hcUzA4mZGqqDfXNdwpth43u7krL0x9KrgF6AZzehIr+tSy9k
	+shP7cS/+oiyFo2KB7prhm/dVZGJiMMJH1sn1xqUPSavMvwcL5828PsYBmMt2jAGbGpiGdii3i1
	LzefLMjM7193H+/S1Exyu0yploxn1OXGL4loUE
X-Received: by 2002:a17:90a:117:b0:35c:f44:c01d with SMTP id 98e67ed59e1d1-35c0f44c0ddmr3937423a91.8.1774534338196;
        Thu, 26 Mar 2026 07:12:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a7b110sm2468500a91.5.2026.03.26.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:12:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Mar 2026 07:12:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <b692b3db-75f2-43d0-8b2e-c5a89b8ff5ca@roeck-us.net>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
 <acUJGHrJvWgqHxPw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acUJGHrJvWgqHxPw@ashevche-desk.local>

On Thu, Mar 26, 2026 at 12:23:20PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote:
> > Nobody defines struct ina2xx_platform_data. Remove platform data support
> > from the drivers which still have it (it's effectively dead code) and
> > remove the header.
> 
> Would be nice to see a follow up to convert to use device properties.
> But again, I already asked this Q: why do we have two drivers for the
> same part? (Probably not to you, Bart)

Because the person introducing the iio driver claimed that they needed
the iio ABI and were unwilling to create a generic hwmon->iio bridge.

Guenter
