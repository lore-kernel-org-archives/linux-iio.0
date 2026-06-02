Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A7314B8F
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423283; cv=none; b=HKCTZn01zo56onqOO0UT9VOFfHL0/ga5NIYK+1MbOa/GVPcVXYrjotXWn9SVDOwJcl+lGrHmpUYWDTPhipdwiEAmbW6qEbVqk/Wqnd/7UveCWJ8+g1iC5XUbVIaPNZrGLbQhdTP0PZ4uqrmNmAD/w+f8b4ATwka5ditv7gMjk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423283; c=relaxed/simple;
	bh=pMK4F5JXOaNego5dsQW/mmVI0cNAEvb+FpVfLcnYlko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swuErb4DjYwd4Q5VIz/UxBu9AUxQkSPU0eI7kwpCbHIntLz2Ja47FVmXSw+bG8uLwbdUgPclJnSb1QlT7xfP1jYqvOPzfZIWiCcKwYGOXGJwwoNJqpzl7q+EilRJqOx12/hAuuC/VS6OdsfZ5w5uFsu2VRHxOvAB7j0SStmB+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7GXmf4s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7GXmf4s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso9134315e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780423280; x=1781028080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFJSYsO0JFeEyCCRMXy0mw71+xPt4H8G/88CSXi29Qc=;
        b=P7GXmf4sCPxjh+7yt3CxdbwU91pqvXQ4KKxYwB7/TWqDm7uUq0/i6TCCe+AmaBSgOs
         qsUZUTWBb9dAcq6CaJ/+Rf2mhRTCwEQaD5xflIpYlRZxIuMxOgYKx2HZbCCeIjm1DIpZ
         d83St11k+sf1DQKykclsvtbcGOCoHDEdg7Ej5+fSHpFeQ0g3vmMnDh1+3ks+PAYJzMR3
         dbx6SZ4uoZPWjaAEnux6kwsUeEHqtB8gA8kWC9awMeWO9uprAO+wuUr2P3xb5ItlgiqA
         QH6LSsMh2tQVrZFcY/1zZmGmq8fiYcDxDspSQCxVPxjUjsSuz6E3+a/gvsrtW+CBXqjo
         kODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780423280; x=1781028080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFJSYsO0JFeEyCCRMXy0mw71+xPt4H8G/88CSXi29Qc=;
        b=ieEJ+njiWHaBkjS3UUPSNZJVhU/940FGQcdLPy/1vintgeWfiOeKWkkj1vPeZjB7Uq
         qd1Zj5PLoSzjtzgHl1LfyL4j0IOB3ACVDDU8KpPFh7sAqn10keiUrvCiLLrKOALdUZpA
         tGvTri7Q4C77zMPd0h+MP1T1V/MVSSgGlBucLHxpHbXzsFoueHoL7xdo0KSyNikaHYXj
         vnC3jssDKtG3KNdni9kJcem8Zzmyeshd6+SKjiAa9snjw/Ls6F1w62QPBbiiLPE76o7k
         kP3eXSmL4JsXRIaiBWIB7rR/bwdBwKScWP0SxfnlPWWhfS6a2POPlEFi0zW2nU9lAaaM
         q3ig==
X-Forwarded-Encrypted: i=1; AFNElJ9eFOa44jUGaBOw12CI+IJkLhIk42aIWXZBJ7hKR76NmVs8JWuxXKvbDFNe9vcbV0RE5KdLIt3Ff3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgVPGToacI4rAKmcS0X31Cv0ezm2+YS3Q0FZtiozpak5y/OEd
	7e2c+2YmqGyX+i4SOSdi0Oe2yUNneeZe4N39h5XIF1aZe9PtDH1jFJF/
X-Gm-Gg: Acq92OG+smOpXeZWM2666Sq3lRO256MbwuV277j+x+PqNr/TlSKFI+EyMbxwpsH2wBq
	FNo3Pt/vJ86EwzH8hE5opGFIUV3QbXAEGgQwg19fivrGQYIVqHY3VFo52BhaqQ2C6Wjs7RlNb92
	hascUh++jypG5Zfhevqf6vGl4pOWCEtVQnjjKIbgLJrjGKx+w64y1e16HWlyBXaOmbVYfVU1Bju
	Oe1f1ynHMdlA9dchvJ1s5GixhiHdKTBXYVy2lTcws8nNw0Auf+0nFME3J8D8mojljDrvLzcW0w0
	38DEukwO3xScEf45Wv/z42pQ7lhgQFUcpVsDcVX3Hrgc8iCFHcb64sa8jOWIsgoG5OLj+2IsHMf
	bq1wP/jqYGTEgmzrwHFgWFvX9pJd2mpFIoDnWiFgovJuuzB93Cwf3pySL8gtNJe9xBfkK2J5N7p
	/stk+isWtMh9vq2OuTpgE0BQFyYl2HwmM3TufD4BMAZPYGGooly+3OiLudmtuk+vE0XFsj+jprl
	9A7t62JS0S6nxd8KcDnHBUa1UPrLPh56zrZVx0f23PZ+VnBvA==
