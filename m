Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66639345CB0
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054751; cv=pass; b=kMZP9xe/G8KdtETBSLtaCgJ5KITKAZOFoLq+/qcB1A46DOzoxNWOXD8x9tISh90DGzA6nIhJt9cIPeudYNXrpd09loDtOX+j0g6/qcn8nXSmEsOoL1b2RJ+OfquxFCXKUdvrWfP8w6ia/+JuobOy8d3gR6MKlX8Q3BSxClqvt2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054751; c=relaxed/simple;
	bh=7X0HWaDEMXTJbxNVhGmRqfkXcMNrU8YBWqOIINDf4wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX9QDUlYX954qC4TFs3GOglWNzaZ+oO91/AHvbsxGoOrnQKBfJ1MgV017XmeVeAvLZtFRIIHWGtMkwWbMIAlk/nwXq7LUJGVJPSZxGQSGVXtQvQoBvimBKlz1niAv8SFOEnpWZmX1ayUJw2ixoTqNrGYqNH4oOC40OOFfhCpAS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2EHmDSo; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2EHmDSo"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65005a8840dso7031645d50.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777054749; cv=none;
        d=google.com; s=arc-20240605;
        b=IN8AHNYcJTdyaSnrSmpIW4iZsRMs8CEgP0ubvoWBOEqwO8+dmOERsUJd7aC+P6kBIh
         ExHJEUt2ZFdDM1GcYyhkdoas+tb9OGSssZIMSiEDXUXkcR6C4hC+ljeTZY5wqvD5NMt6
         srKwcm2GxwUhgT1Zg0Qr/ePNy2xFTWFYoLMPGgcBM7r3GPToeER6g+hDcCjjG727yMu3
         izNJwwBJNM/d01CFDnEz76hv48N+xFIXoAU0Vq0zBkxf4QnwGkqW9RdTg2MxWgYZN/9Y
         Khvcq1yMRQI7Jzt084QPbFl/T4GaIhj5vaLpFoYY1yce90sAsbEs05e8E7YcyP4Vy9jn
         Yc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lWmtpTmT1171ChEiq7yuvzgF8TbRHxTOBMQ4oftpis8=;
        fh=yWy5vIovXYZWNwDTE2DvllSzxhMlJYMQBN07yqvyZaA=;
        b=B/EAK3+6l6ech+Y9mbs8jJMKneIs89R0cuqBuPf6REFadcRAVf1bZSGieUhYR9lTP7
         0ScCc+Mn/86vXXOLl/GzgBVjejk4KQ1tcHvnEX0i/ooHQCUmVyGwCkrEPBT/XG+j5BRi
         VqlJ2vkkcz/xcgHpnQ8bE3J433e+ISu+RSPRw8K+3nyNUa/dPxJh5d3ZUCga0/4bqjsQ
         mKGjyphFKt23zAHg02Y6peT6FZN/Y3mhofg/b7ToeWowpLrgHZTd4tzfLonR8VQXOPfs
         Z/7I9OOSUWowStXsLQuK8iqno3NaCYjOBIY5qh73UTkRqOddQEa0m54Q3eg2vrImJ0mK
         DsPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777054749; x=1777659549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWmtpTmT1171ChEiq7yuvzgF8TbRHxTOBMQ4oftpis8=;
        b=K2EHmDSoFHzRU2wVGP/neS2Ya67sjFrStvodQ1vg8XhsJ3ZsdmaIT2YvUvv2facd3p
         SgN+siYB2Awg8Wc2bx3BfDVYbE9j8wehktMUa76Kx/6WhJnQhcz0dVe2AJsKNpQz+qqH
         RAEwldtQmg9Qsy+CrVmWXfPkkqWtrLoxVm2ypBPYuL3tXpbzV3dsuS2BnkjfO4zsurt7
         1kzBuAU7Xluq0ycRz63J+aJ+IOL5SD3+xs8ii4DZV44wvfu2gKgwsVYEX0ZEOaXAcYCs
         vlpYsSu3ha93+7QoibpihdvtVecusnTZ9h77G50mxs48j5AQeAZJ1bzFEdbAFrdy4EIk
         OUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777054749; x=1777659549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWmtpTmT1171ChEiq7yuvzgF8TbRHxTOBMQ4oftpis8=;
        b=pPI7ADPtB724j0urmoMCJ/7/+89uxLxHpOQ0EW7zWwZruVZq8J/1lC7HOFItKs2KT1
         UnWsq2P+nNQWelAqqPka/fRCOmc9uoKqsckNqZr3HX8DKaekh6l88ZNgDy9d4SYXSRQa
         4n78Z0R3aLJyP0QStIE1bAs0sxNIlP+aFFAUMUKa0GDStX0AzBXXueNkQHus7dTUZzUJ
         pvuejvVNPkaoufNWwYlPLAl4tzVezen9CJBxqP9HxjrvDfqWQ6Wh3MjYhV4xx4sVb4tT
         j4FqjKwQc6EBHRqIbefh1UBHCk03e4Du7/afdJpnlTqomO1xHgSlkEz3R7FVSYO74N/l
         wWCg==
