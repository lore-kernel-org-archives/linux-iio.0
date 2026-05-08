Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B63E63A6
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247919; cv=pass; b=LiiinIgw+38Y+Rx2zOkt2LhSpGPZEPtOd4hmlGOJ77LNqUIVLLzHg2OgwtSbVF4PUnCjw+sbIG3i8fFXg3Dh2BoUuEJAdkvGWg13AlM4+4Qg9h1qjGt237ABK4Ctlou3TrLIot6m7b3TuQII0gCkX4a49F2kZ31Q2+8ah3oXea0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247919; c=relaxed/simple;
	bh=8ovdRW6BMfHNJkXdVjN42guHMXb+vqZMpZzoQRsJVtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej09qotiqQ+dYo1S3+3/eXHpJwTpr/1VtD/+10i1OgbJUAm1W6LPUbVVlWZqTF3ymR1jwOFNkSxNaWZhEtHHMk6kfm6iqd2cskniYAxa6M3HnN1A+b7Tp7pJSNQ/LMNJ7l5WG685wI1+QsjVcSFQTFlSPjP7pFJIixrJlnLOKxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1noHVcY; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1noHVcY"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso1764244e87.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778247916; cv=none;
        d=google.com; s=arc-20240605;
        b=bAIN545LT+5OPB2OgKA0Gd79t8f96OX2QHim1/b78e50fmoeQsFKFFGDlQAYRxMIry
         mrcdr6hch4jMnxelOaunmuc0MINDqdiYOJpSB6eu3OKycYwD+REBsgx7wzFOA/CGPuzc
         bVneHuKeb/HCio8H/1vZclnTPUf6w8QwJco50/IzhTKmjsE0D+tWPt4RjBMqLuD7Cp8O
         WOpw+jARpbYU0xjBkI44xzg1A8izBG7QVYEv8/SjYo3/jvXFP/2nEnJaR0ItHMY2Wmt3
         IXhDsL50SHjttGsg/MDpDqL2klbjuHNg4hBqNOrNW9W93t6uXcUCVIsG9XFSUSvjnV4V
         3S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rChZt1Qr0zf4cSBjF50F7tdIpXucVGx6jGbVjwWWKoc=;
        fh=DFahfv3XixzNG455ax/4d4YZ1wiyZh6Qc9P0yE1U1XY=;
        b=hSK2O0eHNWlPo9CyZXwwRezjRA13lLrT0gm3Co/I/6ruTL0sGIXu1919tDc/YV+prz
         fNbKpInF+J1BwrMmLIRgjYDiItA2J2eGvSu32yVfoLZky4T1IDqVBRkVq86aQIAHJjl4
         mykNb74AFpjSTlj1COnx/Zj4rLboedPVbFEX2ItTc3gwnqKPApUrqQAAhh5FE2I8Zj2T
         R/ANUFv6pD0AyH+tQe6aJ8nb2gZdS5IH1nS8w7JezjFq5aSjfsbbea46xENt67rzQPnz
         9aOTyCTjp/XEjDm3uvJ4DCzH9DCiYKXht1rliF1LESvWKkl96xMA8IgkHTmNLc6wbBUE
         yYxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247916; x=1778852716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rChZt1Qr0zf4cSBjF50F7tdIpXucVGx6jGbVjwWWKoc=;
        b=S1noHVcYo/X9KYjaIPlAMaSCCAb9DzvbB6Hle3UdsIGTKw78y5EkEQ8Drl5Xb8xy7G
         U5ksZXdbqG0CFSg7QkOIc10ZIE3pdlT++EMuvLaeTSBjQR0CpgfUnVVWlLE1KVy9qDta
         9O5vFvJY+ux7UIqwjl7XbEBFBvnbLgeMJpinZ1yBIKqxhF2LhZp0yjs8SxCPWnOX5WBN
         va7bw/moGjRxTQ74gz4G3XbuaIwUKO9cymCH91HhIUuE70IgeT6xjoED3IOdOksRJkbY
         cfLTUqxUH0J5Qp6wSyFcXtWDKpBAFHErX8eoPLcXOrgfF8lm0u283YFp478acKNdmES7
         Js4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247916; x=1778852716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rChZt1Qr0zf4cSBjF50F7tdIpXucVGx6jGbVjwWWKoc=;
        b=fxM3O8OmJ9U8Y4stw+cBQtHAI92XKaYYK5YgbGxTPyNM2KUtVSEYu6/ai7VGyK46CX
         aRrV6G5e4owgOoQqx22MKnaey3GeQRfRlBhUJLDsaKMxtDlY0/vGGOxBma9hdutU6YpC
         snu43PYREvfw38cQink2uE1Q7CX+moOJBN5H5uYCS5ieEGSTNE0BcoCJUWv+01VvsJVq
         NIkManBnfr7cp/8G5gNp48+82XfGAYfosgw+FHagHv5Fm5s8W3L86jw1zBgeCfuDEAfR
         vO+J70m8XylUpGHAeav3lF2hYpO20kDm2v2klWuPFJ4dXre/YWsXGt5bna89dZIq2VYs
         M2Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+qhIHiqwRnxRwHZLPk1A1BcsC0lUVun3h+TpqKzCsIoC7QQ2SMH+/Ym+eiTwrz+8ZO06kTOcxYWYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEiIUvylKJaanzVm7Dte6H9zDYBAB4eh/NLJzRqW4qyo1JtY6
	1Ff8DziP2jq2v6v+NRuI/t+VAAkabyGaruUgtVQHnTWjxXL1uPcKU2bPWu+Uof+C3ikYV+BeZkw
	JVTIsGeaUm+z9/WgjbgWaR81ZZa1nDkc=
