Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88362253A1
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489050; cv=none; b=oMrsVS0dBlzHhZ8RSw0eKMWAkUPEWUY9OpMgfJ9/lofQ7gxTeVoRf+0/yol40Hw1fRtvNZWoYXoDJOwYBBEGWOm3K1yCuGDB9Y2ApSnsUXmkwdkiIMahbwQRMWXsewipt5TwleraR4BfRLoVt/SpSD/b6CP3g44/aIRJROTiwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489050; c=relaxed/simple;
	bh=DAw4JxnUtGkEQZ+K5aXpb9DlfRjujHomzxjuX2PxS0Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UItymPVjin3R8IU8WfAwul9XKOK16zW6JhHsJoC8qiqrnIwHBFut2vC3DsupVAvp+ugopRlDj+VXx0of4k8y4rDL+rmRC1QKzrQxMe5ff/Y1PfPwGknzX99LwRw8cL25JP2XTczTZt90MhPT8jfBMjmMul+jYLsQBdExQH76VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N22U0sio; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N22U0sio"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-befd83e0521so133922766b.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489048; x=1781093848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHxoYQzLKR/tGoWFgMeS9pXy4BlkN8McTt2BqpaK9U=;
        b=N22U0sioPS90X6oMviNw6Rvq+i6r658Md4yi2s09qkdDNir8emH7yBVMXQKCFPHefO
         PmLC1SRP63/Ra7yglSf/LwmMVgslqlWEJhlSLtWzhIEv3Yo3a2eaqTBtBnlrvKTGB9aP
         4zExIGAoxexzrgPNTIajBWxgAlICvgRQjfkgborUDYgMIu6RrLCOxiVONWbom4kle9k/
         Zdnug/MLCwOsu70dQLJ+p2bu73qAAB5L3sUpWVn0Okqgng+AJh3VBywTWjDbeaa0Vh98
         Yymp/NywvS2yoGB421Qkw1zHi3rWTvT+mDh1BY4NMGWhwTSdeevrtwR2pHIn80ndhKFH
         wKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489048; x=1781093848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqHxoYQzLKR/tGoWFgMeS9pXy4BlkN8McTt2BqpaK9U=;
        b=rg18HENQsDNqUoO7AXYZkD5TXmtLwtk30HMo/zGRXyoiX9eAl4C7EubgqXc6ZGAQ0z
         /nDJldF2Rpad8qXxb5pSa2v9MWC/xS25WSxRHdmNieEQmUIBygJ2Nj905xa4RCaCA0bl
         DVMNpUjo1Q/7L0WrXbg0K0b4RzhXyaTDnymbd36t+JBH7vWlT9wLIjkfCS/tZbDdCRpZ
         XcTCzOX+lahIJEdUqFLshPCzyZQGs8co5q7LNBNa45oXy36RxFEEraVEVJLT629a6+rg
         uzFrFZeh6JvLWJTRered9O/FZCt6wTlS311Y0Faen8j3LfMXzhRWYJoQerY5jEt0s4nm
         jtHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E9DXH6vh7DcGE0s3MIMfVZctAuWgFQaDLfoHoRp4WQD1PlQUuHcmMZUFixnG7SMOIQYmgOzRUZuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKh3EqaafgssXTQOW4REtkB0VHlL2NduudVCnLZVqBKQZVjmO
	IlVmzBh6KpAwhPM09gn/grxsLkQ9G4mJ7m2VIOMj/d7MgShFxjWhLeFn
X-Gm-Gg: Acq92OF7ZYKPbb98G8nNSqvx/CfSIYMOfQwto34yy038JK4UAVW2rGTFFvvWcEhic+u
	B9rnjAdx1VM6WLaRTbj335kYwkes/QyuO52fFnmPa8T+aOBi4VMQFYIvQuwXC5UQmqDLgPItpgM
	w3m3vh0GmoU29jpYdvy6c/myrygucm0leOst/Olqmo0Wyob0w73/7teZXuY1bh5jV0dQJ1xVFJn
	TJv6+RO5KXJDc6Bdpuu+kd54+JVBnquNYjEL7/v4A7tngRb6bPF61GFaCl8YXGzmz6ioXAfEmYM
	wuL3R/AGY7zi/qV/nvyN+Cgt731uL9MBxVj/ArCNmr3YEc+Q+slf/ExpdLb3UIqs8N7UPx5LIX4
	qWqSxmQ7N0ISQ4Rd+jylJW9UeJj2NVmQJ+MlJ2KBa39fPivF0QrwhsnpQbr+78hncphBxr3ZSJa
	NYrPZO6gxsmB6P7ii6s5zvA83vH5gHGKte74lgdIx3rW3GO/NI5PUKBhY6TdSCaMtMssPBHa75p
	fWDEKfhZwXXGTf913pkEK1QCF5ogUdY4njsplm+m3NnUaO99g==
X-Received: by 2002:a17:906:6a13:b0:bc1:d3d2:9348 with SMTP id a640c23a62f3a-bf09ea6587emr146364666b.20.1780489047981;
        Wed, 03 Jun 2026 05:17:27 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055500875sm139987966b.53.2026.06.03.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:17:27 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 3 Jun 2026 13:17:25 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 05/12] iio: dac: ad5686: add support for missing power
 supplies
Message-ID: <p3ydzrkizeysxlzc355xzgeboipihgo45w34uwn7a4lb63jgek@kr5r5hgjh354>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-5-691e01883d27@analog.com>
 <ah8oz29R8mem6H5X@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8oz29R8mem6H5X@ashevche-desk.local>

On 26/06/02 10:02PM, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 05:33:52PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Get and enable regulators for vdd, vlogic and vref input power pins. Vdd
> > is the input power supply, while vlogic powers the digital side. vref is
> > replacing vcc, which is being deprecated, but still supported. The value
> > of vref_mv is checked so that a device without internal voltage reference
> > cannot proceed without an explicit supply. For correct operation, vdd and
> > vlogic are required, then devm_regulator_get_enable() is used so the
> > driver can still work without them by using the stub/dummy regulators.
> > Error report uses dev_err_probe(), which helps debugging an init issue.
> 
> ...
> 
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
> > +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> 
> >  	if (ret < 0 && ret != -ENODEV)
> 
> It can be deduplicated now with
> 
> 	else if (ret < 0)

Not really, because ret is overwritten with

	ret = devm_regulator_get_enable_read_voltage(dev, "vcc")

so the check for if (ret < 0 && ret != -ENODEV) is intentional
 
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to read vref voltage\n");

-- 
Kind regards,

Rodrigo Alencar
