Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAA3A1A3F;
	Sat, 17 Oct 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267508; cv=none; b=CM19tHeLrWb8BkiiWt+I3vjl9QnEbXb/QUWJEqsSJwkFeuH2Ms3xd9HcxUxB8Uqn3MfgQm7CR9QcMi44brfsnJYxbYdC1TZaqSx1f0Th3bNIVqGV5OikpNicjjC0yj3FYRb05MkkAVRIlBQL6kH2YDHnB+KZK5LNP3jKQ9F6258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267508; c=relaxed/simple;
	bh=rLN8nufxAXWxJMfE+PnY3QDOZ2SThsHVkBDJj4GDMNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho2Wb8Y5LwdgcjnNQpu6vTHjf53fHjZuamlVVOD7kTyfV6cp4Frgm9ZqrCoH6MPfLKWEOLUYuMmINUM/oD+OIWq6W9EMxRV8lpSQZVX+I+7yBjBdunSacPiZL6URcng+SV17bmZv9+LPeNmPiLYNVTosKIT0xgN3yigu+am/RsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOFbreik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOFbreik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF031F000C4;
	Sat, 17 Oct 2026 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792267507;
	bh=ooYpz/Riez9Hum5kGzQqMVFJJWXWYoE7X9LV9trqEBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cOFbreikKx3hrjca+sHZa2wXlrr1Do7NA087JlnoICMtMDHWN42u3YjeSDFZrDGMg
	 9+8G+CKEnhRYcByPdaBInvjVLSv6cHAIiAUCXvP6nJShzxUa2AeWr8mlg3eTcuAhXL
	 d7hg64pWNonTvXqnVnJiIVnDSRidCUqZjMAJeKsiE50dKgUBGs5vSjmHiCiREfSSLX
	 rypblwJ5P2DolJWDbL4Pd2zacMTpRvZGPqhIolmg4gTLkE4HpL4nA0ZtB+vswk5qIh
	 wRjlwsUHBYn95J1tjyndJwo3mQ/Og2LqHnlfI71Fjm9wTAeQq/vmVocOBB6tB1mWfX
	 XEpy9v0BkaeOg==
Date: Sat, 17 Oct 2026 21:05:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Message-ID: <20261017210502.129d1709@jic23-hlaptop>
In-Reply-To: <20261003050453.413700-2-lyf98405@gmail.com>
References: <20261003050453.413700-1-lyf98405@gmail.com>
	<20261003050453.413700-2-lyf98405@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 13:04:52 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> From: Liu Yufei <lyf98405@gmail.com>
> 
> Add devicetree binding for the Vishay VCNL36829 proximity sensor.
> 
> The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
> in a small package. It is controlled over I2C and has an interrupt
> output. It is powered by two supplies, vdd and vddio.

I wondered if we should just combine this with the vcml3020 binding
which is fairly similar but with the integrated vcsel rather than
an led, it would get just complicated enough that I guess for two such
short bindings keeping them separate is easier.
> 
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>

What changed enough to justify not picking up Krzysztof's tag?
https://lore.kernel.org/all/20261004-outgoing-outrageous-fulmar-2ba7f4@quoll/
Looks like nothing.  Please be careful around that in future.  If everything
else is fine I might just assume it is fine to put that tag back

Thanks,

Jonathan



