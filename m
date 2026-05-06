Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFF3C871B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057171; cv=pass; b=mp/ND17JixSHhmc8jRwMB+4j8yhA0KHHerqEjFqytvdS/YF+qCz26jY/ClKBN8TUnt25MATwGKsurM6DlaeS/6n3nnoD73IVIfOUlQoYOt/y0NXgAz90dLFlVkJZnUqEYJoC65biCVHONFC3DP+2WZFsIdd11Y2Ip39eyEnZppc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057171; c=relaxed/simple;
	bh=wZQzRuCzVGn7zkjqEEs4ggBaDQmcGz5kKz+cb6fUhNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0LmEfbnzPLBrCKTuz793I0EpzNAfqQneXnoQrnN7B0sWdNr7cAOV9bOdETPndsWuwp6RQcEed+nj5Bwgx0S+tgzO//y8fMUngpDilHkBzaqTAJwms3SAZrOwhZPlytEwlx0omzBbepsXJV2NjmcUnMqWRwHgEsbi1Pe6dRioUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFJ4+ZID; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFJ4+ZID"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so87823225e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 01:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778057168; cv=none;
        d=google.com; s=arc-20240605;
        b=RVY/ay2jVpKrvDCQDUVZfiMkGCPIJ6eQmUvYRw9x19JPWhAvzrzmr2mHdc7QvBg8qM
         8U3e0ZjgS1NkMAfYLTp9fprpbEOR0DdB8rzuycyghi8qgyyush2Vh9z8QXBYmIuITh+I
         hwQzghEj2U3j+0M/dIU291RQjUsjtitkMf/Om5KJuMjfG7yEDEZmMFtlTOxoHHzzqpIn
         kiifWaDyl8S1Mwqkh2naw1HfuGiRqOewf0gvb1EjbJnkoYYc7Y6jLL3oJznfzQlIPln+
         k2eaHMNLvNo9aKWXeCpQbTbqu9ill52pERsoQdAdUHrSRu9zekoVHcKjAqxUntee4NZD
         gjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Yl+utyi6zIKqjrRilcYIHnZO2RHPkpNpGfFBZRzGQ18=;
        fh=OL8cx/SR0l2Uk2296sZhAvrM3M8+VYAyQdPC3/twan0=;
        b=VVFDOKYy1ceDSeKoT+pzRxM21+5Ndxmvq08FW4wjI7VqaEBI1jqpw546DewlmVJxOc
         ZK1diAwaJE94LQSnLoI8DW0yJ5UzdjwyI/Lm8w4//O1l3Gl/ylOjAFcNmdKeOl2IZrXf
         RYjLSKpY4EAJrJnG3PuYRnwizCAbghAopcckzweyV5Su7upcFD+bgoqk7qMN0hYvGk5k
         dlPQOtfbl8oZFSsCkVWEHiMCk7LF5g6T/6AnPgFd2wQ3fRdavLqtsgedCBC55f+iY98k
         hwq91T5RtSFJk8jmXA2RLFdxIVCCP+pcjgqXhZYRdgcZ6uY82+doDXE25XaBqU2lPc0y
         726g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778057168; x=1778661968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl+utyi6zIKqjrRilcYIHnZO2RHPkpNpGfFBZRzGQ18=;
        b=oFJ4+ZIDvyRDjMDbGfxIf5HrH85fa69ZgiRYbkwtMhnXYH2BMc1snGtMq65/0o4Mla
         ngVncFVGPhnLmM6BEi/fj9mwzSJw77NJPjIjo4tjsh1zs5pOGY3b7DaC/qMRbEq6sPSu
         K7VwD45dIWSxCLhaKU+ja8lCaK4iM2+EGFA+ml6WJFt+g2cUo28XL7K165YRnXemrA9R
         YN4vrbNSKXyZumHW1jfGizLRD1DR7wxNz9HnazjJdXi1qV7kZpgoMInCj6O6U1SidWfQ
         PnKVeinyvIfF/6nL16xvyDwQUntqhHXjX7y96rFE6i8v58kDCITWUijex1WZBod63CCq
         UNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057168; x=1778661968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl+utyi6zIKqjrRilcYIHnZO2RHPkpNpGfFBZRzGQ18=;
        b=BCrp5xuM7/gV8tnVODaDxi2x7itAt4oL7XD1ypNCgUE+2uxwHvANjBSx171AhOu+mI
         g5jDjHK+lpAWiB/qazEh0hKJv8Q5BD5YImtq1ogYxa/6Rtovo7sssXXCoKA0bJQxrRd9
         WsUHplRfCvc7R6kw26Xk6GGr9kI9MUpyuFOtvEdw+GOaI59YSYJCwo5Tj7AMU4gWlltI
         pD9GSXY7+SrmPb2mMF0OLAy3CVv3hhUA2zfhMIWt01mkhaW8LLxwvqqq77akOuL4FhMb
         V6Ob2Y17o+F4nMPqzRJ+hPNJ16zmk3r/+DVJXQ2GSPKpKvOygulgK7bpSN8c8+cUQ2i4
         y1DA==
