Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FED340A6C
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855028; cv=none; b=KLBgPm5ZTih2Qp9klxTEsl6hMQ5dmyrsz1FW24hzRbpLmQSPpBbyoOuXJ3zSnItUJQk8aV8MwN4oOypvzsk4OfClkMtk5ZdJ2L9sP+8LLDJHuSAMfqkgNmKGIpG9AhIPnJs4pGjzQCrzeWi2S0cCemTWfe0hi8HMALZ5i+vlXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855028; c=relaxed/simple;
	bh=JtwQD+WieKqcogcMHWpjbsbEMyUOZdEqFz8nYzUh7VM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT3iLmiQVZ09qoB/fACtizotVyjFQAHuCIxjW4aWlxFXxDjq2OGbYKOEX3iTzg1Hb3TGJPzfJpEG18/vEGaemBFobQa0Pj2Ec/i5bHlPe65+bL15eEcmONM+ZSrq1U+F/8EHxiGtNcVF2TQMVtaR+nc+zvrf/rKJVQnO6H3D+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTzJfeNP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTzJfeNP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b8d414666so1025708a91.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855027; x=1782459827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/CJyPY47191DNK2I5FV8tH3A2JiB8r3XI4Ww1d0nJQE=;
        b=JTzJfeNP86y6ShPISQBwgECqNb1la4It+H6oAl+3bd1wGP49meeHZ+TC6oxa5qm+X8
         V1aq/HwgTYREZSz1AOuIcytOOOy312PdW5/TqO5idUgQwS0pZS3tiBV1EOUebVzmRO2N
         seHwxCGj11oXzS9XRcYGO3O3NwTUbPqr3/g9j5Bugwzxd2lBPNpTBfrUHOKxrP4zU+wn
         0pK1hcawnEKUecYiQWN55hOun8u3/h4HgrMHJV6KhCojXOyRrFDif3zPG0D22RmWhRi0
         LP61/H8d1+3ueVlFGt/Z4lvmRC25UzhrutfOgmpOMSKZQSUM1SrSg86ayYKKvDdooE1P
         uLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855027; x=1782459827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CJyPY47191DNK2I5FV8tH3A2JiB8r3XI4Ww1d0nJQE=;
        b=XBWdhHz+804Gp4bCqsZoPMrQ45n+/qvylcku60RtzEYwffSphCx38x6d5JsYO7ZAK6
         aZdoIAEH4c/+tHkLRp7LzkQLDn3k/4R2iERWPAMfrxUajnMMDj39HuKivk6lNuwRtIpc
         h35WjRowh7jAFSkjniFQmRETeWIssFHbl/2A2iNoYuY43FOik8vjqfd2bp+FE33eRs4X
         rZiU0Zt1K2eAU7ZvrVipvwM+B3zQRU1e4DKQWlt9a8SncGbTqMrrr5HDgUhF5PUFmCni
         DtdaxsydJzm/edPZ67/3hmWE7x8YKoKS9fkA50lFtyep0A+YDpsQJ8AD3jmfoW+wNc+m
         ziIA==
X-Forwarded-Encrypted: i=1; AFNElJ+KA4uUzR9ngmIesp73OGqhLn1e/cEkYSmK7EbImSv4QSJUOoCbZjHm79jsIYS0mQiQp0jEggFpjm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuttbqlek7NpaO91TWRUn90V9vOg+hNKqZj0JuSuCrDQ48/np1
	Z9CcoPyiLX7+k1ETMMX+uHVv9q3SwM4hOZYI4ZDyNbMk0bIs3ID5WnYS
X-Gm-Gg: AfdE7ckBvFtoRXXiXp+6O4LOfvg3RoZfkJz2CpHdDMoCLrb8lFhAOiZlcIRVdGaefv7
	dN158lJvDoG84nbJ7P0Q7wxtIqGKn6JMp820dlP7jlMFKZtiFbpUdAmttFpKZ3nDerwPqfqzjKb
	jJx1C9AfoxhIH+p8sNn0EcHj3pRD1WFdPk7rVvvqpO76dKOzLE8rxDyFSu+mlmDAR7Hci1WmoHe
	MKugmDUp1KzV5AL2sw4r+QEcX1q7ebG/QjiJoSj20F4owSrefmMuSkjTWWamnc1TPGgHXat1zcG
	gqTqqpC0x8fYozNDnxdPTP1X/zYiYwdEKUx8+cI5Avk5w2ZG9nwp1l3+2gZ40+yQ59FW+AgRsjw
	35RA/vrAmlvGOBre3gg9Uzf75L1jqC9SBdw6jKjvvZ5NUnIJ+gWLobR6err6g9N3p3w7wGm/DGY
	vgPy9ECnFATePjGsp+ej7HbQa2mIPWXJHKO7Cgp8jsLl3T5nSiY1+FO9iRuAtGxTAp8ybFTOekp
	LZ6HV/KUBZm57VQHcrnjvv4xfuY
X-Received: by 2002:a17:902:e5c3:b0:2c6:6926:8968 with SMTP id d9443c01a7336-2c718fc3191mr28913805ad.20.1781855026787;
        Fri, 19 Jun 2026 00:43:46 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089c1cdsm14474145ad.17.2026.06.19.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:43:46 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 19 Jun 2026 08:43:24 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 06/16] iio: core: create local
 __iio_chan_prefix_emit() for reuse
Message-ID: <dlisetsssjoyodmv5ubl4rzhxtla3g46mrrzv2f65nqecel5fu@dqiqsayr4aip>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-6-79125ffbe430@analog.com>
 <ajQGTQ1_qcOwfzne@nsa>
 <x3aijvc4buo7aqbchikuoyyrgiq3afidtkla37h2rg4tvfdbc3@h42qp3estg2s>
 <ajQ1bZSNHQ96pyJx@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQ1bZSNHQ96pyJx@ashevche-desk.local>

On 18/06/26 21:14, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 05:14:19PM +0100, Rodrigo Alencar wrote:
> > On 18/06/26 16:06, Nuno Sá wrote:
> > > On Thu, Jun 18, 2026 at 02:27:22PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", prefix, postfix);
> > > > +	if (!dev_attr->attr.name)
> > > >  		return -ENOMEM;
> > > 
> > > I don't oppose the change. Looks like a nice cleanup.
> 
> May I oppose it? I found use scnprintf() is harder to follow in comparison to
> nice kasprintf() that takes care for the dynamically allocated buffer.

In the next patch the function is reused in a sysfs attribute read handler,
a context wich would not be nice to have dynamic allocation. vscnprintf() is
the main building block of sysfs_emit() which limits the buffer length to
a page size, so I used scnprintf() trying not to deviate much from that. 

kasprintf() it is still used in the caller, where the logic was a bit confusing
as it tried to avoid multiple allocations.
 
> Also there is a chance to get a name silently cut due to insufficient space.
> Besides that this function can't be used (again due to 'c') in kasprintf()-like
> wrapper. I do not consider this as a good approach. Have you looked at seq_buf
> instead?

NAME_MAX is not the maximum length a filename can have? I suppose there should be
enough space for the channel-prefix. Indeed, seq_buf can be used and it cleans up
things a bit as it tracks the the position in the buffer.

> 
> > > But bear in mind this very sensible as any subtle mistake means ABI breakage.
> 
> Which immediately raises a question of test coverage. Do we have one? If not,
> this code must be accompanied with one.

Agreed. Will see to have tests for v7.

> > Yes! I tried to be careful... this is dangerous stuff!

-- 
Kind regards,

Rodrigo Alencar
