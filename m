Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C023395E;
	Mon,  6 Jul 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360246; cv=none; b=KBTz402q4uYBlJ41n7/+jFQlrJ2DjPmOrtGj9UtDwCEueUvZkUNFmB7ke3Kq8vSXQq8Z9XOj/EQkRh7q34tjelRmvxDyXcJzpr+CeZdg+XDN3yNWpPVi50gHdS36/jI2ifzRCXw5jFWsn/aR3Xw2uYAY3H1sd1L3p4Lb5bbBKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360246; c=relaxed/simple;
	bh=M7W/zI2qzpr4+FpsTsLQ94CnIlwq7IoG6+S2X/Zn5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5FIwSruBdLFt5FiAF0NaQoBhHUY2+hTWORdKA9QNIChpnVaIeAr8Z1EVHIUQ9Jiq77i2ep5aPw2gxoAtbpVYYakPluxtFp0nUT8B5t+M/r7weB8n+EhvEWQQJoRMzqx5bx4mAt6xLu8WbktNpYQD6tblMrOSK5P/QDpakZ4E70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+bsa8lZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+bsa8lZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6DF1F000E9;
	Mon,  6 Jul 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360245;
	bh=DfohTVieCdu7CtpmjvR1yaqoWErI0Rmw5QMiv2FYx7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n+bsa8lZZOz1SsJsz6cUimhFN9gxSAi/Cye4UsGfEuR+saypnYM9WwgryAWWlRZUz
	 PPpatx0mSAxhsdfLu+p/DpwSgM8BhG5Dz7T6Lo1NBxhzhuwmd18XA8bCbV8Ug/4TMk
	 SWX2+myGHMSujYJPYYeDcCKUSZmwPIXx43a78PjUZOTp/rh5Jjf8kUojI3vg3OTcR+
	 GJWObnGDX4NFn7chkBnaSREgTd/+Y6h93mQwEcpaJKIQ8mayVAPIj5Lo23kdgH4vj1
	 NSlXCS5jSEZym4yrReDrMO+K5Q6zAC2yZ7F/rgS7gb6ucMaRaGWPA00hxIwZthjfjZ
	 MwUATeAZXWEJA==
Date: Mon, 6 Jul 2026 18:50:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v6 0/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260706185041.0e31ec94@jic23-huawei>
In-Reply-To: <20260706112254.1262002-1-shofiqtest@gmail.com>
References: <20260623140730.12574-1-shofiqtest@gmail.com>
	<20260706112254.1262002-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 14:22:51 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The MAX86150 (Analog Devices / Maxim) is an integrated biosensor
> combining two photoplethysmography (PPG) channels (Red LED and IR LED)
> and one electrocardiogram (ECG) channel. Samples are buffered in a
> 32-entry hardware FIFO with a configurable almost-full interrupt.
> 
> This series adds a DT binding schema, an IIO triggered-buffer driver,
> and a MAINTAINERS entry.

Heads up for other reviewers. This has not incorporated much of the feedback
from earlier versions.  Don't waste time reviewing for now.

Jonathan


> 
> Changes in v6:
> - dt-bindings: remove "SoC" from description (Jonathan Cameron)
> - dt-bindings: spell out PPG and ECG acronyms in full before
>   abbreviating them (Jonathan Cameron)
> - dt-bindings: remove the I2C 400 kHz sentence from description;
>   keep FIFO/interrupt mention (Jonathan Cameron)
> - dt-bindings: simplify interrupt description to FIFO almost-full only
