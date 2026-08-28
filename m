Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091939656C
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909109; cv=pass; b=s0PU9I2sQi1VorAWuP1WHeJ/JT9+KJETsE4yYdk3qFRWLew8tsCJGBuaSkbyaEZOboGGVFBfV4ym4AEATCvBN3EwAKWOFr7JR0e6gj/Dp2mBJ4a2MKkNXNOjx6kM1HGWpuIl7JEpAujXYlVJnTUmn9aRPlDZKMNmR7VshW65DWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909109; c=relaxed/simple;
	bh=dz0SOWNhcfrldhH+lMj9uKn/k/LmiSfJchEiB6WaWBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnnSRWJb++3oCcCnWq6Tf+H6mNXaQbz9ozTTg4vgsjEptUBRdGyiyfH5VWInTb5rJd5XnqxZP/i2bSs2r8VVHrC5xAC1v7H2YdUoQy/y3xuqU0jNvuG6FzLWsuy1uSZpB1x0ZIiwHEPRmNBghWkvC4t1E+h8t3OEb6WxQabNqvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYBzgulp; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYBzgulp"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so725115a34.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 02:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787909106; cv=none;
        d=google.com; s=arc-20260327;
        b=f3VNKtZa6anpS76BGUPgQBuIGeFcdiFH4Msg0vxiAJpBir30nI4XoGWH+bQHBuvDGS
         c9xqmm0YOxuc5R/15bPA4CGV7+IWKWGThU/nZLMo0qvltUD46VxtMtN8Rb1pFLKxqDRE
         Rd3dehbtAn012Uu74crKXX403mjmS++qOKc+wwpIXT+MJfDzM1wTcXompnnT0oM0XRyy
         Kzh1Vahinmsejon0I0dMLbI52lTVRoordUbclIEk+mi4gKgT03wvAKKFML0VcT9goocL
         h+PVLnj7os3FqGtB0ZFJp+sCU+MH2u3suFUrUt95/ILP4SFFli8EcGQRXnex6jxvE6LV
         p5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Imb5kMkVgWrmaN3qHbaWEYz34ASz+yu7tv+BXjiGe0o=;
        fh=5Wl1GCQDdqbj1JYdinewTI/JMEscXPC/S8yYJGrxTwY=;
        b=I0k5ayvAbZMq9XCG4HwTks42ElNX9DRYOYKPESAZ8F8CWSfovxGmPtjvpGLZJZYmVp
         9P1EGzKa1sDQzclteO7bXJ+E0ri2A9p0EFKDfdcgeNFDGQ1vp5Gh4yeM1FDDyN/ZGkn8
         uoi1SG2J0ExnNhuVmzACdTXyUw7cYCZ09pM9pGrpFbcKgCURE77QztYpz3qLmF14RBUy
         SXjFY9HnnA/CoMRsRKuuqCUell7hyajydY77X8NGIo8JiNwTPdBWULWbeZT0gQITjhyt
         wYmpEzPeQTAzkzBh1L9LsPiRC+NADOhydL8sGAhOVy+CdrcIRacjdCi5DAC6ausEHGSe
         Cy3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787909106; x=1788513906; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Imb5kMkVgWrmaN3qHbaWEYz34ASz+yu7tv+BXjiGe0o=;
        b=AYBzgulp9ecpmQCDbBTFfCGl/YnPDMNurviBK52WHAMse5QI01cXuXLjQZlOdlyzDE
         LsCykAm4i96Mw03BZysGG5m9QwgElgOiXnSQHX2O1aWwCvcyqrk74l+4lVUmz47DQscV
         72hodPvc3L0rMsn8vPXUmsMMKH+ycEx0/+t+7AKuN192f3OBqABQMF+AQFonIiABoIqU
         I5lL/ihjurtqe20jPs37aCGUuM8EdBc03C77PMh48Zs8grbmqmhtV7tmFbTeu41ne4E3
         WtZJAkCq2eFP+jVKw3w0iHIA25L3k5mhCf32T0pK/zuGiRLh5157zUDE1OupmbfR53vr
         jrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787909106; x=1788513906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Imb5kMkVgWrmaN3qHbaWEYz34ASz+yu7tv+BXjiGe0o=;
        b=anCI9LYw6GNZZtg7zlq58u3WqKFQE3SfFz00TJIq2oK5mUtlFtPZZhXMhdcEQOgpE9
         ONwc5IMmGH2IWiMX7Qf0YVeNGZ86X4y8oH+U96CaoRuppbatOxMGluzfqyOd3FVZnZ0U
         HpH1MUznxvIUzJK/J8I9PcasWG/FUAgk5HRGnAn0SeCnCU5Ntd0B/js5/BdMih5ifPAX
         U5y0hZ08LNm5WvtcOEgimQt5DuGsxIyzdeYsnYW15NmkquTJZMVpbBjQqt8xAqc1C5aK
         m+0IDEmYQ9hK5wL/7/LJm/SECOUjfeUJE5xgDLVJwlpdj4uStDZxXBVjd7GK3s3Keia2
         /SQA==
