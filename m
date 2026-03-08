Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554033344C;
	Sun,  8 Mar 2026 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772995103; cv=none; b=ZZW5IYCFoaAAuRumKOjkD2zEtNpbGcM2K7k6a4umZmi3j5jaLFDnY3bUR2CNNeRgcHoIG0nkGX9nuZqABVCs40EcaPbwIQC0edfmPTxDCurLh7u+stszSbefQAbsnMStmoCZAvpoq8cbzeCpLDMU8GD2WSr3lrdB1oSNcRAQqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772995103; c=relaxed/simple;
	bh=owrJI1RBQHjKykMJ5H1hBSuXcis4pTX9ZzOqKfGj34I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3js1gzuOVN0SJ0U1xx/R9wiUyRYpRLsgred5h+Cr0WmKYHBbh0GIcZF8e4xTIOx68wy1Hn3T845R+srjMUlqwkEbVXoADyr54dNM47NWiO05oic1IHqCadcXCb3aRLJ0SHZM2447oRriX4vm0apaZT4jjzUPSn7eFmhdogQEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVSBjGb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVSBjGb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F46DC116C6;
	Sun,  8 Mar 2026 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772995102;
	bh=owrJI1RBQHjKykMJ5H1hBSuXcis4pTX9ZzOqKfGj34I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVSBjGb3lwhDgZUImCdJOmhLK+CjJKNFdk/XRRR2x2kRScjYoZ7sDPGE0z6w6t7cp
	 fOogT0yRz/ypsbPc9veExNFu8I5XW5xzSU3PqFBDRpS0OFJVp3Sy5hqPaNqXj6KnFO
	 vOY/b8/1vTKi5ke2fef9tJQtoGviw1QNeKKGmtdGzTioUDB9Df0c63+I8PizuMxxDp
	 rQalPMZT8m+ObaX8kV/epAuVe7b43PmHcuFHPPZMXGgKGKHu8V/Kq/E6dSrcm5pvrX
	 1VGcHPcHOnFABc7wil9ER5LX55rx7895nGeEO78sK6PoGE4WZFMasSRgL8yMs3YrUM
	 DVcLLAPWfzBrQ==
Date: Sun, 8 Mar 2026 18:38:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: remove chip_info[]
Message-ID: <20260308183815.38a6b3e6@jic23-huawei>
In-Reply-To: <20260307-iio-adc-ti-ads7950-no-info-array-v1-1-457f9dc64840@baylibre.com>
References: <20260307-iio-adc-ti-ads7950-no-info-array-v1-1-457f9dc64840@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 07 Mar 2026 15:54:37 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Remove the chip_info[] array and related enum used for looking up chip-
> specific information. Instead, use individual structs directly in the
> module device tables.
> 
> Also update to use spi_get_device_match_data() in case the devicetree
> table is ever used instead of the SPI device ID table.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Easy one for a Sunday evening :)

Applied.

Thanks,

Jonathan
