Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1F37472F;
	Sat, 21 Mar 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098869; cv=none; b=aRAUaNamhUUSwDIiM58Wa+ngDo13QQkNG1yLafpDguodGO8P1HN66SBSOCt4Fr0S2g45C3VBjbWS/DuwvP54jdE50dPgDhWoAfNizd9AeQ5+4dixNh/M5h4m25DNpUttVBQK9fKw9Tugfw8otoLL3A22WMqaaOfdX5WI7Nz5ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098869; c=relaxed/simple;
	bh=DMNh9qeH/WYghLd4OhObaP70yF+SAtXt87jAYBcidVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbOf6VRMu0RRaEsHfsxi+JmOpth/vZ6AUppZWede/FeGipj9sKZCPhDpQol0eMwOMQaJW8RDFLocz/2T7vr3zmak1Ryg2KQV0bTL5yYMukI8GX1eBVWuBKnMjcRaYFV6g35eAsu2mMqb1Fp/i8V1wQ2WSfEaM2qalEQO2/NvXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2wUieDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2wUieDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1695C19421;
	Sat, 21 Mar 2026 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098869;
	bh=DMNh9qeH/WYghLd4OhObaP70yF+SAtXt87jAYBcidVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L2wUieDHjpUe7x9V2vgCHxrQe/eZQP3HbFlSUBV9/bCwSu7k3J2O4pLB0gxImqhYL
	 JnNZxl8w24rTBDn/gip3us/w7OM91QHwfVKHuBSAC3aRtCFuVGegqC49QcVYitMg46
	 jW7qQTERkFYjjmkERYR3Rg3GfzB19TffpMCbytV0kCNW/89IhoG1AGY7BAnYA6u35c
	 SXccTQ+GOLB4AJFFFHlnnlzjZ1M+ca+2g7xjCK0Iwv4Dqoua2th7UETB02tnpiqoRy
	 Hv8o5MxdpqAQox3EnwyXvRs4lLwFZCEdZCZUYe9ojX+K2gNUxkUFxoq+1VBQYTO5Es
	 B9EJZEul457LQ==
Date: Sat, 21 Mar 2026 13:14:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: iio: ad5933: use sysfs_emit() in show
 functions
Message-ID: <20260321131419.559ce8c2@jic23-huawei>
In-Reply-To: <20260320222424.53294-3-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
	<20260320222424.53294-1-grondon@gmail.com>
	<20260320222424.53294-3-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Mar 2026 22:24:23 +0000
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace sprintf() with sysfs_emit() in all sysfs attribute show
> functions. sysfs_emit() is the preferred API for sysfs callbacks as
> it is aware of the PAGE_SIZE buffer limit.
>=20
> Also remove the unnecessary (int) cast in ad5933_show_frequency()
> and use the correct format specifier %llu for the unsigned long long
> freqreg variable.
>=20
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>

You should have replied to Andy's comments to say why you aren't
doing the more substantial refactors he asked for.

=46rom my point of view, this driver is far enough from compliant ABI
that the changes suggested need major rewrites of the driver.
So it is very likely all this code will get ripped out before this
leaves staging.  No particular reason you should know that though
unless you've looked much more closely at what is needed.

Hence my main motivation in picking this up is we won't take other
people's time converting these. I doubt anyone is using staging
drivers as a source of information so the usual point of ensuring
best practice in code that might get copied doesn't apply.

Anyhow with all that in mind. Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> index 85a422329..e5a4f8d7a 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -285,7 +285,7 @@ static ssize_t ad5933_show_frequency(struct device *d=
ev,
>  	freqreg =3D (u64)freqreg * (u64)(st->mclk_hz / 4);
>  	do_div(freqreg, BIT(27));
> =20
> -	return sprintf(buf, "%d\n", (int)freqreg);
> +	return sysfs_emit(buf, "%llu\n", freqreg);
>  }
> =20
>  static ssize_t ad5933_store_frequency(struct device *dev,
> @@ -338,27 +338,27 @@ static ssize_t ad5933_show(struct device *dev,
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD5933_OUT_RANGE:
> -		len =3D sprintf(buf, "%u\n",
> -			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
> +		len =3D sysfs_emit(buf, "%u\n",
> +				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
>  		break;
>  	case AD5933_OUT_RANGE_AVAIL:
> -		len =3D sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
> -			      st->range_avail[3], st->range_avail[2],
> -			      st->range_avail[1]);
> +		len =3D sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
> +				 st->range_avail[3], st->range_avail[2],
> +				 st->range_avail[1]);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		len =3D sprintf(buf, "%d\n", st->settling_cycles);
> +		len =3D sysfs_emit(buf, "%d\n", st->settling_cycles);
>  		break;
>  	case AD5933_IN_PGA_GAIN:
> -		len =3D sprintf(buf, "%s\n",
> -			      (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> -			      "1" : "0.2");
> +		len =3D sysfs_emit(buf, "%s\n",
> +				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> +				 "1" : "0.2");
>  		break;
>  	case AD5933_IN_PGA_GAIN_AVAIL:
> -		len =3D sprintf(buf, "1 0.2\n");
> +		len =3D sysfs_emit(buf, "1 0.2\n");
>  		break;
>  	case AD5933_FREQ_POINTS:
> -		len =3D sprintf(buf, "%d\n", st->freq_points);
> +		len =3D sysfs_emit(buf, "%d\n", st->freq_points);
>  		break;
>  	default:
>  		ret =3D -EINVAL;

