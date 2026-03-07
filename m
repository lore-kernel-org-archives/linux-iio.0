Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAB35E94C;
	Sat,  7 Mar 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889244; cv=none; b=lqN2KGW/dLE4gn8Ou9fDNoFT2xc2l1U3u77Ayv4hpDkaZY0NQeWOEDf0lnAPNhE7pwIJcJ8v3xgEkFHSFQWFg0IG2wsnc8Ye6pDE+sWkDM8KZIPSA1EiAZny8aoRGrKIcs0/DBO83KqkeG67sPAFjKt/dI2PHA/XVUBvSWqYHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889244; c=relaxed/simple;
	bh=XlMEEXzB+WjMvOB+Oy4SuOD48pHVsx3JOsZamGOtvwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuNoZjs93WUI80dVj3ltpuSiKQJYdJ7WxNswweeGaoB0+i+IkC3353SvRx0niqOPn3D+Pw/9iQD5GLpjapFHOsfkWAD/LbNWxlv1UTO8Ro912C8W4h1DHN5k/OMLFqrO4GAurPpBBmjyhNRTyajQrcIYg30tYmVszNOa6Yqj9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P56EtmRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P56EtmRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1105DC2BC86;
	Sat,  7 Mar 2026 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889243;
	bh=XlMEEXzB+WjMvOB+Oy4SuOD48pHVsx3JOsZamGOtvwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P56EtmRSfaz3NuXB7SKevKkNm9qHV4u/7m9Y66Ng8pdfeFqD0HmRDY+Mxj1UUFIG7
	 VKpWpbbwikK+8YJLtI/18IMvDhDhvXCr81YX2YqQbV74g1VQJj1435XZyP0fpWQm+9
	 VMcxdj2/ViO8pvPNi+Lf+P4unxo5/Y7PtSlQ4d18A6AWNGFS2oIR6N9rUqUlMPAVCR
	 wpZIVtmliRd10p4QcNRS30S6KpgKi/BvEhBuudTfRDTVX08Z5F92hTKfLc4IfYj0o0
	 wUuGKbnfhaSFqgpB6He7oOumkr+08PywZ0IJf//iPOKRKCmjQrRNxerBGV+DyiDwsQ
	 2njXV40/glG3Q==
Date: Sat, 7 Mar 2026 13:13:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Xichao Zhao
 <zhao.xichao@vivo.com>, linux-arm-kernel@lists.infradead.org (moderated
 list:ARM/Amlogic Meson SoC support), linux-amlogic@lists.infradead.org
 (open list:ARM/Amlogic Meson SoC support), linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH] iio: adc: meson: no devm for nvmem_cell_get
Message-ID: <20260307131354.1875ff4b@jic23-huawei>
In-Reply-To: <20260304041716.7631-1-rosenp@gmail.com>
References: <20260304041716.7631-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 20:17:16 -0800
Rosen Penev <rosenp@gmail.com> wrote:

> There is no reason to extend the lifetime of this post removal of the
> driver when it's only needed in one spot.
> 
> Moved tsc_regmap assignment to avoid two nvmem_cell_put calls.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Applied. Thanks,
