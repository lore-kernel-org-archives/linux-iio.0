Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A6946C;
	Tue, 17 Mar 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732151; cv=none; b=SxQUffWDkoWiUROTy79lS0zt1UtbfBM/tdfhI1bnz7o7AQNgb7eCW/HodwhLIXE8MM6IDx0qTmRx4FXafFgsgAN502pFw9pc31IAbl/bjRxmf7IaveI+j4TlG+ulYZ4l8cDOUI02yaou5/qDztebx14dMloqXllwoTzNGaeChec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732151; c=relaxed/simple;
	bh=j3GfO6T03uUb2UbTw9iMfFr61eMXHUJG2Fj4b9Og+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6UMhX41RarjCeQssDMwlD7A0AKpFmIoow+XdLLXf6XLVZO7OIFhhMB9BfYTa++5buzMGjcnWFWzLpnRPBzTAsLy4THCgg/fjpZeDMnq6di6VUTzcyiW0IKly842zFh29uh5BmUE8mZeRLpbv/TGLi2mBSL+F0YSxZzpO/+dK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVtgcm4z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVtgcm4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CAAC4CEF7;
	Tue, 17 Mar 2026 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732150;
	bh=j3GfO6T03uUb2UbTw9iMfFr61eMXHUJG2Fj4b9Og+0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVtgcm4zXXv72VswBD5Xq1gUUNESDa6q90oQ2dRf3Ze3O2WCMSM+wSFaiGtBMvVqG
	 S+afTIiM7iyiNBVhk9ZACaU4STbo1C1qF4P4q8L+lkBSNlm0BS/yfavsqfmYFMqBM7
	 aY0Gr/FKdi0pBEPCZ9A0/lG+y0h5A1xY7q3CC5Q5PKsxYz9vcqJ5QJdOXF9rGVd4HP
	 yUmNVIrV/ozFxunn+PArUYpLh80ZLVX6sOCrBNy3fcJI6aBp1EMid/N7EtxmGnUXXb
	 xEilFCKqqeYQJH8251M/zJ/X6Sldw/f9XR9fCtmcVFdrigCkfS4MnMxc4qwM0RuGab
	 6vFtHvway+nXQ==
Date: Tue, 17 Mar 2026 08:22:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	cosmin.tanislav@analog.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: ad4130: Document
 interrupts property
Message-ID: <20260317-little-belligerent-mongrel-6f380a@quoll>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
 <0db1d36106b052d8fbf5dbc8e936558fde87bdbb.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0db1d36106b052d8fbf5dbc8e936558fde87bdbb.1773311639.git.Jonathan.Santos@analog.com>

On Mon, Mar 16, 2026 at 08:45:06AM -0300, Jonathan Santos wrote:
> the Data Ready/FIFO interrupt has a special behavior that inverts the

s/the/The/

> IRQ polarity when devices with FIFO support enter FIFO mode, while using
> normal polarity for data ready.
> 
> Document the interrupts property to clarify this special behavior for
> users.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

