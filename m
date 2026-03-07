Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB334D4D3;
	Sat,  7 Mar 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881788; cv=none; b=Kp83udcc2h9BqIGVvCFvAU9YbUr4DHcMd+aAzEAXveZL+Pnj7n2okdjxdOCrAju/YBmTo99DeK368BBBZ2A+SJz8WTprP8xxeBH994vaSEh1jNgzvobWhvdbdzPFibg+4Zp+VUUgib431ysESiL7jUwS6jKH5RdjzirE+vDUPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881788; c=relaxed/simple;
	bh=cjjr/VoLwDpuHx5Rt1NM/iEHxNEsxfEWMLb4ptTu3WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fx9ng9IlCn3TpPVKAggTJ3SFQCa4D1aaMukcFJwxvcO3iBa3mBcaahIeTq5R0anqC/ZDOXuYkWCYXUJQG97dvnBNHOUJ5ky7A1dQIbfLjGaIdOcImxHxRLOA02iMleLhhCYq7Tq38rLpMM85pUsVfxrxNj2U7QGemIoHZIR5pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/PkVYtY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/PkVYtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0FAC19422;
	Sat,  7 Mar 2026 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772881788;
	bh=cjjr/VoLwDpuHx5Rt1NM/iEHxNEsxfEWMLb4ptTu3WI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/PkVYtYe/prLDRN3OO76pZKXiNuL1txySgkEr4RGahVn6LlYhOCJwGwpBF/jYEaz
	 3siE8ERxyGN67j5718KhbO+cSTP+EFppwQ/l3EJeiVdXnK9kz28w7zaoixxUMasEr/
	 /rwR5d6vzidZY86TYSEsEJznHfJlxAhfEvwxDX3rj2Y14fDT1+R5Q05id7WJ/OxH57
	 61+zSUdhDP0kWCEPGJTcQukf034ujBBpycKXdmNjFSMu8HAZJaUfMhuhJf5ruZYp+4
	 jAn9eTX3FmJHUc+sVgNbL3RbUA9jzR28ZbPFPnPsvZkV1gK20hLM5TJeZfF8RYjT+V
	 1hcjSUoUpamAA==
Date: Sat, 7 Mar 2026 11:09:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: frequency: ad9523: use dev_err_probe
Message-ID: <20260307110939.7fbfe548@jic23-huawei>
In-Reply-To: <aarHeQbq-Ml-ZjqR@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
	<20260306102504.42395-5-antoniu.miclaus@analog.com>
	<aarHeQbq-Ml-ZjqR@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 14:24:25 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Mar 06, 2026 at 12:24:48PM +0200, Antoniu Miclaus wrote:
> > Use dev_err_probe() instead of dev_err() in the probe path to ensure
> > proper handling of deferred probing and to simplify error handling.  
> 
> ...
> 
> > -	if (!pdata) {
> > -		dev_err(dev, "no platform data?\n");
> > -		return -EINVAL;
> > -	}
> > +	if (!pdata)
> > +		return dev_err_probe(dev, -EINVAL, "no platform data?\n");  
> 
> Platform data?! Maybe we can get rid of it entirely?

Good thing to do, but big job. There is no DT binding for this and
the platform data is very complex.  I checked though and the part is
still recommended for new designs so if Analog wants to support it going
forward that work needs doing.

Jonathan

> 

