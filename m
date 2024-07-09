Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DD192B6F;
	Tue,  9 Jul 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541156; cv=none; b=BmlFmagvWkI/ZQqYsEtDaJfqWXNSKlycKFfx0GEWCg+6W0nE1Mc5InfOwFQbNqHCWRMI2Baln5wsDNoJMu4WCDTzQRNXZ3Usfv3Wsh53f7tohsyPuvVIgtAHZIfzgqMHla7+1YjKb2YxKi5r48V/FoGQc9gjIFfjELMMl06Cotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541156; c=relaxed/simple;
	bh=0HiW9BQrBeQWPuzpdcXUwgz/GKySrhx1X9yGs7UcsVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBdESjZ39ZUoAglb+gi3poRzxKV7pr6lybovPXcsXgcsTTxVvu1MwlbceJF2ed5NhEIMwk0m2DnL9vBSAaOAf2U0cVV14Uzndci0rdMZZpPnaoJnIdfQNOmXRh6HIxgldxHnTp1+2qWr+HWHP59bPe4HiyldcuhnV1JL7S/+698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td14CaGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td14CaGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFAEC3277B;
	Tue,  9 Jul 2024 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541156;
	bh=0HiW9BQrBeQWPuzpdcXUwgz/GKySrhx1X9yGs7UcsVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td14CaGsIkyo57mFub73471H/gjKKVxJxWsIq2VDOuX7H45rtJ+jbIlt7KzHYMv6t
	 hDt+BglEfkxev/fhB2fy45Abb8MrwP4us5Z2fW++0+bY1/cKoljbRGhUlJQpJMLTNG
	 r+9fOH9Mxcw5mcTQfFFj4q/JHnzugB9FUdYNXji1F1qFKpGgMcclurPD7btmeEYA7D
	 auZo/Ohu3c6XFIU77F7zcmK0Q/zRwG3ZSAFqYHS4DH9gwMH4RNlGqLEpWVWeWeEWn9
	 yPiIeBtOfChCdstFl8db34YRedatVWXLcS8FPe+x6wI4ZEACpWcSb60nvIPKMUhB4P
	 HjR/KHSrXWfeA==
Date: Tue, 9 Jul 2024 10:05:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marius Cristea <marius.cristea@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add binding for pac1921
Message-ID: <172054115357.3616759.13825605834232595478.robh@kernel.org>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-1-0deb95a48409@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-iio-pac1921-v2-1-0deb95a48409@gmail.com>


On Thu, 04 Jul 2024 19:42:01 +0200, Matteo Martelli wrote:
> Add binging for Microchip PAC1921 Power/Current monitor
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  .../bindings/iio/adc/microchip,pac1921.yaml        | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

