Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CE23D7CE;
	Sun, 13 Sep 2026 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259177; cv=none; b=j6Hz4igXA2cHnOJlC13T79Qn772oPfez0zSOK8yWkUbd5Pz2T5TAFNcZTEnKAk7TYfru97hSbixr6sX6x196sTkWUSadJnSohp6GBGbH4Ue9qjiGnqF71YWgsmm7c90Olq9sXUdBX/POgC5OfxjdiD16AXUD3z4BB6kVEhVgjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259177; c=relaxed/simple;
	bh=mbGy5J1wH0tHCsdnYJvHrDqGzQHiQ+V9xK8h0nYwdug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F09PAF9QM5j7pPFDAF6ufiNw2zxt4l3MoqVjz8oyjua7kcpaHbKX5wqZtAhlkPYQLNcYmCA2lvZdNsDXx/UC40xWmRqXUGdVhdE8XMHlKOSSq8SOLOSPkflURABQ1tS8HVAgPQwCMOifMBPi7KU9kQwhbTum1yV10ixVksOdLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRf7SFu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRf7SFu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4857E1F000FF;
	Sun, 13 Sep 2026 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789259175;
	bh=hgNGnjGjckr62DBzsPqklyBYTtJwHtzKKZEQx/7I33M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iRf7SFu/H6AlQpjq0c2D2war4hn932/GgR988qSkoQiIvtlRo3pYqwfqJ20MrF+y2
	 VRuLAeqPkxpI4sLIvfhuWkssSxEBv9cR66eFzxNxVPtIxm7pFi+ZH6YsZk7okZ/2Ac
	 6w1JV9lq0XdO0//qVFYnhhLIAlSr+GmxVg9qlB8pX86CkLMWFxB+OGyzkYxfuw5NpC
	 iDNIzGSjCfISokc7dympuiZIM7OPsMXGygcRvY9XK3SzXn0Lps1j7Dz1j3JGsddUOI
	 ihGD8/qQu7rGlLbWw0HAI4oqX0PUmpFlwqq2U10AOduF7fTi/FO7Y4FfDVAJdGnTbx
	 CGHom3nbKRClA==
Date: Sun, 13 Sep 2026 01:26:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
 vitor.soares@toradex.com, samagazaryan@google.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, boris.brezillon@collabora.com,
 oleksandr.shulzhenko.viktorovych@intel.com, tgopinath@linux.microsoft.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux@roeck-us.net,
 Frank.Li@nxp.com, jorge.marques@analog.com, pgaj@cadence.com,
 wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, lorenzo@kernel.org, enelsonmoore@gmail.com,
 rppt@kernel.org, pratyush@kernel.org, giovanni.cabiddu@intel.com,
 gabewhigham@gmail.com, haren@linux.ibm.com, pasha.tatashin@soleen.com,
 jirislaby@kernel.org, adrian.ho.yin.ng@altera.com, ustc.gu@gmail.com,
 jszhang@kernel.org, adrian.hunter@intel.com, akhilrajeev@nvidia.com,
 tze.yee.ng@altera.com, manikanta.guntupalli@amd.com,
 shubhrajyoti.datta@amd.com, jarkko.nikula@linux.intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] i3c: set i3c_xfer.actual_len in controller drivers
Message-ID: <20260913012612.745247fa@jic23-hlaptop>
In-Reply-To: <20260911210935.1353126-3-meaganlloyd@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
	<20260911210935.1353126-3-meaganlloyd@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:09:34 -0700
Meagan Lloyd <meaganlloyd@linux.microsoft.com> wrote:

> Set i3c_xfer.actual_len for reads across the I3C Controller drivers.
> 
> actual_len provides a consistent location for device drivers to know the
> read response bytes without overriding the len field.

Hi Meagan,

Why is that useful in this series?  Currently this sounds like
an unrelated change.

Jonathan


> 
> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
