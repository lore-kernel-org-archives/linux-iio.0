Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1C390985;
	Sun, 31 May 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242729; cv=none; b=n8tCzX3xQwgUs4Zxek3UEl+llndn4uxWU+0SDRG57eAEDRB1sdcz+nQw+PZiXNKzvma5+J7WGr5IJ96yvELQoExEBZXevJaR7bEz96oGBwLvGVxyn6Sx+N2kp2aHF8qbxNMN05X2EYbo2yd1Vv/pY2A1SdKOJt/TgUJANq/i6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242729; c=relaxed/simple;
	bh=wd5lujVut/YCkbcDDiWX4MK9YgNsKxj7MV+435Ept4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rReK2hPvNSJUlpGjbRxBCxNRB0nEMrWAk8EOpLZCdkgmy4AOcjC6vIUMrZ+xzF1Rb1QkwgH5I9Nlx+CCsdnp3y8PthDy3TSkg35H/zUkgWtYKXpuZVMT0Y4z3qPo2HrEEVebR/pylzEpjNiEfRKVwc7YD3ZFQaPYO2PNHy7WYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7RlG9KI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7RlG9KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94DD1F00893;
	Sun, 31 May 2026 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780242727;
	bh=eR7tTyyqGKiLll6lxmnF9fbyjgtiuG6PiIQ2to9I1lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h7RlG9KI/qfwxt2MsBovFn4HsnPdEBEKVBXKizu1orQVjrTKARHZbjpD8kKgxlssj
	 wltUyYNcOlBeaT/p8R8eNPrfW3FzOTjAyA5ZW44rJqOoSqVtI9A2EmPSgW39EnhzlC
	 oewlM5ij6RXj4miHavwwDBWMRmyMVQe21ko0yV8+8Sr4D2OFrSBh0Z61g9ifiThWze
	 7Hdl2u6trUHg3TZXxiubT2kew7hUo5d49LGShYYVkLrwcFikOBYmBnDPwHcoQ+enVg
	 VM5gGJ0TodGV5zk8t3B2uBzIFVoCeHTX7FQIdxG/qf3uqK8FVoCfOsh2dg9hsZQXWk
	 Nd4CAFthuAUzw==
Date: Sun, 31 May 2026 16:51:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 04/11] m68k: defconfig: update stmark2 defconfig
Message-ID: <20260531165155.13e586cd@jic23-huawei>
In-Reply-To: <20260531-wip-stmark2-dac-v4-4-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
	<20260531-wip-stmark2-dac-v4-4-7e65ab4215dd@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 17:25:57 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Update stmark2 defconfig enabling MCF5441X DACs.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
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

Sashiko makes the reasonable point that this symbol doesn't exist yet.
We don't care that much as they make different paths anyway but generally
I'd make sure defconfig updates are after the symbols are added.

https://sashiko.dev/#/patchset/20260531-wip-stmark2-dac-v4-0-7e65ab4215dd%40baylibre.com
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT2_FS_XATTR=y
>  CONFIG_EXT2_FS_POSIX_ACL=y
> 

