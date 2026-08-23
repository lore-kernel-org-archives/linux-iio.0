Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA51A23A6;
	Sun, 23 Aug 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787448116; cv=none; b=YvlacD4SDM/GEO7RgIjWm7v1cfCwCgT/dLeS9UONqU6N9nfHts2bJY7RdwohnI11cktnSYlgsw+OwgbSM2fmmsy8eq+oqXbOQMfhydIRwz+W+H7pVlJL58JGpH4KE7zAGcdMaWiY+2PFh0TgS8Vok+PjI2wMJEN+ezzSInPVTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787448116; c=relaxed/simple;
	bh=IPbS25TpnnnuM0WguuYholjWOM1J6+8IUvO1N79FBko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1iVePAxUA1iymBobV02DCNNK2Ru9wF9nUKjeGxR7liJOOu8DvtdfEDdATd2xdja/RBlYBU6e/uj3WgT8zAVb8npFGDentj3c1/ptwZrqKTMJH+0VcXrZsFZPIJANTQYVGlG6QJi2jKsMjfslY3eFICutcGM++7zSVnXjdDFczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxzQUJ+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxzQUJ+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F01F000E9;
	Sun, 23 Aug 2026 01:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787448115;
	bh=Vu5/3ShycdDYCBSFKCIHRmm4kKeuJYxrfnp7DodCBQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KxzQUJ+i76GTwZd5XQSeJuMOMfilm+orRTk998NHlru9CIReWVufDN5h4DxAjnNnc
	 NH4mhQEoRAHVaNns3NBx+xnnyGiq2pgU3gtuaTaS2lEB/USnLrpHBoX8WFf+TKNo1r
	 5tUJrCspbdOPW7Lp75qqWD1VAzM0u0adaTlrwdHUZDA84riLiLvSRDUWEeSfpkmpQ0
	 rFHDuFwj6Tk42OJnvB8vJl8Sb/TlveOLdTyU9g5FM2j7Yg+tLet63C+1mgFKZzkA9R
	 EMI9lmlD2gpRLMw2VP5r2lfLsR1dNfvx72jceEMqkajDChEnafY568qo/ctJgtyWw2
	 Vb7HGdjivio+Q==
Date: Sun, 23 Aug 2026 02:21:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: andriy.shevchenko@intel.com, Michael.Hennerich@analog.com,
 andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, krzk+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 5/6] iio: dac: ad5504: introduce local lock to
 protect state and spi transfers
Message-ID: <20260823022151.4ded2f22@jic23-huawei>
In-Reply-To: <20260821140546.96474-1-0rayn.dev@gmail.com>
References: <aohTG8UxkmHSUzzh@ashevche-desk.local>
	<20260821140546.96474-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 10:05:46 -0400
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> > This part is not needed to be under the mutex. So, first convert the
> > input, then acquire the lock.  
> 
> Good point, will fix in v6. Sending tomorrow to leave a bit of room
> for any other feedback on the series.
> 

Even at v6, 1 day is a bit quick!  I'd not mind so much if we weren't
at the end of the cycle when nothing is going upstream quickly anyway.

Next time please wait at least a few days.

Jonathan

> Best Regards,
> Taha Ed-Dafili