X-Forwarded-Encrypted: i=1; AFNElJ/zkuedZJ2rWIEEDQD4FV16AwRpYHXhPgrjX+kzGPS6LD3SswkmTMk+OTJCwfYjF3ijA6zGX/wKZZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlTldFisR3Vc6wdrbqftE/nf8xGmm7omrZEa3MLd2xEqt7oDA
	1KCcJOhly3P0cE4keGJcDyiP1cL5tl1AdZJRFuBj7G8FzMWkcX4gdRbd/MpOoU8Be2R4bSJKyYG
	lE07O7aRA5joONz3FTmwLIwTshQSb3CM=
X-Gm-Gg: AeBDieu/jG/MiB5iyOO8KHvAOuqXR+n4UTS2bWKN+xI4FBIs9VhsHVujqNd77b52REs
	VLQv1cgJLkmJ1+MD2h233JiQaoTzlStkvKyZnDSium1msCV9D2w+6fb3VnFk3Xh8kjSrooIl8sd
	Qq3WukID6Z0bmjw3kerVAWM1mQh7BMgRfXwqL+ePPUeWYaqMEt6x/khPr/Hoh7ZsD65iIoqUYP3
	pwlYwW9jXBXn/W1NCw4y4yl2Ou6ZnUVAqNmfUs4JDI3S9bgMN9gvAleA0MSe/ne/300QEWvCghv
	WE56zq8iITlbJFhJ828f
X-Received: by 2002:a53:dd47:0:b0:651:c483:1d3c with SMTP id
 956f58d0204a3-65310a6dba9mr23888201d50.44.1777054749179; Fri, 24 Apr 2026
 11:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422124505.8875-1-m32285159@gmail.com> <aejE42knD_s5rsGy@ashevche-desk.local>
 <20260424185327.66914793@jic23-huawei>
In-Reply-To: <20260424185327.66914793@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 24 Apr 2026 13:18:57 -0500
X-Gm-Features: AQROBzCQ1q9ZOf42dCTX9SC2tVrCXZj3OjQQuAoBvOGFDw3EgyN9gxjSgWnLpJc
Message-ID: <CAKqfh0H3JZZtGR2pWCn2vh-dWX8=dOkVT_3iOJ0eTPe8jDbZmQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: proximity: srf08: Replace sprintf() with sysfs_emit()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, ak@it-klinger.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> I'm a bit lost on which of us is asking for what and can't figure it out
> from the patch history.  Anyhow, I did make one tweak whilst applying -
> I think some confusion occurred as I don't think we'd disagree on this on=
e
> and you called it out in an earlier review.
>
[snip]
>
> With that applied to the testing branch of iio.git.
>
> Thanks,
>
> Jonathan
>

Glad this patch got through and we got this worked out. Looking
forward to contributing more!

best regards,
maxwell