X-Gm-Gg: Acq92OHPTqKtK9ZpB/nX0faXhU71tNVow1AVgu+3aCn/ykSZGI4fDFMz6OgYKpMOx0T
	FQYxPm02sWkNf9jY22JStH69Ea6XLzXQ5w6zRcLyqTsIJyMnbmVUsQMm1ukwoE5n9jL8Xsi6nQG
	1mvMTfxPGp3hJKeoURYWX5iQB7gqlcgH8r1E5Foo18bjcEkUOIgXT+VQh+Hz41LTcJy4MPmGWcM
	Yt4g3fBj0VKu3mqNFW9td6YWbMYUrbuYPXN2fFzxrZWAc1ZzZAtwZsavYMDND2Gzfw/fNXw59KA
	QlTn3u87ZJusZzb/kxPv++3gkzjwzodOobfZyaR5WJP5Uj7eBawb5ejo2IaXQl0tCMh1mmyQM8B
	nQpLmRhzbL+1G/oJ55ZGRVa3w7en4bp6SmnQBTQhs5XLhLlHytz6qzf7UUK6Io5udtBV1NllCDt
	rKV44AiPMEOHBeUvbSENLp0jVNkeEYscWrFr7dupj28J9VCgJtHQ==
X-Received: by 2002:a05:6512:3a93:b0:5a4:e6:8fb4 with SMTP id
 2adb3069b0e04-5a887ae2861mr4232060e87.14.1778247915954; Fri, 08 May 2026
 06:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <af2TFa3qd_7tcxeR@ashevche-desk.local> <CALoEA-wUdMm5gu=OhhgYV1C3o3MHEzfC0i9gjjUz6CE4B+xw1Q@mail.gmail.com>
 <af2qiO0BZLoGy1P4@ashevche-desk.local> <20260508143439.01e64e8c@jic23-huawei>
In-Reply-To: <20260508143439.01e64e8c@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 8 May 2026 15:45:02 +0200
X-Gm-Features: AVHnY4IPOGZVvj9bUT2Si3GjdGMDMei1bwosp2738hYqSkYXIauUKaLJKjsKoBE
Message-ID: <CALoEA-zNv2EhV_9MNxZ-KhLnWtn3M82KqTCEmupZGzSmRHXVag@mail.gmail.com>
Subject: Re: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 May 2026 at 15:34, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 8 May 2026 12:19:04 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Fri, May 08, 2026 at 10:59:12AM +0200, Joshua Crofts wrote:
> > > On Fri, 8 May 2026 at 09:39, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Thu, May 07, 2026 at 04:35:49PM +0200, Joshua Crofts via B4 Relay wrote:
> > > > > This series is a continuation of the previous ak8975 driver cleanup
> > > > > effort, as most of the patches were picked.
> > > >
> > > > It should be v6.
> > >
> > > Jonathan said to either do a v6 or a new series, up to me.
> >
> > Fair enough.
> >
> Oops. Wasn't my intent.  v6 would be normal for 'some patches' of a series
> that are outstanding. Ah well never mind..

Oh well.

-- 
Kind regards

CJD
