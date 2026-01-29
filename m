Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598635580B;
	Thu, 29 Jan 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708910; cv=none; b=as3eEVq5CSo+b34Q/zpXd+Dk2sL2Hvlvj6NltUn2iBMlRuDvqYR/ehq1hFUL4OxBkt2bPG90KydxxmmHhxm7jgktvA416f50UrgLUFa2cmCUB6COVghV9id7uK1iJSe6HisdDf0MZiXxE+vA9kMr5c6ieAJYWNO3u1vRC4jd9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708910; c=relaxed/simple;
	bh=ue5nxSZZFNWBfdEwyTU9veKosEKyz8dnkE6Hp01ASJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG8bCDzNv6h5IuSLjVCgPP93P4L2sppaBQf9yqWcBrtZ5TN4ZkVpxw2wCNeoBSy/cUwoGGZO8K51lohjMsN7t2CJiJmqFMDYiD5SNGli8Ws2WxpJoRWOJHDirqFhAKgtjPBmdZKdRdg+Gbq5h9++1m9qIIFPOkl/ESxP59WonL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7z0K1MO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7z0K1MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6C2C4CEF7;
	Thu, 29 Jan 2026 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708910;
	bh=ue5nxSZZFNWBfdEwyTU9veKosEKyz8dnkE6Hp01ASJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7z0K1MO/KMU96yKrqtXdTMi4j6RJsL9imjBMMWqvkzWklEs2MJiinUxgKytgSIu4
	 dytQAThxPbjeqIXEIjBQsTZxqq1jlbbKUGZU6hB2/PEFQOk9z1H6JEbd8HrM8dQtXS
	 qaBLuEV9QkdfFzzQmcryyLeZK6LzcnhWW3Op59Rgn61P7i+cSePdEtZsu4Yt4sxb6G
	 qgvz7p8jJzcTHfmTNREiZcCQxHFGcemsRptIIM81jCsXZuvfqr7xRfHmiSx6LUSF6m
	 nzGOiXs7TVeA0j23cADs2yOK9zhE4Vd4/Ao1CezY2+MBGKf3mJomV/wwgPfqR551aF
	 8yI2tKy23Pfiw==
Date: Thu, 29 Jan 2026 17:48:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <20260129174821.6bac5868@jic23-huawei>
In-Reply-To: <aXqMRZqezVz8qn_3@smile.fi.intel.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
	<20260128-b4-rfd77402_v5-v8-3-36388fe7b95e@gmail.com>
	<aXqMRZqezVz8qn_3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 00:23:01 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 28, 2026 at 11:21:50PM +0530, Shrikant Raskar via B4 Relay wrote:
> 
> > Replace the manually written polling loop with read_poll_timeout(),
> > the kernel's standard helper for waiting on hardware status.This
> > makes the code easier to read.
> > 
> > Move the polling logic into a dedicated helper function, as it will
> > be reused by future updates.  
> 
> ...
> 
> > -static int rfd77402_measure(struct i2c_client *client)
> > +static int rfd77402_wait_for_result(struct rfd77402_data *data)
> >  {
> > +	struct i2c_client *client = data->client;
> > +	int val, ret;  
> 
> 
> Where is the newly introduced comment?
I put it here whilst applying

J
> 
> > +	ret = read_poll_timeout(i2c_smbus_read_byte_data, val,
> > +				 (val < 0) || (val & RFD77402_ICSR_RESULT),
> > +				 10 * USEC_PER_MSEC,
> > +				 10 * 10 * USEC_PER_MSEC,
> > +				 false,
> > +				 client, RFD77402_ICSR);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	return ret;
> > +}  
> 
> ...
> 
> > -		/*
> > -		 * As per RFD77402 datasheet section '3.1.1 Single Measure',
> > -		 * the suggested timeout value for single measure is 100ms.
> > -		 */  
> 
> ???
> 
> See above.
> 

