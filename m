Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566514BF97
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752544; cv=pass; b=l3rywu+xjQJzM0E8AcJAxhv79xcr05Ezi9cUdaXuZC+TlqMnbatWZ/plliXQNf2lF7e13EIOH+T6v1b/ZfaL8fLeUfWtFZDmbl/T1gn8Img8K4sZ0WbTd05m0XI0BokE/VTeXX6FUTWwA/cisz4+Hc2Bf9aSc0+SHvgRsd4I7Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752544; c=relaxed/simple;
	bh=iYf+K/Srey6Qfo7D0vnclCe5OqhIYSsWjyRFd1NeJ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0393giMLZ2RQ96inc6SZOmFvYl5R8HS9/YfWca+zo0Hrvu7VRvv+PQPY8/2z0ENkLgVky4JkeldmRbHuKIFy3tZQQfJzqQlJ7la+rY0hOtUhQ338Zyecs7MDeUXSQfHSi4UTGoS6iAiCX8lFJE6LQOEhWwfZgYjJCEaZAE3Vmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/ph+8zN; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/ph+8zN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so49182325e9.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776752541; cv=none;
        d=google.com; s=arc-20240605;
        b=iVNC3Hm/H5kdWmEXsPNn8fYoACTLhvNR/dQRdxoCZc4eeU0eSC9GGOkwSJYf36UyFL
         XQ4g5ypqXv86tVeLWjfQh5J/dbG4cS7x6wTdK5VXneZT8pnNmwNvMYQJ9HzyzqMx6ARq
         Lsdy2y28Wk/N9OkL0nl2YT6IlWy3fOKsEmlnYdDcDrUdraB0F+4vkpO6huAIdsB7c6ir
         ODbwoHpVg4HP+NHC/ZtdOh1r+qgOnLUtDET5nDBKej7XreB0jGw7YXAHmyZ4cB5jcSX7
         AOeXdqmqJtAkUzsjSgfujiSbZhhgMeCYbH+RfZxr6HuAWtRj7KvkaXNWLRqy4kidX6Za
         lYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zRg9meMzSk9KC4CfB3rKkNS9vZ46ntZ88kQgsYbadfA=;
        fh=cMH6huhqP0iWGveq7CYoN02dkiKIb2O2KPyM9zoW/Sc=;
        b=JaVOXaG4JDLWOjDVhKYgfjippN6xj534UCpqmCvMhbehva9wtKILBC4I5FbZ9In6wd
         E/ZHIPmPuYVFVXOk4E+wmar0tM0ql0Vp5o33PM6L78kNC4dkoBhcHzZ63TH1U2dCZoAm
         QtTbIa+IsvUzgqkahp8sBVn8AgABX0qzAZxzFNP35oqw7L89H0HuBCeFnzO2sebEzYF5
         VKGdknI7gBQILwSyoh+ZVmOeWFrh10BTWov3kkKh/V65Nxv/xEqHSF+3zlKTAh3CHhmu
         eY1YNWlUWi8wOIvuA2RXZmwrOsBRFssO9Ih5TvfG4R5fnATqGCzuUnmcHpnvZ+ainVBA
         NElg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776752541; x=1777357341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zRg9meMzSk9KC4CfB3rKkNS9vZ46ntZ88kQgsYbadfA=;
        b=E/ph+8zN3LSk5fqTPgw243xnff1CRpwLaQqiQ4JAK61hp+pCXHh7vadCmLwAHsf1tp
         tMimF0Qnxo4YFysV4visT35tX2AZbYzKntHFq3FTUqdKTfktP6vFuLbfPO/8PHsxiUqL
         lPXMykSlkEjC4h2zEvL7pYjSHcB+PR/853RiaOz3qe9nq51EfxLSnShBnM3AFOgXVT1W
         TQlLwxAkhsoRjKtM1M6BS8BSRUe2BkQ02QgxUki9370J92OQYiLHWAGQ+KQ4le83H01h
         iF3dD17+wMpjF7xgK8Gmt/8oRTGjK33M69FEjdnGN6D3B9jLhwTOYtVG3Yd3mYsT3OwR
         EwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776752541; x=1777357341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRg9meMzSk9KC4CfB3rKkNS9vZ46ntZ88kQgsYbadfA=;
        b=UuPHYnqiwG3oguUdfhPWU9hSuS4mSToPmti90d4k4NlXpF1zVjZOTBZtYnXMHsnwkn
         f/ViVUPXfl2MbXHxyl+r+Lr9TPWeYvMxG3/5+/d+3lvpW42JKLXEfsSRI6+OK4TyoLFo
         9Iya3ZzQVtqqOT4HBv8bVHt0/qd7h2WJkz8UA6/rfotn4CjViPiRvaT8leK0G5AlZ13p
         f8+FOQUwCH4+cJPCgacdDJhTbREDPKapFeihMK6nNKmjtsWs7EpGbAEcvtyYshKlLj6t
         R+wYJtmA7glvTlgRmO4IBKd3kOYiUxXNupfgxUw2kIqoRjWaz7HvMmT7fGPy8TUCuUGg
         rfSA==
