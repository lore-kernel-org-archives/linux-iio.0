Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3702FABFB;
	Mon, 21 Sep 2026 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955465; cv=none; b=DUoktgqVgfB+FTdEojOoIOLonfclEEZTHSbnvtlHRg915Ysf7PoXlKPPcfRAiB+fMDCyzz+wxK1INJVAUURw1eDtK8//s7WrDVZ8YDJ2Wlkl/A4LQ0R7sbWvyNOg0gSB7Uad0uiAsnAJCQtjVTAoVe05Lc3L9je2KRvm4oIn+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955465; c=relaxed/simple;
	bh=nev2OHsVhnZ1IjoVtapy+7KySSK3L10v6SB+C58anWo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=T68Bvlfn0qFgi6t2S8GZxfLuwWvcH9hMKQrBRSRLF47e0W1pFLRCNRsDg6hmYD44XPgT/7roHU2P/kHn/5qO/eef4Hh9QcdiSH+C1Znrx3tKlLYLdGV/VyxGPqaxZVuO8Mw2NlVWFHJevRTU0UXfbKl5qmgvdMq5AKSCR0JKIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frfS+mpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frfS+mpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6B71F000FF;
	Mon, 21 Sep 2026 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955462;
	bh=k+gvb8370e+hY0RFfXD7UFvUt/aj+vbi4qgE38NFneU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=frfS+mpVGODjQmBJGcX5FKjGGZ0EbgWeTZ/uG0X4YVyUZDEN/lE8a8bX47h+QXGat
	 253dAAbOMF4b1C0lh+ekSbQ1rVhKxyzr8Ha+dAC1x/+gf7jPz0pZKXym4VzDdm3AwH
	 5WkxHIiYajpgadI7LGCgvmiL4tJfWKU5esh9KOL/Ij/Q3p4GDPKzt5jRqWrYFRbhhM
	 7y+ivbbd/KjwIFCYx9CDSVoKkFMlaeAwpL9bnvcklvwQEKg9c8/1c92CUJWCIQeJrD
	 CYm/hXcmKOniLmL/Weocq7/jR0ZxU4sxRnbuOL4Wf4KcOfC3PJHD3DHElaCfD5Qt/7
	 NDWy1nkl9Zgxw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/15] iio: adc: ad4134: Sign extend sample data
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <7083358e62e3edfeeba0201aefd8d3195ee951d0.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <7083358e62e3edfeeba0201aefd8d3195ee951d0.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544506.955708.8075422922635447699.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=nev2OHsVhnZ1IjoVtapy+7KySSK3L10v6SB+C58anWo=;
 b=kA0DAAoBVIU0mcT0FogByyZiAGqwjXegSP27wC2221nCeYsvL1ItllH5g1vtpf27eBEo/ZfvP
 YkCRQQAAQoALxYhBG4pZrOHhAZSkSaBsVSFNJnE9BaIBQJqsI13ERxqaWMyM0BrZXJuZWwub3Jn
 AAoJEFSFNJnE9BaIqMoP/1G2XZvobamq09snMcP409GgFVgfSyLnhN00/V4QfG/Zw9tHqDjeSY2
 QE0f5EBbWCdM7T/gQkZDJxpZADOKLTLU+a7BaDKUF3Pz9gDQGn6q+Nh5UGtMFTx7UH8AvV5ww/b
 V6aWTz4efb/oN9aOvpU3veXlKQEostPFdSj4ES05JmDe+3Ie9EiYw/tiMOZ+y6VXSqSpuQopKHU
 nfsOeguOA56sElc69WUSwEltqEiWBgaQYI3fiv1V85k31yeLfGGyo+qzWFak0+sVt1GsMghtrZJ
 q+wn8eYPvCtkZ4D90a+njMQ1K8d0usmza9AlQIfTgvQPOFkwpep3FytHz20aiT9ywBPG7Wkbr20
 ZyREpUZkaLWYCe8H2+JYsd26sLH2r47igJJgm4atAVGCf/CeHb/FhDUeWOTNBlQqLEIdZBS4PcY
 9iCwqbYAR7UBv+To2qmoOjSAofNLuMQuNTrboL+zIMDFaM46bnd6VTy7g6iDz2PqE6sTlJowc6R
 n5RdhVePvEbavA95Zz8UpYiWI42CWjyWxgwosDgJkebnkxcItV0F65XpBOnXa1yVixdLl9tSme6
 V2Nd2hqIp25PDRHcMf6zHx2CVwr6zPHFHndFWO+2IRCDo4xEGSJAiZdT/ANT3pfrHYtjUpx9QKd
 CtpdlsQkepBLLLwCVXbCgGi7Txlra
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Sign extend ADC sample data for correct delivery of negative ADC input
> difference.
> 
> Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo, Sashiko made a comment and I have no idea if it is
right or not!

>
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 0490218bb0e9..7d40c0521bb3 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -172,6 +172,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
>  			    unsigned int *val)
>  {
>  	unsigned int i;
> +	u32 sample;
>  	int ret;
>  
>  	/*
> @@ -196,8 +197,9 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
>  		 * Clock out data from all channels to avoid that.
>  		 */
>  		if (i == AD4134_VREG_CH(reg))
> -			*val = get_unaligned_be24(st->rx_buf);
> +			sample = get_unaligned_be24(st->rx_buf);
>  	}
> +	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);

Sashiko.
[Severity: High]
Does this code leak uninitialized stack memory to userspace?

If a privileged user reads register 0x54 via the IIO debugfs
direct_reg_access file, ad4134_data_read() is invoked with reg=0x54. This is
possible because of a pre-existing off-by-one error in the regmap
configuration (where AD4134_CH_VREG(AD4134_NUM_CHANNELS) evaluates to 0x54)
that allows read access to this virtual register.

Because the loop index 'i' only iterates up to 3, the condition
'i == AD4134_VREG_CH(0x54)' is never met and 'sample' is left uninitialized.
The newly introduced code then unconditionally sign-extends this uninitialized
memory and writes it back to '*val', which is then returned to the user.
-
Smells potentially valid givne previously val was not set unless
we had a match and now it is always set.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
