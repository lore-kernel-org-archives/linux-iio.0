Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE217A303
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736401; cv=none; b=inTjUR/cfHJyKPgtxPM4bH7L4cC2b7gWQpekV3uatEp0+OmbJCOIE5HhCNOOYItTlSQugPZaXl5/rPlt2wuk6tkaJpgWdLOSerWnzNObUYrztR4N/M+FBiHiXzQcKf23I9Dsnc6mVF1CxNKDg7GWn5eeM1tI946luEo1NvMMlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736401; c=relaxed/simple;
	bh=MLZ3fF2adwZOR6sFDAE4hrov221DCiFKz/yQBEa2j8w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WkqSNy6kszT7UXfMNRy8q9BDYl1HMkunLuWPTrf7VP3w8e/DGZkVjTLxrl1xiJFFCQLcYzIMvK8P4pobvFwio1NTn5R5WOL9X3K4HfIeD+9DbOn/48i1E7wxse5BzCM2u3PsLl07r4ikFKFrEgAONewvO9ch7/0jRz9W0eqW/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1VXKvOX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1VXKvOX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2429f98d0so20419935ad.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776736399; x=1777341199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKuWhubs2jffoAGuZik7i2LnsTPtRcMNffaFHPjYq00=;
        b=U1VXKvOX/up0F8mdlSlmtaVzpnKhmgMfqCTMDXP5s8XenNzK1FlOrMT3rsiYNLuwMA
         vjfoGmeGmF/dypoSO/rWe2AVGHsG+8HCVct9SyBf1HqqVEXCQOO3395qgXt1qTeBvvR5
         nTB9/gdOdUbyZHiyrx5ik84Qz2jgOesGz/iMWkARJ1nIKyjin177ZzLFwlwPBJbjleqx
         hwHvN1Sye9btPAA8WFru5GL8MfG0fvrFYd7N9Iasd1iy2c5CwUUEkX5MOUIyYUB6iQDq
         /sO+708tdN23bkEaN4Qe+06nO5fXNWm5Pz5aBUJd4t1BL0jG+1dv1zuijIbELgCxNRPs
         O91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776736399; x=1777341199;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKuWhubs2jffoAGuZik7i2LnsTPtRcMNffaFHPjYq00=;
        b=NKIuPpdbjvQjmfz18dU3MfFKeade6xIUwAakYSk33vjZabnSDQShrVTBE9RBjRwYfb
         oUt6IsRe/GlEJAeIJUu1LzCnstkkKz/na4pI8rWUE5sxfweLSSqz0h9tpuKvE43I/7Ps
         CJoRJqetifEPmY5JH2Ex4XR94/JbJzzJDe/iokyqOf2T+6bhhP18pdrjTxY0JTyEm65b
         kCdd77JJy55ZR2CXOOXhQJX17so1vY0YuswBfafPf+S8/mONle/3d43Jz6SXXzYXSDcL
         7Wfz4uZO890ChYpj/hDc+2rcp0YIdSmYT6nLdEXSGMx8qojDx637on23vX21Tqjvsp6a
         3V3w==
X-Forwarded-Encrypted: i=1; AFNElJ8kk+xJIQ3eXq08vfufD0tL8JqSAYnXun0AXue0CZjTsdT9H416v5Gj6jHDcWmAbYtxZ58xZ0YvgBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFpHYPNIjh8lYXOviEcz6qVlI9GOwJ25ySCR59H6wD8quzjYG
	fe+L+zDlR+GnjJYkLaotPQNSjRv94ZUtTKyHlH4bu32tkqiT5lcnSv+OKlJUcQ==