X-Forwarded-Encrypted: i=1; AFNElJ/X+Xyq4DgY8xMKmtxGOCgIakQ0QFPjupERQUSPtm38LHjdpEpPU1zzK8HyBv2IpcWVQiJ4XIrq7UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXX4BETzNMJx5a5g0I6TkeGgUDcJA6x4KDqo+5G1Jsz0QRyWEP
	exyxW036cdwC9GB4PC+p0XBp5RQD4M4+dL1TRLQ+cxFa4wwG+RgVZpg14U9U5rRRoYqvX+F7xiv
	AH5F5q+Xrhg5iFxsXNlk2bV8kuRKmyKk=
X-Gm-Gg: AeBDiet/wtZZjpvycr1cAskzOTQCyinPdfGM5oINbMp9I+A0HGcpNfPSQr5QgY177XJ
	lb9GDbCCldET3mPNO2zYzntMwxD7tsBvqH6SC9s+jpg03f9+td572TKGqOzX7EjU6t6M2IKXqNG
	BVGLIHytxx64cV9dh761A8wdsEr4g4XR07RyvnpmPPLupBmeq4BXhfotErNdlW/F+tzoCkB6dPy
	vS1ANUxfusStfrJtOfdlYjkKavBiqUtmsotgriAvZHxrJNt/1lGokfsRDYgCUZUvW+mHi5NqJoM
	5CYkCc1L4BuNLNiAFDi6ImUaUGlJrMqGkm+X3NloDP5Grx72ANfPIvCidMSlOUpwLYZ7dVpHC63
	vjaXI/DM6H8iR86X1845kwazNAn5z1kgVVLCh3hn/GyTMesPCECuA7hEs7aj7HG4jp5y6OpXbwU
	55Qtkfd1+5uCQqEO5D
X-Received: by 2002:a05:600c:c11c:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48e51f46d48mr28969325e9.18.1778057168171; Wed, 06 May 2026
 01:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com> <afr8ibUy8lNywq-5@ashevche-desk.local>
In-Reply-To: <afr8ibUy8lNywq-5@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 10:45:56 +0200
X-Gm-Features: AVHnY4IwKUOyZV1YnUJkrkFu2ENt6jwhIZ92q6mD6kWJfpJB-G8kz-tNviZ8-ps
Message-ID: <CALoEA-zyp4fjF03hn-sH-jOeSmLCZoJorVts7JDNp9rqv6p-4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: magnetometer: ak8975: Add missed
 pm_runtime_put_autosuspend() call
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 10:32, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 06, 2026 at 10:27:55AM +0200, Andy Shevchenko wrote:
> > On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
> > Balance it by calling pm_runtime_put_autosuspend() on error path as well.
>
> I hope Jonathan will take this soon, so you, Joshua, can base a new version on
> this one (otherwise it will be a conflict with one change).

Considering this is a fix, I'd say it will be merged fairly soon. I'll
fix the addressed
changes, and then do a rebase once it's available.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
