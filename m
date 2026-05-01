Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F51425CC5
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664462; cv=pass; b=tUVDFJn4QuODUoappOfIq+u6SC4UN3kqO0WJkspLAEm+JE+VlElsIJNonI+hFcFmxp2zacVckwAM/IaNFLr/fObfM9pZ0KNWhykgLL+rCBOn7szwiJSt6ID4TupPytnmjrK0VkcCoEz9vlH7oDCTvS+vlq/iWErfwV0w3sds/QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664462; c=relaxed/simple;
	bh=66aq98vZ3Uzfysc0/1ScAq+ZfVa4j5VIIFFZi5/QwOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kijibR1pgfY9MxVcGCCs577ju25AbNNcvumOgmFoosy+FDHSqbQy/sbifuEmK28QLfVaMjcuAF2ethcFjc24rmKIZQlQgYx1UgI8OkPYBoyI2NrJzNBxRWI6DjoPw5Zn2Yxq1ZyugpXVieRx2BGcu9tpRBWfkgS2KjlymOOQcJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLdgWOju; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLdgWOju"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1373153f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 12:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777664458; cv=none;
        d=google.com; s=arc-20240605;
        b=T9q7UafON5YGVLdlvZ91tMxYFFeuXB+RbWuYSVDnYiESxmsQOk/X7XvJUOnNeFecFc
         lP6PDJykt0hwJ5/9zD7ldUmtr/AcGdYdjm0NrdoXp+DuUNdOmgaojUYTF1yj3XEQreAj
         D66pAUpmEy+sSn/uS4R2kNyIrgxwLyHKSk7x5Zz9V2SoGKbzBxf8QQWU7ML+qI7WfTe8
         aandb4zEbHc++WUucNyWsb8uvTMJ0LCocnGjDzFMMptbxZsDzTYy1Ukg4Xox+F3VFrLk
         MKHyHNIVe+uVT4pve//sMfq9Wni7CZzehWIB28WA+NGrzB59OviUQnobX2HOLRkzZUc/
         XzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=66aq98vZ3Uzfysc0/1ScAq+ZfVa4j5VIIFFZi5/QwOs=;
        fh=xHLIPkL83tf59Si+WDJXysVXn6kvEXYGMzM3dVnNSAc=;
        b=T8GrgCw3z7Y+Uaze9TjyCKOM/wevOjNeJCZauqvjhVT9T0TE1mYJU8PmveKNhJNMIy
         f3W5x20a8ZZ8uEbYGLYTizIt1So199YX8AD9nkAmBAAzqi+MBmhTDENziQx5qvHXsY6e
         dXoUr45aXHcJ+/va38BTJUs4LAVqcim6i96Fn8bBz5dmYjV68vEBX6a5BYXsYAiL+prx
         ss1u5Q4Ki4EUjM0+y2ZhXEXyvds8tZocjaQZ+hV75kf9F+naR0zeAgdOCGNnOgYn0J7J
         yB3zqoE5reqyCqmif4UT2f+Sa0Ira5eEjbP78ILat+eSjrCbzEOmI9SeACknV13UTYkp
         yOVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777664458; x=1778269258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66aq98vZ3Uzfysc0/1ScAq+ZfVa4j5VIIFFZi5/QwOs=;
        b=kLdgWOjuZC+W8hynSHbMInOaAd2/oZQXrMrxTyG9faGVV1c6f8UqFpC0MbNmLHqO/K
         Uln2iPf0hRrZr3fPCp97Fvd1Ec+uZiG66Ovf13BoNwUlo+27lj//jfBRq7+HCFdYLZTI
         NqxwExyf+yStSrKyOWy7oBgLIVSpIjfGIELOnHsImzaZ+/AkpHNREUZVTADdJGf0lxty
         XSpxqDDMWlM/Iq/1bgfjO6fTHGPrvXA83eJCKHI2SCUDbqWRyqSHmby7On4ANd70Pdtg
         YMRNgrKGZOLYlHInaM5D+XUO/t8BaEim4xnG2Zwy9aS4D78L4Gg5+Ph7SzAZBWfCPQii
         GTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777664458; x=1778269258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66aq98vZ3Uzfysc0/1ScAq+ZfVa4j5VIIFFZi5/QwOs=;
        b=nTTIN7ezqGVmBlTOs4sBMAgSVC1CbK4SGFtYAkJ/Dgkf5fwalxWQIXnYtH+xDUuUxE
         OAyxA9iZ2ERkQImVP2+jZzWiz9jcgfKlBVL/y+WMaQ2dvLn/y7OWHDO66Wmt744a9FWX
         YYo4jQFsQtO1sSi9OlzPYaHW0zaFVqLV4N7DyW4pHCPjkVckbEnT/jmDVw3wkpIHEVao
         Jyany78fn+OW1wEOUR3i8F8zQSFHHTTFaiV2WmeflNHlQsGSFshp0AFJLirwp3YY/lak
         OFda0gYaPZ+lm9gbVyh+wGi/8gj7moFxjBcCr3+hp7iFM7t+p2KOSbpUvqv5ewWBx2DL
         8w9A==
