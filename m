Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658061;
	b=KQhzNInyHb/m5am2GMdZY5Jxg1ZzG2niOfoDPk85tJTX70kNIjhD5Ln5gxTf250YHFlD
	 zpF/s+iicb2vT5FrwEkrqxRKeDMF7ssUrdzKvlbhiCiSjOpcvT3Nc/SH9zPu79MH2rx3d
	 j1VEj6m24hyzca2bPAe0Ho5auwUgWFxahT7wH6UmGpWHffF/LjaDUC5ts2iTBwevQW7br
	 qMuK0GOqWRGylymVES2fSuZQMKFwcWqR/P17+f+xMiDsd4fG+6vpgaJZjOL9QXAGZuvTk
	 hcRuxcdKWYnT/rY/xOhd745u+VwUm/rB+M/8B/r/GLA7IsV4ytVHfDEqB53WWmx6m1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658061;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+Hw9sq9VaFK71g+8WnPVyOU4RYJq80Ol7r4/gNdfThU=;
	b=qtnnhLXvPwkscrQqTozpyC01e3yheFyp0sn8la0YDqxb2nHnY+7D7IBhOGXWbEqUxqPY
	 n3VSN/MK2ZQxoV2p6lNsbyf++dml8/E1uxlQz8a4nZrv30/jNhtSMRyQPoE5D7XQvMbI9
	 S56YByqOEdD8Xni4/ySU8KSCbFi9dLUOhI9J3U5mD4E/INsKj0K7pbXXUhLpVqDkApKpu
	 wSN6Wzef8kirbknCZgVarjnyyKarkToSLGYsdK72fQtExy7RZELiSY2bkq9tvUJQrDbci
	 luCBK/8BAILJ4AsRLK0qYWESMbund2TLuBxqISc28SiKPLxtqmPGFgagRUS1MnGHUtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEdNqHBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A10606A324;
	Mon,  2 Nov 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEdNqHBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D3F1F00A16;
	Mon,  2 Nov 2026 22:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658060;
	bh=+Hw9sq9VaFK71g+8WnPVyOU4RYJq80Ol7r4/gNdfThU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XEdNqHBiKdOsOWdik/MVP587AiHnPUcW1lKgfFWhoWVgpKG2WIMS4yLFJvaOMP/+c
	 d3fcSW17hfMtxIDqP4cdipsiCVuA6r2Ybz06He6i3+976/1OiWuU4MxUY8drEi5gWU
	 bgpkQP/F9octYIYVEExDqRIrgLrGMK/LgmYDP59/hxgLB426ArkdtXJilvJ+6QO3kk
	 OnpFNmGAyz7bC5ihp/0JvF9Tb1javi5SD5P0VsJ9CBKPQ3lPWlOE5Oq6SObJ9eLaua
	 MG75Kb9sfere/9iLMWKHABad0I2YGpmvYP27xFI964KIyc8FJAjms6lwe+xN54PJ8F
	 WWTAAh03whOZA==
Date: Mon, 2 Nov 2026 22:20:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Vidhu Sarwal <vidhu.linux@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] iio: proximity: Add Benewake TF-Luna LiDAR
 driver
Message-ID: <20261102222056.30f23d75@jic23-hlaptop>
In-Reply-To: <21b771dc-e9cd-46b9-a456-0950ae1270a3@oss.qualcomm.com>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
	<20261102-massive-busy-woodlouse-8d0bbb@quoll>
	<CAFqz8LJZQ+tw6wmLS-1FXvt6OxBESPEyz2-uK4D7B8X8epoKhg@mail.gmail.com>
	<21b771dc-e9cd-46b9-a456-0950ae1270a3@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Mon, 2 Nov 2026 13:23:56 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> On 02/11/2026 12:48, Vidhu Sarwal wrote:
> > On Mon, Nov 02, 2026 at 11:47:56AM +0100, Krzysztof Kozlowski wrote:  
> >> What changed exactly? b4 diff fails, the patchset cannot be applied on
> >> any known upstream revision I tried.  
> > 
> > I am really sorry for that, I didn't realise it was based on Jonathan's
> > iio.git (testing branch) instead of linux-next. Patch 3 conflicts in the  
> 
> That is fine in general, I'll wait for next linux-next.
Might be a little longer. I've pushed out now. Was just waiting for
anything nasty from the bots on after rebasing on rc1 before pushing
out.

J
> 
> Best regards,
> Krzysztof

