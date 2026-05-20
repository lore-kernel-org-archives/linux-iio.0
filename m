Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71D2F7F06;
	Wed, 20 May 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272372; cv=none; b=eKKISZDmZLSraZP0sUWsVZwSRn2/mxuO8sSdKfn2cRo2Yzw8UtJauQBvslsT2weWHuDgrvghr8F3lsrd6E4pnW5Q2AoDezb5PhpCONnheglIFuzhzgIHBRP35t/cJMsJx7129N1f4LupMRS4mnkcAFGLhyJZZsV0YxmoBEcZmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272372; c=relaxed/simple;
	bh=UeBihuTwpiwY+Gc2fcmIUxVR84SFd6ZwPgT/Sk1I30s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXmsf20d5sXBcLIbSalF20c9gHyrgeBpWzQhf7IfnvhjKmEaAuBS6jqsnGWW1OlpiYNuSEo631nkTo8ERGpzXI/xGd8Hi1WFXu2h4SWxKBibB69nxX2ZqM3fCqwNb729hB3yvQVnJVA50eZhsKaeR2tnzWwy/4xYz1op4WcqYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZP8+xT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZP8+xT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1291F000E9;
	Wed, 20 May 2026 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779272368;
	bh=tgf+kb2GSBgtHp3s2/DubZNMXmf3PXS/hgCixyB3A6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HZP8+xT68iH6VPthHgYdQ2vxgPLFxxcbeR5qosATmzUKPLzyYG4/dlPyTdeDdvYoy
	 ayW1hN4jF2dBbb/dUJszf9JG1+IHDLNDMwqeEdMrVIoxnU8KOQUwBu37lLop1p86F/
	 +/PDiAb3JkEuKoxAVIRqqmPQAIanWGaTv+ZltYV0SxySOEC1za8Me6ab9bhvkxZjv9
	 SqSH7WCkSka+Z+ngM6mu8kcJZzp1LCCG39jIAMPNWcINyrZFcTCFyapUId1e9JgpZ7
	 Hvo0/jXrwYw0Xfu3fnIi/t9+BZaiwq+Kjx4kP4mRpzF0Mbh5WqsDCoj4+Y+jwcHncu
	 T7NLsIUq1gEWg==
Date: Wed, 20 May 2026 11:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 04/11] dt-bindings: iio: adc: hx711: add HX710B
 support
Message-ID: <20260520111919.5e99fe72@jic23-huawei>
In-Reply-To: <20260518220228.63322-5-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-5-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 03:32:20 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add the avia,hx710b compatible and document the HX710B-specific
> DVDD and VREF supplies.
> 
> Add constraints that forbid HX711-only properties on HX710B nodes and
> require vref-supply for HX710B, then add a separate HX710B example.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
FWIW the only thing Sashiko doesn't like is dvdd is enabled for the old
parts. Move it to the earlier supply adding patch for hx711 and we should
be good to go!

Jonathan
