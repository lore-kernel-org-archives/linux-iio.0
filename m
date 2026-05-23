Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79893195FA
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562850; cv=pass; b=Pu33ZNONHOWq8x6PFtjzITLtsCOYvZMm6BNdecMaDPENeG+3bLOkeYS5IsqlkrSdHtRWcgEYkeugSTSUT/Fe3673njfbq02MPoBCvQsxRFvS5PFodb7sAqzg4d1lyFyph+FehcySW34wFc257rDBNzadHWjU7kzvrwfseB97kxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562850; c=relaxed/simple;
	bh=ok6fG2xIutcw8x09syZycqVA66y3BLAlhAcTLX1O5pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUHImXepArRBI1RgZ8XNUX1nOqT164whJXurrSjrd4xoO1oAx7E0i/bipC0sOVvYk0X4VcY0dSAaUk4Lyym6vSGxndbw05PD9G2ZzUso1GW+d5eaqXEOHNYzuqGuNq/vKP+z9HFp4xsxWu2+sseBghnCUMNMM2MgHD3pniJuNCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUk7YX9H; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUk7YX9H"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so8834818d50.3
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 12:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779562843; cv=none;
        d=google.com; s=arc-20240605;
        b=AEDwPulVTU7PAGgArZOxAhZrJU/fUhjg/n82MA/q3FoGc1FvssKlfeusUIhUXxddcJ
         bWSOgU7/4c++dE7ye6Z5um11JscDf1zXFXyhyr+ePu5fk8F6MJ2N4NXTRi2lfxIbR/FG
         zqJdQ0iJhE6JP+qKKERHjYinBIKPy6Y1FiRYvaLw0bj1WNZezhvFyvypxB+0Y1GKkPyb
         //bIut49QQGLYaMABq2ymPchCuwIPFTWDBPV/es9R7FB1FqfRyCkpf7JUNS623vPZcSY
         P7pTptxiYnGiLOpifBkIrlsFZWW5Y1XX0Ero4TUIka7LxkGu0XZU5FyuMGl7W67j1UKf
         nWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2/j/piwPbHwZPQVLBhTSCXkAzy5+ZfR5C1AFGHmnHs=;
        fh=z7JNG8iFWGBmT/SyapDwdM3zA4goaUTj5E5BF0pyHAI=;
        b=W7j9EpO+tdnT2O58fHgzQGTQR7Lb37sjRIb+3skYgn01WngAA1hByx8dk6ptKWSzVz
         hyRR41puoC8/H4WoLXZI1OPxCxjWbnE+eSf+e0wb0BnZ6YA8TkYy8cL0tZIA1P4zJ/nB
         +8rU7GgJY9E4bFXc0Llj13Qv8FCtcOmWinLK4gcHnCsVfKp40LmQ+RsbeE1ZOBJDWwqH
         YlshBV+ZL9xRjFVgflXz+YCY7mDeqqS2r3MRanjLYj1gWGugLkmZKVbcQfCTU3NxlfJG
         o3B9JHthc24/sdD5k+yj9t77WvWgelmvyv5zznCLwCVtt1JlIEOdrJ9OgE/eoKnLUCOa
         k2PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779562843; x=1780167643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2/j/piwPbHwZPQVLBhTSCXkAzy5+ZfR5C1AFGHmnHs=;
        b=AUk7YX9H8sWV+IQjBqyAGidbUEl9mfL1nqCUkSvbyo4PP2SHC70sVo+oM1WFdO/ofs
         knmCC49oQunXwKLJTTpPSHgvpq19exgMRn9viiBBtAmpxp7tKEiLaVfpn71wQj3TQsoM
         d7ctSXqfxt4k4n5dTs2oM62In4uCJNKvsyTKz3FaKX1gfZK3qRtdxz82RLje5vi4ZRCl
         eLqj2vCJZqjkCmBOLHCp1AccC4eD4qQuh5k9/uaGlL37jO1sF+sNZmL7A3Z5tZGfbeEZ
         Ok56x+LVwttv+vaHBXQxnShcdUl26iZ+EJBE8zk1ce5OKZkmMC1+clkl0Ew7HKRjHlU9
         BXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779562843; x=1780167643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2/j/piwPbHwZPQVLBhTSCXkAzy5+ZfR5C1AFGHmnHs=;
        b=jKL7r+C743GDSBrdCZqN8kXbRbOO7hYo+eYve3n+txp0DqE6aGymRZUdCO5QUQfnAr
         eJf6l6A287DsMjX34vhqL/pFMt+mcKtOgEOt3zRpGTvRxpFgn8RlGO/mUzSwyept+hTV
         fuZkrfLC99MHoIP0i3tlIhhdcHAwwFS7uD9ec/Vp1rhiJsF7V285zM7Bdd+y0O6j122S
         anvTImNEyEoNVMwLUtGmtzK2lbHi7v5JLkiAVqP8Qt185Ywt7akvaXR42bITMfHYq80P
         ZWT/KMQJdREMCBJUmSRqTRQw6NwlSfgNVfkjR1NgOxIIz9ubcNPKBt9xexfxCnlZ9qxU
         gRMg==
