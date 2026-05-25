Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6F349CDD
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715337; cv=pass; b=opPukSA4VFP6JqBFkie6X6lwvQ5wYsjtnC0Ue+IvpH6ROgGY5XmovQCJFT3dQGAKNALOgQzwi8vccE6iaw7cQB8WmycOq6tunZRVbrZGuoOfbqVuyTqqERbasF9XIqhPeHExnBfz3IXmPQdVhhaWJrRVEM9c+o602Cs8V7WqF7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715337; c=relaxed/simple;
	bh=5vadwd1NT4LYH/6j75FTMd9Led9+b6Zc0Qn0mpQdLPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7XC8edxBzKI0G+RzEtTilEA7X9pB45t1srRrbTzc1tWLcUy/RztVVL8zey2MzvxOv6CLs5KBV5AXv6FvDbUcJTy5xqJ8kJZI0C42z0PvDiJh7PHEGNgS9bn30Qn9liFOyxiaoeIFEL7UMUR1iv65NYoKYr2wUg4GzEPciHfveE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSNcvgwH; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSNcvgwH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7ca947f9b00so88592257b3.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 06:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779715336; cv=none;
        d=google.com; s=arc-20240605;
        b=LNnBYUADXG1WcxC2sjY9qNOOzTsh2IkzANIFMbADr9z8v1C0uapnXf8EgptS5wiY+U
         Slws7cvy/TeEZ2dFplyLfyJu+oLD6RcTuAb3mZ/eYa4AJjBFhjZ4erEkVAdB6HuCkzNE
         CfiqUBdBXMuJIh+6prfcm0XYQUkOojXILSR/PXj8rIHqg+qWMryRbuS8PFHeIF7dXZES
         ini7b9uyiawPlaCKR9whNg/KHw3CwibzkmuZBsS1QdDvr5CyNIo+o9Bzz2QYhDqwaMWF
         fyVTxLa7ilZEbU78cpYiBNKOk/IdJDiYUzF2LcjvUEqOdimhHvnCwsTn4ZYcYWxw3j5P
         HZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6MFRTZKfm7Sb4pZlWDCvdf22hIS8g937dw+Nz2lPPE=;
        fh=CxOROdd/dvXWHGRqK42yEmkP43NIM4y2z5HtdnhCHw8=;
        b=aJbff84ZvCvLwBB8F96NdCgsxHJtM6nDGRfP+2dC4KHw2vfXWMoPSrt/nWFq/eul9v
         XZaNc28gQsFRCeEa8H/7bOW8c14qiwlodbVndVclZiSLJy6OT08DBvSdh0V3Mz7ypgwA
         A+DOsLRqjFfOnVUS9nKI+FYsV/MtaxYbCmtV4300xd8dZMnKW43ho88jfv5sRfBHpYXy
         B5HrJmMcu8W51wG8+x+KZ6Dg64UL2LKXHi4kMjNKoNLJH+xnW5KvQNFH17P9VLi60WJF
         QNRJON49HO9PuhtsobVIbN4eR/1scYWpoVHDvxkOdfwnIAs7C0WvB27oOon0s4u5tk56
         1hSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779715336; x=1780320136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6MFRTZKfm7Sb4pZlWDCvdf22hIS8g937dw+Nz2lPPE=;
        b=bSNcvgwH1Jr0Vupc9cnVVo5sgEztWkx7xTI66xrm/bPuP8sY3quWacoMpf2cWYlsDy
         DqPhdlbuD7JpMwjDTal9K3Y2MuJjO4DC5eLDrk9ty4J3YbwpRThB9kqzc/DJCPIia7PJ
         4Va56XT7fhkGWQJa/0aq6JVlJbwUOGVXH4QGHaARymVurX5uhYANFhahWgcrXIEDpI1E
         eSbi1sSvkt1a/c+HGqYCrrDHK1XIBjUd9PnBY5Maoy3XqKz8PCGvjjf7Rtcsyfg+tOhA
         39kdFHGYRvEy7BQjdEYZX+6eO6//hZSSEvXAGKWRyoooTMeU+OmGVnPWBHT/N2PM9RXs
         Zajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715336; x=1780320136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6MFRTZKfm7Sb4pZlWDCvdf22hIS8g937dw+Nz2lPPE=;
        b=XeKjuurKnt0DZD/pxMpInFlDOv3NdZw6OUBYlia6fYNq6T+VwjmaVnRe3PkkJETLNP
         nwWzI6JA2eSVr6K14lB9A0tWks5Hb7NT4obdwJa8Eerxk2qU3ljGZlNnZ7j7Tyi50Ut5
         Nap9jwlnand2YeKwntA/Nbt9p/pEkv0fNLM/5JlNq8pgIJD1Z/XV3UO8ov2aq6rWyRPt
         HfCZb42553YiGYhaKi0CQ4P+kM9PGFP7iXlVuyRSfevEtOZ6y745RmKegLj1+aMDFVHv
         zy7UM5zA3Rb2OkEjuenUvOqVIxyu0gDux2J10d2dyVF5P6mzCFMar08t5qb98tMIDguB
         p2Jg==