X-Forwarded-Encrypted: i=1; AHgh+RopCTcdHApgJqnmhoMAr8Qj3/MGQ5MPG42N3AupkBvuEe5dCQH5iZmgoLWPcuuvos0ZXpuu7mMZ0Qs=@vger.kernel.org
X-Gm-Message-State: AFuF++n9GnCMgSgjzQYQ7/bWdYog8EJ9jJy0PkO5b+Y5JmFzwasA0a9i
	9MiNh3DE5y+dx42XaN9wqqUjKVmJipWQKz+KtJvp4VjumoBw+37CfNHyBKLkk0vLctNpyiuXLVS
	gI3hjam9EV5ST3vhO7PYkr94cnwDxGok=
X-Gm-Gg: AR+sD10IePdDPMvHZ9J9tNRPUBCgzXwIf0XVpdRJRvbTmRJzGb/dbRmvg2qiSt4JN3R
	l3CmQaaIBxxJhltvZyezBQ9ZQgdXIMHnYfZJUSmCVEnXWEMEqreBivpixG8TNQUEUA++4OLKlK8
	C77YD0W7dSrCJ3MY8D9t990/agd+gGznPSRmTA2Fo2zz3HFgKf661+KTpW7TkYBtfvmxq3Rt5lY
	iRT9hvs+iQTlGuF2p3rIXt2PkJbOcrw7qLGLG43XAEH/hYWMZpA4jpCaVSY9AdK50URuZRqI+EP
	W2iJ2nx86zkjANpY2OSGe9AYKtZX0dCdqgm1mYc3if4Mb2vrYCSrur8gLdo3g3y9j9AtAEO9aXu
	VjwU5INd+tL2q/p8tRuHOKHskcpS//r59KlU=
X-Received: by 2002:a05:6830:67f8:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7f4f227d276mr8198335a34.7.1787909105673; Fri, 28 Aug 2026
 02:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828071123.179670-1-dayou5941@163.com>
In-Reply-To: <20260828071123.179670-1-dayou5941@163.com>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Fri, 28 Aug 2026 14:54:54 +0530
X-Gm-Features: AcwNN1US7WSfZ25oq7-XBcJ8hx7fgmGhS9ze9BWZ_-55L1Fbw-jjvhmGdcF6m5U
Message-ID: <CAFqz8L+TjFmnKpJtChJA6c3O0TJv_O=A9Lb5bdzbVQTeFHg8BA@mail.gmail.com>
Subject: Re: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return value
To: Li Youhong <dayou5941@163.com>
Cc: biju.das.jz@bp.renesas.com, wbg@kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Li Youhong <liyouhong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 28, 2026 at 12:46 PM Li Youhong <dayou5941@163.com> wrote:
>
> From: Li Youhong <liyouhong@kylinos.cn>
>
> The driver ignored clk_prepare_enable() failures during probe and
> runtime resume.  Propagate the error so probe does not continue with
> the clock disabled and resume does not report success falsely.
>
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---

This is a bug fix, so I think it should carry a Fixes: tag. Both call
sites look like they date back to the original driver.

Thanks,
Vidhu
