Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291941;
	b=huHg42PvIZfHQFGifSEtfg+YmQGQ9jmFKRlqAuD7tEWuDUQrV0iq/4QCcbV2405R0Yeo
	 EKUQoheHdk4OdU8pOloT3L3uJ+/vToVKGyDS0QHcpmcvFim9jc1bLjN01hW2pHEXjsHZi
	 l24AU6YN94T8iL/t39AlpRdD++ZW1BcbkwO/VCW1/dXyVTkAMFeZzFMgBK0o3ezL8xdWL
	 dxQfdNKWZS+WIRFEku5KSYNaVGG1e4pwGW/j/qwf/AkvhEQ2HQdY09nIPCyzCZ2VQ/xSx
	 jixDQdGOAhxi2tcpk39XRXPHw9LBUHID004254QrCkhsqAiWI7zHYBxePCFbIgj9TIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=secPgUqYwtFyT27T12CKOEsJz45eODbglv/xrQzYdao=;
	b=p02thx5y9ZN2U5oZewaO/lRSTzOq4Q91SOYasl2XZ21+bGdaqt2pChUD7hKFqoYLC0lT
	 waFdEOidK0E6ONyAf1+xbGxlHEus/o/s3zaZeO3mlJc3rAaLmIKvHbmYCJkkZGqo0Q7pV
	 CaZLRvEJO1gYsSFVg4756cKtdnXV9mmxiC6H0ocHdLeoQmpEvRDUjl+1VeC9oKMIkB/KZ
	 suzVhnEYfGpVZbcbsph7w7SV868NUXYZCNKg3Qnbrl8Ja0BDuyuWPgEoM27tICJs1/Jzt
	 4A9uHxm/5ptis9A8rLfczHKOcP7WRgMD7EqeVN8IZplf1Od/6a8oQPTpQ9FGf9uVtwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVcVTC8T;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5D606A322
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 16:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B5D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVcVTC8T
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a3c08d6928so3161107c88.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291940; x=1793896740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=secPgUqYwtFyT27T12CKOEsJz45eODbglv/xrQzYdao=;
        b=rVcVTC8TGQMpCG7a8sOBfuFoJLWg3xKjWScLLKASsUj3rkRZlIq3nyaHi8fO9e+FB5
         enpl4lELhHTl1EhmwzICVhyizGAri3C+TY3nDGm40h/8CXYYQ+FQQcWZsayhU2ln/nH9
         ULPdUUCkU0Ppr5gi23H/YQlVwnMA94z0lhZWhLJShAvlvPZwNp5XBfbEmEScjSS1OR4Y
         FGyXq6Q7WJIh/g8p2mVqkNgwH2zpSHz5IveuVPiDF4WC8yyYE889ISVmD0pM7oykSG/X
         yp4SUH2uNM5CfrusIGmuQi3Vuo9nEpHFYTBSrBuXGHeS3h64V0UHETPQGaE/qaTMNuwB
         Yevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291940; x=1793896740;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=secPgUqYwtFyT27T12CKOEsJz45eODbglv/xrQzYdao=;
        b=1+BQu2POL6tZvceQ+d9byjy+Fc2/dsexs04iZXbnEIO1bVZP74E7HFXDNTq49P0D0O
         iXJWSHVvjneA2XQ7QjwCfdgpXRNiiGah4MEF0zAXnTXJIlFpTzl4GhGUXcOVuyRQI0zw
         O8oBV8b94FIEAAukP5VunMK17HXfnPYv/PGWN5hvrqG1ljM0sc99fVhW7/3VYnMfrIwG
         Lq4jtFluj4emAfsER8zcIFf229KyJqdfGEyiZyoxjJQQQ590jaCjZ6cfr+iiW9dmmVKL
         TGEtabrbj1yup5qwgrUlbq1S3my4pbUihB1L/gbXTLCmxveCgt1D6awT+FZ50DQQN0g1
         LKXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSOmo+Ht3y184YguYunpP+tx5X+RrL/oJzNElj/MDV4sl7bAXbQ7wPyx0JKDhjQi0OdbSCMN4eim8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN6epeNrO7YkBeYfJnJSM35bP4Sll35nf2/phvuzHtGbRIFU1r
	KaCUHjIjnRKVFdxU0Zp7UYBIHtf0IwQWjk1mn9nlDk5I/rugxjf2rsH7
