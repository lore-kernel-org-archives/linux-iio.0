Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD711607A4
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248245; cv=none; b=UJjda0SrX9wWmYD5ZC2zurecaaAOrExpee1lC5wNnwlRAMoyMch5f+SsJgiy3ZcuxPQjV+xA03fHCrmn0zalgiWtYg//5CrUvpWcy32YDPbxVvLCYtREXxWB+GmEgeONELEO4OVR5eeTUQAvuZOi+ZxpDaM8Yxoim3ciN8Rl5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248245; c=relaxed/simple;
	bh=/DW9ChJ+Z4lvrI/8m+Gj6NNDh8t2JT26OuVxVi091XM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stSBx3hL8AAnkiILh61bURQv8lnZGjePd95x5RHLi9fpN4j4bVOzbVz6H8jFfEIFHssuJLlcydTk8coeUV6g7vRp96qq3MoXgrL9iTg3U0j1LAEbyjj8lbUQ0gJf2jg4AbNfJEnCkSk4EwEQk7TGt+MNbH/5w7Mlbm/90Y+Du4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHPxm/4p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHPxm/4p"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1222672f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778248243; x=1778853043; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NHRSS+oWN6kCe7LyNpMRwfm45OI0qk2PQL4/WD6qye0=;
        b=BHPxm/4pS4YovEdzHEHLVKHBImFvDhZ1oyMnUatu+PEv0Spif1inby1u27Smy5CCUn
         stxKS0zYBstWwwjDaFXgCtVydU/hXRblaVgmiAjKNOGtPgsOW1wjL+El/YfcBVcLA7pv
         AqiWDSIB4ZCos26/RFL1gYdCbgnQTi3VGcgxQabPavrFND1nzAUtC+KVB2/Ph+qyl4rQ
         AEJC2UAwG9gCHX9E+aRTafcNN6ky2+ZxW3s5Jk5log9VR59v/62b7Fnvx2kyiUAeG+Kn
         CZaANAo67HUXD6aAxA1eIdVR9wLqGMR1Dh9dBqmNj1ZtV3uCtcWjhJpWAn4z0nz2d9jC
         0EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248243; x=1778853043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHRSS+oWN6kCe7LyNpMRwfm45OI0qk2PQL4/WD6qye0=;
        b=Qdgh6zSBwnsw9Olvwsm71/4rJPDf/N6vKZC4YF1DG70z2jIAxFAWZjHjJr2h5tE9le
         LDuTtWr86cqqaXoh7Y5N2nOnKoDeifuaE2VMH8NZX5NC8Q7gtmjFB2tUXW4N5h1UHnLN
         sZSuybe/Ua1yAvnkR4zYajei105iUpgv0Po4YPi5lft+8paoPsS97F1BoFqi3b1Onr3o
         F7nkdxK9yXBr4bWBRdhBbxMV/UZL0XLujhZQnLRrnPQb5gxpmZL0eLonG5JQm2ll86W+
         w9107tnbmLkZm8GOovx2Dq64xNv0vH2rDFZhAXOqxQGLARDjJW4WiTFwYeb4xomIu3xS
         UjIg==
X-Forwarded-Encrypted: i=1; AFNElJ+l437B4Ge8Gc1nvbB6jYiDibb9JPW4ItNYvVwMPrnX7lderXe6PT4gwP+ZvfS5XTrNdEnL/K/v9YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9HrVD3r9ek81eXvWDuBdkV5T5EcK8bLRUBeA81aQxuJZN7z4
	H5h/pAAyXMsZoBXx34ssWLzDdjyUyPnGuLQMEFVBOcD1/c4mehk+zYeD
X-Gm-Gg: Acq92OEe2avqtcSnRb0kxqp1sxCwzm8dtBNIp6p7cWQnT1A8/pbhz02tWvFBT2hImqW
	GDinAty5TDgxhSHwc8ch/JKg3P2YSYPFVCnST2XOkfP4npMCUbJ0sAPRNiDDZ44a0FnZ+krH3IT
	vjggFrsd8aafj3Eb9fzX7UQt284cHdyOqmYVWAO7itI2eFwfi7CBNgvNCFcZzjynE8WvCGm8GvL
	iucnyF81oHom8KbuozbT3YTb+dAbI9iQwNG8NI+u15agh8HKdfbI4FFLDFKMwVDzWEpuWF8ipl5
	Mg5SNZsadDVawxYjO1tbP8d04DNRCsw/ih2rL+2+S+WhnR+21bO0ExIKjiVeH6FGO+UehqkeOT8
	C5EfFT11aSu10ltIMp0w1+wfvKMT8WmeCgn1Dz99kT3aLd4hc6edejMmmpaBlBNJ+D/GhsR1x/n
	0bNFW3IbQ/JL19EWdzI5gq9My7+sQdxc3GcNxHS2ihnqzr1QfSp+SX5S/AN7uW9UeErUZnTwWZU
	TtQ31KNFz9E/RPNAMtuyf4GvwYlKVxz/lu2U15jJ+6vHhhltFashPc51k6W
X-Received: by 2002:a05:6000:2882:b0:452:c246:ab7a with SMTP id ffacd0b85a97d-452c246ac5cmr13022901f8f.14.1778248242599;
        Fri, 08 May 2026 06:50:42 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm4657716f8f.29.2026.05.08.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:50:41 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 8 May 2026 14:50:37 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	rodrigo.alencar@analog.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <zh7iqytpkrfonxv4mup5fcyo7z2ymnizobdu5smxevax2isge6@zug2y6e7rdj5>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
 <20260508134843.7646c4f5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508134843.7646c4f5@jic23-huawei>

On 26/05/08 01:48PM, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:55:47 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:

...

> > +  Specifications:
> > +  * 16 independent 12-bit or 16-bit DAC channels
> > +  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to 20V,
> > +    0V to 40V, ±5V, ±10V, ±15V, and ±20V
> > +  * The device supports SPI communication with Mode 0 and Mode 3.
> > +  * 4.096V precision reference, 12ppm/°C maximum
> > +  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp waveforms
> 
> Interesting - so this is a DDS, be it a simple one. +CC Rodrigo who has been
> wrestling with one of those recently.  Rodrigo, can you take a look at this
> driver and see if it fits in the ABI etc you've been hammering out? Thanks!

I am not sure how this is a DDS as it does really generate frequencies, so it does
not seem to act as an oscillator. I'd say the minimum for a DDS is an NCO + DAC.
The function generation seem to act only on the voltage levels. There is the step
size and ramp limits configuration that are similar to a DDS with a digital ramp
generator. I suppose that users have some use cases that are often integrated into
the products so they can do less (and the overall system becomes more efficient).
However, those products end up solving too many problems at once and they get too
complex!

-- 
Kind regards,

Rodrigo Alencar
