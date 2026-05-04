Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D626980F;
	Mon,  4 May 2026 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877564; cv=none; b=IP/bN2tS2dkr5Q8y9Vs2pW4t38WEvK5BQDyVCXu5OkHGH5nT7qoF3xTthc5XADOICPyutZfwHpMf3HYTQvJi3DdQ5EIN2xg9k3t8TCWfu0BwBnhlTu9RIzlcitKpPm1jebl4i9e0rpmWqyqlyUDfcGUKB+1xov+XfWmG47V5bIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877564; c=relaxed/simple;
	bh=5/OQpBVx22aOC6izR09mUiEWJlx0JKm4J1adoowDLyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k59ktmZEkSFO8MiBzslAZsMfnuTE/lmI0ncAfKctQT7rvoHJ7yJUUd5b1jEm7BTCW2CPzaDiD3tOhS8yt4AQc2oDbZuMGe19FuJ1n+TaXKAkbSQ34t0OUx8EWY7wfYJkLDNvnsPC8iNeN1uNOQbJngHJFfUQvoLTXxQFVPQE6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5wjrPdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5wjrPdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C0C2BCB8;
	Mon,  4 May 2026 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777877563;
	bh=5/OQpBVx22aOC6izR09mUiEWJlx0JKm4J1adoowDLyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5wjrPdTIB5rRz+bNTpTMojIq/NqzCiWPRO8p6/FGP+MRhBDiFX1sH8XmeoA4FCrQ
	 XfeXp3/jteHHFz0Ab+kn2bBGmYCdpKcdpJ44ANz9qN2ry3V8PDJ41FtDN80YVck8nF
	 rTAV7Ou9/V5kH54kL7Ok8/uTLE8Ll6hkydY/BLMvHrkJAHtkPTglvkQjONcbvC10ey
	 Psr/74to+XuUIEK4h2p80si7T0wje3nASo8k8GLlLERH1VUSvjkZaR+hDyEFTNxoZX
	 HLR5Hf8R6hfOjmRNsB5BdPuTPwGPjh2SMpxo0tfRnB3qSgwh+C1P7BZ8vDruGDQjcS
	 oTbRr4s80mTEQ==
Date: Mon, 4 May 2026 08:52:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO
 property
Message-ID: <20260504-tentacled-smart-goat-82a3a5@quoll>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
 <20260503120949.80292-4-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-4-piyushpatle228@gmail.com>

On Sun, May 03, 2026 at 05:39:32PM +0530, Piyush Patle wrote:
> Document the optional RATE pin GPIO used to select the HX711 output
> data rate.
> 
> Update the example to show the property in use.
> 
> No functional change for existing users.

You just changed existing binding for existing users, so this is a
functional change. Drop all such incorrect statements from your
patchset.

Best regards,
Krzysztof

