Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF93CC31A
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892520; cv=none; b=dybXrz60+RJIavRuCCp+J2eAaexkgEFO+Ld6G0CxgiBHkIXvaDUi9Blj3882gk6XZPL6qRU+S4cU++4K0wLwiyf3sDVRkuAi7EZzV7jNMmgjQXx9yX8aO0tLNB7OODl1xc6DadVHBejaJG6ohUl47u4jEWkcj+hkh6bxBxyQpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892520; c=relaxed/simple;
	bh=usrk/brkiF0gDQ4v/eaKp9rFYPDNwORJnY4Wqr4tzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCNM7Yr3uEu7ejDEK8D+DpqHg+6zgJHYqsQ/mACWaw4r6+WixZ5+wtDOYLgOM7LKoTZhPzafMc+HH3AdpzOQlrYdf9pTwx5AymWKFDsynQH9Dalsujo1oRAZy3y46s+Ja5k7unCf3dFtN+xPa5iMnZgyFweUxhsRL4JKcTxhQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB2kG0Cj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB2kG0Cj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-459bf19e87bso7093772f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892517; x=1780497317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXJMeIed8n1hIt+0o9e1Q/FT5FxrTL6nQCpAB+Niu8A=;
        b=HB2kG0CjLZb5WmMKkMT9uvRR1UZYZ7JJpYQ243kjmAk96GBg9+pKU3PVDu90hGdZJk
         eZ5j3ejqATIG3GgqQq8xaWQM5YnZW83kmIylDWd7G+1MCcTzajB6BDywe/m2FVX+i0NK
         EvuUzNY64JNVZiEzABJUnmPxM8DbAyTyhvycDDd/u5Cat4gJ0UwELgO4EqpcOCePtPzb
         /uvXB5HGSGqsQz55mcsjld/B7VtcA2MBZAzOdbvr+WZcec8eaOTJF+tEaAtqoK+ixH5U
         VQ+umW2a54l+XKX8UXupNH+Eb0B0IYpgUMrVEZN50jWXrqb0KGw5YWT4vqWxFvCBZMQ1
         Y9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892517; x=1780497317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXJMeIed8n1hIt+0o9e1Q/FT5FxrTL6nQCpAB+Niu8A=;
        b=FJYhIbi+wo0meOrFqkFmvj7gLQbx+2aIsQOfF9nU4WLmlcRoKCk9eq9QkcxJOzrvNv
         0iiol8IW4afMtX31hlqeIUjizUVjmcmp2lsiEk7OnqpVAAofDhXzfZ6XpGLQPK1ivbN5
         gzJSgq3oGqE2C/mPYrwWjVHVLJQZlF1d4kVrMwVXkbwbxjwa68bDzywm1yNXUpufAaDj
         I4BEKXhkyvzJFsTUhphMdUCbwqyC/fsmFQE4gRyY27P+ucm739Ug2aAKGX5ptVqOuFtl
         Ps5RRAKWKAirGrKgdMixcqlnxWWbd31tuusjiFfm7jrWDH8hF1D7T7kBRdHFD+JYhjkd
         HGOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xIyzxluOsOQxL4vYVoGYFYlypH9OxdfsX9FApdwjXkFd2KOEM4ecwuy/m65qMudAwGHsB8zukYXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JjKE3K3mQe8muL2BovKy3GBEHssnldIQmh1SE1UxpnQCXWL8
	yULiuuJoxFsZi1X5USZaFNGrA/qTHmhpAh3+t4igZ6ZCNESTl4SGeOY9
X-Gm-Gg: Acq92OHSLKVTn069vNlTt70sKLIH+cqjmmM3MwrRhP+MSu6bqivFvVsIJTXp0q2mHcR
	1SSvyMu/lpTTyf/w8/C8avhOqEEprSUANG+3lP3aN+H+xt82nEOs6mdg87/YE7XwxwlXE/yZZh3
	3n12Yg5KDkPDHW7GHPGsHfGkytfei1jZOyGDu14N+IAvRqb59jepmM9Me644m1y6RYEa+2OsCgi
	w8dI4ct80Ft9uYcE6+d0TxKLdMr/oxuAaJNG0SGkWREVygYYFnGF2mSvvIdcoxaus1M38MkCGF2
	nn/C8gZiPxR4XaWN1Ryqz9RGQpQg4uURL6RuC0sqqDOAadrN0IS2XPNaWkCgShSRpoghdP63/7k
	h10hXmbK8nGy5/QZVp3fjDhlrGoBEFfcGSd+wbu+jdFILpXkmtfO/BbAuc94WGDTnKGNhM+Ci7p
	3HGqoRv3eWVEi20JE=
X-Received: by 2002:a05:6000:41e3:b0:43d:50c:6f18 with SMTP id ffacd0b85a97d-45eb38a1687mr33364115f8f.11.1779892517326;
        Wed, 27 May 2026 07:35:17 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:16 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] iio: add Sensirion SLF3x liquid flow sensor support
Date: Wed, 27 May 2026 16:34:58 +0200
Message-ID: <20260527143515.102794-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526171214.750c2e25@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260526171214.750c2e25@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 17:12:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > 1. Subsystem.  Liquid-flow sensors don't seem to have a home in
> >    mainline yet.  iio/ feels like the natural place for me, but
> >    please correct me if hwmon (or somewhere else) is prefered.  
> 
> I'm fine with this type of sensor in IIO, but open to hear from others!

Thanks - keeping it in iio/ for v2.

> > 2. Channel type.  IIO has no flow channel type so far.  The series
> >    adds IIO_VOLUMEFLOW with _scale in litres per second per LSB,
> >    so drivers reporting smaller units only need a fractional scale.
> >    IIO_MASSFLOW (for gas-flow sensors) was left out on purpose --
> >    happy to add it in the same series if that's more usefull.  
> 
> Would be good to have a little more detail on difference etc to have
> that discussion.  Superficially I'm assuming this is a compressible vs
> non compressible thing?

Right - that was the distinction I had in mind:

  - IIO_VOLUMEFLOW: volumetric rate (m^3/s in SI, exposed as l/s),
    well-defined for an incompressible fluid where the volume at the
    sensor equals the volume delivered.  This matches all "liquid
    flow" sensors I'm aware of (and the SLF3S family in particular).

  - IIO_MASSFLOW: mass rate (kg/s), the natural unit for gases because
    the volumetric rate depends on temperature and pressure.  Most
    "gas flow" parts on the market (Sensirion SFM3xxx, SFC, MFC
    devices) actually report a "standard volume flow" (e.g. slm at
    0 degC and 1013 mbar) which is just a fixed-density restatement
    of mass flow.

I left IIO_MASSFLOW out of this series because I don't have a driver
needing it right now, but if you'd prefer I add it as a stub here
(name + ABI entry) so the two siblings land together, I can fold that
in for v2 -- happy either way.

> > 3. Subdirectory.  I put the driver in a new drivers/iio/flow/
> >    since there is no flow subsytem in iio yet.  If colocating with
> >    drivers/iio/pressure/ (next to sdp500) is preferred I'll respin.  
> 
> This is easy to change later if we make a wrong decision. For now I think
> iio/flow is fine.

Sticking with drivers/iio/flow/ for v2.

Thanks!

v2 is up, addressing the inline review feedback from you and Guenter.
Dropping the RFC tag since the three high-level questions are
answered.

Wadim
