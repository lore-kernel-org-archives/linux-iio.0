Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF03624CE;
	Fri, 24 Apr 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052381; cv=none; b=RMzRwkv5dDVywV1eOY/OG1sTmlZ3w7yM74ImjOTtTBkrOxhZnoPJDO+2+SRtknyKUpK5bsmQc6USIjexzYthr6kKuCVeBsqVrtiAVefA+8uiul1aYkXJvL4lvZMHVF6Fbjv9yXxZA1w+mdSYF5frDyNwOIK318oDhG9kYZdVbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052381; c=relaxed/simple;
	bh=oQrLBoc+m9SsO7aM797maqBTBBIi+UIqyX4AF7PxQFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRJgYE/8qSgDbTMqtNPE3vpTxBVyembXFTafVrS4Hu1nAwRhCir2mfYj02xTg7qP8xm0tChUWAq+zsCLp2odmMrpQkQVFIU8FpVfolvVggjAdzs6plTM/1QOdVLyOqiQmSaKyKlc+wPNyuMq2+foZlSf9UHTXhqaFicJZjinfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4TMhtlx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4TMhtlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24845C19425;
	Fri, 24 Apr 2026 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052381;
	bh=oQrLBoc+m9SsO7aM797maqBTBBIi+UIqyX4AF7PxQFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4TMhtlxyMW2OBtFfknouS0jlcCBCIFC16OR+NspSpqWAkw8IE8Zd4lFiNkZXwWl2
	 8NG84c6kZHNEPnraoK5dXx40HXLUXfj+lJP01p1Vi4mB0GQoWPGpEjk+ajptciyQaq
	 +eL/5UW8dPjrpJC1k7v1HpceLXSeDdgfPPKuBzioVLwAou/EGiSYXTevfq9fo7sKrQ
	 bf0IPyczFuJ11WmL/Eamvq0SMUQs/gHYdE63HdWxziEyrEBcf2L+7NmvtaRWfFunrc
	 agMMZpd3f6yF9rjPYosENegG4c9PeNKACNPl8C3G+6QLXUq7u7bnv68dJjtrJyuPu4
	 mAysLkehvg7OA==
Date: Fri, 24 Apr 2026 18:39:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: mcp47feb02: fix example
 indentation
Message-ID: <20260424183931.2b9b33dc@jic23-huawei>
In-Reply-To: <20260422-lunchtime-hatchback-14f42177cbe6@spud>
References: <20260422-mcp47feb02-fix7-v1-1-709c7c02799e@microchip.com>
	<20260422-lunchtime-hatchback-14f42177cbe6@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 17:53:42 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Apr 22, 2026 at 04:40:52PM +0300, Ariana Lazar wrote:
> > Correct inconsistent indentation in the example and use consistent 4-space
> > indentation.
> > 
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Applied to the testing branch of iio.git. I'll rebase on rc1
once available and then push out as togreg for linux-next to pick up.

Thanks,

Jonathan
