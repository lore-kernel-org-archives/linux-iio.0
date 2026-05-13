Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01047DD5C
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684974; cv=none; b=DZYnfbtsk4mIhIPZ7lqkmpXsXr3crtaL2jjQDQeO+KSpp737y4mhltMwvejOP7Sn7FxphCkZyVddzK+voCOJybG+pw1voXNJh280cFm5Mm1VOe6+u791wUAduGLkWlS8+DRPqzEBjSDppRCw63JoZUD3TQP3vRqolpRGYPXyG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684974; c=relaxed/simple;
	bh=6xl1OZ39wivS4tq4DwCHKYc6atV3f69XK8Y07bvYulk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B60ZS1eQvr0IwUyxLp6avFp7GBQMLkIkcxWLKJJXcYLR5UXxudOp85XvdnfoGbv2kZvUEjwJ9QXIL2/cHsgYRrGBqUe7Y4HSmMPIuKPJ95XMsa+hfxRThZnBeqvJOgFRX4KAodZ6FyLBQ2JB+JWYOwX4sHGoHg5KdmpmbdBdUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKTY2ck6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKTY2ck6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso5583731f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684971; x=1779289771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90qdZzTNiTsSE1LEeRcQYoXszr3HSv7vr/Z4t6wMOgk=;
        b=UKTY2ck6pXR6CIazO9ViC2GBc8u7VlKlZELwDr4XBON+z8O34h4T8RJfuyqqLJkTcE
         5TGtLNllxjZcgjeg/Pn1/z9l42mWqCjd0iTYJHtkhn6k0QY/TyRvxWlWrBdk8ZgSfDnl
         Yc5B8aBaQpyRTi1LThoiuOZu47gkgQCrjvNKplqx4M2jFq9wq1H2TcuE9xbejlXqqaRm
         IIgOSuPdVj1pew/ap8JQ4lM+cVgxfBpDJL/Cn4XpgGkyv13ZLgBN8Y3eYVz/0mlfs6jV
         Mqv0VXQ1ydsNh6N/NY7QPNojx8WVA1So4nzcZfvk0juT5oVcnJu5JFnHVtRFuRytQwcU
         hPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684971; x=1779289771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90qdZzTNiTsSE1LEeRcQYoXszr3HSv7vr/Z4t6wMOgk=;
        b=b9jsGUQD2X6HBFdBU3/veGqevRmOrknLb6IE1+QzKUsD3eryUq+Wcxh92wKI5RYF91
         EoqBQF7T7WjCsNw5+eDI5aXCQHRgRJ9z+ls9CqG+VP4rXdKhMbQew1O+QQeH/Ft0WPW8
         6eIgdv4El5LBM5/E4trbNnL0KpeJ2gmbT14Q8hBRimT4b9rKZGfK6osh5bTl0Fav9TGH
         cxXul62HHIMxyKYwFqu3NRxocncA218xZdoymknOfiZse4PYTWu6gMKO4j71Lpm4pCSn
         6CCxvlgLV7AMHo5JPHPZP79wkR8dHzuNrCUdTw/vE/Pi7IJ/ez7H3Hku7AaA6rvt79qv
         8+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/w6VeEibTiOjbcQSLDXGHlX653G+GhAhOAb8peQpWQp2I0V8sNtUUOYBmUjNAe7qn5lHUa9EpEc1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNo8o4pK9aBE/gLtFB9gmS1mMRkN3Rsg17GIcX2CaX+rPPweE0
	aMW0vA/dvNg8xbvUuM9i1dwn+nuRd+JxwFvVJJTG+Fc77wJdkxpfLeDJ9xPM0TKN
X-Gm-Gg: Acq92OHSJRuu1/uSyXr3gTTJZ3Zj8+gJG+c5uTxff2h4Cmi3mMv/8E06YZaBn4rRd8k
	39IO2QKhoEGtzF6LxANqe6SIFMhDj6Vn/ZL0bBcFy/yx8bNQ4KHSvVTpNj1R7vvSetQRb7DLbUj
	YHorcQdOqQXh7tEcXMlHBtkfa7dOtxZcmzeeLt2Q1U4KOz+cRKijTNv66dIhrLevMAI/2TT8oAj
	hGx73ABKrCJzQL5q6xTJZg9lBwGGOGmpI84axWJaOVmFZyXdAzLZMSlVYb/zvb7a92PvTWJXxFs
	JwxTePSj0QgAkIsp4PDkWVp8WU6cGJGhvYannfiCJBHs7KrPMVIMAPGdouIufncbkR851UkP/iM
	UGjPh5UXrhPYV/ziOwhA2JPVchiU7Roo2MDajT5BQ8jpVP/m3H5YcKIqEH0Fl+hBuI9buqBXrp5
	kNNmkDbwIS9GJN/OLOXbZSABp5WT5qr169r6ozL4PZBSCASAlBY5ZFVotQch5kaBS2CsfYJJWWm
	BuQQPMZrwRkOXOEcBAPRy7NhJ0ucuAFJ2EDO6t76v7tEkB3WfYQudDS8f3/
X-Received: by 2002:adf:e30c:0:b0:45d:4688:2571 with SMTP id ffacd0b85a97d-45d468825c6mr1533975f8f.41.1778684971053;
        Wed, 13 May 2026 08:09:31 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm39821178f8f.2.2026.05.13.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:09:30 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 13 May 2026 16:09:24 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 01/10] dt-bindings: iio: frequency: add ad9910
Message-ID: <vklczsi4vk3sqf53zifslhp5pysdmj3gfyhvdgrwo4bg3wdkxj@lnbftaf5jcbf>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-1-d26bfd20ee3d@analog.com>
 <20260512193129.777d62a8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512193129.777d62a8@jic23-huawei>

On 26/05/12 07:31PM, Jonathan Cameron wrote:
> On Fri, 08 May 2026 18:00:17 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> > configurations for clocks, DAC current, reset and basic GPIO control.
> 
> I think this is getting close enough now that for next version you should
> drop the RFC (which is probably gating DT binding folk giving it
> a detailed review!)
> 
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> > +
> > +  adi,dac-output-current-microamp:
> > +    minimum: 8640
> > +    maximum: 31590
> > +    default: 20070
> > +    description:
> > +      DAC full-scale output current in microamps.
> > +
> Can we use generic dac.yaml defined output-range-microamp? The base will be 0 always but
> that shouldn't matter.
>

would that be fine even if we do not have those child channel nodes in the device-tree node? 

-- 
Kind regards,

Rodrigo Alencar
