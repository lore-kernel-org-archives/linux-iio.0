Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D51CAA65
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912117; cv=none; b=Pvb/w+C3ui1hzC8TWrIT73VZqcjzluMYLTvWscPq5PxVSCddmBXwRaciVZE8xsjU60GEPexMaApNkKnF4ui2m0Km0cyEjOo2jvvRgAL1Jw4Pmew+q425tCPmoVZ8qH9EDKh+LS5qAM+JV9eO2TWQW8OjT4eVl/63YiHva5w2TE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912117; c=relaxed/simple;
	bh=ztjOOSO54tCzHYxq2SzXkSvMK2ETLWfyHU2DVuiT8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2yk9Ezvz+OnjBwXHcirz1DL/oxOWaywg6ZT37hnQLIi+g0vaM8Mwcuytw+ejndGIARZ9gheta2rSqTgiiZb8vyRxnXRcESLtI2eaT2QzCb+wEq8iaseEPlH6vlaHAtJq6P8odw5GQwX/aLt/8ar84cHw9gPbQhmNfyZH6Sk8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocqj9BnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocqj9BnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C8EC2BCB8;
	Mon,  4 May 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777912116;
	bh=ztjOOSO54tCzHYxq2SzXkSvMK2ETLWfyHU2DVuiT8MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocqj9BnHta2XGIovsNfxbEDip6MiVQ1LZVRrbhCRDWWCfW4eJEnsIRIr4PbXIt9vr
	 blTx6EzBPlQ25jtGLy9Ly1y/IMp/3lALMWjBW2nLdOChYzYvT8PajNSU/nYpjjmYrA
	 m2gKnuxFev8SQg4NBUUHeuf1Z69VCOZxwfqj6kqrVEguVNMIxJvh/dvE9bQig7w0fK
	 GcFebtVa7a4ku53UKclnOhLPVyMAdXvElevYdMcKSoochFphhZj3KSVacda31PbGOZ
	 zNIcTNKBhbsgJE3/OlCG/cyAv9FsyKd9kZRksRtUpz+afgDBIpCH9d/Wl4QlvGxgHu
	 Bi/qAZI1HK8mg==
Date: Mon, 4 May 2026 17:28:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>, andy@kernel.org,
 dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, nuno.sa@analog.com,
 ricardo.kojo@ime.usp.br, elliancarlos@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for
 veml6030 and veml6035
Message-ID: <20260504172828.0939ce30@jic23-huawei>
In-Reply-To: <afip4G46Bkj4iEka@ashevche-desk.local>
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
	<20260502234348.131563-3-gabrielblo@ime.usp.br>
	<afip4G46Bkj4iEka@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 17:14:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 02, 2026 at 08:41:04PM -0300, Gabriel Braga Lagrotaria wrote:
> > Modify veml6030_hw_init() function to deduplicate the setup logic
> > for veml6030_hw_init() and veml6035_hw_init(), and remove
> > veml6035_hw_init().
> > 
> > Additionally, introduce struct veml6030_hw_init_config_desc to store and
> > pass the custom configuration values specific to each device variation.  
> 
> ...
> 
> > @@ -963,61 +972,21 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
> >  	return 0;
> >  }
> >  
> > +  
> 
> I can argue that this is a stray change, but I'm not objecting to having it.

I am. Don't see a reason for two blank lines here.
There are subsystems where that is standard formatting, but it's not in IIO
and this driver doesn't do double blank lines anywhere else.

I guess Garbriel has been looking at other drivers where that style may
be in use.
