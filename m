Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FF4279F9
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892525; cv=none; b=svct/JxtjBRb4ADb4sFXeFcCpq9tkb0p855Tf7co5Gukm4r9GHaxVi0ItfhLg3oZ8IifIncAPxdg24WVPPBOIrhBY3qQ0cXAKHGaUEwbACAblH0OyHesjg9amsbtdvnhvF6UCPpQOzg1OXX/TvpzHfXuJ2okp1UebZuLg8G89iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892525; c=relaxed/simple;
	bh=oDWKqtDhTF1qyHxIbD15S5vg4OO35WpqEhsWVqAUDSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJZHGn+AuAXiFulmM5tLx2cmYGn/FxUptum558mOcqXiq4AAqZw4hR/G4j6Q+tuQQ5QcBTpFXiMKk3fTwdJBeTx//KE2jn3eT+vp0jLuhHrexFZmEhOrw2r4A3xmEo1RlgU28uRO6THK/hgAsApiVQqaD1eluNugzTPP+WGRaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoG+FgdL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoG+FgdL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49039a8851fso62667655e9.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892522; x=1780497322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn57LpZx1VKSH9/vRJzOE7/6rh8rI01XjeBWgZUoy7c=;
        b=RoG+FgdLKrtK1jTsy5RAddq13AfKNprgBuI9MLyAeKup5P5xmw8HJ3YjW9zCahlmAx
         GWjkNW4/5rdOmwYPTFC4UDU3FzPbPxjmxyo7tPBX8QHl/yew3iLA7bkhp9kTrJ6I+qZU
         PPPyaJ90JBbEV9LgaSdCW7bvY8ZgfRIAoS9JWxXQiODESVLXX8J15XQb70q1q3wR49lV
         OqxWjNmnuhdQ4kDkp+siSkkZlFZhFSebWys4u7EyzAzrlTdVLMBLmYH7su//GfLshYOU
         tsiFwZqvNLbFxubfPUXUhIgH0tO7IfPdtWK6PTQRzP1qtxPUfZrc1y9alpEPzjfgf7kk
         nh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892522; x=1780497322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vn57LpZx1VKSH9/vRJzOE7/6rh8rI01XjeBWgZUoy7c=;
        b=hCv4xr/wIPaE92554QyuTAtuq4lWborEArQsOd32IsX8uXaCgut4w7wIXcXEbaJ8MN
         GQiJxnZtm8okfMLsw0qW/Sj+EyBcJUTn7ab+Oncw01mbMqA0WXLhbgPceS+sNS9V1pdn
         mNhlWFZQuWYTSYcvWV0o6ZxpSGU/uMsxB/mpptNhito3xtlVLWh+nctGl/+1fijS3drC
         deOOvuAYpX6pI045ZqjiINk3qh0MHr0a4xtFx+k/lGIv4ziVmtEbUOHO7hDlUaLw7ngD
         7q4deCRJSmF67K7fTYrqLQWioYKLLWZXKQEhHDpEE5qyjCBZJFru7l5zCWXnR07CmZ1j
         FD3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7U2iHp0LNulfmO+OzSdqjLtWD1kaifK77GOR2ftC3LC5xSE8Yj5r5+oKS5mTxulum1UEU6/7vsO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5PuIqQCn5OqgxwXk+w+zOmSocODkFByPE0PRz6WJmSHrr7XS
	4K2DFly/GpZahQZy6HfMqnVrUvEn04QkPAFFuB/cTly324Q/m72Xn3W/
X-Gm-Gg: Acq92OFF9cckhsEFRZbgbdCXSOPJ6bz/QIfdmWAGxFGsL+OKgCCXC8ri0mzSFyJAqoN
	OkyfbF/BLUPEDFIJwXGfxIu08MkzVCTJJhqbPtO2Yri0wqknlkG73gzV39h/r3mCyFVUaxyY8Bv
	u05/c7F/H2Ti2HXeZywsf+i7EBM0kBsb21EvQ4R5rMB9ssu2F+gDAMuDIZu8cgTzxxsL41yHQdk
	Tk4yL0bs4FYIRVXVfyaoWVS48ogyW3F10Zw/RpCE889LtsdizTXYcROymbCTf60nJz/f+eY+Zpu
	WTNd1iKtlpSZItNu2N98DhMSRzD2OFJjjfkn4IBwbvsV0jRV7l3QIilxF2c+6TCjYzPv7fh8INB
	G0k3+57CxuTmYzQqnuLp7kiZSKA2ZePe/a7TAxFXy8APl9v/Y6IC8l5vZiH3C98EdO4khTm3q+m
	XKdYMu
X-Received: by 2002:a05:600c:458b:b0:490:47e3:929a with SMTP id 5b1f17b1804b1-49047e394a6mr366016045e9.6.1779892521796;
        Wed, 27 May 2026 07:35:21 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:21 -0700 (PDT)
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
Subject: Re: [RFC PATCH v1 2/4] dt-bindings: iio: flow: add Sensirion SLF3x liquid flow sensor
Date: Wed, 27 May 2026 16:35:02 +0200
Message-ID: <20260527143515.102794-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526171930.0db4125e@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-3-wafgo01@gmail.com> <20260526171930.0db4125e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 17:19:30 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > +description: |
> > +  Family of digital liquid-flow sensors from Sensirion with I2C interface.
> > +  The same register map is shared by all family members; sub-types differ
> > +  only in the flow scale factor exposed by the device and are detected at
> > +  probe time via the product-information register.  
> 
> Because that doesn't work for fallback compatibles, we often give devices
> their own compatibles anyway. Fine to also detect in driver but if we get
> something that falls back to an SLF3S-0600F I don't think there is any reason
> to think the subtype will match, so we have to trust DT to have given us
> all the necessary info.

Done in v2.  Per-variant compatibles (sensirion,slf3s-0600f,
sensirion,slf3s-1300f, sensirion,slf3s-4000b) plus a generic
"sensirion,slf3s" fallback.  The driver picks the variant from
compatible / id_table .data and uses the product-info sub-type
only as a sanity hint - unknown sub-type on a recognised
compatible is dev_dbg() now, which makes the fallback story
work for future SLF3S parts.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,slf3s  
> 
> If you don't expect to add  more sensors this in near future would be fine
> as a const rather than an enum.

The enum stays (per-variant + fallback now), expressed as
`oneOf:` of `const:` and a list.

> > +  reg:
> > +    maxItems: 1  
> 
> There seems to be an irq. Given bindings should be complete that should
> be here even if the driver doesn't use it.

Done in v2.  Optional `interrupts:` (maxItems: 1) - active-low
data-ready signal.  Driver doesn't use it yet, but the binding
now matches the hardware.

> > +required:
> > +  - compatible
> > +  - reg  
> 
> vdd-supply presumably needed for device to function so should be here.
> From dt-binding point of view we don't care about the kernel providing
> stub regulators etc.  The supply documentation should reflect what must
> actually be supplied.

Done in v2.  vdd-supply is in `required:`, paired with
devm_regulator_get_enable() (no _optional) on the driver side.

Thanks,
Wadim