X-Gm-Gg: AYBFou3uuN5HudPmMhveEYBzHLZWWWwOAok25G8PCgAoU9hJXuzYGvZWfXPGCRU7Z+B
	wwDYcRJIUt2fbAtm8/d5pqEgS1tl6Ooebcnwi+fK2McWPmSYzUbG6zGtO+WYsRZU3GU9CiUBxQm
	bNlDTIkfv7FBbl2hTqg96wP8LyNVJFFJAAik6aVQzZG5kXZQOqu42D9foEXmRywAdwHXo/D1hFP
	i9BntYtqkqBeDX90T7x7vQK0+0HNvCVWETQqEy3WSCaQ7LlKzjR0Zgd5L0APhEXsvpAQHwESncg
	upa50TTkoX+UlLIG9bQOV957yIp9S+itZGm3AfaO60ngeDfLmGZego+Q6mGr+r3+IcfWxlJYp4w
	VklCIuE5Jg7B1jfpPwo7mjM/2KQpzYz1KCjepcAuRe75lubuHPAPzXebSsLeAUs/4g3Vv6dAMsv
	2cUTmZattsTIFXd4dawT4m4uynYW2L4K/xv65Jq9X9sDt3LjJoFnvvSPkGU+IOpmtJyIhzcF8+q
	ZrMgC+Kx4WJ2tPoCNXZn5YOHtdyIdmZpxlKEm3LkkGM7DGmHtHTJYXxEO9d06/ooi1h6lf5b8TV
	j+k0pwiwBbzuj2SckSVYcvPs1/ZD
X-Received: by 2002:a05:701b:4559:20b0:151:2e62:fe6d with SMTP id a92af1059eb24-1a6ce4eaea4mr8107048c88.22.1793291939202;
        Thu, 29 Oct 2026 09:38:59 -0700 (PDT)
Received: from localhost ([149.28.89.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1abe9d7548fsm192739c88.13.2026.10.29.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:38:58 -0700 (PDT)
Date: Fri, 30 Oct 2026 00:38:39 +0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <auN2jwQVr-GSnZvF@zephyrus-g14.localdomain>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
 <20261029074851.216029-3-marcus.yu.56@gmail.com>
 <533bca43-8de5-4295-b226-5ea3742871de@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533bca43-8de5-4295-b226-5ea3742871de@gmail.com>

On Thu, Oct 29, 2026 at 12:20:24PM +0100, Jose A. Perez de Azpillaga wrote:
> On 10/29/26 8:48 AM, Chang Yu wrote:
> > Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> > 
> > The AS7343 is a 14-channel spectral sensor featuring 11 visible
> > channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> > flicker detection channel.
> > 
> > The driver exposes 12 spectral channels (11 visible light and 1
> > near-infrared) via sysfs. Runtime PM is implemented to stop
> > measurements and enter SLEEP state when the device is suspended
> > or torn down.
> > 
> > Future patches will add configurable gain and integration time,
> > interrupt support, buffered reads, VIS channel, and flicker
> > detection.
> > 
> > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> 
> 
> [snip]
> 
> > +		/* Check for digital saturation. */
> > +		if (status & AS7343_ASTATUS_ASAT_STATUS) {
> > +			/*
> > +			 * Per the datasheet, ASTATUS is self-clearing: writing
> > +			 * the value back clears the entire register.
> > +			 */
> > +			ret = regmap_write(map, AS7343_ASTATUS_REG, status);
> 
> 
> isn't that the STATUS (0x93) text? the datasheet says ASTATUS is read
> only and ASAT_STATUS clears on access, so the write shouldn't be needed.
> it also covers analog saturation, not only digital
> 
Aw man, how did I not notice that?

> > +			return ret ? ret : -EIO;
> 
> -EIO reads like a bus error. as73211 returns -EOVERFLOW for this,
> wouldn't that fit better?

Sounds good to me. Jonathan, if v7 goes in, can you replace this if
block with:

		/* Check for saturation. */
		if (status & AS7343_ASTATUS_ASAT_STATUS)
			return -EOVERFLOW;

I've tested the change on hardware and everything works fine. Or do you
prefer me sending over a v8 instead?
