Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8338B7B0;
	Tue,  1 Sep 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225769; cv=none; b=lctX4eMn/woNofN7lpSt6LZSuJ50vENaKraChxqh+yYPQHN9227sJk0tOcjyfvId1Mo82yf0C219dSOQL6/Ww7JilGNU7qaMugRT0P15Ui8qTcR3vRgRXqyJi37FmMcpZP0LwpGkWfzlwukwB1TeFa1JTKNBT9d87e4i+XUps9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225769; c=relaxed/simple;
	bh=tF6XOUtrejWT8EVMO6Zhhxe2yMTRVHw+PEJ14jV4VTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMbS+wu7sbscO7Qc5qH7xzfQ0s3v9b/o8CgOrJtj1ILVxNi/ANnyFJ3llm/AlxdXeAx8vlS6fN5cEC+bjuiTVMDdO9YjwK2/nPTq+fIdA4c5DL3jmPUgQakrTvVM08d2DPK+F5q5UIKCPrd47nc22lDseXBg+p53RTwzx11UvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Wi6buP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Wi6buP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FB41F000E9;
	Tue,  1 Sep 2026 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225767;
	bh=Kuh0diH350mmX0hoYzwyiO/Y2NDLAM9orSUchM0wV3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q1Wi6buPedWm8HByLDmLbcu4csEQvPZMqp5ucvJrDGM3AMJxzthOIIXR6rNngB6vE
	 D0v0SXyi+yVCW5nMVbFX+E8NOh14uZ1LaxjmaKLht3q8PyYCLzuw9JMj7whXzvLQJD
	 L4xyl+miV7XIpkCEssbxPMasHDagfPlJsvy6moXO4lX8jDWFmMm3qDf/l+LEYn0Ja8
	 U+CdxPW9Ovgz8opakfAtrbPxtyh+tOa9hELGx7RveHHU0k/RL/yc8HUA7klmmbBLht
	 nRftAa1MpV+g2U8uHythJVlFSzJ00m2QBS3PAoMnY42/zkIV5Z4DHHBCRRxgXuUcAf
	 jqC0bouXZljBQ==
Date: Tue, 1 Sep 2026 02:22:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID: <20260901022243.740760aa@jic23-huawei>
In-Reply-To: <20260824035531.141429-1-lilinmao@kylinos.cn>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 11:55:29 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> The recently queued ICM-42607 PM support has two error paths that can leave
> the PM core's state inconsistent with the device.
> 
> Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
> ensures that system resume restores runtime PM management on both of its
> error paths, so that a failed resume does not leave runtime PM disabled for
> good.

These look fine to me, but I want input from Chris (and ideally some sanity
check testing) before picking them up.  The dead chicken test that they
don't active break operation when we don't see errors is probably enough
given the analysis seems fine to me for what happens on error.

Thanks,

Jonathan

> 
> Changes since v3:
> - Patch 1: commit message expanded with the practical effect of the current
>   behaviour, the cost of propagating the error, and a description of the
>   recovery path that does not assume a particular regmap bus
>   implementation.  No code change.
> - Patch 2: unchanged.
> 
> Neither patch was reproduced on hardware; both were found by code
> inspection.  They were compile-tested with W=1 and checked with smatch.
> 
> Whether patch 1 is worth making is still a fair question - it trades a
> possible idle power leak that may be cleared by a later successful access
> for a runtime PM error state that needs an explicit reset.  The commit
> message spells that out; happy to drop it if you would rather not take
> that trade.
> 
> Linmao Li (2):
>   iio: imu: inv_icm42607: propagate runtime suspend errors
>   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> 
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425