X-Gm-Gg: AeBDievn++c/GEgHyfomKlaS59ZIqDegd5I/sjC2EIcqxhSSWZo/x9oLrPaFdRPxzpM
	ehdSBjwICqeWq0Xiy3XBUJOQgpl+p8rtDCSGG/Lf1yW2I7cdcxOgG3E17AihqaeSVrzxt/4kaOJ
	eUgaGKF3kHqTcRfvi1smVJVUwK0JCNBp/ZSvL/7zRimNFRBbWGEkg2jXCX64QQ5PoJPWOEUc658
	eQQKddKSo39IBN9PyJaiiZC0dZSs/EBnVHFRqF68y5jHvu4Io+06K/KinOLG7G8gricZqORs+Uy
	kgaAaHb9aADl/xAJevb9adSV/9eOXMmwMTGFlsN3gzujNR55Elpv9qwmBrjVOKmaBmee5Qc4rKl
	VcyU/Pn8Bl1NjDj3KokWIQBXZr4bQZmplCbMNlYJLtDE9k4/L40lu+vSBSbI55/gd3g+zHzQAD9
	nrJ4BOqNfuoLa2CL+i8Por1PM42xk6GiyPCxN/z2xXeR959NnWYczYbYBPzyznngpFEcNJ
X-Received: by 2002:a17:903:907:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b5f9e77061mr154975445ad.5.1776736398902;
        Mon, 20 Apr 2026 18:53:18 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae21:d323:b31b:43e0:4f1e:901c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3c067sm116610065ad.76.2026.04.20.18.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 18:53:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:23:06 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
User-Agent: Thunderbird for Android
In-Reply-To: <CAMuHMdXCYxrCoi7zdUfmbgxXwdwiSKB3YczG-odUQLgvUJ9HQA@mail.gmail.com>
References: <20260414192045.3598010-1-sanjayembedded@gmail.com> <CAMuHMdXCYxrCoi7zdUfmbgxXwdwiSKB3YczG-odUQLgvUJ9HQA@mail.gmail.com>
Message-ID: <67B89EF1-C05C-4317-8E8A-A8DB87748457@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 April 2026 1:36:14=E2=80=AFpm IST, Geert Uytterhoeven <geert@linux-m=
68k=2Eorg> wrote:
>Hi Sanjay,
>
>On Tue, 14 Apr 2026 at 21:20, Sanjay Chitroda
><sanjayembeddedse@gmail=2Ecom> wrote:
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>
>> Use pm_ptr() so the PM ops pointer is automatically set to
>> NULL when CONFIG_PM is disabled=2E This avoids unused-function warnings
>> and follows modern kernel power-management conventions=2E
>>
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>Thanks for your patch!
>
>> --- a/drivers/iio/accel/mma8452=2Ec
>> +++ b/drivers/iio/accel/mma8452=2Ec
>> @@ -1744,7 +1744,6 @@ static void mma8452_remove(struct i2c_client *cli=
ent)
>>         regulator_disable(data->vdd_reg);
>>  }
>>
>> -#ifdef CONFIG_PM
>>  static int mma8452_runtime_suspend(struct device *dev)
>>  {
>>         struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(=
dev));
>> @@ -1812,7 +1811,6 @@ static int mma8452_runtime_resume(struct device *=
dev)
>>
>>         return ret;
>>  }
>> -#endif
>>
>>  static const struct dev_pm_ops mma8452_pm_ops =3D {
>>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_fo=
rce_resume)
>
>You are still getting defined but not used warnings, as reported by
>the kernel test robot, due to the use of SET_SYSTEM_SLEEP_PM_OPS()
>and SET_RUNTIME_PM_OPS()=2E  Please define the structure using
>DEFINE_RUNTIME_DEV_PM_OPS() to fix this=2E
>
>> @@ -1835,7 +1833,7 @@ static struct i2c_driver mma8452_driver =3D {
>>         =2Edriver =3D {
>>                 =2Ename   =3D "mma8452",
>>                 =2Eof_match_table =3D mma8452_dt_ids,
>> -               =2Epm     =3D &mma8452_pm_ops,
>> +               =2Epm     =3D pm_ptr(&mma8452_pm_ops),
>>         },
>>         =2Eprobe =3D mma8452_probe,
>>         =2Eremove =3D mma8452_remove,
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
Hi Greet,

Thank you for the review and feedback=2E
I will update changes in next version=2E

Thank,
Sanjay Chitroda
