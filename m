Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843A1A9FB7;
	Thu, 26 Mar 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555956; cv=none; b=U9Yxu/Rdb9u5fle7ubIQ3o+Add/tV6GT6UkvVVE6Cum3aaZFPj56+3I5RyEIsl4HmsBqo1syuZEPCLVwzJ/s/uC6jkUDKOpOWuZ4txjeewxp+GrWH+jzJOveZHMYSshfbrkQghqQ7EZ7MAaaWYd9z2XvC8Bw0RM/9u4p2L1jPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555956; c=relaxed/simple;
	bh=slBF8u0NbpBSkCbGlWeZUuwlUfMLTy/e44e1DiZ5TwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMgS9n3q4HoFdIm8rpuZI5wnTu++rXi9yWFQ64BIAY+vf/gaEO93SIEnEK5+qcvBPasAbSiB6qNO56+FDTxcoGS21ToYOx48hTOEyBll1RbNuXJgrvf8BrThKjYxcytwUomdvrdxx7l4o6hlSAP3DHM+6UErJBn+2hO8lcPdkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6EXy7eB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6EXy7eB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2CAC116C6;
	Thu, 26 Mar 2026 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555955;
	bh=slBF8u0NbpBSkCbGlWeZUuwlUfMLTy/e44e1DiZ5TwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6EXy7eBfqZln2aRps1MplO/koQ+fm7Tw7QQe4ZAyRe2myru9cTOobRSnccVI4LUz
	 2fE+QxUXE2dcHjs0GS98UasSFA/JzG0U0pVVvmg4zZ56NUIJrG2MRTABRNXiDaiq7P
	 jKZuobC4yfai0w4gXC3hsXKwC/3r2yZuHju1bLmvxBAjCubpF2HWKMq8NiovMRMJij
	 VbzupeTpC0pSxIqQlwux7gZckgGADBTz++b1TdMzQIUvnmqN0Gh1qJII94STOidZXy
	 rcryNMCFZCoPqQuwefqhF5hBrcjMRDjXEzwUPwfm/JydCDPlETx/hygJwGWv7XKon7
	 YHzpFoL+OluSg==
Date: Thu, 26 Mar 2026 20:12:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] ADRF5702/ADRF5703 Digital Attenuator support
Message-ID: <20260326201225.65b1fa93@jic23-huawei>
In-Reply-To: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
References: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 18:32:15 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is a small patch series that adds support for two extra attenuators.
> Basically, new chip info and device table entries are added into the
> AD8366 IIO driver.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Changes in v2:
> - Add more context to the dt-bindings commit message.
> - Link to v1: https://lore.kernel.org/r/20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com

Given I want to get this a tiny bit of exposure in next (tomorrow hopefully)
prior to sending a pull request on the weekend I've applied this now.

Given how near the top of the tree this is and short window I may well
apply any tags from dt-maintainers etc after applying.

(as background I'm travelling next week so scooping stuff up now)

Thanks,

Jonathan

> 
> ---
> Rodrigo Alencar (2):
>       dt-bindings: iio: amplifiers: ad8366: add adrf5702/3 support
>       iio: amplifiers: ad8366: add support for adrf5702/3
> 
>  .../bindings/iio/amplifiers/adi,ad8366.yaml        |  4 ++++
>  drivers/iio/amplifiers/Kconfig                     |  2 ++
>  drivers/iio/amplifiers/ad8366.c                    | 22 ++++++++++++++++++++++
>  3 files changed, 28 insertions(+)
> ---
> base-commit: af980a79bfed43c4a0be12cca786be46f1a0c5e8
> change-id: 20260325-adrf570x-iio-support-e199418fba40
> 
> Best regards,

