Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7A282F1B;
	Sat, 25 Apr 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131035; cv=none; b=YT+wVuwcHMDmy5Q8ssvTAZjv6PdY5cAu+nCy+E0eUYmBIsCLsUa023ZXTUaXS8/5ERKyjj8QlJverOJxnn11BRrT7jv5mcvgtFRqjzr5Q4qmqNJ1yL1PwUCZuJwOohosv048HGFMxr2anwwQ5QKpIx1pMMfv/NFG7Hlyjx9brng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131035; c=relaxed/simple;
	bh=LP17QttSwLXI3MgSLOda3e65XZuFE88BUegQMkuSjqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjX2RktCFr+aO8d7gPJkbZYTjXFKq7zbRHGMktMGkFLrJU+C4fpGYk7ITokq4C2Ni8oyqlMRSwfsiI25pJrC99u2HxxN73xY9v56f1/igmLGEtPlpUC3BKJTQpNGIYQGAWUuM3Osl7bUiojLz5npOYynYNDnnSxxUPhGylzIplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+7fs2Tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+7fs2Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC87BC2BCB0;
	Sat, 25 Apr 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777131034;
	bh=LP17QttSwLXI3MgSLOda3e65XZuFE88BUegQMkuSjqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+7fs2TlqSlzU2wHFlphir7S2ddw1F3AyPryOaH0Lyt3yyONswcmfCfN7RAaMqKcn
	 iWRlvRHClZWodOHogX11Zw4hgTDBRzSLtsydEQhw6bbVxdI04lFt5SZR1GcK3MgQou
	 dcKpTrvgb/prK5PQ8LudujcpW5zm48O+FxeIm+SDU9+jz77cRXoP9vqcYeK+xav3oR
	 aN4hW/8xmBOIPIbdQGz50Og0kgd2zObLtQuN7S/8RdaJccRHVsU6Ro86KU75M+acSG
	 0TTorOBEgNxaOPfQyTtfc6E01BuqeKsPwHuGhiCiSkUo7AgHXPxMEi85d5Dfmay26X
	 LDVCEm/N5Eyrg==
Date: Sat, 25 Apr 2026 16:30:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dan Carpenter <error27@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: adc: qcom-spmi-adc5-gen3: Fix off by one in
 adc5_gen3_get_fw_channel_data()
Message-ID: <20260425163025.59db1d00@jic23-huawei>
In-Reply-To: <69fbeffe-1a8a-441e-a4c2-a1fcd3d41421@oss.qualcomm.com>
References: <adjM_ZXs9IoIYjyN@stanley.mountain>
	<69fbeffe-1a8a-441e-a4c2-a1fcd3d41421@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 12:15:41 +0200
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:

> On 4/10/26 12:12 PM, Dan Carpenter wrote:
> > The > in "if (chan > ADC5_MAX_CHANNEL)" should be >= to prevent an out
> > of bound read of the adc->data->adc_chans[] array.
> > 
> > Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---  
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
This was waiting on the char-misc pull requests going upstream so I could
rebase my fixes branch.  That's now happened, but I will rebase again on
rc1 once available (as a pull request based mid merge window isn't the best plan!)

Anyhow applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> Konrad

