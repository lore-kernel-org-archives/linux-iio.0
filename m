Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792448160;
	b=EaH23HUEUy5LHPADAsHHqBOAnTeEIlCIB28nWoIafxlA75tfDXRcZy0Zhx5Y1gy/GrFH
	 Whyin3MlU2L/1pS+T40Iv/1CqkDTM/Pk7XysWqhtExlrkauzCPNAGAp8/5csfSQoqiNc3
	 bT3njAOOrTUJgEtwq9k8ErVxGWuf3gmCwnPJuPFWCdhLxCDyhqxGDs2v+L7pHA4Apf9DJ
	 T9HMAuP4b7yGc0m9Pyr5KHHStKNLnb1aWQYJulQkD5EpPDj+QhT3QnAGZOTE5JpODUtCP
	 dVaUL83rGRhbOtXHn/qUjpfyG9FOWm6ir1ldiUPEdEHp8yRjdMgWThszvlFfb0QHCyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rdyNMiM+XBlxdbJkKkHd/PYJIa4td4GcgNTCZeLOXak=;
	b=cQ5bYmJTAZzKiCfMMA3Gft6hv/G8DiAuAqvF69T83+zk8jOjvnBdWosKWE9a6Fr+BYdD
	 DB11eqAWB/iMsopElNE+L59u14S86W7PLLD3a90Cxu7Z3scDAH9emNZ6VZiIzVIlkIaY6
	 K80AYSRpdKTzVrBJaxhw+YKw8bqAyfHriA+EYAREM9runnckc2D9LHBtbc/lRsaxxQpWe
	 9W9u1fslB7MlPPCdaO4vqpgyxrdZkTHHOhOKj8qAoao9JNbNZvY90Egb8pjbcRRXIarzs
	 ErE+8tvu3oQ6AWBq7GJvUwx0HQRuVXbLlXqcl6PEYbIvqhWoT6LcAA2Vjprdv0B4BgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z+jFQGuM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2360A3816
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 22:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C2360A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z+jFQGuM
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso4952148eec.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 15:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792448159; cv=none;
        d=google.com; s=arc-20260327;
        b=jW04WcKTTEj4eGJno1Yx5acluXO+PLluw05VqvmV0GOk92J0UnMekYUaOzKDQeZwvM
         qxsV+JTri1TiJAP2/W7lEKBrdDk/3JGgaLMEz+s9+vVaxHIyi0lsK4GuqZw3SUS+oWeq
         eTry9PRgPQ6C/47RtIrr861SsUvbV/5iFFj5IJyH8AHoVkHYm57GxwBbFW3TSAkGA+5F
         H1yq0t9CguteSjhfS7yoBHC5d+PROz+LKhBIUak+JkxEpbdyMCfkwUtb+k/8Sgm8m488
         4E6RE1RJVLzvicjNTkCJQkraTqdHAsJEW5SFjvAURUwf+m/TrWSy/6DaQRYS3AWH4qkB
         sf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rdyNMiM+XBlxdbJkKkHd/PYJIa4td4GcgNTCZeLOXak=;
        fh=nIABZ/5QbcQOo4deZPhydP+9qoeb7EN94KDXK2/amHk=;
        b=QPTlJuqskaC2SIfOUz1aelz7QxoE9Daa836zk4fdPB9uRdmV1vf4LA7kdDTH+PCzW5
         IA96uQxAJYL8MRXumJ1Xh+LUlua6E7IJtiTHXPA1WvmpK7dGVoXN/5fKMd5kErwu7oBt
         z3lId50qTE3GpHM7UosjsoNEQLiAeDCGC05vPlHnr7wTeBU8mm8/ZsXhK2cMUgnMq89O
         TqIVGv1hkYxehjeZl4NFPeQR/LZIdf1oLrIi3Yxp1lmnViDBWwAF8lBjvVzOr1lnUpwZ
         u2Y2Xj2T+mVQY4DNP/WIDvgz6uNMKsPjd41Q5SHibyjmFP3cOiv6bBll9uotWQ8M8MIP
         QP6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792448159; x=1793052959; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdyNMiM+XBlxdbJkKkHd/PYJIa4td4GcgNTCZeLOXak=;
        b=Z+jFQGuM+R8S6JsKAZwv6LyJH/Y9IcZLAIfMG9qO65yJSvvkJip1WU0/fePsvMvrdM
         yYvyExnOZ/UDbo7f5/ZNZaPmFvXELK/csgabOGxEJuKLv3eMRHi0j8pbMorAeDeWXPy6
         if+FoWjEM68ZMFBEzCawUsBFbTdl1flplJBqveirwOvMyeYZfPexKkwMexScRX+ZMfIr
         Ox3ItrAbZ0kYTh5IhPqoMCvUaY/xYlw4WvIn+vC4GqdKa9wnrVccc6+xEDQgnJXnzfr7
         XOxauoWlOliEqhaFDaUzCO1Lwi3uB1phcKCIy2wQzogQzIQowzJ6dIzbRPaDUO00JOoX
         JcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448159; x=1793052959;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rdyNMiM+XBlxdbJkKkHd/PYJIa4td4GcgNTCZeLOXak=;
        b=lneiOIRi+JjWaw0QMiXTgDZvly1MgrnnsXx9WLwmW3joCnHk9WQ+4PJnDgKfxV/kkG
         PpkvQBvbqCCZlNEzxH/hO20r89CRbODwIbVInJEvzQsdWRb8u7lPkS7L7Ju/OVJY+JxC
         K+Xtp2ghHw7SDD1ZevI1Gn1CA5pZBHlHKTBidcYqfoQsjYLzpfE7R+ctEW1UNbNLZS3U
         M0vmdbHpOK37dhIuAZRd9hoyoUP9Jhjs54+08Psn48oBbBijWh0BzBJd7yFMhlImtTu6
         sznYUQcgQs5y4zmAW3R1j0kCOw76i4aIHtyx5Q+Ri0tZ/z5yl0hRZqvSABzyvgZxcg16
         j/LQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDs3DICfsAjOZNUEAyriSClb5wPKd+1ducO+v0lNjJuaj28nfkDUUQAL3qo2M5Y8W0ZENIBu1jLQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLl3rVMZNOgd0tnUV0Je+dPCjCLfhmylvsuQupwds0oqGPGA12X
	qKTGEP6Ipnhxs3giYmjzdFSjIvF1ExYu19ewfJtQorryEb85b8SayHmnr7K1djUE24v1ynbG1/u
	CEnOyfLV3hNorcpfod/3GLJOZKZ0sI6Y4D6kgYne4
