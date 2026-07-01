Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF93BB57;
	Wed,  1 Jul 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880887; cv=none; b=p6AFETgVgn0gBL0xe9gG8j/NUtDsBTLjIUTgez3NNNHeHqEaLiNj8XZR4UGVzU6YsvmVEBTjIGwHGA8Wtx1+doiIfmRgGLGPSMjEk+/Oe2LfEfCKpAVHMczWDHzjQErG1AYODrWe/3D68+ecX5AF8T0mTFNhquU7h/P0Ei5KbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880887; c=relaxed/simple;
	bh=bpuuP/pctebarV4zHLAWQ+Eu1Aacl2gexT7cNnLZ9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1+mqpX5WNLCr7/n26xtlfBLQGh+ddA8VZzhUyYMjQ0uBJNQhqpysMf3OS6aGhFizqEPSswT3y4tiY+BgRVdRdmSZU1nqu8jr4z5wD3nbfyKMgl5XDNV0Qhd52wFy6viJQGv9qzNB9sHxoas66Mw7PsGwMQIIFbAPgv8VMSw5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6E21B201955;
	Wed, 01 Jul 2026 06:41:22 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wemlG-005WPL-17;
	Wed, 01 Jul 2026 06:41:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wemlG-0000000AfMX-0w1w;
	Wed, 01 Jul 2026 06:41:22 +0200
Date: Wed, 1 Jul 2026 06:41:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ti-tsc2046: Simplify device handling
Message-ID: <akSacgGql8AG4zLn@pengutronix.de>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
 <a3329201c27a1f2439f4b6c1c89cd1949dcab23c.1782833415.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3329201c27a1f2439f4b6c1c89cd1949dcab23c.1782833415.git.u.kleine-koenig@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Jun 30, 2026 at 05:35:34PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The driver was introduced in 2021 and since then only supports a single
> chip variant. Simplify the driver by hard-coding the device properties
> instead of using the id_table's abstraction for a single chip type.
> 
> Also drop the write-only struct member dcfg and the then unused struct
> definition.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

LGTM - Thank you!

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
