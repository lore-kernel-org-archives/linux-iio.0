Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF12E03F1
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595849; cv=none; b=QwQaqJuVpvrcwsMFeraid2IAiijl+6UyJBgaFEOfArHF/dV8B7Ydex2BeUbwys4LoomJdy+pjlOm7DIYCWImBowFQZ/R4O0MYT30O6QOgOAFAz4M1+tD+T54HqzeSv6cy8uSEqKBXgKLEHvObJwlElpEhJTrFT3mFuFrysqmzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595849; c=relaxed/simple;
	bh=IAuO3hZmjWwJidDrBK/ocDP5eyCa0LwHoRRJa6AHUhw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN8QKDrcoXeGWFFmfOROdFs4T2/RFcnL5bq6Fn0BNqTQ5asHEJ5hlRymxaaq4PmVBelLtlrA7YYpirFRkTTqA2UdKpclvW2wfnPIqscw5NPk2oBlWksa00wi+559enVnhrbJUJNHpzM4a7sJhwzd2e26rwFXLD+Q8RsAtVe9egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7B+5XjG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7B+5XjG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so55497305e9.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 02:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769595846; x=1770200646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2K2glf1WnKZAPsmypQA7tsSM/kM81tZ2AhTOrY90KiM=;
        b=X7B+5XjG75R7H5Y81fYY/ZjBnyyoRo7svYk5QWYN+CEO/KEkKz0aium590j8gAh0zk
         blUuLMUlB7oZV0OEwN230dzsu3r529UGidfGnqdJB7Gi+QPYop+hIZOBoejQvSyN2RnG
         Z3ebA/+VpkyVQa73T5erjx1K1pTw69QkoIzpmsO6jfsmjY0DYyzvHYoXXsbVrE/pa9E2
         bSqsnGeChUhxgEuEj6wh9PYYwJPp91PTqUBSAtq0ON73ki0HYbJZbcU9eWmyvG1o1eXC
         maqSBjbqUaPSxVUGeJqCDIkKvzJKBah21Fjg4N82x9EEa3N/4g0RtCJhrfy4lg0uPS3T
         aI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595846; x=1770200646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2K2glf1WnKZAPsmypQA7tsSM/kM81tZ2AhTOrY90KiM=;
        b=isS973OITcTR1IEyKohNfIEHM+1FEhHK1vwL5wyM8NWraUS2higYDuVoLXkJ2o3+t0
         Q/lrrxdbM486bN/mxKcUannwzt4mfI/U9JiaFRs21Mnt4OIEkHzgBfLySGXmmxAG0sxm
         StIUjEaOXq/EzsY5rl6B/1xtrptOGHTO7SSJSvxZLtBHzdHzRC7tuwYQ43lpQMXfTzGC
         yUCGDZcvL3aGpSsH0rKCAJMyqYMTv4ZidRL0mjJCnjHiRMaMgDLXFw7Ri2CiN/tz0KGd
         wgqFTgpCpXT0tipn7avD3Pk9lIeeovVZxHTpQmcexBazUi50fo6B2M8d9W8n6WsX9Q5J
         QnKA==
X-Forwarded-Encrypted: i=1; AJvYcCUfpe+QLqaLPaUNoy97skrNbbqYrGTl21NdeOtXIjfbUYVpnXZgoncctvzkbzUM4zZyCnIUgtB/39I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FM3+iwWkuzpOJmXFZi/cezZP9Wv4WSUeYE1KNtEKZ/dInrci
	8Zk/S0KfBn4N8M8cVyNHvgficIwOxBRgeMUoKgMacz8LHkXI1NGBH+Mu
X-Gm-Gg: AZuq6aJolix4cT8EhdOIQed63JnCbA3wXuxxX3E9e2WmoHHqTRY7JU3+q3/518vI4Sg
	Ek/A7iSEnd+ZX5RkGWhzrvFre3xDNWVUuWSBi8izSiiRUvAGdF2PxjhGjI7ZYYrPriAlgRxg/cV
	jZGUT5eOp3NY+eIa/UQRKpTR944k42smoBsahFE0l97LSYiD4o3BFlwd90sojYhO3qcctMtFt/3
	b1YI9BDJH/coNr5/eC4i+vWhf6dpQeci0pvZ3YDVaduCP02ZRtBQqKymo2jEqm4vPITy3joyZP+
	u+6EegLzJq7+rBpn2vCbsxURsoewy2sWIDDx9Rp3+7nHEMEu6zBiYTH5+eN7krUPVTGk7w3z1GI
	f/RJFkBPz9XyhdTmtj1y5QTKr/TZEpDftRHM4oNKiPEOVGxl8OI4Kt9gOnEannbnfu+Wo50IBMi
	CJaIwSq2j94YKVfyeWbmZBBZavpucITld2xVARMUAmOgBT5Jzr2L/uxVrfiZ8CTzvpgjRwdMrJp
	3OC
X-Received: by 2002:a05:600c:6092:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-48069c3a7abmr60068075e9.15.1769595846225;
        Wed, 28 Jan 2026 02:24:06 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdeafffsm54409255e9.7.2026.01.28.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:24:05 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 28 Jan 2026 10:23:58 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: amplifiers: ad8366: add device tree support
Message-ID: <knzaphyzfuh4fihlftzh3jhjxbjrdjqezqsd7rc33pmtc4anxi@2uhqhizyfsed>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
 <aXksSjsyNn6if3eQ@smile.fi.intel.com>
 <b6pzhwmfranyhuetv65movfqzubvbjasl6ruxiym2ehuch2hov@r56lgzgf4us5>
 <aXngRcVMj18tryGT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXngRcVMj18tryGT@smile.fi.intel.com>

On 26/01/28 12:09PM, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 09:55:16AM +0000, Rodrigo Alencar wrote:
> > On 26/01/27 11:21PM, Andy Shevchenko wrote:
> > > On Mon, Jan 26, 2026 at 01:51:05PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +static size_t ad8366_pack_code(struct ad8366_state *st)
> > > > +{
> > > > +	u8 ch_a = bitrev8(st->ch[0] & 0x3F);
> > > > +	u8 ch_b = bitrev8(st->ch[1] & 0x3F);
> > > 
> > > GENMASK() in both cases? But I don't see why ch_a needs this at all,
> > > isn't the 2 LSBs are not used anyway?
> > 
> > Yes, I can adjust with:
> > 
> > u8 ch_a = bitrev8(st->ch[0]) >> 2;
> > u8 ch_b = bitrev8(st->ch[1]) >> 2;
> > 
> > st->data[0] = ch_b >> 2;
> > st->data[1] = (ch_b << 6) | ch_a;
> > 
> > so no need for masking both.
> 
> This is better, but let's think a bit more. The data we put seems to be
> __be12 (yeah, we don't have the exact type for that) and can be put slightly
> differently.
> 
> So, something like
> 
> 	put_unaligned_be16((ch_b << 6) | ch_a, &st->deta[0]);
> 
> should be better, no? (Note, you would need linux/unaligned.h).

ok, ch_b would have to be u16 and ch_a could be too (for consistency)

-- 
Kind regards,

Rodrigo Alencar
