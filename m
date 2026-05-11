Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234E277C88
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513306; cv=none; b=QzchF0gzsd1IHhU5SQwdo+ldnDm0UEvfS/Pc9ELhn0b0L8EpdrPODxmf2+tDRaYJa5YkAxdwL0bu7UsF7iyp239yRXqmNO2yi+lY+Yrc3p8zskeMIT/hntAqhot/xvqTY8mpbozFWsPYcf4NGN5Y0VSNoAfXOQuDyP474oE/66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513306; c=relaxed/simple;
	bh=FzMqaD7IuFQJaxpXLFJvhMohEqMmqbQyxCiMp3Nf8is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg4whawoAxkeWSbG5hG5YCv4/WomFI3uEh7GCbl+OhQsNFL294LPclDyLSqGmatkdpwBHvX21nh5yjHES2Wc6pOXRDorC0ePAd3IFdE/w81OTBROfwbFH5/14fyLu1azjVG7GtkrjhTSJLktTszoS8diftoQx1f8uNx0mvJfidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVdyqq2I; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVdyqq2I"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso7820553a12.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513304; x=1779118104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx/fracOZJpjZlO4z/Wctta7RdzXOVS4izK5f1NPMvk=;
        b=lVdyqq2IQ7zU2uRKmPh6vjmxazS8Dd8BBsZi8gT+GGgQUepL8ELyAF5GMqxT51vM2Y
         jISdif4tZ7gyUeuNK2JpZlNQKYgP3hNie6Es7i6aHaXvMKdfP/x1tHgCwliL4Mf4B7ya
         h+cEU2isIph2tPee4HoLqVg8iAIOdRugu0bH0wUKspubZVeG8W4kEG/1Le8QJCSmfd8B
         bEAtp/4vfiVWSViN1lYpjKkZO2KIWbbZeHqx6TRH1XOPKzBOctvKAslXbdaoP/Q392WA
         YWrrZhZEfaoUPy9fu1nivKzkGQ30H0cFcT2oJSUhrgVa18Z6VlAdkxlZi8VScvLFBkgx
         zoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513304; x=1779118104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx/fracOZJpjZlO4z/Wctta7RdzXOVS4izK5f1NPMvk=;
        b=WQ/XtdtgASh7MF/YBGCWkH1RsG1tZcUflDAsq+Iit50E7+wh1WBpM521GGovcQGcGc
         8cPIX2+COv5T+Wap2Oyr8VH8MMR+CKIWZPeOjRfTjVVGA6FVeAah0c0CLzJ2eUEbdsxP
         J2plIHtNY5EM8I4qlAr58SZcSlFd1nZHWWYksAcgYadmIeBfwAnqC5I0UsKfH4gyhpLE
         Yf3WKDI5YtfVEVAdInKndYr2Qia9KMgbUlqaTXOrPjX3wnCtFHumM79U+ED9WygwYnPW
         oYwR6k0/IYArCHfTDqycTnoMy9YcnfymYRVXO5Jl52Kvmc6RpdnXyx8Hgfa4ZDwpt6OO
         Bg2g==
X-Gm-Message-State: AOJu0YwMXi3gzAWMryyqO+R7qu8cg7uA97EpFjYFQMKBCPvC2zWPvS7m
	PGuyX2XH5if/Ia7oI3ZvCe/ckpyfOnbki2GQMNcfdeOD18XzkxLsg9GF
X-Gm-Gg: Acq92OHWR0d9E/jeCOjTKY76NivjgT9PdqK8eAnTOwcuMInJ2h41Nm5/m5b/pnGfj+R
	x/5sEThnIfELA+NlSn0A2pu1MMTdtyo/6d+jMU2+yz2338f47wU3U4eKjo7/m3b7VHXB7FyIbrJ
	xXMnsWkA/2LBRYBjJeGmujwStRTj7E8xfddgsrk4lVVc8g8I1xzcbUEr/1V4QIaHw5uiBZR1z6B
	KPUniVOWrgwWK3/q2qBELCs40d7cPjBbR01HouPMtV9+AAxv3P/WqTxk6qisDuURtUA4SWpGCeV
	W/X7bcjs0ntTDJmN+Lu5olPXRtR5GcvxhNEalpZ+fRbzDHpYT7ytItwovpPi9AEZ1wdvsvSMK/7
	Y94r4itqIpaJRWetSYf6UCI4DsZsodfWplvOlqzr7OgbyhPSjhgU7z6T+6ihENQqArEssl6wzaG
	8IzAgdA+joe0tHlJ6USVNjm7gVORg=
X-Received: by 2002:a05:6402:278d:b0:67d:d904:df2b with SMTP id 4fb4d7f45d1cf-67f706f8439mr4424559a12.7.1778513303557;
        Mon, 11 May 2026 08:28:23 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0dfd34fsm3896183a12.14.2026.05.11.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:28:22 -0700 (PDT)
Date: Mon, 11 May 2026 17:28:19 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 1/4] dt-bindings: iio: light: add DT binding for Broadcom
 APDS9999
Message-ID: <agHzqPiGttkJtTMz@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <6acd3ce2a0e417699a8184817a4a8eb381450beb.1778491503.git.azpijr@gmail.com>
 <20260511132635.7f0855c4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511132635.7f0855c4@jic23-huawei>

On Mon, May 11, 2026 at 01:26:35PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:14:44 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> Title doesn't need to mention binding twice.

I will fix it in v2.

> dt-bindings: iio: light: add Broadcomm ADPS9999
>
> > Add Device Tree binding documentation for the Broadcom APDS9999
> > ambient light sensor.
> >
> > Proximity and RGB features are not yet implemented in the driver
> > and therefore not included in this binding.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>
> Can you combine this with the existing avago,apds9300.yaml binding?
> Other than the missing interrupt in this file they look identical.
>
> Note that a separate driver doesn't necessarily need a separate binding
> doc.  May not be worth doing given the extra supply this part takes
> (which you are currently missing by the look of it)

the VCSEL supply and required vdd-supply make a combined binding messy
with conditional schemas. keeping it separate.

...

> Power supply should be required

noted for v2.

> Also you need to fully describe the part where possible. Here there
> is an interrupt and a vcsel-supply by the look of it.

okay, I'll address everything said in v2.

--
jose a. p-a
