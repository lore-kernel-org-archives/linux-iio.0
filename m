Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FEEEEA8
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426236; cv=pass; b=ez+00tuGN9IiVwlSX5hKT9PXrg2rRoMAYdvctGVYuwHG/47SaxHoBUeogEmLVWGNEsc0SesWPyym5l4NCw99zbu5wPbXD+wgjr1uJIFqNiZCN2U2Oj5MBIJBqD/cXtPu2essORxL4Irx2KcT+woBGpk6stZ3Jt6b+Gr0bx6iepc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426236; c=relaxed/simple;
	bh=EflvLmjetEQsxOH8qHNIDAu9R9EU4Ucqsq7KmIBHq2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zs7M87LH4MCzVPiQoB9yRr8l5texqeuP4qYV6z/dwF9Zd+E7vYUg2XQyQpJzLBNIsKo7Q1xdw6v25kj3JiarcI8Db4HnzMVAmxS89JbIBCu38OgUz/IcRJ1q6ITxJ48ejxVGE2ZN+DmvHoiwU/2ovmr/iDRUPUxzU3mMviNsNF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agN1Iycj; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agN1Iycj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0046078so28547945e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778426233; cv=none;
        d=google.com; s=arc-20240605;
        b=NPsBj3bO4bUxIy3fI4IxnzZAGjVwgz80BP9lDIyIf+mWeoXb9m6qTQ2On/aFTgynbi
         gUWbr/R88mdi8g8fABPqhFc4XvhYT0yufj7cAawR7savtFmdVuCOy4c7343CTgllkYqg
         ssRdTWX6ULdpSEW/A+0v7NmGe9zVAsWjRkyoBhtvHAchzWneL0cYfRonePxz+zc/el9d
         vdJgZLdquRDGTzO434LEVkPASXaOY0ZLIKXSGmG9hOcWDSuUwUn8+/zKelJID++BFY1T
         i9cjIUFXblJpUtlWB4gXHAz7umPfDu93OMXMC8YZUjNix1RK1VyJiRm4ghuq/nQeOlZM
         mg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4bIV/tUSerEjjD9AjXDVQnssQtVDyCLS3cb5hxbRye8=;
        fh=tzxLlbzcJ6Y4GNqQEROZuTicL1MxgOOUD+EylZIchRY=;
        b=Yk893UOI/ic8fZRdczX5C8rMdHnw2G+ANSkSTmp2Q916LYtl0tYZ51P1Lao1LBurxZ
         oVKT5q8Mv6VegCDNORNMLmQWmzzSo3Rh8vQqczUhxssGxVKLUFGt3QA5LcKzIlBQbZ1v
         XWMqAJRIiNbKkCzKV52lebGUsBVXGmkYrRhgDfgF/VrH7RKBiyf7D5rHnPkm119zvc24
         t9M6K8GRQZXhp3XmTSFA/iXzbw2PTRR4Imx0antHVdptR+Ekbd/AjxxcTr3rML2dCEU4
         hzbh11jNoP5PaWI1VUuXSl3y1O3uTnrFgNv6OtS20p1axmqj/8zncXYM3l9JkZ+aS+Kd
         muGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778426233; x=1779031033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bIV/tUSerEjjD9AjXDVQnssQtVDyCLS3cb5hxbRye8=;
        b=agN1Iycj6k/VzgAdpIgSeEKAS5mZZCcgLSWzAY0aSN/9chcbENMbEvMJCCkdl3ig31
         qcUDIlYpTvhz7yIHJ6zxuvxvTn673acQ2UoJxttDFakX3WQkDWPy8m3aJAya0PH0nbuX
         ZovD9K12VvMOAqj3K/gFYAyzyNCmmjnSaR6fsN83mFfPTpi2fExIUjRZk/svHwPKOH5u
         Ic6l5LXv7UmYgWIJyio2ZX/Y9VLHsh4nxKCM+ruG1YcCxQw/4AD+SCout7W5bdW+irJV
         OBYrDpMWR0OKA19WkDz/evI6jE4kA58VH8P92sNH/W9Rypw188898XPFScK2/V+hfHVa
         15Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778426233; x=1779031033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bIV/tUSerEjjD9AjXDVQnssQtVDyCLS3cb5hxbRye8=;
        b=oBy3ekWsL4faD4WuQJWnh7ZqlJRvVmf+3pIE+6dhNeDkf965AFN1IAeVfY0BWrWzY9
         GCJoPuKn3uoPqQYXKGUauVYys79exP971Zu88cuqnbuZ7PDuYXk5bkVMF3wc6TkvJ7zi
         0jvuKLfChCe7nFkdx9uP2croPEdm0+/cioGiutv5yDnIE3ybCYNhDT8lpsHMFKdEA9at
         QEcfQacUSmDhx2QDhKw+ON0sco/66BM3BmbPNZSsPza3GeE7LC1xtCERnXaQ8XK56Xy/
         SsN16Yttdkwnpkar8AIOp5Wa2VCso4uh/m2F1Iyb7H8B4aRu03Z6j+h7FLgoBhNzThmw
         mt0g==
