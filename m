Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA39440A0B;
	Wed, 23 Sep 2026 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165288; cv=none; b=afqlJMR+DGjf8xbXwGTtkTDBmMsIG5hYL4ilmvcwP1s15AXnU65jhhRcX8bCbOIYEEKyaZq4b0epK9FR5EHYoS42fVT3x7Lb05m8enH8hF/3P838pXd2ZcLmMBs8xAs4TtD3JEgRYHmexdRrO8a5HCqIj1j4e7typMgJGHkURus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165288; c=relaxed/simple;
	bh=j/pbjEEC+OxP910G3nTkBK9F+J82AG/EAEqPzgrrZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcKd9hOGAP2+3Zc4c31ui44b/DfAhaNHS9wEgFRYq7bx0Ry/uJIi2uSAcFuJWeAKfAifeA9ILz8AmsiAswP0DTxREGqYnT4vMF555TR4Tu8ZnacGPrUQ/dAZJnDcIHxfmkawRITlNSE5iPgaJ09n1ossnly1VA6HT0a/0m65JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEDC1F000FF;
	Wed, 23 Sep 2026 12:08:03 +0000 (UTC)
Message-ID: <a0dfd7f0-2949-4be1-bf1b-5a891256e5eb@linux-m68k.org>
Date: Wed, 23 Sep 2026 22:08:05 +1000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] m68k: defconfig: update stmark2 defconfig
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260701-wip-stmark2-dac-v7-0-ff8fdcc8010a@baylibre.com>
 <20260701-wip-stmark2-dac-v7-2-ff8fdcc8010a@baylibre.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260701-wip-stmark2-dac-v7-2-ff8fdcc8010a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 2/7/26 00:17, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Update stmark2 defconfig enabling MCF5441X DACs.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Thanks, I have applied this to the m68knommu git tree, for-next branch.

Regards
Greg



> ---
> Changes for v5:
> - move this patch after new Kconfig symbols are added
> ---
>  arch/m68k/configs/stmark2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
> index b3fb95f73a95..3941113bc60b 100644
> --- a/arch/m68k/configs/stmark2_defconfig
> +++ b/arch/m68k/configs/stmark2_defconfig
> @@ -76,6 +76,8 @@ CONFIG_DMADEVICES=y
>  CONFIG_MCF_EDMA=y
>  # CONFIG_VIRTIO_MENU is not set
>  # CONFIG_VHOST_MENU is not set
> +CONFIG_IIO=y
> +CONFIG_MCF54415_DAC=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT2_FS_XATTR=y
>  CONFIG_EXT2_FS_POSIX_ACL=y
> 

