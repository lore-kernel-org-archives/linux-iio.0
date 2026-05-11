Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D3308F15;
	Mon, 11 May 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510096; cv=none; b=Vxfxj2c8/WH4/MMa4fgfhx4vPlm1hh5mtRukqRO5jgYXBopnZ1uCD+NGb5Hv3Sg57tcmO2v1sZAURGBqSj8xyRE8GsFaCM0UiBV5ejNGEclH7ABHsyGKuilNFFbje7pG4MVkQyQdgKpfwu+VB1D6bFUr2B8mcto7KMFJZim64MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510096; c=relaxed/simple;
	bh=ff5K1YahL+W6BYrNSAw+gF/VIPU32ovACXbWzSdEUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYq8wgxPiXViMaEH7aaF4P6t5DhMP5RkrU/9OPSRTyDfpkSWh6l6MY9hITwOOLQcY/JMwDyQbExHxHeRTxxBdQuu5Vk5qMGDNMXxy6Ogt9IzcvbXBLUG8FM8CSRJ1nUk7c+6OUx8uyd87/0Zhkkd9jue2HtGJj18mS+ZSgaZ3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le5matBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le5matBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF3C2BCF7;
	Mon, 11 May 2026 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510096;
	bh=ff5K1YahL+W6BYrNSAw+gF/VIPU32ovACXbWzSdEUF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=le5matBd68sP1nWObQASOK7xWbxJHzedvpNwa2nzrrZdgGyNP6SibqXAPUdHV+1gW
	 6/BKyGskQ831BJS+6OPJ8ObJ26VZc5LLmMyqkAys48N57gaSyZuCax3icqA8CI42bf
	 iKIhhRt3tIqaT2tI49xnukP1xQfKPewq2vvXvtu0UZzyUxYK3JIxVTVjVhg+s+yMPp
	 kFLKUc9SvRk9iYfBvJF1hKl/CiOMWIztWxFp12rJg4sJuEL7prcCaL69hfcqGTHBSe
	 hHgW/sJYxR4CblftLy+8hWv7zX4wQEVsnLXo6Pfrd4gzyJygNQXQFoHvXeJjPSifQw
	 RGrypb2HJOoDA==
Date: Mon, 11 May 2026 15:34:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
Message-ID: <20260511153446.14d0b95e@jic23-huawei>
In-Reply-To: <agG8AG1srKZ4oWp6@ashevche-desk.local>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
	<20260510194947.31997-9-piyushpatle228@gmail.com>
	<agG8AG1srKZ4oWp6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 14:22:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 01:19:30AM +0530, Piyush Patle wrote:
> > Separate the initial value assignments from the declarations in
> > hx711_read() and hx711_reset().
> > 
> > This is a small preparatory cleanup before the later loop-iterator and
> > variant-specific changes adjust the local variable layout in these
> > functions.  
> 
> ...
> 
> >  static int hx711_reset(struct hx711_data *hx711_data)
> >  {
> > -	int val = hx711_wait_for_ready(hx711_data);
> > +	int val;
> > +	val = hx711_wait_for_ready(hx711_data);
> >  
> >  	if (val) {  
> 
> No, blank line should divide the definitions and code, and should not be in
> semantically coupled places.
> 
> ...
> 
> Again, no need to resend, but keep in mind if you need a v8, this and other
> comments needs to be addressed.
> 

Looks like we are getting a v8 so to make sure this is super clear..

	int val;

	val = ....
	if (val) {
	}

is the correct spacing. So also a line missing above val =
that I don't think Andy has called out explicitly.