X-Forwarded-Encrypted: i=1; AFNElJ/D2FsICt651uNYDIqPjRTxZfHTTbJTFb3dr31kKi+UC1UCGxYZoeJ43EfsyXY2OShcv0Wr4cPttUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIKFMtbQPROt981YyPZHR16oQRs+qJQPP6jOF9cf+EFkOrjfF
	RRF+kYqv8r8NO77WbO2G+9HVB/azmBMepxb91rsGRBmUDVZ4ieThTAXAbiM66GsD9cvyEhxZlJK
	MVFsATFNXV7A/X698fajQ+YQdM5rr5bk=
X-Gm-Gg: Acq92OHpZupHcInZAFPD+Q0qbMBknL7dhDtLrG6WPnqb3PIbfDGyDUo9f/M0SvSSIk9
	o2kBjcznSQOtkoHrVcglRtYQUzy9kGrCBjldQF46JGPmygGV5Uzd90X2WtLztOF6ciXAlvpZuWA
	T3WBPhh6k4FYHEeE65iq9GIVxsIPPQs4n4BZZBXzBX0DWWtR54FHI1Z6jSFiUfjzrIsVL3cIB4G
	iXH/pFzYFEPplAcoc3KwhEw8JqPbwnKlVc6+wRdCEIRHJkf/q7Iok2tYFrUc26kAeOhrb1CbjjZ
	jfNeMa8vilD6mkSmVfUuphY6XRaeYpYdLVF27fUbw0e8SixVErR86ajOGgl8UMSR5ViKuT6jr8G
	JigFkEUwiYO/Evg5HvFbFDwW/+lh6SrQfcRylM7wfikqb8jUPkp8mXPre4S6VzcJqSFi17yr9/F
	gwrCUtCcQ32FBf7EjU1pF/mC+nOUP8lA3G1bgk4g==
X-Received: by 2002:a05:600c:b8d:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48e70691673mr96049965e9.9.1778426233096; Sun, 10 May 2026
 08:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510071944.56700-1-sozdayvek@gmail.com>
In-Reply-To: <20260510071944.56700-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 10 May 2026 17:17:01 +0200
X-Gm-Features: AVHnY4KxqyAGIhS8y6ywptlh5pulG4QqI_v8E2pu12SROCBd41GOIX9koI67vHM
Message-ID: <CALoEA-waQYWzZfjY-+Q1hKzFXSQVCmMo9LEJRAn2Xz1ZaCeM3w@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 May 2026 at 16:35, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> The "minimum 500us here" wait after power-up has no specific upper
> bound. fsleep(500) expands to the same usleep_range(500, 1000)
> internally.
>
> No functional change.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b648b0afa..a88b19fc1 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -456,7 +456,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
>          * and the minimum wait time before mode setting is 100us, in
>          * total 300us. Add some margin and say minimum 500us here.
>          */
> -       usleep_range(500, 1000);
> +       fsleep(500);
>         return 0;
>  }
>
> --
> 2.43.0
>
>

I've beaten you to it unfortunately...
https://lore.kernel.org/all/20260506173946.2b1907d7@jic23-huawei/

-- 
Kind regards

CJD
