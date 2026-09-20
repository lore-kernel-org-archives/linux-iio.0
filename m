Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BB2D97A6;
	Sun, 20 Sep 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929898; cv=none; b=Or63IIe+vuquHMkhBIFn2sD+LIl3amlLyAEnkyd7oSYbhZYaCQr0Zjdb63ZozQtWV1h8SOsIyyYNgToijXjvrbBliDk646OCRnZcLNqlhLbSX8cC6kXVOwrZJ9PpTcdgJ9xCjmr1wbH7ce/s50l3rmLvbbZL3ivmpwlAyGYcIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929898; c=relaxed/simple;
	bh=QJsWC1gMcYVMlfiKVitvzXhfgKd6RInLe4w+N7jhQUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g03dKdx8OB2MLbUHzlvGLXLKjBd7MUpof+6n/6iq3PTiYSMq0InJzGpQl/iS/3rvDLOj7+J5xseIjFfXqceUqZGrEmrm3XB46gfVaCU7u0D7fLZpuWsy4StmCCTyLK0F5T0QV2oY+GOXIKgb1yI9ScU+TTCnrYJDy0TzsQaA57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldRB+0w2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldRB+0w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8B1F000FF;
	Sun, 20 Sep 2026 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929896;
	bh=ShJuUyGu37YLcWmRpCjUv5c3tepo2YY+TNWNbuzT9es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ldRB+0w2x0AdgNKHhKz5TqehKAcjNVeIcSkwTnjYthzEUouNivwECwGTEH1/DfjDe
	 hKis8fGjBvJr0A3cDG7aw79QJ6CNA4jiWiFb84b4EDL8JxV0nYx5Eve2DHYsFAivMH
	 xxQkbIVw2re/n+t1IDgeSyfp4+HMxesnofPyx38y1dTKR+EQ1yWuHWnXT1wRyGch9Z
	 f7ioi83RxP7WPwsKzbq/EHINOboUQcWbJBmhVJRj0ap6TTb7fSydBQxN6qB5OvYIpi
	 5t7gkpDrCg0M75DG5DyzvQGBIvFVkWRHJCOrxoJEAWGgW1OAVBLmu/H5l3ehIuSWQ4
	 z7ODk74O5Y3gQ==
Date: Sun, 20 Sep 2026 19:44:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 03/11] iio: dac: mcp47feb02: use field_get() instead
 of custom dynamic macros
Message-ID: <20260920194454.7fffbf97@jic23-hlaptop>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-3-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
	<20260918-mcp47feb02_refactor-v7-3-82ca794eafe2@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 12:06:29 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Replace manual bit operations which select channel corresponding bits
> from a control register in mcp47feb02_init_ctrl_regs() with field_get()
> macro used with masks already defined for regmap operations within the
> driver.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20260913224339.490d89ba@jic23-hlaptop/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
The Eagle eyed sashiko points out that MCP47FEB02_DAC_CTRL_MASK seems to be
no longer used after this patch.  Please drop that as well.

Jonathan
> ---
>  drivers/iio/dac/mcp47feb02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index 1b1a4972f77196399297b3912abe69efcbf17d75..d910a6cf9718d6c6ad68eb1bb1ff5f3b15b33e84 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1024,7 +1024,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  			return ret;
>  		data->chdata[i].dac_data = dac_val;
>  
> -		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
> +		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
>  		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
>  
>  		/*
> @@ -1068,7 +1068,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  			break;
>  		}
>  
> -		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
> +		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
>  		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
>  		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
>  	}
> 

