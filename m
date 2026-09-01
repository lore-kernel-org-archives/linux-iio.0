Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FB3ACA4E;
	Tue,  1 Sep 2026 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224807; cv=none; b=jO8nW9fYD6EaRiA8wOVZzfM8Buy33ME9HgHKUTg0dOQpIM82EC7MceM9bQ0G+PXAOFBi9PfU0tRAqXUR/OKPvkK1IZ1CpvzgXZWiatAvsUw8f9sbL8jXUZA1/yP7FrK+vuzCx98fpZQSF+HDfi1Yd70n2HOnw/iqTtMA1zcScdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224807; c=relaxed/simple;
	bh=NdoRwJddN+5U4RMlKEG2tveRo36XrUNk/hB4imxFJhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhKzp23+OcBXGDWdBK2SPnOuphTUtVZvKBbV895Er+icLImsMU6vWchInMAeSyiD5HbPjUzkBzN5LqB+act8stcS5eqWN63X4MB15ztrFgmmIQ+FDYDdW/BOcG9LbfDtkRE81aBQFTaUL58y3bQGsK3VJIR2GcZzYAvVJw78gGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ0hUKHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ0hUKHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F071F000E9;
	Tue,  1 Sep 2026 01:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224805;
	bh=NdoRwJddN+5U4RMlKEG2tveRo36XrUNk/hB4imxFJhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LZ0hUKHTzLvrcgJPMAR0Urtk2gNjy79WAW8DSbJeLMu8JCFJyqQV0Pxe/wGMcOHMD
	 KWnCgHtqFrxmGS2bOcsv90sFfFDD1ha4d+kjePk9EcCzrfrNxOWB4eeaxWWe3aCZTp
	 do1nQS5luh9hxwqjiBghUQb03EUwOPnMScvQxhFRhXz9DSkulnbvuXfAWkJvKV/2dR
	 KmgXwgCiD4CxJYX5gLcpWDFlxGmQAMZvMjcvWj7/dLtbGFK2uQ4WxiyxLGucSXUE7J
	 6b3RPCS08VQ67H29lbFnR/Amu0ianoU3NYWL+db+GIfC0AAygUrDJuX2waztrA4zK2
	 L0Hp4TW0OsaRw==
Date: Tue, 1 Sep 2026 02:06:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] iio: accel: adxl367: add INT2 interrupt pin
 support
Message-ID: <20260901020640.4baf035a@jic23-huawei>
In-Reply-To: <20260821180753.4633-1-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 21:07:49 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADXL367 exposes two independent interrupt output pins, INT1 and INT2,
> each with its own event mapping register. The driver has always hardcoded
> INT1, so a board that routes only INT2 to the host never receives
> interrupts. This series lets the driver pick the interrupt map register
> based on the interrupt-names device tree property.

Whilst the discussion has perhaps not ended on patch 4, I'm going to take
the view that something will probably change and mark this one
as changes requested in patchwork.

That doesn't stop me applying it as is - if the discussion heads that way -
but reduces the headache I get when I see how many things are
waiting for decisions.

Jonathan
