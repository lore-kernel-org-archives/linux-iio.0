Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7542EEE93
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731392; cv=none; b=dWpISSxDtwIY4ZWQmQjepqAduL4VNhUaGnZHFsVErmsRAg+NWkMjwm0l9LRYmG75zaWth5ZMDDBULbvEjf0Y7/Gf/gbGpb1/V5zi9lFGCM65p4xwVmjfW2ZLGen2BnNWd8yxDutOA6ULBi2YSVMpcQU4tFXgb51hxcg52I4cEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731392; c=relaxed/simple;
	bh=In86mLNja/BTrKVSUMot1THphmLb1CA0dynoVkOov0Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=m+XyQq/CSMWXZwAhFkSPNRSnngtiMh84nzp/NTPFN7PUQIRkIapkz0oOm1Y+o7JvPMqWTY1qVfK1kDk9m90pnOHembXGY03t7ys+nmM/3Nrxcw9cKAZ/aJF/yrJ6OsSGYLL5hlNMhePtkGoLbc0AuG2awgi5I8Hc6PS4Em3zoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=nLAMviSa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QwzqPJuF; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="nLAMviSa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QwzqPJuF"
DKIM-Signature: a=rsa-sha256; b=nLAMviSa7n4WfsCoV7VmV3QW8gAAGYaDxtIzGjnOKgM5LZpIdz06HDcwrlrOQPk8IlJZuK8RqY2XkswqLHgs+NowY6tNvCN3iL6Me/d1il3QlEZjTK8QQHAyr9am0texcFZLb8EJEAXu1oY4ZPQgiueFslxPDfAEQiKE8XRe53DhKwySnhYFMCR74IYm2NqyTMPftFYG4EfwbV3XywGR6SBf3FAkkIq67NqLT3LYTAA9QsQ8eu848/hRCMTCs017w3nVzIDK3Nma5G2wpae7nAKXGmIhfyQY/UUyyK/6vkkkpJtOiaKU09cHyOHa/hpmU9a7r8CGnUpdjWpbitgNOg==; s=purelymail2; d=maxwelld.cc; v=1; bh=In86mLNja/BTrKVSUMot1THphmLb1CA0dynoVkOov0Y=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=QwzqPJuFB5xgQiETEUlSwxl8Aq7ku3Y79yGf4uSbQVNAbDKivsue3WhQaXfQCSrYTeLLDm3mJ5d5qmBDXAvNGEO1b8kX7NNZl4e2ESYJrDj5gVLP9Vb30bxwF1HgXIj5tU+IMXAV4i3VWfYpqVhnSt+IXNqDU8llIQ4GgjG6YX68ukacQJYgGfAmNMDhb/tT67GBgj99l662sJZ74zfr1u5p+mVEsptVmQCdU6Pfqm4A7D0LNODWZ7blamjuHJM48xwwI89AMb2BqNp5HriMTrzAkTapAKoi904FABuu0ae5nyQD2t+F01WvQTvFa+KuuFtuVMATFnQJv2tTNrYwJw==; s=purelymail2; d=purelymail.com; v=1; bh=In86mLNja/BTrKVSUMot1THphmLb1CA0dynoVkOov0Y=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1849703559;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 11 Oct 2026 15:09:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 10:09:30 -0500
Message-Id: <DM23RGDMAP30.4KFLP01K5LSM@maxwelld.cc>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rodrigo Alencar" <rodrigo.alencar@analog.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261011045149.353929-1-kapoorarnav43@gmail.com>
Subject: Re: [PATCH] iio: dac: ad5686: fix channels member name in
 kernel-doc
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Arnav Kapoor" <kapoorarnav43@gmail.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261011045149.353929-1-kapoorarnav43@gmail.com>

On Sat Oct 10, 2026 at 11:51 PM CDT
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The kernel-doc for struct ad5686_chip_info describes a member called
> @channel, but the member is named channels. W=3D1 builds report:
>
>   Warning: drivers/iio/dac/ad5686.h:95 struct member 'channels' not
>   described in 'ad5686_chip_info'
>   Warning: drivers/iio/dac/ad5686.h:95 Excess struct member 'channel'
>   description in 'ad5686_chip_info'
>
> Rename the entry to match the struct member.
>
> Fixes: 0357e488b825 ("iio:dac:ad5686: Refactor the driver")
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Comment-only change, checked with scripts/kernel-doc -Wall.
>

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

Thanks,
Max