X-Forwarded-Encrypted: i=1; AFNElJ+KDo2vbgm7cQXvF8bpM9mUtmkzVJv33V1MUsLVpKC1HJiX8W5+p7/hMPhRCIU/rFTY33HDh6X4zZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ8DlKtRXOsoW0zQIqF9/C/2E7YSBQ/UdS4s4UcOSdBtSF5c2
	k1twLtKXnbVmlBtfPjgfH6g9oZyXnrjp0hQixciPY+orupSlTcLQMQAvexV5ZuBeP41TQXLJpPy
	m1qNmR4x20FJjIKF+nA3ceO6dWMH8dmY=
X-Gm-Gg: AeBDievXgdshk4g0r3LJbJTt4xYio2hSwqSWxYrdqh6Pn1cJAukN9v4KxfvW/S9+anR
	x0tj1kLjiKapY9lZoJTDrtc45Z5NNsfbdYmSpA9eSk+oJE/lqnu3uhXtArrC14sQMJdbap6S2Si
	UEumWQcyAflUOXFjTE+2lmmMAQynGfg3iJkCzbEJD9MrvSuCYuL2V63lAgU+02sT2Sq1tCAD8Qs
	kikA9NnEnzi2m9stBzflKkppfaFHMkFLKJSZGuSv7njgXx8D5z5uhVPzRuagGiNQnSu/mYV3M5A
	nySdoY0iGLHu57ywi3XJWrevBK1egdGvc8IE+HXasTbnTXvBNeomj1esL9g1OdKectjropjqh9p
	uOYLljAukHRqrfloucxofcyhspIdEHIA/po5yQ757OtlgqId2BBJaJxhrIjhWKElG+EN6gIRgxz
	KUhhqCqGkvXNVr3Dt3+RsQgC/Y25Y=
X-Received: by 2002:a05:600c:c4a8:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a52ee579dmr61196325e9.11.1776752541466; Mon, 20 Apr 2026
 23:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-4-joshua.crofts1@gmail.com> <aeZhCM5YJqHbigmr@ashevche-desk.local>
In-Reply-To: <aeZhCM5YJqHbigmr@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Apr 2026 08:22:12 +0200
X-Gm-Features: AQROBzDQe-4Q3Pwb4I48S5BBBUAz7erorLtHaGltD4MWIi2NLYu4bxUvJ1O2Wis
Message-ID: <CALoEA-xtnfTBPXROMaP+CEzLx-UCH1aK1TzO9FhMKgPF+5jRNg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 19:23, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Strange no warnings on the open-ended function call on the first line
> (trailing "("). That said, I would rather see the result as
>
>         ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
>                                                         def->data_regs[index],
>                                                         sizeof(rval),
>                                                         (u8 *)&rval);

Checkpatch seems to miss quite a few issues. Will fix.

-- 
Kind regards

CJD
