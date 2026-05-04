Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135F3DE42C;
	Mon,  4 May 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910336; cv=none; b=jlvhn0HmHKZTkarfYLpXQlL7i1wqUBY6MA2IeMB4WCV4kbNo9yXPLDk4MbqnPmrakP0BpDe6ZqMfaOVhFxOwCxk0pe3+jk96geI6YLfuGzoe1r7OnnLEHt5iM41QUn8md6DNadozj/g12uNhxZGSBa4fzq8uLgXSNIBk+wBZv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910336; c=relaxed/simple;
	bh=aak2ugasIdfbzsmHJ7fWGYX6iVsJ4BgHABl5WvFEppw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUVs5FYWXkpjw41hw2whKFEoRid6P8Lzh6k/WDyOweMCGsXF2dSC5n31gbmubyHsFVQRq1gr88KDfV/AJ6nu21dNy0BpO2z2F+qGIoCPR/b8wWj8J4YoA7baH/Z43tArjuuyr2510z8x41HTRU6yHTPbPw0E6+KpONRi3IkK6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOSl7JbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOSl7JbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD2AC2BCB8;
	Mon,  4 May 2026 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910335;
	bh=aak2ugasIdfbzsmHJ7fWGYX6iVsJ4BgHABl5WvFEppw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOSl7JbUQHSKsgppFlnq8ftzwqcDfiL5hekD7EbMupOQibslzG2CwTp4OwOpkh7ei
	 tHDTNCrELdfjK1ezJfSep8jwCLfjLLzWt142Rs1YQr4Xc6bC/xV4JQi6akDFWFnypk
	 619WN05w39wIEfmieIATQGRtp5/5A+l+bTLReoCMonhf4aiKes8eKV0ycswyhdAmVz
	 v+Z9nax3Us/0vb2CrsSMA/dXKX1KIy7V9CnRGwU416PJtxINPgJgw4FjRL6HIrjh7y
	 ReS5QNu8UpmGJ+pi98BrkDjZ9HTQkUpkePuPjDepgtSYoSsAg0nmUE2A/SLL6y0His
	 i4bESOODNWwSA==
Date: Mon, 4 May 2026 16:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Piyush Patle <piyushpatle228@gmail.com>, Andreas Klinger
 <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: hx711: add VSUP supply
 property
Message-ID: <20260504165845.5875e833@jic23-huawei>
In-Reply-To: <20260504-simple-garnet-quokka-bfd9b3@quoll>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-3-piyushpatle228@gmail.com>
	<20260504-simple-garnet-quokka-bfd9b3@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 08:51:37 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sun, May 03, 2026 at 05:39:31PM +0530, Piyush Patle wrote:
> > Document the optional VSUP supply used by the HX711 on-chip regulator.
> > 
> > Keep this separate from the HX710B support so the existing HX711  
> 
> What does HX710B mean? There is no such device in this binding.

Yeah. Just drop this bit - it's reasoning that might belong in
a change log.

> 
> > binding extension stands on its own.
> > 
> > No functional change for existing users.  
> 
> There is functional change - you added a new supply.
> 
> Best regards,
> Krzysztof
> 

