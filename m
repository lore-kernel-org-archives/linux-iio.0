Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60C25A2C6;
	Sun, 13 Sep 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319472; cv=none; b=oZ5RA7uyfGfm/Ms9oUENZaVB8al1BZrIQ/blOwNVsT6MZFHrEaH/WroRlHkOzUwxaq1biEorrCKpIelL3f/aVGLfq+WHhkMpXau0bPr9ttw4qHzE0sNMsvU6aSvIRXpK/S/ZxhADS//X4Ptm99p15XnZ7JWuEnYQdieaH8TK+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319472; c=relaxed/simple;
	bh=gSNhIyPVczHdrNz6XZ14ZbvUe4f3P5oAUHg+F9j5o+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nui0cuOgVsSsFib0Q3vJYGdbLzlsMD3nc0ve983eRQPCaLua8bonSO2m4FRCImvnNReTbkbcf7fOlXGHTYUe3jyMCfAYbfeF5igmuZrMeRgXu2JYfip0lfsYSe0MQZ+aJbptQPaF9X8/yI3APLhE9F8geErjMfbXSfOeqgmA1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDYqJqYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDYqJqYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809751F000FF;
	Sun, 13 Sep 2026 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319470;
	bh=3ePSHLLz0FZQQ1hloKf3CkOMqoBYsNBoQtmCbsSnMWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iDYqJqYBNl9KANlmSRCN81sP/IidHcHh65Z79XX5Qg3BVsX6gna2hyK0KfLGRxqID
	 /enCAHtC9ufRbO9KjSS7j2SFKsrtXl9JanFSI52Pl1ZRcAFPLShPjqpnY2x3aixtTU
	 cIDHDtMq4Yx/27sEBTsAPdRuFL214up8+S0NfSmkXFsRorEadLvS4d0Qk9a4UDc/Xr
	 6B+zweWRlAeyNVvWjMnbczUErZP982CpzPuf2+QssX4hXw34M87lLulsYAxQKouIWP
	 9oE2TZI5uPi9esRwPML70pALG9XMXsuNdqXVT/7siM1AFdXaxs/WzdEVNPBdcWKfHA
	 pl6LDwFXqjvzw==
Date: Sun, 13 Sep 2026 18:11:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: marius.cristea@microchip.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1934: check ACPI label duplication
Message-ID: <20260913181106.781e6e90@jic23-hlaptop>
In-Reply-To: <20260913125107.109723-1-bolin.liu@seu.edu.cn>
References: <20260913125107.109723-1-bolin.liu@seu.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 20:51:07 +0800
Slavin Liu <bolin.liu@seu.edu.cn> wrote:

> A label duplication failure currently reaches the terminating-byte
> write. Release the ACPI result and abort before accessing the missing
> label; earlier labels are managed by devres.
> 
> Detected by static analysis and reviewed with AI-assisted source auditing.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>

Applied to the fixes-togreg branch of iio.git but as it is a low
priority type of fix (these allocations don't fail in practice except
when things are already in a mess!) it may well wait for the next merge
window.

> ---
>  drivers/iio/adc/pac1934.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 23055405a6e0..de59dc27c440 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1108,6 +1108,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
>  				     (size_t)rez->package.elements[i].string.length + 1,
>  				     GFP_KERNEL);
> +		if (!info->labels[idx]) {
> +			ACPI_FREE(rez);
> +			return -ENOMEM;
> +		}
>  		info->labels[idx][rez->package.elements[i].string.length] = '\0';
>  		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
>  		info->active_channels[idx] = (info->shunts[idx] != 0);
> 

