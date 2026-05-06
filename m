Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0D2EA749
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051244; cv=pass; b=A/aAoeQMv8b4+R500I/faepMstC1OsqcKc9pZYSL9e32gOCd23mqqqVSl3rwStGyYXn3DVzppBpXAUL2i1O67st5jeamXvA/gdR9ZPm7ajFHN+8aM+366EBgmoKyEXrYll1zws/8zRs93pF1wIrFKR3oOZ8teEC8VWduDO9np+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051244; c=relaxed/simple;
	bh=hPm+0mA8hVc68H8DYpxIBcWTtuKbfwzoevixyHB8Fvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbabQhV+IUzoER/idusmDppHNpz8O2ppR3Qtu9uMEG0GDm1MB2/DjyAFm6bkluc4bmwlrq4cbwk7EvuqA2yh6lw60BWTsKvLj/NCBcPjaao7j+rzTllbPtLbATBkXMSDDbokgNClJ0ct625BpG8KOA1I8IcivAmMQpeIs6QMVnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rl1qZCWq; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl1qZCWq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso71260565e9.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051241; cv=none;
        d=google.com; s=arc-20240605;
        b=e+WnHcFRcaNQUzh3eXYck9LcXYjUOoQb5hTrVxOmwK0FgliCZiRh6tXfxBkvatxJ9k
         AqE0drvsWHPXFDKVYRl/mN5jYUeqy5lqa3rx1buCucz4f8+XibBQnIMt3zdIcYP6cq5h
         4+EEpAFAj71ms3PFSiNtZmWTaVkvF1Fs+TH6bscSg/QDRWtE5a62scYjJmGfWnI4fMO3
         bgJhXnH588XsJaQsFkPgsVVU05nugHk1Jxj8iLQ+KVCvxE551qil0JeLpRV9rUmZS+Wg
         978wn+kkk6Ftp/WKw6jGM+fk1wiyARev73Q4Bk/GrrR6/ubmy49wn8Cd0XSCjpgQ3CxW
         ATNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n3vlAlljb/IwfykFQ6Z5DATCtg+qRry4cWpqGAbGZ8M=;
        fh=SAm1ZqBVw5Ek7g7JhGqaU9fFUoWYHS3eLHHI94m6Sow=;
        b=EDIosKOkPFnTTP2lXJ0Y/1B5df2/EVM73nz3mnCesYUbBpw+Er5bNZKiQr/jl5JivI
         2UqflsnRKMF5scqNvh0cZm+M5FUY5in/M3v6oD++kGABUW8yKSTwVDgtO2MD54KkDhLj
         /uDE8t4oixTOZYiU0TUuZONvsxtYC8m7Y2TDK7UvKihINgkLYCThe+XipWhezmmL1PNI
         Mb+YABXi67Y2f+QmNHrwBNxL3qYWH/mKCwAdW4w/q7mWo+y08Bt2N+uqe6JsMn99V8ik
         W60z1qxBFXXBln5K/ZETaRAEaVa0IOtgrbse2aOTsIeOcX0vnHG6buFctn4wKELTo+ez
         /PZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051241; x=1778656041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3vlAlljb/IwfykFQ6Z5DATCtg+qRry4cWpqGAbGZ8M=;
        b=rl1qZCWqZNGqJ7B5U7l/RerZXV1vEq26qpJvJHQAt+Cnw/8NGpSQaE2isVYzMbfjBC
         CAY10SxZ0pssYJFnR+zHrAnvdobKnBy2PsLeSgJSJwFoqgiBDgPLBDS/bv2GdCI7EzpU
         /hyCYuvc0v+hv4UceXYmv7AVevLo4CeAKRdr7XGOzbuZ1B7BdiXlWiAjpT7kdskuYxQj
         rKTjjoSqvLQaHDW7cajeV1jmruMd+HGnNLv3zGDwI4UH+PK+Pz8/iNz3GngyobBrYMPq
         wXQ8o8hgtMHEzjBG0K3Z6TXseFQPvCxuXVJ4RAbtQpe4uQ9QsFNvE4NX1V2rAfCDJcUa
         S6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051241; x=1778656041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3vlAlljb/IwfykFQ6Z5DATCtg+qRry4cWpqGAbGZ8M=;
        b=Ts4QpwPoNmsSReWK1Lis0POYEttYqpneYVDAXQlQoV0qTpZtUFoY2tagLgP3KFbp2q
         7ynthN9hebIog+TWbc5xcf4yuIAi1vfsYWGziqf0CPuXycr49uUY4VujSJ/CTUu9O2gK
         +UfVyOU/7y9zWRe8FiSkZSBsi3txgw6SldjZsBykdE99Em/+e/yXupqkenoCANZ6+2vF
         6w/MCm/ax1DH+YrN3rgNhQklvBA/prbNOITHtQSpIEYAfmMjHB3WikWwMHU0UIjnfF+u
         G6r40PAKyPnZ+AWlMO+7PVXOz4dxPMC2oieyVHL3S+AEw+PSSxwOBi2TXqipd8Wtw+lT
         5RFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9goRYWJdqhwbGZmoIH5bFfEAhhi1tNAt1YnqH4JN66i6DJdNPyJr06Z2aLFRfMa/eEno+OEmAF/SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTB0QXQCygd0E3W7uUUBS+vE9UWMe6z8+wU/dVw+H/r4jrHaQ
	yBMwU6w8FcV/MNFT6Cj/JDTFpnFTGR0movnE2YGxPcTK8l9EIxJO0Ojd9JLf+NJyMhYCKqk9WXq
	DmvNbSMGVeLoS0X1LcrS9uK3Bol9P4vE=