X-Forwarded-Encrypted: i=1; AFNElJ9pc8l+pm59WW7TK42Sw/KyGtOShnWk3hpSM3KELNkigO+sKq8bajPKQsKOYGdoSS9KHCufYNCpmec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/Boa5cnE1GWlOAFByuOzCZnN3x2F9xw4GXV0ScNkANUJfwn+
	jT9vz5hYVxnrLXifX6e8w9oRK9nk1P3RQKmBjrnS/yYZ1w65snWHaokxPNyjKYjoTu45TGqmCAw
	wamqhDA9ot/do11TDpCPgKwQk73+GC/4=
X-Gm-Gg: Acq92OGXkRNsVS3rObdEAKKqM7+MkGiSNzGrYxZl85YGSTnYpG5x3GuUcMMWc17Q1zH
	phgiNkN5hZfAoaaPENp3pnP7l9TdXH3FK/QUAT8h6kXwD8drl6X/3UYzb0xntUNi5a8cM71gmCj
	qkUJB2Lq7TsF7IDhpvQI/y8Ajt7ldYk0xK2WBdRwKRA1BfUqYmVHiSavSLiNsFz7muJVUa71f7S
	JIf+6aqkU9JlKmS6BkBRZ7w4WB5S8oTfbR1gkY9RjsGzqrVXO1kW0qzt4iLa+RLWRVNiHTb6gCH
	IiaW2HkQ
X-Received: by 2002:a05:690e:b41:b0:65e:5d9c:2861 with SMTP id
 956f58d0204a3-65ec98edc4amr8574968d50.38.1779562842945; Sat, 23 May 2026
 12:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523184448.7609-1-sozdayvek@gmail.com>
In-Reply-To: <20260523184448.7609-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 23 May 2026 13:59:06 -0500
X-Gm-Features: AVHnY4IdmNi0hl9KeVtzPTj-1cdFGxpAs5riT11hWHYEBpGT5jf_g8ySsu5OGxo
Message-ID: <CAKqfh0Hu7cVELUD=m8qapEaJ7_JanbbEAen_HsJ1bFrvtwUJCQ@mail.gmail.com>
Subject: Re: [PATCH] counter: ti-eqep: balance pm_runtime on
 devm_clk_get_enabled() failure
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 1:45=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
> before devm_clk_get_enabled(). If the clk call fails, the function
> returns directly via dev_err_probe(), leaving runtime PM enabled
> and the usage counter incremented.
>
> Route the clk error through the same err_pm cleanup as counter_add()
> so the runtime PM state is unwound on every failure path.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/counter/ti-eqep.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index d21c157e5..6b79a50fd 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -548,17 +548,22 @@ static int ti_eqep_probe(struct platform_device *pd=
ev)
>         pm_runtime_get_sync(dev);
>
>         clk =3D devm_clk_get_enabled(dev, NULL);
> -       if (IS_ERR(clk))
> -               return dev_err_probe(dev, PTR_ERR(clk), "failed to enable=
 clock\n");
> +       if (IS_ERR(clk)) {
> +               err =3D PTR_ERR(clk);
> +               dev_err_probe(dev, err, "failed to enable clock\n");
> +               goto err_pm;
> +       }
>

I'm curious, why not something like (and not compiled):

err =3D dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
goto err_pm;

Since (I'm pretty sure that) dev_err_probe() also returns argument 2
(which is the error that we pass in, which in this snippet is
PTR_ERR(clk)).

best regards,
max

>         err =3D counter_add(counter);
> -       if (err < 0) {
> -               pm_runtime_put_sync(dev);
> -               pm_runtime_disable(dev);
> -               return err;
> -       }
> +       if (err < 0)
> +               goto err_pm;
>
>         return 0;
> +
> +err_pm:
> +       pm_runtime_put_sync(dev);
> +       pm_runtime_disable(dev);
> +       return err;
>  }
>
>  static void ti_eqep_remove(struct platform_device *pdev)
> --
> 2.43.0
>
>
