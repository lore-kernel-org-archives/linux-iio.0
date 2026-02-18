Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDF1EBFF7;
	Wed, 18 Feb 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442446; cv=none; b=SQyafuf1dRoFowGxI3NMSaqxgJaq7eHkEovpwXH8zgeUCI+mtu5V9KtGtBju2PwtJ+XZ7Qf+iUCGxVE7SV4U2BDlhc5kZSTFeFY2Qj9faL9oeK4MK5Val67m+nSaCZAOSspw/XOFnFFNjdPNz49NgJXQXtre2YoE3gJUSnobkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442446; c=relaxed/simple;
	bh=syW+YdeJQYh71EcWxwtbw2IYB85iAjGbfOvhC7XyEVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjANJxisHStQFgI6jRm6I5axsRrQIKW7N9syd13cMoArxMv00PnM+RiQ6VdAKj3PFA/lGZFBSYJBR+s668rRiXZPEWas7fLKZQo4ckF7i5nbtAkgB1ApwYC61r6eUB+kEh7xh+rRjF9VAGhEBGq1ZbDoAv/EjuknZvi0fVTrG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neb2InzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neb2InzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8D5C116D0;
	Wed, 18 Feb 2026 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771442446;
	bh=syW+YdeJQYh71EcWxwtbw2IYB85iAjGbfOvhC7XyEVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neb2InzVyGJKPokMKpZg8Gd8K/+kxfWM3z4bZ0RX807P2P5GvpRdu5MbScqpifsRv
	 nV/0zL4AY5nwzNI07GnS9vED8Q9MzOnWnLWJ9wYtNqEThLZgf7bS4kDv+cn27IvrmU
	 zi4waQ9J9/3c6XjkaxvO1Zqs3sKRHrRCajmUDATV8u+ohHOU/wMpBXSSszLiJwRQsn
	 kv9nWIjLIZyG5hWDnh8k4me/obN0FTNtJoSthur3gNh3gBNLm4U9Y7H/wGGvm8cpg0
	 vece5rjl9J5p3v/a8EzxAl/HCP29Oh9qccjlc8+sQ/JoCYRFahhoOVNzLJAufADuwh
	 Rrc5/dwo1N50g==
Date: Wed, 18 Feb 2026 19:20:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: tlv493d: remove erroneous shift in
 X-axis data
Message-ID: <20260218192038.30d48bb0@jic23-huawei>
In-Reply-To: <20260210164951.8511-1-antoniu.miclaus@analog.com>
References: <20260210164951.8511-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 18:49:50 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> TLV493D_BX2_MAG_X_AXIS_LSB is defined as GENMASK(7, 4). FIELD_GET()
> already right-shifts bits [7:4] to [3:0], so the additional >> 4
> discards most of the X-axis low nibble. The Y and Z axes correctly
> omit this extra shift. Remove it.
> 
> Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied and marked for stable.  I'll be rebasing in a few days anyway, so
happy to add tags or indeed drop the patch if other reviews come in before then

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/tlv493d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> index ec53fd40277b..e5e050af2b74 100644
> --- a/drivers/iio/magnetometer/tlv493d.c
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -171,7 +171,7 @@ static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
>  	switch (ch) {
>  	case TLV493D_AXIS_X:
>  		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
> -		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
> +		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
>  		break;
>  	case TLV493D_AXIS_Y:
>  		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |

