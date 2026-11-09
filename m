Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794214022;
	b=yEkWhT4STe206nRBMnAHkxElZOzlPWRZ81giPr/Z1zoQ1NSy5tb45mzlR4Hst6sMAdBx
	 PwWHbmuBKcumjzPelZJxvhcq0TqWAvisCNxVcSgvun1a/3K8k/CpVZ564yNf6gcVKyZn4
	 kuiRjjIy11I4MsvqCcnEIyc9773QBVvMa3zFJS9mHXzLt1ewRO1G/XVNgLdgABLHWOwof
	 IXL0RJC21oM7qUDidqao2d3q7zhfz4+5K++hPzlRdfaFdHeoyAzF8U2Z8+d1wnDn6P6K0
	 F3A1+48IqJa4YVCmwZ4kyDqjje+2X8cswsiWavXJAKGbpVFg2AaMco6veOBzQuYhZkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214022;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p6+qnX849jp/6JD+pVHbvJqGOwgNSqvsHvAosu48gKE=;
	b=hzrFt6VSXdkDehPAxYPYb1fw/W5oT2Fd6PTdajTlVJwsTZ1E9gmyLkNYKj6+dD3gXP+T
	 vNpm+NwaK4/2gbW5j7hNa5Mj6w5eZvfqrgrXBH7Xb/3hu0XOHaSGdnOAc5eNEaH3Vfty+
	 +7aDwwy0YSeD4+yTc9s0dKsfsKqmAKIpd8g+O4is0E9nUylj8eoGMNg8k0XoFsPF9K3Mw
	 Sl/FfciKUpC6tMqSEE8Yx0HX5fnox6CZ3Wt/Pkz6FaFrls6S+OM3iAppi4DiRA2t+Ob53
	 I2TzSIn1sHOrGu45MP6DYY6OBsHfFmR/8Gl/V/HmhK/sp6/jQJZf2PRn93OJWsOPq8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cR4NptMk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488A606A33E;
	Mon,  9 Nov 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cR4NptMk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794214021;
	b=joUjlQj9B36vNEmRQZnPcL6n93O0xapZB9y2mYKm+4+N8qMxpOKpYEov77aiWTRGccrI
	 zTO3p8tpaCN83CtUdZB7Y74LIv11rBoxs8n9KsvCp1UfMGiGTWcpX++/lbPiY2hW/IIi/
	 0W4sDd85PPuftrMwULJhJl2G49jxmg17QaLUajVOuFUKQa11cqRzclAlYjHcVqzw4siSK
	 Qd0CQuGoQIpQoaygmFQgC86ZS+5Qdt+iV3Bgjayov7WRLipm5q+YLY6N1MWJ821HBgPZo
	 0RK9XWR52vWwBta8UkEI+yqwG4+2i3iuYSYDV7CgR8iH1y+qDjbj9UD5MiUjRc7gA7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794214021;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p6+qnX849jp/6JD+pVHbvJqGOwgNSqvsHvAosu48gKE=;
	b=ItKdL4UJH8JH+nCv4Ck6TDwvbZxTYC5IIV0COFRn/vEH7oJYsjrPsLUaqCawxbHQMbey
	 DajwS4aV29w7b2m/FRi2/MeBspoG8g07uIPNsrckdJ/Ah9h/csZ9pk/RSYVtmEFHYDxsX
	 IkNnzfZrwYlWgCB6Z2vgWkDtBICHqPm1VbiUwGkPgBPgCFwFE5ab7C8+zc9wgZCWeCTS5
	 zsCZLnsOIiFhRawf9tdaNfGDfjoC2H74CQKyx0Txqqevr77CiHGsgR9i2VA9h6WcFVr3x
	 pJLd1E9LuDCaqpn78G+rdW7X4seijtTS4O24hu6fnsdPzqpxfSbmldDWCFtkyfVLe4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 2EAD31F0089F;
	Mon,  9 Nov 2026 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214021;
	bh=p6+qnX849jp/6JD+pVHbvJqGOwgNSqvsHvAosu48gKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cR4NptMkOKvU2B1seiOg15pv1v+0ndJlc4XgdLwBeWxFx3bhEq9KovQFlDtC4m2pT
	 pHx6najM9uGT1XR/vz9tfHSSYLMtGj7z16rB73/Qdbpub6su0raBmasuAZilD9qSX+
	 vvIMWitsxtKPT40BwZE57q02b2nwLsALhqYlg37Bq8J+zNW9h7gMfBl7dY8YpHtiSc
	 EsQxpOp/8L8XkqQ17Ko2Llp1k4Wk9c+ENUwLWiSx9bI9gf1W1TZrol/zW9rh7vUWQy
	 XEaTUpcfYvRCn7H/VebSPOx0fzeRauqdIK7Iyc+vjwSK7QMiLxrCIZfSROlCnNMAQV
	 Ka86d39Ku384Q==
Date: Mon, 9 Nov 2026 09:46:32 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Song Qiang <songqiang1304521@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Waqar Hameed <waqar.hameed@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, Jonathan
 Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 13/14] iio: light: vcnl4000: poll own trigger
 from interrupt handler
Message-ID: <20261109094632.00002649@kernel.org>
In-Reply-To: <20261109042851.1326940-14-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
	<20261109042851.1326940-14-jic23@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 04:28:50 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Keep a pointer to the driver's trigger in struct vcnl4000_data and poll
> that from vcnl4010_irq_thread() on a data ready interrupt rather than
> indio_dev->trig.
> 
> With the driver's own trigger in use this is the same trigger. The
> driver does not restrict which trigger may be used and the data ready
> interrupt is enabled whenever the buffer is enabled, so with another
> trigger in use the data ready interrupt previously also polled that
> trigger, running its consumers in addition to when it fired itself.
> Now samples are only captured when the selected trigger fires, with the
> trigger handler clearing the data ready status as before.
> 
> This removes a dependency on the trig field of struct iio_dev, which
> is to become private to the IIO core.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/iio/light/vcnl4000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 911f8d1c74d4..cab6e0af8c7e 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -206,6 +206,7 @@ struct vcnl4000_data {
>  	struct vcnl4200_channel vcnl4200_al;
>  	struct vcnl4200_channel vcnl4200_ps;
>  	uint32_t near_level;
> +	struct iio_trigger *trig;

Just swap near_level and trig and you'll eliminate a 4 byte hole.

-- 
Kind regards,
Joshua Crofts
