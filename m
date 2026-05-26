Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FA3D9035
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791080; cv=pass; b=k6gHppsKBWzszf0QzllJgV4YHt5TLZl3pHBCY8tzNmdbjkHgtgPh7tE6GhMtorchM8FHZlQkb8NJHMN30HVqqH/sL4W+YKe59Z2ikIvGEDLIdhpOf74JoZ8x8HGrXqZ1cxo2RZaU1uzzGo1SgmmUoyHkGSzWzdPT3+qNkDnM1cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791080; c=relaxed/simple;
	bh=GVacpxLCAtt+ARYGTfL3py3lMej667BEWwDj2Ay9Gbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPKoOwBogNRlZ/TxIzqwbl510QyX9x7DUP/8nTST9unCkcQJNHT38sDTI4YkcN1a9T+sThLlS8PBAZ+Cz6Ll6yvBrHk7KkS3suq+62k5cgM/8zlL1JU2c8Zm/e2zF43OiR9eTah1uDDOLXoHnN9HWJt0K9RpQat1Cc1ajon3fCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecwt/tMF; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecwt/tMF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d75312379so8753099f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 03:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779791077; cv=none;
        d=google.com; s=arc-20240605;
        b=ehYiZvxzSSW0H2kfnufsAHOOyJiXk7UMT3U8bhV5vV0fPn79spGZ/ZomatewlDg2ie
         9lnz6hKSo5tkzKRcQ7+L7K4aEZ1N4hanSEYmfLt6XperLyDhpO8BuSXQpRncGjw6UXgE
         ez6N3b7naMYIsB853wJz3HFfnEK2nGmt7Tl7RLvAZOzOmZP/TU6HsPZ1fmDX2gW37nB5
         DqbznJMSaG+6n1vUNz5HkA2TL+Eo+bXI87VIkxfBA6qs970SaiRu/HsR8rn8GG2NEJAp
         warZCOO747MbY7WjJwnyeOrT/mojt6EtMLbwZXVjDZ0/dfvT/1QQIuJjDZLgBD/+zBnl
         qDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mwCD/suEi8BopQFl4tpj8z1xVXfvd0efVxC4LL2hJfM=;
        fh=qrnqQpWenIAohflXP9EfFF3RhLwperqiXQAIr0rwUXg=;
        b=aRXS7Z4l0MKMm8UzpdGh81GDLF3y+RLxyBsPC39JJNcdUogRjLCIRqH+M39ea+JHF2
         5sWnRVMOqb8rxo4Id64qZCWxmbdR+Kh2hMeoTYdWr4+GSvI6JWrc/EUb5NVWI5IS7N+R
         cmOST5TRBuaykrPrE3NQfuxHKvbtnocBBR1AlV/Su33D6I7oSTrvQxBFcnr+YzkfmXtM
         fgsrSxnpQW1EShjlijeKEc5EjyyXjcdjP+L5t0TnBSDn1bQ/SBn6CYZXCy0SaHHqOZ3c
         LoU6tb6/7NPB1nhLLyqoFEoAHHPZiFCcsr/gDKi0a2cXkXhWH6P3RkFdbyH+zTq11mRS
         nSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791077; x=1780395877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwCD/suEi8BopQFl4tpj8z1xVXfvd0efVxC4LL2hJfM=;
        b=ecwt/tMFTEkhuYxZOFouHYr+Md3o0fIN22hbFoBqBXrVTdWKiTSg1sVUrLd4lzWapr
         PI2ujPoNHp6YJz0Q/x/0C4pm2xyUQGJEWjTBx3iHi6StQSbK5F502p1Ae6oNVVnGUBUr
         BUbFvD6MAxmzI3sbhP+HkxucppRTAn9lD9BT4L0mK9N5jiXNkvs2iOJVevHun2dp5HAm
         CQ17Xcv4MkYAZN4wszm/o+DWMtE6Xfp1XTdfLsWrM702gisImQup3vZHGo7rN/cHo3/R
         5KtSNTx2jCpxX268UtqHt4hRSISxqIbTlgDZf2fGcyiOcz23szfKkIsuWNVxKmw1DGfC
         9yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791077; x=1780395877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwCD/suEi8BopQFl4tpj8z1xVXfvd0efVxC4LL2hJfM=;
        b=JTB0wvI6G0tnq9Fo4XDY0W9KLiMLRHq8rxYKTRz7x2UHFJc6rubn5+/1BOQxk0IIx+
         xhJ3/XYPVcQaXTKi6R/Gb0K0VA7ezjqfamtwEDirwIjVZNQTF5cUCE7uibFgOOFy4qvf
         HK8Xo2CxOKPE24zcRlfpgoaQ4lWHqmdWyx5OXM/M+xSQ79GOHN9W3G3QJR/wCxrrr75J
         8JwnB/vqixmpN8ZEMOneRPtoBEQeXUtmOeDSYkY2KKSjNxZ1t7i57Oj9moeBFefH+LZV
         EcnYANCbaA2xtabGG4/TkPkPFGb7OnRVoCm3D/hC1VMWB0FszjWzyO42+zX/stkzRKAw
         Mscg==
