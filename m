Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F083346ADA
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782066789; cv=none; b=iA90rHWdvt8Tkp0jA7/mRz6Jj2bSsyWGhKbUftu9rvPb28AmQ8Gp6r+olhID8ES9/K0BvBrL+lG9xnQhEXAzHBtqGni7w/Wpe38DlmJdTRRzzjQs4+nUaqvS9IU3lW7Vhue5LFcgcJBRtEO6X/la6UhpNWDwzNQXdCvx57lyDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782066789; c=relaxed/simple;
	bh=afy8gHu2UvcnSrWZy43cE4WQezTnCjkao3mbOBuVfwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m65Bx4urBM50d8zhS+TMY4qtAmFmnHxbOPD0awSIqEOdpjx96fJ+8bB52dvyZWhDmxQaw6ED5aTX1KV31qrYyOLQrHQ2XfFR8ehc7g3or6J3SCGQjpkVU01DL5vxCus7M3S7n94uQgD1Kk1FG19w3EYUccKTrhXAsbmSpvlfNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYBP1+uX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYBP1+uX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46255b269c2so2743223f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782066787; x=1782671587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BtFcftqMIozGzWy6CXRRwSzUeTjhCeJaK6U+BbNRPM=;
        b=PYBP1+uX1Hg/28OGJoyN6onBk+NOunEB5NEFx4fBFixRHkCSmLWFMjEZag1aWs7atQ
         43G4T/dRxQa8UUJFl2zYsvA7uaoBUTxy+J7bCg5sMLFer+BLAqDmL4N6GYAawQJL7NPk
         wUjZ0kafa1+5hCAa7Im8/I+J7zYpJqTnAVooRc0WI5ez3uOt1I7swHJGnucxNTRcudCT
         AuJUqvWx6Wre2ZKzDeNTnnqgViJAQbWebxTAzSVTuT+gWDFw7XRQvrsI+j2odZJZVSTq
         IEsXA4Z1rFY4bAlgZTXQtAmhaT/6OUJDGsVtaP/kenp9jnz58yFqxiyhXTUG9yKWFf8N
         DdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782066787; x=1782671587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BtFcftqMIozGzWy6CXRRwSzUeTjhCeJaK6U+BbNRPM=;
        b=QiE6dpdG+yAy8YS/2YKpun0lYEmnAcOGH01o490xuxMB4vSysikwdQonfwsDB/vv5S
         JG+F/YSuHXflkq62MVxJq3rLY2R4CR2xWMwsgyNbLxE9JnKHqnSqPTPEvR2fLzBnBTjU
         ukHTKcjSAMliFeHIkIfy/RwDYcXBGySWBirTDfffEo7PmdBoVhDJ5VdePRpAiQJV/dcL
         JHl4bWKodpigGQ2x4QHkErsYGdr4nf5VLZeEbL03q5RDfrC2rFTW58A26qmAscwSdnxU
         Ij+flAWGrc8aj/kUTRxNnUCWDgyDR1LGVYj4dGPD4olah36olfRKxFhHKVOIFgdIsb1n
         K3TQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQKNYpKfDt1dXio9nACJT3K63e8EI2eHd7bIvYl7kgESdX++3NL2KLU9whl9yYeiTaEJW8lVdlntw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ryvYEfHQrYo24cqrWljGpVQnk/UYJlY9hnKxjg20d3nSmSnd
	PDdQpYp/YWGvCLIBYZXYu9qAgXRP01YQL+vurYvTt4Bx6wRPqNBKrtzs
X-Gm-Gg: AfdE7ckmV8+bCXlPrVFqYAlWGw+hlGNdbTalgzRSM3a6IC6P9JnCTMKAK42PKTglTXJ
	0pxqPxAq4RXpJZcQhqvVANtDW4JFwBYKu+s8DPVS77rA2Lo45FVc7cRG9aWm293Pu3bI4cvsOsd
	m7WNjLPPGwdzw+5VcWAJ++EG12T1vNosJS1B53hFRbdT5O+Jdwq/OibxcAJ8N4uQxwoL0aDCjK2
	hRIl6rS7CATbfTpPJNfAHthe/cizwpld0kfciYpZROmtb9jcNH8vs3TqPPFYeRUi1znENs+bSxv
	UCCg1zGajLQhTjw4T9007nKIYhV1lX11SueYRa6dSRR43OHXzkPER1RvcSKCxGxEylJc/Jz+6QC
	rKO+hxoStctxD576i/TVdsC3jJxwr7TYzHstx7dlxnrON59BpiYe3wxw7YCsapwd+94BlpTXjVL
	3sAwIG55wmVgvXFLRGkvWKwdUy5B3GDwrAZHOQS/YCV0h95TbigmxSYW4upDyPSPY/+rt+olzvI
	HhC3jkCeCvyB2XAbSO3s6RXPt8EsANwSHL2HTMfTSFKHLqnvV6aCrcebmGnp3ctXZr3jik1RcBb
	XUJbVw==
X-Received: by 2002:a05:6000:41ea:b0:464:5df5:332a with SMTP id ffacd0b85a97d-465026e230fmr18615319f8f.34.1782066786621;
        Sun, 21 Jun 2026 11:33:06 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f563dsm17228387f8f.3.2026.06.21.11.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:33:06 -0700 (PDT)
Date: Sun, 21 Jun 2026 20:33:03 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260621203303.0f8c5d08@systembl0wer>
In-Reply-To: <20260621004626.66629-3-m32285159@gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 19:46:24 -0500
Maxwell Doose <m32285159@gmail.com> wrote:
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/i2c.h>

I am a numpty as I also forgot to mention a missing
mod_devicetable.h header.

-- 
Kind regards

CJD
