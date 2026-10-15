Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D7515894
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070067; cv=none; b=Wr32iZ4OMpeFssPprWR0Phv4FArm9YIgNZBwdo0vH4vWzmF5F6+RduwVOKdj6Wb3RQWYFQV5EfFqtQ8lEUAaWRCCffy5akI9tg4vDxFBTCRPzoNkyPXBmvOQcWnoOSIgUx8ECb6Xes4eeYF7y8PKtqC3DGSIEQer7MfmGdlY/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070067; c=relaxed/simple;
	bh=vmh2K7iDtyJxcr4e+vs2mwwAuQGJXmiU3OYpnbP5Chs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCSSFS6ufp5OHWUqRlgRTEagYS9Ragbuma8MjWb1cYpjY8jT4VCDl4g9bxPxIjQplbdz8qfQaiO5OeqT4QsyQ3KwM3uI2Bu6SJtTT2PfDZV8kTOs/J3Of5gB6y57whC7j9QdAO98Vdf2rqqsjm+idF+dM8gSyhI+cqslf8w957Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJtumqmD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJtumqmD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so46174275e9.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070064; x=1792674864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DKGlkemdch/mOvhFiOVD3G7PX9cRJidAty9RrIvsrsk=;
        b=HJtumqmD9S7QmMzDvYc/V4LbLJ5aDxgUJMykfEARGhq9PHJrlt7Z73uPiMOAWb5Ahs
         4Nzm48TtBhjRHAO9BSwtOXHW8ADrtazaeVuT7dY/MI9mZJ58SYDQJ8EN1UyVf5lMUNHY
         oh4kf/wTMBhAruSvk1GatYvZvUcRgoVoil/foT+qSs+9fs51kcahPfgCohPS91KOfFD0
         pm6fbtaUdpNQF4Zp+4DibRIAanIvgSU/RhQW+lmlbv7976R5PQMj3TBiY+dG2qbQvsEy
         k1qGHNMSVlzdyQfdsasyMs0p0s4l9ksSXPw4O2OcxQZEbjvOVePXixdjeMdBInLkca/3
         d+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070064; x=1792674864;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKGlkemdch/mOvhFiOVD3G7PX9cRJidAty9RrIvsrsk=;
        b=DtGgwgJUrhgnGYtLU3iGpdj3webg/0nVqtjfEkqdlk9HqL/o6gis1weHAt0kyNbX0n
         TMDOgU5006yCT8YVV+cAj3TH0O7TVrVXy3EKIJnuU9TjasB3cChUzH1ruLEZ8HxpVzEa
         suEsVkT/ybl7P0WoSdropqDu/BJb8AdUaHuaZGFM6YCXdDKEDXyk4aNDTSSlfuchbRrI
         qgk7zq78E7pk9V0sn17ZRhK4UwVYbAjsiU5IioCY2CFKXhPIeLLD6t38HuHATd4gGJOm
         SFKSKNqATwrnNWh4o2RR/dNbGcFKBMShluQl0OjXwtMR7vFLas6pUF9hW+Gm2kF80lTH
         2hWg==
X-Forwarded-Encrypted: i=1; AKwUvBzz8agfBMPqxG6Rbe2MKmRd6IwGNpYEKa9Xvk84MbMXEhI9H2jPOa3jUIe6uTM4RQbm9S8J5XuEx18=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmd0f2VAm4dPl2kx/aVcIE8PfpVphyoLWCfaReogZKLtQLQLdf
	Z9iP99cz5pgm0sOKs1J+Ca3FKIeGgZ2vpsqNW/P0oQj/ym9EFm0C9xgt
X-Gm-Gg: AYBFou0wEvgHdXtiTjQrty7l4GHL45ZYvswwts+dop0cK51TB+JTtYtqWT+D5240d09
	YaNP1rzJCGfKrENiP8RfeScFDUUiAoHJhlDlej/zPeUG9lzXksCsmgr4MpoRYf+y4Og/dZFUncY
	U6jLGoo/OUOQYw4rhJnp6hk5Pa8nmQ9/t4rS0Ey1JY+Z7pVsrY+GHK+YNBywggYsqWWmu+7/cr5
	tiJpQsfY4ZAiOEo7R93NnAKQ5F7cZ/dicujuWF7pAMjriBlWcaGB4Mh8TF6xzKZGGcaugBpBQcj
	CSib9/eVqfSmWu4k1FSZ3e1+zl68BmsAi+bJyc+PCnhBbavMGHd6DVtLdFAJeAgi7KVvfNzp8m4
	MUSyEYVVSPTJIu5TXFUmZdkiFUaIbxw9JHRKWqswJ5ZCjFG5XR2TJZso6KHHurTiWn7z9Rbd4fr
	di2ZN+xoAM8WQIUL5OGpYtf5vMs9+NBDi1m3A8l1Uu4pbggJAmnvPeKgmBhhLOmZBdHYpAiNj5r
	Y8aF+q9hC+n1uVYDiUAc16kyT+nSOBqSGAwgcxfPYcNLYQPc5OleHl9zhpEf1ua3/DLIcSkrfVR
	jFjE9LlAnGg5bpqsyAnP98zXiWnjKIPtsodARZa4w3HF2/zwaNjIxgf/wK12PPX83+smDEWb73B
	UMxFp6RZLZDaDCnfsdGFFulliA3MOF0jsfb1vhA9ATyGQTCex2dFHUObkDtdQ2mP9pjsLcZ5xEU
	rfknZb
X-Received: by 2002:a05:600c:8b58:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-4a18e4ca287mr353914885e9.24.1792070064296;
        Thu, 15 Oct 2026 06:14:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a15sm70210175e9.4.2026.10.15.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:14:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:14:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Eddie
 James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: pressure: dps310: add an OF match table
Message-ID: <20261015151417.00001171@gmail.com>
In-Reply-To: <20261015104945.2687162-5-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
	<20261015104945.2687162-5-paulius.zaleckas@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 13:49:44 +0300
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> Devicetree nodes match the driver only through the I2C ID table fallback.
> Add an OF match table, so the chip data comes from the compatible and the
> module autoloads from the of: modalias the I2C core reports for
> devicetree devices.
> 
> Assisted-by: LLM
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