X-Gm-Gg: AeBDievI+WoTGNNKwhCqnEC72gy0F6SCEtel+eHDZ6LHSHIqZv3fctBAMVfHlCcKy1J
	cFnQl8hjt1yPaCu6l+ku81wy6EGmOUdOuXeHZwv2zktyvHlFspDzZn6j6HQp9DgKJPHm8P7UmTa
	Z1K3dva/26+spkdFopbGSMgbmNi7mGwCvBZIz2R8uQvrAFg9F8Sn+aldIb7td4DhpkqNrQ2T9fD
	LWwWhXLBCZqF+pLxVgQNvluhAJE8EKCfPNONRafCdaJx6KClmeMZ3Fy8f0DtM8gkLpAtQjOeff5
	y+DJgxg1EhJTwUuEZ+2LsmMt2eTJd6jUy9dsv6pjZp614bxwPQnyFqGz6GENgqZcaAXWTILbpmQ
	f90eLZ49/gwbDut8IMBdqiMI2THHJJm3yP304WQ+LAuM7VKvHECI6jzCObm+nItOWPP620krJHC
	OsdU8TVmm8UUG78XpF
X-Received: by 2002:a5d:5846:0:b0:44a:75e2:558d with SMTP id
 ffacd0b85a97d-4515d9a07damr3359012f8f.41.1778051241145; Wed, 06 May 2026
 00:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <afrlfIZFHVQeOZWr@ashevche-desk.local>
In-Reply-To: <afrlfIZFHVQeOZWr@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:07:08 +0200
X-Gm-Features: AVHnY4IvdfCniNzVL42XyRLWqv_3etLY8oiLzUoJ7VQKAlh1vL_OJw4Bk8H7DQA
Message-ID: <CALoEA-zuQ3LC=N--7P0JX83GM0mjqHaKeewmKdW3vre20Chf8Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 08:54, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 01:46:04PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Add a check that ensures that valid data has been read from GPIOD. If
> > not, log an error and return the negative read value.
>
> ...
>
> See the comment on the previous patch, applies to here as well
> (to some extent).

Will do.

-- 
Kind regards

CJD
