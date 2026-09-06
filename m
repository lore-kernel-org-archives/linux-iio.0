Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CB3A7F78;
	Sun,  6 Sep 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717589; cv=none; b=SoivEv1gqvHLk6TZI1X/IRMpTX6B2nvu/l3r9o/MitQeq+DbT3BT7TCD7ZD/9QdRdzxMzegO15UnP/SXEmlm183HamX2QPbYc748w9QhohIitcVpOzw//C63kwcU5RZUq6/zFh+V3cDu5aCAZUmnE3A0avTdckT7ePxNxep49ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717589; c=relaxed/simple;
	bh=iuYBiY0jnf+su54owWt+6SKD2ac946FuIq7oNQdA5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJT05w6VQEEShAE4riIkUGLia9OkFag1WuCP9GjMhLNsRzIQvtUNyNCKcSO62xSBde64GUMJ58h1O5hC6xN0mVHNdJH6SY6s+41aOsz0pOIklqtI2OkIGkZ3ml+V59lS3jAAhCZezKG8HHCcb43c2G6Hl1ucJi8yngK6Muj1xDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciq+cjrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciq+cjrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D76E1F00A3A;
	Sun,  6 Sep 2026 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717587;
	bh=NqRJj4shv8kz41iTiZkzqtrQTGH1w7ksol4JB+8gtQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ciq+cjrvvQjsSLRkFiNJ6jNqaFPoY6jwreHSElJ5lOAdXTTTtsSq/b0EFJSDAZXdA
	 Wu97bI+Zz3nOoNYZqQqby269UeHlJRTypDoDYn+4qLz8wP7bZzLCxwegUnvRQLHAAD
	 0lV0E4XIA2kySOM0T+dB7nXgtgjvZc5vVxGeCIH5UdsXQ3agysWjMwG6DxUWKlvVyB
	 QwvVr17L9NBdlJPpyzlsBJ7D3UJ67KCT4rn48cEi21Q+bJak+M6F0X1W3fo0fMe1me
	 jasfL9ppRJ70/hS6EpwKv3Rn8cEI2QwxZGfTzmX3YIBHVJ+zWMcg/rKCS6dhfSH+LG
	 rbqq2GxkItt6w==
Date: Sun, 6 Sep 2026 18:59:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tuna =?UTF-8?B?S8SxbMSxw6c=?= <tuna@tunakilic.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260906185942.595251a5@jic23-huawei>
In-Reply-To: <20260906090802.1282585-1-tuna@tunakilic.com>
References: <20260906045428.4f03494b@jic23-huawei>
	<20260906090802.1282585-1-tuna@tunakilic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  6 Sep 2026 09:08:06 +0000 (UTC)
Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com> wrote:

> > If AI had anything much to do with generating the patch then
> > a tag for Assisted-by: LLM is appropriate. =20
>=20
> AI was only used afterwards as a sanity check for the datasheet,
> in_range() semantics, and the final patch. The bug and fix came from
> manual review.
Ah fair enough then to not add a tag.

Thanks,

Jonathan

>=20
> Thanks,
> Tuna

