Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDD481A87;
	Thu, 24 Sep 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255074; cv=none; b=kcetnhL4j4NUk9x7XTGhiNF1XjktW0/0li+r8SJuomZQH1cc9tv8sFIatfCoGA9D3vVKVdXQbD6H68jQnQQ5MSUI+tL5cjtkVuEsO4ca0DEjfoxkueE8ecSQb+Rqx7kL0YpxebFUpcrSX/d7KXstQEiel6CCXpXgsquRiUXih3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255074; c=relaxed/simple;
	bh=9wrD8ooNQ54Mmoqr2WCilKEOSNJhouR2e/NBSl5AzKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQLwZhYDDZlj+SIIMGFwCkSlx/TRDxMgq6uM3R4uGCZTiZMkMJBYQsGiAhrDa5O9vdaB7zeUci0D+k4FaV1scrdDvNuSHVMl94xGAFU30dJGr6Xmp5/W8yINbCsb22xQgZ9UWnVmquS3lXhgRoAFK9Ydzqy6sITiwXMVPu4dMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtPRH/uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtPRH/uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A741F00893;
	Thu, 24 Sep 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255061;
	bh=9wrD8ooNQ54Mmoqr2WCilKEOSNJhouR2e/NBSl5AzKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jtPRH/uLEr9iaei94uBW20XI8XsJOWpieIjnnDQ9Qk0zGfWax/+mc+Wg1w2LjJ2cO
	 lhBS/Unw2EnWrb9GL7PBvULokLIvfGkqf9XaJ3RpZ+s7WILzi5FOOGxY3KwZiZD7FP
	 zm6zFslIs90ro9I2N0/mm4CyXv/DvEzHh05cDVE7h9o46psSBcLodvKrGTaZf9qm3t
	 xRYQQ2BXJMRcuOs70ebh3/b23fr9CtgFzBMfLM9p6IsA8q7ADH1kd4ww2IR9tBvbb9
	 5Z3kxZaFPnDHq7sVCv27Jsthgb5VGvmveG00S3lVjZqM94FiZ+mQCv6PgKldWCfPqc
	 xJvS8zLKW5o0A==
Date: Thu, 24 Sep 2026 15:04:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Message-ID: <20260924-strategic-premium-seahorse-83cde3@quoll>
References: <20260920164724.32019-1-m.abubakar365@yahoo.com>
 <20260920164724.32019-2-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920164724.32019-2-m.abubakar365@yahoo.com>

On Sun, Sep 20, 2026 at 09:47:23PM +0500, Muhammad Abu Bakar wrote:
> Add device tree bindings for the Sensirion SDP31 differential pressure
> sensor, an I2C device that also reports temperature.

I don't see how you addressed previous feedback.

Best regards,
Krzysztof