X-Forwarded-Encrypted: i=1; AFNElJ+dgh4tzknbJY8/IVQptIcbwOKiewRnTt7FkWPSvB9cbkmQ9OXOpJ4774KLg99+fcxXGDW60Plt3+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhe90E2uIbd4uXUY6WGF1OcEwmvIpeukuShdgEvPhhjq9OTy45
	cZtbaNbkkyGpUOzkF+v3uktFt+hpW+UbtTr8vRP5upGrItg6Jd61dHjjzwatmwbQHG5szO9AhiM
	x7199Q9u9yM2UWrY6BUmL6noWLdQBDL4=
X-Gm-Gg: Acq92OHU6uG8E1AmOJ0DfwgKmaxRzEKC6dqZFo4LkMwAwB8c+QpQ+UWN73SjytWZ5Fo
	pu80Zrt3bWkZd/oEvpJ4NdO8P2Kto3+UDtDR1vPe6ShKb7vpQdlXtwNAFohDNXHi3Vwyh8NDE/0
	DkoUNH/0J8FsrR/Odmr03OgxNyJMDM9xAd+5MQBcOcIHHzgTXpKbrntNXxMJXvMYhGhN1eCowCQ
	q6pJG2plckbn8FfI6ygiqON35YOxafnDa4F1ZzJ3/xesHziBWd4Xv2EzA6+ClQHHzO4PNand8hW
	nBVxVMU=
X-Received: by 2002:a05:690c:4b0c:b0:799:198d:8c5a with SMTP id
 00721157ae682-7d335fbc537mr157076197b3.34.1779715335747; Mon, 25 May 2026
 06:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
In-Reply-To: <ahP3O2tQdu4dNx_c@stanley.mountain>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 08:20:31 -0500
X-Gm-Features: AVHnY4Ln2oRkoa1-22uMDmFE_zBvuUlsey06Dkg0x_igMH6mKJTzwvAP3cl2ceg
Message-ID: <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
To: Dan Carpenter <error27@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 2:17=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> If the *ppos value is non-zero then simple_write_to_buffer() will not
> initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> going to work at all.  Check for that at the start of the function and
> return -EINVAL.
>

Commit message is incorrect, it looks like you're returning -ENOSPC here...

>
> Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iio/industrialio-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 138ebebc9c0d..4763e224ebc6 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -156,7 +156,7 @@ static ssize_t iio_backend_debugfs_write_reg(struct f=
ile *file,
>         ssize_t rc;
>         int ret;
>
> -       if (count >=3D sizeof(buf))
> +       if (*ppos !=3D 0 || count >=3D sizeof(buf))
>                 return -ENOSPC;
>

See above comment.

best regards,
max


>
>         rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf=
, count);
> --
> 2.53.0
>
>