X-Forwarded-Encrypted: i=1; AFNElJ/jYYoEMKdSl8aRmaXcyhaqvFpx9bc8+yjvDKBS/QacTDX673mOxh9P9kdVMQMh58WMZGCk+zh8MAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagsPD8WTge6hjHr4mCYIkop4XHun8RgEJtQakmENopudLML0Z
	nojK94SE6cMSBeqIhJqcCT0VKelbuTFSUca5hHUj28VbUxawdo2jlz6Q7nNwB1dhVIU8VvjJGet
	Ew7VJ3ltZzt8aq5ywnxuB9664zecoMQc=
X-Gm-Gg: AeBDieuUeHfNWn3ml7kRcKVYvZl2mAimS76/H3/ar0+PGAkz8pI074vVvlr+o2n56RQ
	ymIb7hxgF4+yYx/YWymp7PKKvy4JtFRimXi6X0WlhEX6BvAXtzx7X4pTmbXBZ+n6VHB6CpRezyq
	2euJIkvWJfIS4REMispRgpPod1nNO+0Y5CL/xqev9qULBadSl5O80GuuN0X5RfvhvrhHaJ4aftv
	J7Bj65CuTVNxcKvI/GMhMr8SgHFqO42wnkeHLmVZSO7VazFPLlj9t4mcWptNalTbPNcP1QmrO95
	0Wph51ohprBxdHpD3gYiHXBq0/LZKYUVhtQ72GtZ5m7o4pSJhph1kQ6fZZpSkrz+vZo7QMHQMFQ
	cvIfUWAqrOJh/BvOYoCnxUFlR6HvUxQkqeLpiSLRirqK2SSCHjexga3cOl5GzeQdsr6sCONEREJ
	UhMxRr4xZTaKYZPg==
X-Received: by 2002:a5d:64c4:0:b0:43c:f5a0:4e56 with SMTP id
 ffacd0b85a97d-44bb63f58c8mr1313686f8f.42.1777664457447; Fri, 01 May 2026
 12:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com> <CALoEA-zC9je3xsq0+dqG5b-EiVM1DiKbgAT8JvtALsNwLpp=ZQ@mail.gmail.com>
 <DI7GHSFZGAL4.1EFUSTVRKWUBU@gmail.com>
In-Reply-To: <DI7GHSFZGAL4.1EFUSTVRKWUBU@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 1 May 2026 21:40:45 +0200
X-Gm-Features: AVHnY4KMx3dhe0tBOESTYF9QZxJk8iltERzjmYcE3aqmM17BZ6GvLdG8Io4_azk
Message-ID: <CALoEA-zDzhLwgDp6-815xorrXoF=qrfBN=WSdLhar2Cgpaqv9g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in error path
To: Maxwell Doose <m32285159@gmail.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E2=81=B7

On Fri, 1 May 2026 at 17:47, Maxwell Doose <m32285159@gmail.com> wrote:

> I think one of the issues raised by sashiko has an active patch:
>
> https://lore.kernel.org/linux-iio/20260427-iio_buf-v1-1-2bbdac844647@gmai=
l.com/
>
> and I think they were waiting for Nuno to review it, since they noted
> they were on a "wild goose chase". Thus the only issue raised by sashiko
> that would still need a patch would be the OOB issue, but I haven't
> looked at its explaination thoroughly to see if it's hallucinating.
>
> Anyways this one should still be good to merge.
>
Yeah this is good to merge, I was only pointing out that
Sashiko reported additional errors (unrelated to this patch,
it seems to keep finding more issues with the driver).

--=20
Kind regards

CJD
