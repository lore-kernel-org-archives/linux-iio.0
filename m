Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6638AC68
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063959; cv=pass; b=KFsU5Yt+c3+86nYEZqqNNj3otIofJHt/9JGL70uAg+BmuuAoyLjEOOf360W8Cpz3WJNKvh7VpU+BqnA89MQ5Ed5Ah2S/2g/fXLBBnVEGSQ0goxHZxyqBIzaJ17szfq4d/FTGPvhXd3Duo9B2XkN83FR6OlIlFqE6cwKS64Xhx8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063959; c=relaxed/simple;
	bh=6NNewgyL8mNQKfHVhI7jr+URAuqSbxwpJSjB3JPRtLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptcs/DYllqGvauIUVaTPCQvmwN1+YT1RmB20fPxr0axfmuKCkXB3BuC52zYSPOw4pUaKH3AWIpG1TT5IrGDSaKgoOwHBS5RLnV76thGW9BU0zeRmmFXeGvvwLm42UUM9e6LtsshcO8d7937PmRQ0Q0y5ahYXvSVs+2VoaxuV+Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KycfBRUp; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KycfBRUp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d73352cf2so706845f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 00:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063956; cv=none;
        d=google.com; s=arc-20240605;
        b=ChOIzNg1x5kKX735BwdrYDdw7QWwe3uz+Yxv7YthrFwauMIb/q6sbdxtQSX+O2dayY
         geNcYCfjDFmZnEn299c7Ml2f3eBtAD66otMvb5rpoE5yjs6WmgkxiWExM2q5Ie6WPgkA
         aJG+YVd0CJ0zom7WYWH5yLNz/PGvxjqye9z8J7KaUWiunowG0y7e7UoCgTGVsUSe0X+s
         FBTs9FLXJSAucsqX5BfGos4kdGIuccvGgznYdSmtULb3qSMhpPjDrmy77CATweslnJiQ
         dtFFsHlh+3yU57fYulW9+hOJ+IDlV9Xin30QQuh5EDKA2QUWnYwH7ZFJQ23SFnhJCPPj
         xyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHI2UWp8+R2OAULr/9NO8p7Pt/rJO/LrNlqi21QyDfQ=;
        fh=I3MCDr2rw3hJqZH06xXlx6H21bIkPRaQ2HJRAs4beLw=;
        b=Y50wq8DKNP/J3sHi7pgKJ9SKHJqybnIOLWwINLw1Lp5ewPhBT4ewCKRp+2gIgBlD6g
         hnsxNeBcL3Q7Zz6H1O8blgftqEj0XEflCmYsHth6PK+oCiJMYKp4waD+dfeZsOMolAh/
         2PdDXo4AFONBFEWqH1Hl+qHVU0cHfHt/4VaTLUovzAmzBE2XNfdl8QJZFXQAuYUifCCG
         J62orSuhvVH3G63mzsyLj9ZOUa13kRP8xnSN5nDzkfnyEeFUffTBWylGC/36BQTJ3qMV
         +a4ct1ScvAUO/NUZInC93BPpVU8dnCLI/GC7+6Bmmx89N01jAoVnT4QODRgoiID0Yhn8
         qZZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776063956; x=1776668756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHI2UWp8+R2OAULr/9NO8p7Pt/rJO/LrNlqi21QyDfQ=;
        b=KycfBRUpzZDVWzHrsTeLL82Qy1GVbKnJmI6chg/ywQF071CthhU6ESHL/KV0ARA+SL
         4C6jeD4c4mBmOGkD4tBUhYuEsG3gxr/o6m2G+0cKQ8s4BTJRK8NtgXUrG8RO5m+7zbtO
         RNUY0GPjwcL15ws5yvzw20Z7oBdBbzSlGHmndckcxdXWJw8piYCjUhUpVX9TiHvnUHCr
         cK4mJAptYs0ndRoBK6c0Dwf0E3eWz3ej59ck46fxzTyDa2vlCfYqVV9SNDJITTa8XZ69
         9gOiGBk5vz10ZQs3WRyCPtsqniMG3rgrkSidd3V4W2ZjY/Hq2PxhINFQULEq8eIuZ6+R
         +k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776063956; x=1776668756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHI2UWp8+R2OAULr/9NO8p7Pt/rJO/LrNlqi21QyDfQ=;
        b=nfr5LEQE4jgh08U1REluSTR71zHzGu/mTxy3/IIOxr2trIv1hmP9sVuLrnZ9MauSSz
         etWKfcddQk6g29cYiDlJfQhP6OGMiPQnSuUuPOUEyeVZjGu0wkYCnb1GtJuTN/tGZ3A7
         jVGEdolW5HK6g00QopxxUmrgyvX+pvi7J4FrtIOhvg5L/6glZ+XvqRxmtiaG8R367S1c
         cJOT0b+yTyJ5gQTPH8S1Biv5fEYRwAR0nA/H4DEnp/i5GSqij6HXYG6qFS34kGiC8y9t
         jUj5NZQXzqVEZzeEopNsHayhr1XRCHaV4M82ZY3rBtQwVy54njR0sw+QudBNzOmKoUx2
         tyCw==