X-Received: by 2002:a05:600c:3590:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490b5058412mr15287225e9.9.1780423279671;
        Tue, 02 Jun 2026 11:01:19 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35f2e6sm875371f8f.32.2026.06.02.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:01:19 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 2 Jun 2026 19:01:17 +0100
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v15 06/12] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <m7q5ne6tp2b4e34e5tn3wiimbcmihbunni2hoc6wylseuxsqji@mz7sgo7omxg6>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-6-da09adf1c0dd@analog.com>
 <ah1SUD_QpRLD2WGV@nsa>
 <u7p5ndqqh3ngnmmzoir37yuc3hfm2llenaihuekwuwoji743mf@itbbdxfo4qan>
 <a607ff15c5a9c6edd6be1a40182b16b5dc48c151.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a607ff15c5a9c6edd6be1a40182b16b5dc48c151.camel@gmail.com>

On 26/06/02 05:56PM, Nuno Sá wrote:
> On Mon, 2026-06-01 at 16:12 +0100, Rodrigo Alencar wrote:
> > On 26/06/01 10:43AM, Nuno Sá wrote:
> > > On Sun, May 31, 2026 at 09:30:49AM +0100, Rodrigo Alencar via B4 Relay wrote:
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > > > defines the representation of fixed decimal point values into a single
> > > > 64-bit number. This new format increases the range of represented values,
> > > > allowing for integer parts greater than 2^32, as bits are not "wasted"
> > > > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> > > > IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> > > > decimals into integer values used in IIO formatting interfaces, which
> > > > creates consistency and avoid error-prone manual assignments when using
> > > > wordpart macros. When doing the parsing, kstrtodec64() is used with the
> > > > scale defined by the specific decimal format type.

...

> > > > @@ -707,8 +707,25 @@ static ssize_t __iio_format_value(char *buf, size_t
> > > > offset, unsigned int type,
> > > >  	case IIO_VAL_CHAR:
> > > >  		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
> > > >  	case IIO_VAL_INT_64:
> > > > -		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> > > > +		tmp2 = iio_val_s64_from_s32s(vals);
> > > 
> > > I might be missing something but can't we just call
> > > iio_val_s64_compose()? Likely even inline in sysfs_emit_at()?
> > 
> > There is a compose() already.
> > 
> 
> Yes and I was suggesting using that one instead iio_val_s64_from_s32s() :). To be
> consistent to what you use in the other path (which is decompose() if I'm not
> mistaken).
> 
> >  
> > > It would match your call to iio_val_s64_decompose() below.
> > 
> > here are the helpers prototype:
> > 
> > 	s64 iio_val_s64_compose(s32 val0, s32 val1);
> > 	s64 iio_val_s64_from_s32s(const s32 *vals);
> > 
> > 	void iio_val_s64_decompose(s64 dec64, s32 *val0, s32 *val1);
> > 	void iio_val_s64_to_s32s(s64 dec64, s32 *vals);
> >  
> 
> Yes and it feels that iio_val_s64_compose() and iio_val_s64_decompose() are the only
> ones we really need? (Maybe with other naming if you prefer iio_val_s64_from_s32s()
> and iio_val_s64_to_s32s()).
> 
> > > And the above makes me wonder if the compose()/decompose() are not the
> > > only helpers we need? At least in terms of parameters? I mean, just
> > > assuming we only have two integers instead of allowing s32* and opening
> > > the door for misbehave :)?
> > 
> > I suppose we would really need some sort of:
> > 
> > union iio_val {
> > 	s32 val32[2];
> > 	s64 val64;
> > };
> > 
> > or even add a:
> > 
> > 	struct { void *ptr, size_t size }
> 
> I just meant using two where we just have (s32 val1, s32 vals2) given that is
> what IIO has anyways. No need to overthinking it for now IMO.

Understood. will drop iio_val_s64_from_s32s() and iio_val_s64_to_s32s()!

-- 
Kind regards,

Rodrigo Alencar
