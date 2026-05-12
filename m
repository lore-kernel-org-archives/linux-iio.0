Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B336A37F;
	Tue, 12 May 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597811; cv=none; b=sJU81oZvrWsRd0PNWumvTynA57OjUSsWpbqW0vI/FstASlrjmBibWj7iYGH/RKm6asSYL9VbwMpykn9I5L7xZoG9KWPiZVLN/zNE3qIYgbWcM1Dq2hxdGJWfxk84FGE7e6+9S3367d4+wRC8JnTbrJYbZdPGU6zqHTjISa6XyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597811; c=relaxed/simple;
	bh=X7Rj3vr/hEga8Oa14GUBBAxAVe9FSsqs/jIniTnQfw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmwLUs6lxqX0TrvlGFAewGnVJSL2LleIhi+qlXkWtkWRsHtWRm4MtaS3pkIhsI4iUPqwEPXvhqtR9S2W3I6FhhgR93fmnzVOez+CYFRlJgnW2N+0BMwGo2e81tP7zKi9i/s8n1bjY495v2kFgQk/FPc2X5vS99sfjn8KuQJhKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa8XURt6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa8XURt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D19C2BCB0;
	Tue, 12 May 2026 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597811;
	bh=X7Rj3vr/hEga8Oa14GUBBAxAVe9FSsqs/jIniTnQfw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qa8XURt66A/NXEPD564L1g0anorMORaD4p5c1Tgh2p60/hdIxqIgu5bPGZCbcUbJb
	 qpLG0uQPUHouYFjGgN3jTjofLISUtgg8Cif9nROf9AC6as8PNmhd9Cb+mmcCMBKIax
	 1uRpAyDDpxJpuB567bvzV7DecmSvqtup95D4ocs9H3c/6lkiZUrVBtp86++Yt65+BK
	 tim7SG8woLALOi+tmtTr5BAvuI20DjsG/7IRhoHVqhy3UY78G21XNiwBJTrQOeKXSM
	 nJ1wgHtnPmzWHMZ+Am1hOAEPdphW0f++eHqs2kwOljK8WBWPpgIxNIX0qz+s2fDmHw
	 WATowAXC5/qnw==
Date: Tue, 12 May 2026 15:56:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 4/8] iio: magnetometer: ak8975: consistently use
 'data' parameter
Message-ID: <20260512155643.6213c4f9@jic23-huawei>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-4-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<20260511-magnetometer-fixes-post-pickup-v7-4-9d910faa28b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:26:13 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Some of the functions use 'client', some use 'data', and some use both.
> Refactor the driver to consistently use 'data' in all cases.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
A bit of fuzz on this one but looks minor so applied anyway (leaving
patch 3 for now)

Jonathan
