Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794838800;
	b=CXdVfcqzlzVk9PJWpTyl6bpKR45ruS7SQCOQNKamFIUG93bveYnOxXeRsXCC4f5Tgr/3
	 JtGu/VCvAxGcAku7dBPTYIoDyTlBkhSirRL8ikgPnrloil54VETvPAepI1kvQw9SvGKnB
	 280qQ0mLgkTiKPuXUIpxJOZ6zM70nfNpcz/fymYg72hIzTMGDSDFkhOn8OczvXQqw0aVN
	 d0bPiJP7iESvUqR7jff82o9OcQjpKXJr3SIUsAV2TzU4cQsPFR25gJyIQgUvBBhH7MSLz
	 8c8P9Fro6OKMExSc/MkCdHyC5eLIL06xjbQONtP1m41d6v0GrTDOUUROFjBoO85PIRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NCkH8am+CesP32jpnMDJrTNEnxrT6Fp4c5piNhAYB/U=;
	b=n1CwggK677eOqoekg6v1v8jjYAMEX+Oo/G9Qf6ZvvC0fmFoN3vDngm676xqULmlAtCSl
	 4MIZxwQsHL57nBiY3CwriJMnCixC6/chREJW2TlrQG+7A4ZaW3yYuObgHLKb14awqdkB3
	 g522px2vTcH7xQYeSzZjB87RQ8RRCNkdtNo6jJ7BOn9/KepLHufSlEFZPBN3rZwgh7xM7
	 amSE8CHxuY3hNHlK2+Vvvb8RENFYsal36C21T9vOWII3R3W8TgSpBwZL/r/SouSBP1qGV
	 WXuf7Ud61o4iQnOEX7DpHWLxLvTxQSHVFLBq03RjPHt9icjcfj+uFbEJdBUNnEGV4ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=evFJZD34;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE9606A31C;
	Mon, 16 Nov 2026 14:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAAE9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=evFJZD34
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::109])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C6751205A1F;
	Mon, 16 Nov 2026 15:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794838792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCkH8am+CesP32jpnMDJrTNEnxrT6Fp4c5piNhAYB/U=;
	b=evFJZD34br3OHRs0gGoIN+b/2R+6bh75AQltPNP8tFO0JWQNsjG62pMtpQlF5V9xdYFYGj
	S5yhRph0JWnoV08N8ZdqKs/jMY4bSvD1yk+b0aXuievN0Ci85r764WaPnInHAm3yW72JB9
	dYCbw3bydaWeG447cz8CrxP5RYRDmETzW4vfN6j2VZtYKqphofTNivfiDKBDmyr28HJr3M
	9lgB8dQk2vk9woBp2TwfFo9AMYjUS6MdiCulYGkpGU5fPy9cfneeDBD/WPcUauHDr9GGca
	NKTbEQFYKt62uKZ/8WMf1U3FLG7R/VAI1SCU2ipLgVntRCWCa4qOR42FUnzP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794838792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCkH8am+CesP32jpnMDJrTNEnxrT6Fp4c5piNhAYB/U=;
	b=Zj6PSv0kJRMcMHZEcBfwXw94xSSQCsHIZCtHY5+oPxjC9aXb+sGhQHorDPbdXnbRXEhEb6
	ImRa+232s3FiKWlt3PYBJ7+C+h5OfFYhO0Se3gveAA9ajSzLKl3Rl8+3Bezvm8tVhoU9ca
	lKrzHQDUJBNGkRlIGdvQb1DfteFclD0icivAf6XX8JCXArz1hjtMV1hohESWd0/6fBDvrk
	boygNFXeYdR57n8e9R5KPEREnyH9kLJ/H3uTNF6DaT4cSKHLgI6rpLiQrsAIiP+O0R+Rap
	jSagc6yt3gnJPafwS8CRmPR/yaMIOoNOYGNSlbVMa+W+0QmXPMAwZf7ErgwKXQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794838792; a=rsa-sha256;
	cv=none;
	b=d7ZeHxQsS4YDHiBlEa1HicRjJ4TaeqsrvZbKkc6cEax65bXu3VE357E1zGztd2tUJ8wqa1
	UQVLaHslp1LFBOmVu9KyepN1JX/uMFAi1ek85AhZu/mfufv9nZHgvWwfpRRV7V5S0FLtVG
	0Mq6YDlFKlmW8MeMy3HhM+7cYFLDrvG50CuunNDJgitiFVcNrLou3FkTX8FzPBdnK4kyH1
	ZD69w5WPNNPBKig5ZyZkSE09JzAzF7IDX0dhSiK00XoZAVvwemoRvD2+bKmvkvdzB8j80O
	qMcfofvYQ5Dz0Upp2zECia7LNzbLrWcNrzhdojrhiBHmP+d4ylTJihudc0M5zg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id A80F91BFA16; Mon, 16 Nov 2026 15:19:52 +0100 (CET)
Date: Mon, 16 Nov 2026 15:19:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 33/35] iio: adc: ti-tsc2046: use default_trigger
Message-ID: <avsRCJ3tsoQkoldG@pengutronix.de>
References: <20261116014823.3132576-1-jic23@kernel.org>
 <20261116014823.3132576-34-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116014823.3132576-34-jic23@kernel.org>

On Mon, Nov 16, 2026 at 01:48:21AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Set indio_dev->default_trigger rather than taking a reference to the
> trigger in probe(). The IIO core now takes the reference during
> iio_device_register(), so it is not leaked if probe() fails after
> the trigger is set up. This particular driver has ordering that means
> this leak doesn't occure. So this just removes a fragile ordering
> constraint and enabled further rework on top.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
