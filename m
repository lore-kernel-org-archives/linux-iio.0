Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2419D093
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574216; cv=none; b=b/9fc3fssQH+67N3oL1ON4otj7iLszzbT6KDVqaXXHRPKyZ5qfGM54/TsAdRvZ7UvGOSlbTbOj5veHKJJz+bWw9CkfOQ8fppDAje2uJ4xmIj+jZvUu2XTN9Q7G3Vv3fiBzfVRNyt6oFP9/uON2HxCWrwwg45WxP04G0viPRI0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574216; c=relaxed/simple;
	bh=+sbc7iaL3aXBLrJpJnf/nT4NQhBQhxeKiXrJGnC5nZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWtbXLxbPpDhE7CTv0hiAPFo5LCz/b7L+mIFnzPyUjcuz+VFvl6R8vwQom6XJItxPVeLt5Aw89uOPI9rvIqcu0sRswnQN0/KCn11lffjKjwWkfzR37rgFULVCK/EtqGvy2OmZMzTM205DlsGaDTuHPQup9GYvQnaTNpRWy+1oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0ZV+IlB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0ZV+IlB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44b052142e1so2879640f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574214; x=1779179014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aljjnhKjR/iBbI/t8/f/eA69DSnDJrgp0J/o9iJh64E=;
        b=r0ZV+IlBAiZNkXyvmJsWtLdUk7AQQ/hJMrT0LHjrNGxL+0g1g5KhnlZXqqC4kQCTW2
         UFsqL3sQcCVMOzI53wP+I74P18F28gI+DfwcBtRvxKNie2fFkdZqHTl2+jGQgDiHPqwK
         3FpBxNoDZaq/ELfRCzHlQSf8s2+zb4RFURmwgsO36D99LU5G3RJfAUJsn1qoofS1/E+y
         kZXv2/guuJG1Ebe/5sgu0sTtYXrDoouaMbPNYVjaMAzkToV9NAGti+FRMHT8LAbbM72T
         YkmIUPZxuZqTtJLLoGBDxoA3mGoSUCH+Hy4w/y8i7CEFDgHm2zrnLoLQFMfy7LH2aPVs
         GNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574214; x=1779179014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aljjnhKjR/iBbI/t8/f/eA69DSnDJrgp0J/o9iJh64E=;
        b=Eo+NSUe04dR5g35Fk+g1EChpemW69V79U6VsOyvgYLC5TLB/0eQ/QWM5BPtiiyhnpl
         6vlDwyzXkf+uQE+x4RMuqaF59WcM1LtrlAg5DabUTm7SiCBH04Rz7/Dc3X9n8z/23KKI
         ZMd0+OIDPNiSHeNGroolTYm28MxuNj4HOLunplNptcw8N75Qm2rCayO11q/Qen8qMgDK
         KNpIKD+u0zIPcGI8qVA7gXgCdD7a+t2q6uBRPQuYuJC+ED/l8Avkvt4V+5dswr4SSqtV
         te3HHI6algiMfmq4R2UoKAwAwpxhO04eHtKe84grf+SG7Tgoa9hAJODvaSKRPGOeTlEw
         mOAA==
X-Forwarded-Encrypted: i=1; AFNElJ8cVYYoM0FEFRlfOF9w3kITAxyrvFqBeZvst9v1krxWeGkgCIuli3+NDQdT5ji2jtVv3ZUpIptYPqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHXPpA4NNREH9y+IDe2Hi4I30CeCJFOo2y419lAjBjhxj/dPB
	rZug3D7cHADSdFzaU7cXH8Xouigfe+6RyooU/CHb4JKH+7ehFrIDRveg
X-Gm-Gg: Acq92OF6dNILfxX3I3CvS91vhXGA/KE3rnlMbZ3NnPW5BF2Mh6J1ROkKYEK66hLCNCL
	tCv9BoM9N0XJTmWYyRONcwm9K3wLTjmk1kbKkwIZwkKJJ33U2WRFKhkS1lkAdaVt9RIBpJ+VrK4
	JB12jbaV7RVSM6SKMTJfgOtQfArD8BVGUP5ROqfPkf4JQBZwbowHtWsAWUJLpiXcFQ7MwZX0L+f
	19Ob0A2+U70cFWIsn22Zyt8ZlX6aalJ7A00ELycHYWZJnaapKDhA60sF1acGRrsiRcBSim4gOr1
	JO3yasIj9gq6A8VQqDm5pT8tQKgxayTrWbiOYvEZ25Yizr9NjQnoVc9NBAO8MDIk6eI8iL+JXMF
	1JVvKEomkCQTsUY9koqMEgW2/udJYL0Smek627WfUKLKGmA4oCkITw5YyCEnYwxgnSTtn4a2zEW
	SPsA5IupDMrx8P3g==
X-Received: by 2002:a5d:5f48:0:b0:44b:8fb6:9a2e with SMTP id ffacd0b85a97d-4568c19d154mr18872057f8f.20.1778574213510;
        Tue, 12 May 2026 01:23:33 -0700 (PDT)
Received: from nsa ([185.128.9.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm29359598f8f.1.2026.05.12.01.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:33 -0700 (PDT)
Date: Tue, 12 May 2026 09:24:27 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <agLhb-S2ISSjaopc@nsa>
References: <af2no3bJA9MSjXvV@nsa>
 <20260508121441.39ad9f65@jic23-huawei>
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af4LCQiqNaiMzFkX@nsa>
 <20260509154600.02e2d11a@jic23-huawei>
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>

On Mon, May 11, 2026 at 12:02:31PM +0000, Stan, Liviu wrote:
> On Mon, 11 May 2026 Jonathan Cameron wrote:
> > > > Ok. So what are our options here?  Present it as simple resistance and leave
> > > > userspace to figure it out or add a new channel type? To me feels like new
> > > > channel type makes sense.
> > >
> > > The current approach presents it as IIO_TEMP since the chip outputs coverage
> > > (using the custom table interpolation) via the temperature result bank, not
> > > the resistance bank, but I agree a new channel type makes sense. Should I
> > > create a specific type like IIO_COVERAGE_PERCENT or would a general
> > > IIO_PERCENTAGE be better?
> > 
> > For ABI purposes we don't care where it comes from.
> > 
> > We already have some 'ratio' type measurements like concentration which are
> > percentages and similar to those I think we need some indication of 'what'
> > is being measured given it's unit free.  Hence IIO_COVERAGE_PERCENT seems
> > the better choice to me.
> 
> Understood. Will do that in v2.

I do wonder if a complete type is what we want? How will we present it?

in_coverage_ratio?

What I'm not too convinced is that coverage is relative to what? Well
it's a percentage so I guess we could not care and leave interpretation to
userspace (to know which device is dealing with). Still I wonder if a
new iio_chan_info wouldn't be more appropriate? In this case applied to
iio_resistance. So something like:

in_resistance_coverage_ratio

So it's clear what physical quantity coverage ratio is affecting.

Thoughts?
- Nuno Sá

> 
> Thank you!
> 
> Liviu