X-Forwarded-Encrypted: i=1; AFNElJ8tuAioDBIYfVt2VkJWBTcJqBoNYjWIq7Jep7axe3TW9jrxdf1fPAZ75AFEsEax8W3kGFfXlnbKhA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+hsnExI4Y/uUQ+8VSJG4OC2QMIpNwdgfbwa/mCiLBRk/pGg2
	GDNz7VbzCKkqE6CyjpPow78Tkb37pAbK4QkMxSMi4M2V+nQ/0BRJTxHVpxlESOF12//YX2Y/ATX
	pJjJhVWd8QhVZNe3DU2HzvsE0uvL3kEI=
X-Gm-Gg: AeBDietQ7mefKTJ0/54mVJC5h2YnMxIoO7Y3nNH+fYrc2LPPVFtwcUgn9eJ1wuZOiE6
	cxpuMg/Q7LrYrhRLb0TDGa2FReiRzkq3X1yD28D1BBD6xVeDCB1JTQSPg6+Y73tHgK06uqW1qGk
	6+tW4DpAbb1mY43ZNfo3/OyOTFyHZR961Z4QVLd6XJWtsxlC7fQNGwSZ7oeo2wyJ2Uw6yFtvs5r
	k0xC4jsrIYHFjDgXGhHL8zjBkvndu6BY6jnmfS6fCIxPbj3/FXIY7k05n1qrqaIE1wirLkEbz7R
	ugqGYiO+urqif3D7rzSnfyJNvYgiO4HkR6wXYiJomTSOnUEonDHlH3Yx4jgmBK1rTBCMFZ6LTZ/
	R4lZ1WnASJJs9kKTlGPzbHKRALitP7YkdEOS2UT+Hxk4KvkOv18ouKZ6QxmsV5PAFQ+aCDCMPmI
	vYvLc9vw==
X-Received: by 2002:a05:6000:11c2:b0:43d:68dc:9ca6 with SMTP id
 ffacd0b85a97d-43d68dc9d13mr9278619f8f.18.1776063955971; Mon, 13 Apr 2026
 00:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260411123512.84739-1-joshua.crofts1@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 13 Apr 2026 09:05:54 +0200
X-Gm-Features: AQROBzAXYuBSZMKylrzZk9piXxiKmPZRoVgKuuLSOCWThsyrFt2uKr2aQljUk_A
Message-ID: <CALoEA-x4Kdi+=y3E8RKX=42Tfb4VjxtGXWS-A3khqRfLhY4K7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: frequency: ad9832: cleanups
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2026 at 14:35, Joshua Crofts <joshua.crofts1@gmail.com> wrot=
e:
>
> This series cleans up issues in the AD9832 driver,
> including proxy header removal and bit math
> simplification.
>
> v2:
>  - PATCH 1: removed redundant bits.h include as it
>    is implied in bitops.h
>  - PATCH 2: changed ull to u64 type
> v3:
>  - PATCH 2: remove rogue vim typo
>

FYI, adding Nuno's reviewed-by tag from v2 as v3 is just a typo fix.

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
