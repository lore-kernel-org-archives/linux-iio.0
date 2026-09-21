Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3542BE053;
	Mon, 21 Sep 2026 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951973; cv=none; b=G1hAv1qdX/03AoQVpGlKT2EoPE2vBloct1+hbIULmJlNe+Fo9O0EbWhD8rNcWs9mdNFcJ+1Id5aN1UawLuv7BtSp5gMvkchuaXLFgPai369Ib9bccPsBCmnsFA9JaOAxblOzh5yIfiaxkblcrEQBF5SMLcBHL5VsIG4ak504Qxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951973; c=relaxed/simple;
	bh=kLKSwtXcpejSvpB+VDpGFL1O8Lz/Q/w3ZYTUSCEe/Yw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dH9T/BbmGv5CnQknTkkYKgh+L/I0sLFQZYz32npcx4IuI5kkFjMsipOZma6LgAxK38BgJGfcA0+gYUC8ou278/MtpSVILvXFs1PqdAMmRDjF6ImkrmqyxXNV1AOqMby+t3yrqq/IyB6jwDVFu/U/Ha3bDpV5dqKkbQK73qY3ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlF6Wabb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlF6Wabb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDC1F000FF;
	Mon, 21 Sep 2026 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951971;
	bh=aKswkhExMpqcj2WU4L3sGt75fXtJv1eL2kQtFFDoDIA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IlF6WabbTSF1MlMpT+9f5cRnRjasA4tnpt5Dna+IstriLBS4MFVt6JMFZ4ALUCZvf
	 ilWdPQDOBBKFbWvsL4ddQmDgoQ/tyBKF/O+cMveOwBbUYtO/4Nk64KldvonTUIciSn
	 UIo/ELrjDXGiD86N7KKRkIfqPL0NjwSWOXG9VV28Aadleg2KOvX4RcnpSPyLWh30D+
	 FzWYM/iYkCEkcYjXXcvBBwbpESeZ4uYUfvdofjVnnMTGsn+8jY+ww6zI4xfr2xoV6A
	 D+VEuPTczY7tZIeB6/wAHsNsVgA1YJvrG3/gRnO0hlV2WmjQKcUrR71Goy6xp1cWrn
	 RHB9o0g/E8w9A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 07/10] iio: accel: mma8452: Add comment block for
 struct mma8452_data
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-7-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
 <20260916-mma8452-open-drain-v9-7-0dd24fa2f3d7@geanix.com>
Date: Mon, 21 Sep 2026 01:52:37 +0100
Message-Id: <178995195773.928090.4574643769779647971.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=938;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=kLKSwtXcpejSvpB+VDpGFL1O8Lz/Q/w3ZYTUSCEe/Yw=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsH/Y5WPn09boQmN+ThX2T8wrzFiI/r66GEyTp
 2LKIcTmk6KJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarB/2BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiLN/D/9WomLrqEtdzTzs0quvmJ93K1h2QEcTw/o2UMYR7tiFYOC
 nZSgWiujjss6qVR4Ope2mdtiPnFEyMtQkRrfDHDdfBwtSsaVPCqd1+SCQgtrfa7pPQ7OiHuDFd5
 Biggj4y7ihp2BO3yyuol3nxlFV9hPtKv/YHpIu3/SWJJquLo3cz51uufgcFr5pQh0YnsNR7QskR
 v4LZs30+3FtEUb1j83BpTHmHPqiCUALfrVO5WbP13EWUI6hCsurucjKrPxHkF7PNl2bs9QKqGEU
 xTHzIV9pEd6vOiVNXEGvxV3xZ+BatKUqQ+h3Jl4khbtjoAQo/aY/bo3d58DnXj0m4+XXwSpremj
 hfL0LkTuF/361+K8wR/nP5S+8svz79UsdEk1wWijCE8f4Bfoo8cRwISDRm4L9jUblSmRA6uvovq
 EUBJf6+kI95dSuvbbym4VsOviBsjMO2aeqrz9NuwpJHM7ii2lSYRtHgRGANN4a3W6OvG0EMhozm
 pfWua6A62cb+bRCRak2Ss1VatGbGA1qwRFaP7dsyA+Ds2JgO+itipjVOEqdVWOT/9/oprIC/6Jq
 JLFEZr6OdcOOSsY9VKuP4QLb9E9RUE6FfsWfHWTB7XUNn0Q0W/0gRYvImZmtNQXV+SfU0FQXpxC
 Az0njZy+JOWXwuj9SqnXusPoU/OZUz2Pp5PqDEQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The struct mma8452_data is central for this driver, and it makes sense to
> have a description of the fields in it to make it easier to work with the
> driver.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b70bc8638128..223bef4f7baf 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -104,6 +104,21 @@
>  
>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>  
> +/**
> + * struct mma8452_data - IIO device private data structure
> + * @client:			the I2C client object
> + * @lock:			mutex for synchronziation of register

From sashiko.
[Severity: Low]
This isn't a bug, but there's a typo here (synchronziation).
-
If nothing else shows up I'll fix it up whilst applying.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