X-Forwarded-Encrypted: i=1; AFNElJ/5VrByXBx6gDPPXmUuFlO02dvmxS+4e4wlWhahO0HCTm5OMaKVcET+ZrF1FYPhTLOnavJCJ8tcfiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzlxq0jHn3puUcZBLcv6dl43Z5qyUsQrTMGIiFltzRM20Cy0a1
	9tFShIYMzXD+hNPdZnw2AEz+ucrJowhWiSoodjzwOfQtRgTFTeXlrEkh3r/dFtEDwcAeazYY46y
	7vjFtHRomD+9Xioet/TisbDZR9qwsSwan9Q==
X-Gm-Gg: Acq92OFaumQQ5US7DQAgwBfsJszq21vnCUDiv7FGXgEwoxFeEE4qz2/gM7f7uNVfxns
	YOZYJqmY6+Kw91q5LyNtvU1fwD1vfCh/hSAQ6CfY6edCDNkuqYQ8R3DkMAOsophe8GmINpDFBXk
	thvWC0fzUGndHilOypnHYKSVgSL6JEeDGRz+uVLxLtJH882B37Uz/zd00W27/Qvo7DBC54w7QSg
	6h6Bq+GWTl+L9vQXb6npGtvVFcH8LqAm92J2OyhMguH3YBimw78aPbO5uPs2mfX1TJFiQc7tfTR
	isdZygThMpoqUC9vtPNfpLW3QRNPK54FQBLDZ6QkGlbWdJRdnDzTOCggEI1T7iJh5joQT56ijSK
	d3/4y26Lho4P+tpHKGsl/kAE1v8Sznnukl8z3kapyjSBa0EPJJ0XIYM//3xZk1Qg/DFBRfA6LVU
	ruKOtzsA==
X-Received: by 2002:a05:6000:18af:b0:45e:9304:a4c3 with SMTP id
 ffacd0b85a97d-45eb333aa31mr26418669f8f.19.1779791077240; Tue, 26 May 2026
 03:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525151240.7258-1-sozdayvek@gmail.com>
In-Reply-To: <20260525151240.7258-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 26 May 2026 12:24:25 +0200
X-Gm-Features: AVHnY4IAU50C4_nrqzpMXwpALdJEBFVEC-szZySIcvwevd6ApZMGYZEckkCvaFQ
Message-ID: <CALoEA-yfG6TvhpR7hWq4wfY3Eznys7K0-ee54H=0NWGu5VJ0Gg@mail.gmail.com>
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, patrick.havelange@essensium.com, peng.fan@nxp.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 May 2026 at 17:14, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> action nor a remove callback issues a matching mutex_destroy(),
> which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> enabled.
>
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
>
> Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Add Fixes tag and note that the leak only shows up under
>   CONFIG_DEBUG_MUTEXES (William, applied from the interrupt-cnt thread)
>
> v1: https://lore.kernel.org/all/20260523184351.7567-1-sozdayvek@gmail.com/
>
>  drivers/counter/ftm-quaddec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index c47741292..8455f16d6 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -292,7 +292,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>         counter->signals = ftm_quaddec_signals;
>         counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
>
> -       mutex_init(&ftm->ftm_quaddec_mutex);
> +       ret = devm_mutex_init(&pdev->dev, &ftm->ftm_quaddec_mutex);
> +       if (ret)
> +               return ret;
>
>         ftm_quaddec_init(ftm);
>
> --
> 2.43.0
>
>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
