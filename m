Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73456274670;
	Sun,  6 Sep 2026 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666876; cv=none; b=k413AtqliCDsD8y6THr8sWXeaKOKWN8AIOwHxKAyM4RG9RHFfQfiraZfLHH7+GZpE10vvHxyhzgiDGIBnsaQTXUZE7MWPJbOdCnSIvkTWigrO+GIg1cwXC/guvz8T1jplWrzTdD8RPrbixSV7XDiFSRzEPYD+e5x8LnLbQYevpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666876; c=relaxed/simple;
	bh=SqqaPpywbkGFF+nDgU2ULimBfuNeb5IkAVDDivCoO5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoNc5vWDAkWTziPKE417ZQ4Rh4SE079xfa6YG3MuCTIyMDiOx84zin8ofWED0EdNdDZj+GkQoIiKCoWOCuOVjBtce61GYHkS7emAtxDf94MfskWdH0Sxvr+s4S7fhnVRjp/CqV+sHwfDb8ePmgD5RAXDY6G+NgQk/kfXXjpnv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI18wDlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI18wDlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0B21F00A3A;
	Sun,  6 Sep 2026 03:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666875;
	bh=jIPclx7fD8rtjD2TzRmqu89RETbtSvh3t06cIpVaXXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OI18wDlgqy0YMyPK8x5F8A383Mg7/xdHHojj/g5nMEgP2GplOF2ABhsv3BBsOctbv
	 s5UHdCIa/AvqFOhczCQjL6Ku7GsEbwS7LEY1egaXemIWIRC0G0aL6eTbalwV/Ml3OD
	 1kNdR8Vejvuvwql9fS74XyKz5JaKowFp6nRD3YxPbTOEhietNVLkRZulxUTCmW7ClF
	 YRtPN+NMBqUN8l8pO++dNhaj+ZmE5PncLR7FkF5mo6Nv+PmavykeF9F0jo7c7stbKs
	 9Pn2Il9ExChmsFmFx3ZxGeGoFRLqlOG2535w2SWm5o6QwK5J/rtz4Ptk2tawc+lszQ
	 9XgEDVRLaaC5g==
Date: Sun, 6 Sep 2026 04:54:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tuna =?UTF-8?B?S8SxbMSxw6c=?= <tuna@tunakilic.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260906045428.4f03494b@jic23-huawei>
In-Reply-To: <20260904125100.185128-1-tuna@tunakilic.com>
References: <20260904122513.175298-1-tuna@tunakilic.com>
	<20260904143848.00000d7d@gmail.com>
	<20260904125100.185128-1-tuna@tunakilic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  4 Sep 2026 12:51:04 +0000 (UTC)
Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com> wrote:

> On Fri, Sep 4, 2026 at 2:38 PM Joshua Crofts <joshua.crofts1@gmail.com> w=
rote:
> > Can I ask how this was found? Manual code analysis or AI? =20
>=20
> I noticed it while reviewing the driver's range handling and then
> compared it with the MCP47A1 datasheet. AI was used as an aid during
> the analysis, but I manually verified the datasheet values, in_range()
> semantics, and the final patch before sending it.
>=20
If AI had anything much to do with generating the patch then
a tag for Assisted-by: LLM is appropriate as part of the tags
block.  Same if the bug was found via LLM.

The verification is good though.

I'll wait for tags from Joshua on this once testing is done.

Jonathan

> I don't have MCP47A1 hardware available, so the testing was limited to
> build and static checks.
>=20
> Thanks,
> Tuna

