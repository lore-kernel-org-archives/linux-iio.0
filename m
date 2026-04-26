Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CC1714AA;
	Sun, 26 Apr 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209709; cv=none; b=e3gg6e0/Hp45iCpJ8Brwj7FRXu7W+81JamRhXkw/iXaoYqlgVQiFWS3T57Ff1+Sh4+Gpy/FZ96g2M6R8HC9jwoMwOv1KCGHfQfYhYghOLJX1qzqpuvt4V2zc9j+0h7J5pMvJrQwl8RGsTbyxr9asLYvpvYWOFeCdJLxO5+7XK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209709; c=relaxed/simple;
	bh=w4SN/AD7W0aohDEFNq7hlt33ytIctV2qzxKpMGYskgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS1m0Dj+1lEesCvtGRwF5owVSeN7wT6oilG0IdD1mOLas1GhQoUb/KSG6+NJt9eB0cb4nV5Lj+j5ScXk0qTdZdXKmixYBQrhCe4fkpfpmlPITmZ8LMWagJCvwrVefy2tWkzfkYU+MODjmWwNmSCArFQCQ8BgUAMxCH8yjLKNXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO2UrJka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO2UrJka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C24C2BCAF;
	Sun, 26 Apr 2026 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777209709;
	bh=w4SN/AD7W0aohDEFNq7hlt33ytIctV2qzxKpMGYskgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oO2UrJkaFzdAhrULz0QaAboUF6sC6CduTDNhnSVbOdRMrvOOsu+e0i/oXtICgy22D
	 d7KFGDYBYQfq81DCFNyg0zaEJxmnskTh7L+JBHVJqZ92DWPKGmhlmFboweBVhObCUM
	 W5TTYWI+veNgHX5LkNe9x2pfuMn9ID1BckkwdK2gqTslP/tn5BRc55TE5sNY+fyU9F
	 QQNSeEB4/pkqGwsTzd7vqlxQEIOckmq6JvtgwZ2yLva8BwJcT7h4gyh7N6sQFXHtNo
	 mhZpv83quWit0GytNboW5SG/Y3rntQTyJTb7DUrM8sQY1+zZ96NM+dIofZ0kaZuQI8
	 EtNlSYgHOBTxA==
Date: Sun, 26 Apr 2026 14:21:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 phone-devel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] iio: adc: qcom-pm8xxx-xoadc: add support for
 reading channel labels from DT
Message-ID: <20260426142137.61072daf@jic23-huawei>
In-Reply-To: <20260426-pm8xxx-xoadc-label-v4-0-0ec782362615@smankusors.com>
References: <20260426-pm8xxx-xoadc-label-v4-0-0ec782362615@smankusors.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Apr 2026 20:39:06 +0000 (UTC)
Antony Kurniawan Soemardi <linux@smankusors.com> wrote:

> This series adds support for reading channel labels from the device tree
> in the Qualcomm PM8xxx XOADC driver, along with the corresponding DT
> updates for the PM8921 PMIC. Also removes the redundant error logs when
> reading values, as returning -EINVAL and -ETIMEDOUT are sufficient to
> report failures.
>=20
> This series also includes minor refactors such as remove redundant
> error logging and constifying pointers where applicable.
>=20
> Tested on Sony Xperia SP (PM8921):
> > cat /sys/bus/iio/devices/iio\:device0/in_voltage7_label =20
> usb_vbus
> > cat /sys/bus/iio/devices/iio\:device0/in_temp12_label =20
> ref_muxoff
> > sensors =20
> iio_hwmon-isa-0000
> Adapter: ISA adapter
> vbat:        267.86 V
> dcin:          4.82 kV
> ...
> chg_temp:    +1071.4=C2=B0C
>=20
> Note: the sensor readings above are incorrect due to pending calibration
> fixes are not included in this series. This patch only addresses label
> visibility. The values are expected to be wrong until the calibration
> fixes lands separately.

> ---
> Changes in v4:
> - Constify pointers in read operations
Whilst I can't say I care that much about whether we mark everything we
could const, it does no harm.

Applied patches 2-4 to the testing branch of iio.git. I'll rebase that
on rc1 once available and push out as togreg which linux-next will pick up.

Thanks,

Jonathan
