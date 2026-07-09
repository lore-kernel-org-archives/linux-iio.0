Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869129DB64;
	Thu,  9 Jul 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581513; cv=none; b=dt8oayy8mPhURPY7SsfoFtTAs1jCdoycpozEeW5RmLdsDunpkbwcv0Anm9d5Et8C9ITGHBqocrqOwIPCT1uvvBaE5vqoJ5tmhb1y20NcFZilKFp7Dez625PN0LD9GhF4WYPSMfHpBDUxr81WH61AbxTRd8Y4DR/bS1064PYoAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581513; c=relaxed/simple;
	bh=gRKH6yVFOpakanSra/yBAh3iPcHcQ1aQ0Z0Rttpcr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovyg1DSkNzrezv4y5JvEz+2yspgAgCQ1hlcZWBlUGnWgm80uKY6Y6ZKTmXhDDCpFY/r8Q3k1msPxNdB4BudWK3M9mu237EUysSEQDmgK/NNQ7zSO0Jk5Y6971rnobvwrFG6oV2Nj9xfZSSXZlQfEXwHzRejBo5C9+fu+EoLGD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCJahx5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCJahx5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24271F000E9;
	Thu,  9 Jul 2026 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581512;
	bh=kgCeCn6OahOqO4sDrHaiF/txhFdhW29F03MbnNXOaSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oCJahx5Ib5Fv3jXdN775xAah5Yb7crnZNGyNLVjSxmyvfc9saMBUIEtdP/XFLAoPZ
	 PpA7ii9+S1kcC43WPjl9RhXm0rRGCJCmuPC4l7d4/2ZxjICmTtNsKbVv05t86H6Abi
	 KcK5mk/GRRdC/JhL/kDA5AD323UuHvKICaZtJlSv4u5L8sBeCXnByp2Cvgd9PI9WmI
	 yzc2rwvYsJIGFao9cwVIjPeEuszyP8ASlDn+kP85DguHaYva4dCbEwJRrYeaaTRsmd
	 BfKCIcFZVa4VEcAbVoO/ac8iardc9WmIloGAPLm56LgnTiHIg7Wz5GKzGQB5Mo7XEc
	 CHkrgbDjlk8uA==
Date: Thu, 9 Jul 2026 09:18:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andriy.shevchenko@intel.com, u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
Subject: Re: [PATCH v9 1/2] dt-bindings: iio: health: add adi,max86150
Message-ID: <20260709-nondescript-thoughtful-bull-b08e2a@quoll>
References: <20260707112714.2261727-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707112714.2261727-2-shofiqtest@gmail.com>

On Tue, Jul 07, 2026 at 02:27:13PM +0300, Md Shofiqul Islam wrote:
> Add Device Tree binding schema for the Analog Devices MAX86150
> integrated ECG and PPG biosensor.
> 
> The device exposes two PPG channels (Red LED and IR LED) and one ECG
> channel over I2C, with a 32-entry hardware FIFO and an active-low
> interrupt.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/adi,max86150.yaml     | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++

I downloaded entire thread and... it is only patch #1. No user.
Please thread your patches correctly.

Best regards,
Krzysztof