X-Gm-Gg: AYBFou0nS2Y2uUo0hNt0w9DC4dJYQ7DQKCJ+7T3pL9F0YXU4XEupBdqF5nWWEXK8lKx
	HyQdyh74arf1AQzzwZ7ryP3o1YwSIjUnPAIukn7ZH2xw+hwUUKbGsJGEz7g9NkwclMwp0q/C6V6
	AHH6kNe3hsBA3wfpmXEe+qZkMuDc6vGFSA7ZQeYV2+2iKVAHPhG9upBH0HL0RwvNQAkJX+dRt8y
	2dkkkSsSxFVijSaOaRwRdMJbC5Vd0vfW5+Dft8c2CFIRLPaljmBy0N1iBfALaqzWIxbIwilJst4
	pk18VUFzoH7dYE/MFqzuSvAJFO/UF7IUeRcxFFrcmiklI1xqM15FOOu2YuYelt03Ap1fPoP3esf
	kYBduHTyCJE4=
X-Received: by 2002:a05:7022:7e8d:b0:151:2e62:fe8a with SMTP id
 a92af1059eb24-18514256ee0mr13912895c88.40.1792448157775; Mon, 19 Oct 2026
 15:15:57 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261003214516.128573-1-zoone.rupert@gmail.com>
 <asIRkK-uUz4FKQBN@ashevche-desk.local> <20261019004509.68409863@jic23-hlaptop>
In-Reply-To: <20261019004509.68409863@jic23-hlaptop>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Oct 2026 00:15:20 +0200
X-Gm-Features: AclHuK_a0n-l-qngv8FVuS94ECxKd9nndQfPACOvwyf1hlN0WIx1_aiPJEfhYO8
Message-ID: <CANpmjNOY2=M_G4uaRe+QENQRaet342UZDfXVkh3=gLaVBwW+Wg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rupesh Majhi <zoone.rupert@gmail.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 01:45, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 4 Oct 2026 11:42:56 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Sun, Oct 04, 2026 at 12:45:16AM +0300, Rupesh Majhi wrote:
> > > The __acquires() and __releases() on adc5_gen3_mutex_lock() and
> > > adc5_gen3_mutex_unlock() name adc, a local declared in the body. With
> > > context analysis enabled for this file, the build fails:
> > >
> > >   error: use of undeclared identifier 'adc'
> > >
> > > The lock and unlock are split across these two helpers for the ADC_TM
> > > driver, so mark them __context_unsafe() instead.
> >
> > Doesn't sound right to me. The __acquires() and __releases() IIRC are sparse
> > annotations. If clang has something special, it needs to be addressed in
> > the compiler-clang.h, no?
> >
> It's in compiler-context-analysis.h and for now I believe is clang
> only.  Reuses the older sparse definitions. I think the intent is to avoid
> churn.
>
> I currently have no idea if this is the right fix. The only users
> today are places where a lock is intentionally skipped.
>
> +CC Marco and Bart and putting back the patch content for context.
>
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > index c68c6c5f6aca..6a3cabedf4e8 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > @@ -663,7 +663,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> >  }
> >
> >  void adc5_gen3_mutex_lock(struct device *dev)
> > -     __acquires(&adc->lock)
> > +     __context_unsafe(/* returns with adc->lock held */)
> >  {
> >       struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >       struct adc5_chip *adc = iio_priv(indio_dev);
> > @@ -673,7 +673,7 @@ void adc5_gen3_mutex_lock(struct device *dev)
> >  EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
> >
> >  void adc5_gen3_mutex_unlock(struct device *dev)
> > -     __releases(&adc->lock)
> > +     __context_unsafe(/* releases adc->lock */)
> >  {
> >       struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >       struct adc5_chip *adc = iio_priv(indio_dev);

You could probably stick the whole
iio_priv(dev_get_drvdata(dev->parent)) expression into a helper
get_adc5_chip(...), and then
__acquires/__releases(&get_adc5_chip(dev)->lock) should work. But
that's only worth it if the declarations get the annotations, because
if only the definitions have the annotation, any calls outside this
particular TU ignore the annotations anyway, so __context_unsafe is
reasonable if you don't want to do a larger change.
