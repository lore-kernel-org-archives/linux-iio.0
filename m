Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655837C92B
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567396; cv=none; b=KpsiXpJv9HxjIMwl93i2QlZMKz9NNXNfSB/wc24ihtkqf6CW1xfgKZmZdETs4Oh9E9zuyydrqFhJL66jzgNWZU6B56qGbcXouOrjY0gtAy9MzR7rr46UnJ+nsON40NHNs7GWd4yYSkO6M44zlx7ntAd/jbGfSSk3AxzI2By6Rwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567396; c=relaxed/simple;
	bh=bf7OXJYrDzR0xg+YlTGqYfese00L4BLZyQTwoNqUEFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFrcV5JjvkvHNWbGN/QQYlQCK/kYxnscPZZE3OWZt96QBVPg191oZYseHpreLmHa5jfx45pq84dVL4ZYkuzR+PFO6BqU+mVlItNZ3ek1HooITJrpJ42yVWe21lM9xMHA86S/02gfcYZ3gfEZioW6jKCMxEYlB/Ibv54m5VX2Cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-798578e2918so56036527b3.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 11:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567394; x=1773172194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+2z0zWJzxCsKpo1ZYV84wRSE8MelG00boJ8gBQ4fw8=;
        b=WZ7ZF+x0ig+IcTH7g5oM4vfeJNY7cxs1327g40lEfijYiuTeqyjAjQWH//KQWeUV0l
         7nn5U3Gcj5l0rSGrp4dDt4C6SDY4Jb1iI9terdVRFiykRCaQHdO794/K8rv/Hsf10JJL
         olFCA2T5/0spPekEJyNE7SN3V7cpIwwWlNFU0IzKpUvxWjX+z+MXWqce7PlaNnfTa2W5
         F3wpZvLrcN1ucoDaqNm26HPnmrVHp0u/98z0W3M/SPK6iVLW7Q05mh5R4lUgEjYiGRmH
         WAW59WIQl9u4pqYGpAJW3p9j6psqRgKHTk5ec6dR0fH3JTDsPzBjcIgYATDZcO3ttDZR
         b5Tg==
X-Gm-Message-State: AOJu0YzriSvHxqt6KsFX3KtrA0l4NE7xBYePMT+Kmo1voNzYFQ2zSZoO
	8izUdMuSCuZ0dOx27Ery1/yrw7fauwO6YNkCAMgp+dCSwQKhf6Anu19+uf1MBa7G
X-Gm-Gg: ATEYQzwKD704HbqKtz9TlbNcMyBY+CZTylZLUMFxbr9QGIv691P1G0ewqZb2tIQyY20
	p3UkpOVNKj7YIsklRppsHUK88/58HydZjkaEF/E/TcWcwzZr6lvwcFJBF/eKxZKOYiVqotJDaKc
	kADbTUiQUpyKDwfpF4MH07tz42eXyVrWxrjFETz1ba0IVSzm62HJrqR5tyhbdvml2YB/prWKYVQ
	pywjnIf7o0VHi9UgH81tDiRpgzG8IfFZHaUm+ToyIZds9ElQx00UyO6Kou+rtGBrfcfbsH5okHA
	vrxDrNAp6nSzf/8pME6iYKJLlrzZd+9DfdsqLC6AClPUzaJFQAswM3SSZegscnCsrTH1FbOWt6u
	sfUU6enjW3WrHtvjmwDn9AlxKquZjITy0KEAUGy6wqlEz5AVyw0Kq93PH17kquxD+AI98Kr4PpP
	9VnPhWbamALJoJ3agzOv8suiSo2A6UuAEI43A5PVOJkgBYohRI2N2uW5Gd
X-Received: by 2002:a05:690c:338c:b0:798:6c28:dd4a with SMTP id 00721157ae682-79885517629mr161477007b3.26.1772567394117;
        Tue, 03 Mar 2026 11:49:54 -0800 (PST)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com. [74.125.224.52])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a91a28sm67191027b3.5.2026.03.03.11.49.53
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:49:53 -0800 (PST)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so4507954d50.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 11:49:53 -0800 (PST)
X-Received: by 2002:a05:690c:a:b0:798:13ff:1250 with SMTP id
 00721157ae682-7988561e6e6mr158386547b3.51.1772567393468; Tue, 03 Mar 2026
 11:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303090253.42076-1-email@sirat.me> <20260303090253.42076-2-email@sirat.me>
 <20260303-strike-froth-a2e082b8b59e@spud>
In-Reply-To: <20260303-strike-froth-a2e082b8b59e@spud>
From: Sirat <email@sirat.me>
Date: Wed, 4 Mar 2026 01:49:41 +0600
X-Gmail-Original-Message-ID: <CANn+LW+kWoTnw32Db_T4t4JCCcCRtUead53i5tmc7Xeme=9X-w@mail.gmail.com>
X-Gm-Features: AaiRm52QcrTO1etlzEZjEfmU2lfgcYxrWAOjQ59uukPR70KXooqvqzaWX-Ugrok
Message-ID: <CANn+LW+kWoTnw32Db_T4t4JCCcCRtUead53i5tmc7Xeme=9X-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, Mar 4, 2026 at 1:12=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Mar 03, 2026 at 03:02:40PM +0600, Siratul Islam wrote:
> > Add device tree binding documentation for the STMicroelectronics
> > VL53L1X Time-of-Flight ranging sensor connected via I2C.
> >
> > Signed-off-by: Siratul Islam <email@sirat.me>
> > ---

> > +  vdd-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> Are you sure the supply is not mandatory?
>

It is mandatory. The driver uses non optional devm_regulator_get().
Will make the binding
match in v2.

Thanks,
Sirat
