Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889553EFD04;
	Sun,  4 Oct 2026 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099548; cv=none; b=Jfs/DtlE+KD4dqKlkv4/su85yJax22LsPSwo2audiHVRg2VVy/vlGPFwKxg89JujpZHOeIAXLwvIjqQWNJkeO12Cp2eds4Tu4v8H0eNc7VYHd2UnOlZfydQ9TsQSTOKb/XWY6FNjHu+H7MG7p2bdqCLalqvRgh353TRz2H93qeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099548; c=relaxed/simple;
	bh=oy8kqtnUmYVUM+IlWPlkQwixf+yPf6wDktiD0oKDdGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNJNpxJCru3zEC6eookX5wKkxdCZEs4Yi6GljAEHz+IBl59LDh3MAVb1LlnU8d8bppzoOUSw2cj8wW1DlrMlM6Qa0VskaZmD4DSEPvmnn2N/uBvHezkuuPF6BYZpw0nFs/N/9jks5Vm8nGwVIrGiPFnrdtr8VcZb42WqWZ0/vQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orAJkQ8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orAJkQ8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4231F000FF;
	Sun,  4 Oct 2026 07:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099545;
	bh=Z988nW8A/KGpcAjOopC2iIABK526EzOFKtL5XLIo0fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orAJkQ8RP3EPR7JeNOQ/99U3Oi0ZM4E/2knnlpMFrvS1LbIn7UKG09eQwf4sIOHlE
	 tvDRqnISNLnLiunnE3u7hsFvtSMoui+bErNkCU+LdpLPZ6JqnNDQfTcVa7NmPqZ2JC
	 lhOkwE9LVkeXKcIfYTUCBAbsYkKELzeBQM4cOkECX6LvEEfr6FlYEIUHpwJwYXw/BN
	 zeeGp0rgUKOib9AdJ+o0LN+8dI670Onf+EGqo66e6e8D5XD461gmH40/Byw+Mh/xsH
	 Ey6rrjEZRTloCoNTuN2PcHCmX51TNfg4ibivxqJS7+9Q/Ilf27mp8QSpMaUec9PU4Q
	 DYlzWaFGvJdzg==
Date: Sun, 4 Oct 2026 09:39:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Message-ID: <20261004-outgoing-outrageous-fulmar-2ba7f4@quoll>
References: <20261003050453.413700-1-lyf98405@gmail.com>
 <20261003050453.413700-2-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261003050453.413700-2-lyf98405@gmail.com>

On Sat, Oct 03, 2026 at 01:04:52PM +0800, Liu Yufei wrote:
> From: Liu Yufei <lyf98405@gmail.com>
> 
> Add devicetree binding for the Vishay VCNL36829 proximity sensor.
> 
> The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
> in a small package. It is controlled over I2C and has an interrupt
> output. It is powered by two supplies, vdd and vddio.
> 
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>
> ---
>  .../iio/proximity/vishay,vcnl36829.yaml       | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

