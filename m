Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D20257843
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427020; cv=none; b=DrVvfTx4bft7+a5EMnEvyvJXtfwPjtkXHixsPfvvGe7iXF26JRE0eIbVNwwTYaM9WsDWYZqzlEJKAwExf/GqshwVbE6zvuul7mV83TyrhUKCkeQD7gpL/F0FkNFkA7T3jHGAXJpNQN3P8Wv7MhgLktKEaI5+Z43MvNIcyhNCt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427020; c=relaxed/simple;
	bh=Hg08va1NfeGii59zk2DHu0XkPiNAL/Bra9Zqs3KObiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPCn4zdTqeSgGJWcbdxY0xgzmUWooWw3fLOcWyfNIV5AENYFcmdGdehLpH4TU5K5AY0Hv3RSqUPQfwNVxc/4XGtgbsbcq6Qj0G7xUig5kgyn0NFSm2tuGLTd5pSRlu5QOoiyWHAQzkBWl7T+cvIEsf/L87VKdIjKwWR14i67ctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so4619753d50.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 01:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427018; x=1775031818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hg08va1NfeGii59zk2DHu0XkPiNAL/Bra9Zqs3KObiU=;
        b=Hpl1WnflZtW363s/1m89eVdMRMKg08pCFi6gU9tQ8RiMqquROd6oJYV1XVPAJ3JEuh
         63l+qfbG6MF4kHo8oAtZoh7PyMG1ExYv9h+ayX0R+qBkTUvvCdlSfnn1tqlJn/hVVsEW
         Ay9KYCFyQLeDykXwPzHZqyCxzGbas78ufEMeNu+zGjSZjTeun4eOXX5UXWY0/LjPUdNJ
         0vYp/0rCTyb8X8eAzaRoeM/FSBl9qTDX6q7DpS9Q439nH8fnC6AKSJXXhop/GSZZzZsl
         l5PmcNo9dari6BegImaop04cAe+atZXrvi6pNtrrb7EFYurKv0XmiqRZ+UFSo3UVPK8m
         JPiQ==
X-Gm-Message-State: AOJu0Yw1WPNhB0BoIsL6gai7UFKWuUkZtEV1oFG7W7NnLKWa69ZGStyy
	b3XulelfghdO6omKVoBaDPOsvjUOYe7Ea68yD37/K/yrBs7x/k0byC/giKzfZ9rq
X-Gm-Gg: ATEYQzwGlZCkh5dMfYUwVI9i1GM5y0zSNjJRMX6cSjTiPqiMHGOQhb1aRPtisxJAHkG
	U/T/iZ1CGUouY7ZTbUfeN22cR3cfKrOjPtPNFz7Lq/gT8ZgIK2pTOmM4VYXllsRFOlPLBshQbXD
	r/YTsal8mvtnRMhKyTs9/pFQ1Zu937V/FV+jhAs/lTcybCphU62V+kfBHRPd2t3uNIB3t6mOmn1
	XKf3Cur+5PKHQgFLp4MzpB9jVljxANk/PVCsnhO54RKHvj+3QVyZ6OGnJ/kxVLSZoYFXz//k3fg
	EFq17eUadzB/tuqPSHK3GE3zCHG1PXyEj017JyyqXAWbdY0yPcPBMRA/4hBmwjX9pLg47cdCuVe
	rSsz+KMSXMgex5zctRLkPkM4z5yg9MroXRkv95oYzcw3Bb0QRsL7b7lNsI3KtvY3GK8t2Mdwa1o
	yQUdmZINeCMDskbxheGUeE3RgGlDm3gDxC6gRlWcWUzezI0MXz9aUgMPhegFD7wCmrfFu90nfiN
	F60vCGoJh7K8V9V/IOSliKW8D+kYqTiuWwcrxBUa3fRDQ==
X-Received: by 2002:a05:690e:1442:b0:64e:e2cf:519d with SMTP id 956f58d0204a3-64ee60a7f49mr2367255d50.24.1774427017896;
        Wed, 25 Mar 2026 01:23:37 -0700 (PDT)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com. [74.125.224.46])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7dcc9sm9008418d50.12.2026.03.25.01.23.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:23:37 -0700 (PDT)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso4558747d50.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 01:23:37 -0700 (PDT)
X-Received: by 2002:a05:690e:dc6:b0:64a:d672:dafb with SMTP id
 956f58d0204a3-64ee6073950mr2268673d50.8.1774427016800; Wed, 25 Mar 2026
 01:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325063254.18062-1-email@sirat.me> <20260325-perfect-locust-of-serendipity-b0cdfc@quoll>
In-Reply-To: <20260325-perfect-locust-of-serendipity-b0cdfc@quoll>
From: Sirat <email@sirat.me>
Date: Wed, 25 Mar 2026 14:23:25 +0600
X-Gmail-Original-Message-ID: <CANn+LW+_VPJ12ESR61xmq2Kw5+q4x=++C_uXckf_YGR_Lxms8A@mail.gmail.com>
X-Gm-Features: AQROBzCb0c1yCGK240KD6g6MkgsnRfjcUsb6bd4H2kW3AdpCENOoiKdIVAWTitI
Message-ID: <CANn+LW+_VPJ12ESR61xmq2Kw5+q4x=++C_uXckf_YGR_Lxms8A@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:55=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Mar 25, 2026 at 12:32:21PM +0600, Siratul Islam wrote:
...
> > ---
> > Changes in v7:
> > - Add VL53L1X_REG_ prefix for register defines.
> > - Use iio_push_to_buffers_with_ts().
> > - Use continuous ranging and drop postenable/predisable.
> > - Add comments for XSHUT reset, default config values.
> > - Drop vdd-supply description in binding and comment in driver.
> > - Add ABI rationale for vdd-supply to commit message (per Krzysztof, Jo=
nathan).
> >
> >
> > Changes in v6:
> > - Make vdd-supply required. Add descriptions to vdd-supply and reset-gp=
ios (per Jonathan).
> > - Check reset_control_deassert() return value (per Andy).
> > - Use volatile table for result registers and caching for the rest. Als=
o mark write-only registers.
>
> So where did you explain dropping tag as I requested? Did you read the
> exact paragraph I asked you to read?
>
I dropped the tag in v6 and I was not sure if it was ok to modify the chang=
elog
of v6 when sending v7. But I will keep this in mind.

Thanks,
Sirat
