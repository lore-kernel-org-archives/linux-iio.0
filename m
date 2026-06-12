Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAF39901C;
	Fri, 12 Jun 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286033; cv=none; b=l5ae1AYj0R1IOLu77HUEZWV5JDpXI/iFqMR7seqnt36Gw4Vwe4NGM3fSh1DRX10XMSiG8O7ZaNp1iFxlVPOm0uh8U6dR0YSKZiVtFgWh/StMHVNdieBsyUKiqmHeLgtxbE/S7H5Nh6esxdpRHTTElhlZlvKBUtOf97pJNpdm0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286033; c=relaxed/simple;
	bh=T9icJ/xqgLPqrYhSWnPFWzmoEXORXRk8pF0qSJLXlcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnjKYzg0iZnVUO0bmwAwOMPGWfWgk3VblMUr5TRsRgOn0FWVhEs3R+YLeFTTrsReA3u9jj1TdoTcY0A3oFblxP6B3Ah1CvoeQsOLewrHgMYFQNFWYj8L/ruCouKDq0V5RqhusmUJq1ppiUzwmwlZIbLjDly46jdwPGOzuCOucHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuisr8F+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuisr8F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287151F000E9;
	Fri, 12 Jun 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781286031;
	bh=T9icJ/xqgLPqrYhSWnPFWzmoEXORXRk8pF0qSJLXlcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nuisr8F+45WIiEeQ3Sxhciek01C2PLQNpSUsX4AqrrgivMHOvSPE8uIHmuhbBYRnU
	 zjVTkevHdXQwQ1IS/bQMqum1BTVRW04AYfwjqcm40lshMRAQfqvXYrxJ9p7l8V7pzd
	 VKADnIMziTzpJ3kYqy+7sDiJRyn7gc7ctEsB3OkJWOGCM0IKOKjlnRT18mTA/xglQp
	 wll2XJbvOZomdqM7tzVmEy4CpDiI+HRofpbH4C/MwJqiRYF/FOtnwMwTOJ/Is6wHr4
	 qa6ExKyDg4i9ws9GVG9prBF7vBOoZ+qS8SA/V1osOCdyJVfcihsCUXNTTczFtq19l2
	 vNeDieicOlumw==
Date: Fri, 12 Jun 2026 18:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <20260612184027.22b08f3d@jic23-huawei>
In-Reply-To: <20260611134245.30042-3-email@sirat.me>
References: <20260611134245.30042-1-email@sirat.me>
	<20260611134245.30042-3-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026 19:42:30 +0600
Siratul Islam <email@sirat.me> wrote:

> Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
> argument alignment, and add field definitions for BIT(0).
> No functional changes.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20

No blank lines in tag blocks. It breaks many of the scripts that
run on the kernel tree.

> Signed-off-by: Siratul Islam <email@sirat.me>
