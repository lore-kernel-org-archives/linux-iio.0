Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F312EB5A1
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513617; cv=none; b=FgkhbMYdYeGJ5HOjGHKPpNVvbJSucfdmpYw03cnjdWd3iseAjY/F1zWcHflVlAEl/u4e2zdypJyBfSeF4hHTwAYeerQ1/HzDoxY8Jl3d4r0VlC3nUYKQRoc72pcoj6eyqkAjad3RSLYbjeqFUag0Sxenh0ua80vYESeM6xb2ymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513617; c=relaxed/simple;
	bh=wWgNO5D7pwoBe3Xr8kN3gWYMS6UvxZkvM5VSQmPYjIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6vw1UDGrW1Hb6E7pfZSH/BIWIYJ3+o7GmfaO+LfzeXbF1P++ns1hYRCGSjPJD6GV3ljOQ5Js6gwM4afHwr7A+xDF1ZKSD0p+37YtOpvxj5MAqAIWCyI98032ot2s1C2Db/ClAK+izdsYY756mvsIBbESjq7/+qrEAAUfujtgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCLA+uNP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCLA+uNP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso289916766b.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513614; x=1779118414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tT6LZmKXfjnHi+vvSeRz4PAaAP3mDaknA4l7KqBcn3o=;
        b=kCLA+uNPAEfPQv0Qj1Nr7kxs6eILuqAiZFgDd85DAyZJ/0xwcLh7pfv8XT8Jb7K8IY
         yJvs6JjbaFHRtQpBmMcM7Z2QbsdExnx6O2m887sGspg4dbOQMddCrn06MvRgH/KdGTyw
         SqgYdFE2/M3SL8d2NzIzjHvksDCf1lxGXqszdI2jS4LI7CdvVQ0m3R2j6QKaSnpuHDv+
         8ua72TpADPafliS1rPHxRDyoDsPQ7aAn2liJfZrhJPvtscutdA+fvuS0a2BYI/Nt1Q95
         87yZTRuNlmQwFy/gz8QoN3Oi4bob2YbCskQOW5TXNv68Qz9kg8UPojsvs1Mau+Y25nzw
         R1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513614; x=1779118414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT6LZmKXfjnHi+vvSeRz4PAaAP3mDaknA4l7KqBcn3o=;
        b=aASWKwkyAbc1frn1HuOVhElkmd4hCip5HJfP/zMJP0/Ejy5lROmQf9fJyt6qIWcZ3g
         N49xzYnw50V4Il2M4jDlZj21nxWIF7JDB2pcYV0N+lCi8U4jfvoAs5yYoDXLjaHKeR9w
         J/NlAMIHdbcy+u/blP4vHsNHpvNkCKQxRV3HIk5zT26DGMp8pvKJLkZr4i9Hn7+Bm1Jc
         LdG/+Sjr3ZLury42gnyH4pIVN566XPwDfG3T66o0fh9d1a+ujaAAOZkyG+bAQ/iQaMdu
         V7M9XRFXFlRejhIrNif9KD0YOCP+s3QfdhBgUWhTHRQe2O2lFeO3edR9tt0BlEbe2wW5
         soAQ==
X-Gm-Message-State: AOJu0YwO5Itibq3lgHA8nj15cYpOOdFi78/NpUpCJDwEhF5EVqA6KUn8
	JwzMEtOJn4FRUk7AKOwUOprqP14mN/rrLI3GKSA5cWcr2LN7s/FR1fWs
X-Gm-Gg: Acq92OFzb5dsetoIrmKuDqgzBKg4DGEQ7QEXXbSqJvzJDysHgU5xrWBT2+kIQqg/M0W
	0fU4MNOCyhGgy9WC7bTcZzF6kWqdYBHTrBIGaB+Res4ctfEs9Ix0zJPIKp34eaYF2U9hXOt4t1t
	dvj6V7rCAtJpyIEM5U1ICFifLA5zEP/T7bfy2B51U/HojamCwwVd7awJVbixVyndL3VOuTt9Vxs
	t1h0ZXeVfRiWMJmBP84iWu451/bXazJsyTBV1mFl2WxGeOInaqI29JGpAapWLyKEGuVUweh8Eck
	/MhzajFKqEL79SAqkDD2yjVsrnCmSINJrP5yqXFNEfpJZ4PH1bgArs3gr5Tc+TRI8l/4Mv/9keb
	3bCe+vz7tO88D3LOZffZdw0fYXMxD7NRT5oILKe3fupTKB/g78KK8ncqCRNlXnDNZEj5vN6FxJ9
	PgBVao6Ipd+RFgu4VaXJS0TENVEkSZU9s9qFdP+Q==
X-Received: by 2002:a17:907:2d2a:b0:bd2:2657:9b7f with SMTP id a640c23a62f3a-bd226579ff1mr31146266b.44.1778513613759;
        Mon, 11 May 2026 08:33:33 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcc384b75b9sm372810666b.21.2026.05.11.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:33:33 -0700 (PDT)
Date: Mon, 11 May 2026 17:33:31 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 4/4] MAINTAINERS: add myself as APDS9999 maintainer
Message-ID: <agH2OVN9CZLu4RwT@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <dced0d8107c8f046a80128ec0fba85b764ef1848.1778491503.git.azpijr@gmail.com>
 <20260511132908.6aea342e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511132908.6aea342e@jic23-huawei>

On Mon, May 11, 2026 at 01:29:08PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:14:52 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > Add maintainer entry for the APDS9999 driver.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1aa9c989973f..cdb703f37f06 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4302,6 +4302,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> >  F:	drivers/iio/light/apds9306.c
> >
> > +BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
> > +M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> > +F:	drivers/iio/light/apds9999.c
> Build this up as part of the earlier patches.
>
> So add the initial entry in the dt-binding patch (if that's a separate
> file) then add th driver in the follow on patch.
>
> There is no advantage in having it separate and it annoys some tooling
> that checks for valid coverage for each file added on a patch by
> patch basis.

okay, I'm sorry for that. noted for v2.

--
jose a. p-a
