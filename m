Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37931E83E
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973337; cv=none; b=IB54EGbt0/PWdsT/F/qAQjM8Hlu13MoK0rD/XX+AJFIZARkY8M3FQ3UU9ODKuqq/dFlEDs87lcbUuGKnCuu8COJTr7x8trWI0f1aKEhKwtDzSZbjikpJNXM7t2Fr9Lfuwz5CjxjxnZ1n48gQ3Nda0or5sjVCFMroKIPgfRKHLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973337; c=relaxed/simple;
	bh=IJWwEB3+34NsbiEAKwrGRCgD+marV4XSEhQguafryis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW5oC8LCgxwTRDEKIqup39VdXZLcpgZRDGT+0wxh5d67rmeHgDTiYbUL6Z9zgtGlnpZIJqY3ZiMuwpZpowFtmOwZtgq5/AwJCATClqpa5LFmw+iTJLlhSyNC1sKUjhAJFJbSWNdJpx5KNnWlcL6/NYUV7unzlM/US/YhvqsW3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHGaWEC8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHGaWEC8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso4200328a12.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973335; x=1778578135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afa3+8lQ/dFRvaJ7aUrtsIA844bD/GltVTCqRXI/BJQ=;
        b=lHGaWEC8iNYuOPncmZ7bqA1MQXWHT+E7mOW3mZ79eshk5ixjaSEO2Vw1BMLtl7x34q
         h8Z1wwhxIyX7RWHVwWMvPbxnqrD7e5pGUowwB8ioi34ZKBxqq+wbRn3+r3k6LT7+Zrrf
         zCxilDMlPGpYsf0w1aDP4cqnGdMydLUizGoTDRyRWf/P+vUrspk10l+2gP2/OVpNxBwE
         tyhZbeT5a1Kh3JTSe5BNU1MDipknVlbS9pxLSCpOJu0jwoWEMF4gTqBVIcTooGHOnYQC
         3YTk5GYuqyTGBTniZd5v/D/xlI4FDYzSktbXJFOdxWAFpeVuMgnE4Rp9OElvusEF578D
         Km2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973335; x=1778578135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afa3+8lQ/dFRvaJ7aUrtsIA844bD/GltVTCqRXI/BJQ=;
        b=TNiqUPv8mjaK8UZyHOCgqb3953IDH/3DkVFDYIItodi8WN9bcug2psSnno8BuYo/aG
         y6pPeUE1+fUj2L96zUJF78ok4qHX0HT1rZUpVRJ/IQMfc29oAQzUOSgW/m7lMZKvOa2U
         4mbXkxGlcPYFekoo/hgX3xec4fIxs9uDxBGR018WA0P6dwbJhdff+frbXmJACElBSOZn
         9FyCxmy2m35Rg5DOtbsprqXE8fILWWyBSFVvhIBVTnuEB0iQrgM1hhFYCXufkgdnvNKh
         FkaCUjEVFY2p1gRavezs3i8FT+V+siYWlDhU1Jrw1A681fuY/LGSOUPpTVOICZPPtzxQ
         ToOg==
X-Forwarded-Encrypted: i=1; AFNElJ8qbHS3tdLYuqFcXdc5ZbvDGDaIrWtrqM2mG1ocrf2WgIrI4UMQo9mzA05bgncv4XxLEStZtFnmW5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yZ1a2AVkV4Eicrv/mDzkafccm8lo6wl8ZKPaNirqchzB4YPw
	66XkS7gsi1zQLFwsqsBtUiRsk1sdLNmusRxxwwvywFgGdR7VSSzo7Mb4
X-Gm-Gg: AeBDieudnb0WpLXLlEmKW5ePKIUc9D8PjyeMh/ZVMU234UY1gpCzOhAegmMvEmqBiKy
	r/L8iu35rlFx/sJkQtBWZRo1C3G/W6uwV0wikMq5oanEmFIICILL7033cVFQIcAqX2gS45Ctf/r
	ow0Ndh/bqz2WB4A6pnJVPcPg+9OMbpAq+wvSJsRuy+eRoqY0HvssnMjvPM6e7BEpVobdstlXR91
	yU7ZmDOwN3iZX7HHbAfyjONXlCeuEb6KAjjj8BpE6FESfsN9EBV6RiJNrALB9Ydux/RCjwvUtYa
	JJl6rEpmhnnA68ZJk5nNw38xJtxWufcZtznV8xzrUtMR4me3qG/V+b5dOF16wPCaG427JADGFPj
	fkCU+5IYHxRzUdDjZOtn65tgvq7b80xStoVwgWoOIw1xXX5vBw1eknI8kMqj74Te36fcWDw+YUx
	F5i3/vu8NWX9d6mq6roMKqDT4=
X-Received: by 2002:a05:6402:7c1:b0:676:9c6d:7448 with SMTP id 4fb4d7f45d1cf-67c1b0aa7demr4298401a12.22.1777973334601;
        Tue, 05 May 2026 02:28:54 -0700 (PDT)
Received: from pc ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90e1aaesm241812a12.3.2026.05.05.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:28:54 -0700 (PDT)
Date: Tue, 5 May 2026 10:28:51 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afm4U2nsfdyihSEG@pc>
References: <20260505090247.74555-1-salah.triki@gmail.com>
 <afmzOM3s_TCYxXyt@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afmzOM3s_TCYxXyt@ashevche-desk.local>

On Tue, May 05, 2026 at 12:07:04PM +0300, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 10:02:47AM +0100, Salah Triki wrote:
> > The ENS210 driver uses both `i2c_smbus_read_byte_data()` and
> > `i2c_smbus_read_word_data()` during the read and probe phases.
> > However, `i2c_check_functionality()` was only checking for block reads
> > and simple byte writes, which could lead to hardware interface
> > incompatibilities or errors on certain adapters that do not natively
> > support SMBus word or byte data transactions.
> > 
> > Add `I2C_FUNC_SMBUS_READ_BYTE_DATA` and `I2C_FUNC_SMBUS_READ_WORD_DATA`
> > to the functionality check mask to ensure the adapter supports the
> > required operations before communication begins.
> 
> Can we rather modify the driver to use SW emulation for these cases?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

I'll update the probe function to check for I2C_FUNC_SMBUS_EMUL instead of
the individual functions.

Thanks for the suggestion.

Best regards
--
Salah Triki
