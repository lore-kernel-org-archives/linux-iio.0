Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9538343D91
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120467; cv=none; b=YVp7zIpSKVSS3QOCHljDbCacYnOP9fNTXTBVR6truAAHKRKphc3wxVK9AC+KxXaKCYZlmT2EBMEg2NA2ndYqaBNDVY8N71iVboqYZgBEqUasJJystX6WDJRBag+LcHkyFrWFHDXYLRQWdydF4PK50ctFVrzrE5MxR4z/EeP4mM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120467; c=relaxed/simple;
	bh=QIVhtn2J0BUDxrY4uRHm2HVbU05wclPQpDf5Vk3Gr8Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NvCKkD7uwR8dQWazHM2vrhCuINUDewKHM6TTqHdHsndvHL4FdHvnRn43nfoCXp4qAPvK/bVdNhsR3VzNTCx8uHGXgX0gviAfyZ+/kF5PyXHp1HcEJUrObgkVihEZ1Sm6yDMnmFBFZ28yZQ5WrqQ5X5MFTQ+JbsZcE3PKEZHzqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7UHDkTt; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7UHDkTt"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-559a4d6b511so230901e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120458; x=1769725258; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlTioEKk9FUswlrdV4H75LqD84cfQHLITNlV8YyKgDA=;
        b=B7UHDkTt6O4ZHheRgiVaSrbLFCzlnRlwhp/dr16q/LZ0jy7iI1F/uzdBrAI0L4emka
         1wL1qS78jdEC+Fu8UAd/1Bhl9LQykvFh9FYV9cus/xRMAVd7CwMJa7Nzz5r8rgC3Nrrg
         +y9IeU6NA6FVEIGeBMTa6pJecGh000qp9Ax1JeITaTKJJemC7m4ZiRq1iPZRY6mNzZVl
         loK55JbrzW8ZnGkliC7wkI72fe9oAn0wsC8BKfwf0Up7MC5VhwPlM/scE7h1qwcLlBHW
         iqhMoTy0JJbpj2GQv2j+++v+IgABlLRrAhjmZpSVDYzQdX/g1ANwbjXO9UusjBymJF4c
         qC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120458; x=1769725258;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlTioEKk9FUswlrdV4H75LqD84cfQHLITNlV8YyKgDA=;
        b=pmJWA/EjrX3cYGOWnuRhN+Q3opwSodmF9Ap61YaKaixaW6jsG5kp1fVACGyef6rtTH
         fNfs1y1Zy4yLF0QfCeumLyHiqKh5J/N7PFnXPT99+UEtc+mKeGlTVolVvrprqG98l6w4
         s3W5fNs2u2IZt1CuCpFPLCddtXemXXrLti5cxa4LBKWBWqz26z0Cfgb/mi02Tv26g/MT
         JHB1rOy600uwVj7s0f5oMt73DFv1RvDaxl/kDHCbW5qOgEmGXYge2nSYjYipObVa6qQw
         EbVJioYLpnGE4d9CZPbJpmFcuYu07hQpA4S/ZdRxRPxBHdKHbTPYvNN1LqhX7WGFdULW
         vIxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzWkg5MKKdZl+/7qnH6b2rA+D7aiFKrGrmsBjhm2fgok8C5LnD8ON8h18DMyYxCKRlBh8A1dWBRuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvrBB3QVCAagdEGFSfufBEau34ZR169yrD1GwqnKU6RxtkTu4
	p8fMzN87wRBbKKIcTYSsfyTE4MZeZrvxP8/c2tOeAnqaZQKGSK+Wj1eI
X-Gm-Gg: AZuq6aIGHA628vkQsBIopQdc5uDzrujnSkHZ8jqwaKqPhOrG/H7o5NoL1U/tYI8O/9b
	w5PK5LkrC3dxTl0wvljHKB5t9wBNFk0y7fmbcedrTh4EolF+0Q1/Wd8Ji6w5uL0C2E+DUqr0sWZ
	jY943C6JXCunYUrlOpZLiP8iZb0XwLmljtvq8CTmwk4R0cxjiceb+OEXt36iFVN6auJ6gZ5bpy3
	BA49Zeor9kQUnw0BPKq6ZbNjcoOQtIYJM+Wpjow+QGRWIvjXjVTefwmgJPh/3VgeNhVqtYTeQRW
	JEKUPikrUm183pYCxu10aZBcqkB3hNRjLQfLy8NAxunE/EonjxD3Y2dOKbkn3+akKUc82bSCHi6
	9swzOHWkR6rrrNMN+1xAnfh1ktRRdzZt8R4MWwT+kI00hWu63/6ZWbrjwfr6gaTU2VAiV4jQsVC
	m1UWlpYMs=
X-Received: by 2002:a05:6122:614e:b0:559:6663:8b1a with SMTP id 71dfb90a1353d-5663ea668b5mr328984e0c.4.1769120458447;
        Thu, 22 Jan 2026 14:20:58 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:c903:2904:3cc3:8b4c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5663fa6342esm171468e0c.2.2026.01.22.14.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 14:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 17:20:55 -0500
Message-Id: <DFVGV1BDS81K.3VWJ5CAO37A1X@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
 <20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
 <20260122190401.510234c4@jic23-huawei>
In-Reply-To: <20260122190401.510234c4@jic23-huawei>

On Thu Jan 22, 2026 at 2:04 PM -05, Jonathan Cameron wrote:
> On Tue, 20 Jan 2026 01:20:42 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> In order to eventually unify the locking API, implement
>> iio_device_claim_direct() fully inline, with the use of
>> __iio_dev_mode_lock(), which takes care of sparse annotations.
>>=20
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> So sparse does change what it moans about with this one in precisely one =
instance
> There are 9 false positives with Al Viro's updated sparse - I haven't che=
cked the
> original one recently.

Hi Jonathan,

Upstream sparse is kinda broken right now.

I'm not getting any false positives on the locking stuff but a BUNCH of
"error: bad constant expresion" on MODULE_*() macros so I don't fully
trust it.

I know at least one subsystem maintainer is getting these too so I guess
it's an upstream problem.

>
> Anyhow,=20
> drivers/iio/adc/ad7173.c:416:12: warning: context imbalance in 'ad7173_se=
t_filter_type' - different lock contexts for basic block
> becomes
>
> drivers/iio/adc/ad7173.c:425:9: warning: context imbalance in 'ad7173_set=
_filter_type' - unexpected unlock                                          =
               =20

This one is interesting because I can't figure out why sparse hates it.

>
> Lets go with a bit meh for that and move on...
>

--=20
Thanks,
 ~ Kurt
