Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D538F929;
	Thu, 14 May 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741323; cv=none; b=qh8DfuPF0YwO5ORfFxAlCodSZc2+VR9W06C9v2B09JdCnDkzG+SyB888vKCSPdH7HBexZ0X9wOI6wNVjomnZjszXPvAYOOoDI8AA0ur3zvnKYNA0nrT3UxNbGbjqyI07bA7rHRNKQ7o+dc4GybZMDGnPYbxarJq+SUu8/m6b53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741323; c=relaxed/simple;
	bh=WCHZYIPH+iaGTxC80/OSWRgwos4c3asSFe3qsQ8TwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBYd7LLtJWaj7EGppWs6Ehu2ycuaHd66lpIhLFIZ1LPW1+QZUSpNnCz1EEWUPqYSzE0DiZCta+T9ujtmspi5cZBXK2tyB/wMsJigtedduGgndJjL4Zx3kLV1PxNQ4pGX1PtG41GNmCKrt+ZRkvs4ioXvvXNv2IUdwQ0oQ9bHHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX298jPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX298jPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22412C2BCB7;
	Thu, 14 May 2026 06:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741322;
	bh=WCHZYIPH+iaGTxC80/OSWRgwos4c3asSFe3qsQ8TwXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uX298jPBDF7o+eqVd9BfP4F2VfmWcnnlGfI9rWhTeqpBuLRxa6KRXL9BDtz1Lmx+E
	 QF67ol5dEtzZJKBgKITXZeatRLdL9NjuOyFYaVauBsFnRCYQozpmXNxS2CaU3F3jgk
	 CFgVeXTKx68/VE5ynNbjORuAiwmzz+yWrUVJdDyHA8TySBylMKhe/KAsaydHsMakIn
	 Ms9vSG1kzrgpkwU/hHDthRxR4fGmBwNkj8sGbHNms2uWGsuLDFL3uhp1DhmN4CyMy+
	 P3E/FAX693Xh3A6h4hcE7vtDgumwPitFt9EXpmPs3AWlYq3vy5LqaQaFsZSxYdnXGB
	 FqUGYY7xP+qHw==
Date: Thu, 14 May 2026 08:48:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V6 01/11] dt-bindings: iio: imu: icm42600: Add
 mount-matrix to icm42600
Message-ID: <20260514-fractal-falcon-of-domination-4704e2@quoll>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
 <20260512221634.256747-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512221634.256747-2-macroalpha82@gmail.com>

On Tue, May 12, 2026 at 05:16:22PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add mount-matrix attribute to schema. This attribute has been supported
> since the first revision of this driver, but was not documented.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

