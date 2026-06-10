Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9540D567;
	Wed, 10 Jun 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082637; cv=none; b=ZoNcOuUc6qQoWLmyj92mE7XwyBcIkwk+ntjiupGDEp3OfuHMqR8fzw3CCnvcLyQ4MB+xG1N4VGpwN3qWXXYtWT94tSpWDqiNe1li4X8oBj2XzOG7XwjhpaN4lMgqcG9+JsXCcNUZzUTrfu8U4nuhuQz2oRIxHxtrve8bqDlKsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082637; c=relaxed/simple;
	bh=IrvrWBJUPYJiLVkmBmbwMo2/NilKmJGMLakTYRMufdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFa6iFG6tHBKmWasHoLPRR43G9m5neWiWcdpoG8pnV4N0fIBAcpZg49uZqsKcmcDiNTl50zu5x/G+FyChqHTYS0N29DiIylmnxDBxY++JUlpl/lIy/7TMTTaI3rZdDyhKUibfFDkr/3cp37HPoGOQ7eLak1V+ADFNZD7UL4cfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2APRclX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2APRclX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38FF1F00899;
	Wed, 10 Jun 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082635;
	bh=v9MqVthuuXbr7qh4lo46ufIlaPNZ8NkonwQO2+RmQXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V2APRclXKe0aoKWQlYyBC177SIyTmhEqcSgVL9ulg/AgFK6cNZz4FJ33Gu5G3AIAr
	 Em73w98deB45S3MQW2qLQRf60I8AL6WkF8Ek5+YEfmHp5CMT1iV46zWJq0ZbI1F9GZ
	 S/jEAAFZ/fA1Y8dQaXiqUGhzWPAuYY8nf4LVLKAtJayKQQcxNzEYCFp9THy8yrPY8d
	 V4X8J5vq19zUiJzMGvm1WQFSJhLWG4vARgXg95q6I1tlCr+Qf0YTfY8vk4aeot3wYH
	 kmqj6WpXp67y41il6VOWFXuD0yJAqqYjBoliO0y/eR0XuGthSsq6w8zAE9t3FpuCVA
	 v567Axw9Cz86g==
Date: Wed, 10 Jun 2026 11:10:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duzsynski <tduszyns@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sensirion,sps30: Add myself as
 maintainer
Message-ID: <20260610-silver-elk-of-eternity-2beed0@quoll>
References: <20260609161701.52513-2-m32285159@gmail.com>
 <20260609161701.52513-3-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609161701.52513-3-m32285159@gmail.com>

On Tue, Jun 09, 2026 at 11:17:00AM -0500, Maxwell Doose wrote:
> Tomasz's entry is no longer valid, as he is not active anymore. Add
> myself as maintainer for the SPS30 to replace his entry.
> 
> Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
> Cc: Tomasz Duzsynski <tduszyns@gmail.com>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

How many separate patches are you going to send?

Best regards,
Krzysztof

