Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CC1CDFD5
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757380; cv=none; b=VBJG1/8rW7CYHAthH3r3q+RqbdD0SCEg0+HTgIHIbHSRs5wCkDiZixWSMJ3kNpabEcezoi9YotKUquXGAY1wl4iVOj/Ay7mf+9/SQtBcMiPnCdy76drwgx2R618z1Ncba4MFxHZwmKJjJR8eQrdlCGUfbWueeOYHMnLXXXxcZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757380; c=relaxed/simple;
	bh=aFid0Q9EAFG8hgo9XzVxXgpSmcdWSf2NQEiUDjszoAc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFahrpjgC/1XPXcztkOQctG0J5vT/tlBjqnyJ/gdd4apDjfxMr+lbbN3ngtk7udKLFzrQTu3DcncqYnjusiWiOg3nKdQP5EiPzlPMuscOzeeez6GW2aB8xOWxDsFKpeYyGjux13y6KKMfmaWpXcEVyij1rTpfUrscyd6gJN6D6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/02ciuY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/02ciuY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359a16a400so3175630f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 02:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771757378; x=1772362178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iOYzXXu7pNppZDAAr/5PifrRwxVT1ZlY3UB8ntS2Ws=;
        b=S/02ciuYq+ZJKJVaxnoRHfCnEpFLE2pMOaTxWifVhI7J7tljr/UL35Iirnl7PuLDke
         PhVCplGlwFUKMrNwJepPptmO4pelpuGPU5glOEs1kLQIloezQf11wuCpvk7idrwpfVUq
         UDQkpTESPrAcY2NJ/kvHljkU6jdXP0m85zLE6zIaguBdiSMvbRedAYmUb+IjS/shpJn3
         Fs29AfrkKXAYAF66LPXjaccBU6lcMb0cmc/V6aF2deocd/6L8c/CmJ0NkqWT9d9W+c0T
         m4nTujZVe9aJ84IDtncwpkY8bkqOijyKTJqniuL7+PFGCFlBM65BMHGJUEOm220riuS9
         LrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771757378; x=1772362178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iOYzXXu7pNppZDAAr/5PifrRwxVT1ZlY3UB8ntS2Ws=;
        b=jNAcivAJAUdT0he7P/0k+mVAPxHSdBn7efNEucs3SdtLZov6bAbyutDdNXsE68aM6e
         dChrd63AuJwrP0bnnZBDEH+TeayOtJxxM1X5H5I61KLfcTIqPCwlxNyxseMuoBoA6EcM
         ZXnZ50jtJW8POYaHOFLKLORe2ZVyuKech7KdDBe0ry18GxEW1kOsDjIYo8XaauGyHqOg
         tfJcgX29prUHK6SIGNW9Q1F5BJfgqiNHDTq/95Sn9q5nVQhv24+mR/99I96F3RWMXUX7
         q+e4SJHIzCCoanwkldA1tLr8FamejUIpMOePuXcftuZ0v3gUL+sdbtwqZd4pAuPib9Bf
         Y5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Z2U9T980SQGhLEZA1SkXZl28X9rZWtDZ9mMaBy6zkK0Nr/wAqLoRvlSFSaOLPGxTvN+R1lmTykg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/MuH5Dc317CfaAN8DH6FRUSkLBsIJFUexLoWkY3wXpwX1gpy
	uoVh4ycWuw6zIK0FiudQrbGJdL0QHNZ9p1HnfYQzuUdriY28X4Lgj6LN
X-Gm-Gg: AZuq6aKiYXvBquHJ6BN6O8JmtnX5tuMM8nBM/4jG5SLglNDi4/1xwsB88ORLqdgGclx
	zb6BqKHCtOWdK6xC+V0qPZRFNGIdPK29x9LioYAg7jiXgJym9hGcSwMUVN9QdIbvSfP2JSxFfuv
	k+QXMCiC4V/XoTbvCC//dzWEsc+Lv3arZ6/eQE30bzlfHbQZeU6fztCGqFWXfeiEqYzWcO1Sxzu
	9QC1CUetZwXPKVkuc9pI9J3eWSFA79ZGuOQCPdtlHJAD6W/GTArLkUMsl89dLW0B96FgQ5QMjj6
	bt3s1OfBnKeKGenxBn3t5+4EMePALHquTDvpfmP217ObMk1EobRmAGAHXXzPlT1LiWXQ8nbX5Wv
	gvGBj4nN74C9eK9V0Cl8zx2wpsS4t4SVynVlKZo+uiIo03gOyk1hGKaymEQrkSe1crAd2w9+9EN
	Pi2ogQC8TIPGZTrFGQUVjvk6c3w9M9dDihXB5Hjz8YSqupbz84gngKuQzoY4ScjbZAC0nPUUVap
	TS9B9c015m6glDvadPp+zFPv6OUEarDNhHuuuCrbiJncwGzFdk=
X-Received: by 2002:a05:600c:314a:b0:483:a361:41a5 with SMTP id 5b1f17b1804b1-483a9603aeamr76521485e9.30.1771757377708;
        Sun, 22 Feb 2026 02:49:37 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00485sm12453138f8f.9.2026.02.22.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 02:49:37 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 22 Feb 2026 10:49:35 +0000
To: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 1/8] dt-bindings: iio: frequency: add ad9910
Message-ID: <rvsygiakolyb6gtinpwojn3atj6i627zmpxecbs4b2z6urllp4@iaxemesawckd>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
 <41190a42-70ab-45b9-922f-317e792b25a0@baylibre.com>
 <20260221-batting-amiable-fc01ae386789@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-batting-amiable-fc01ae386789@spud>

On 26/02/21 10:43PM, Conor Dooley wrote:
> On Sat, Feb 21, 2026 at 02:43:02PM -0600, David Lechner wrote:
> > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> 
> > > +dependentSchemas:
> > > +  resets:
> > > +    properties:
> > > +      reset-gpios: false
> > > +  reset-gpios:
> > > +    properties:
> > > +      resets: false
> > 
> > This seems too strict. Couldn't we have some resets from a reset
> > controller and others from gpios?
> > 
> > Or maybe the reset bindings are enough and we don't need the gpio
> > bindings for the same pin?
> 
> Actually, I'd be interested in seeing evidence for the resets property
> ever being used with this device. I think every single reset-controller
> that's currently documented is an on-chip device for resetting
> peripherals.

As mentioned, an FPGA IP as an IIO backend (MMIO platform_device) will
implement the reset controller interface.

-- 
Kind regards,

Rodrigo Alencar
