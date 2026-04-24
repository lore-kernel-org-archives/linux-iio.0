Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF4314D05;
	Fri, 24 Apr 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051987; cv=none; b=VkkFmtPww9YemaY+pbKI7RNR8pWoZl61JWuo2bEOOj62QG4y7ILKMjSpXs9A47KVKsOMVRK+o7zOC8QRQERKdzm84NKEoL6POnjimiCTqFMmagFMe6c/KSnTFV+ibbCtkHdjW6YWe3Q7iwCGqI7+FZGYyDKSOVYwq+OYOCLqPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051987; c=relaxed/simple;
	bh=VuheHTS/5t7AuoPF1iHAFG7k9A7SmbU3/UjSzdEZKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/nKytWVmMeGjmjiMF4/12/pCExbKsTmVJzeuUk3BnyRVIJqvkdA/TzUwuNTQi4etpPYHTkk386nXtwinKvlCy098tV48tjUnRCtEW6pD+46IbcokITh4TqKnpTWii92teNKq40BC3SwdEqp+N+RdeLoIFvJBf0jJnvy/6rGwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDf+n0Wx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDf+n0Wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2639C19425;
	Fri, 24 Apr 2026 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051987;
	bh=VuheHTS/5t7AuoPF1iHAFG7k9A7SmbU3/UjSzdEZKPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NDf+n0WxUFtHUGbwAwsVPvnSQTXhlvusFE60JMw+vg4/OUu67l/OKu5suspxi5Qxr
	 ZQjEIjTQI6iIDzFd4SETKqBok1FTaiktNzlxq7T31rJfmGSDIm05QmX7Nr5n1rTkKN
	 QnthEChpmiDWhpBVnOE8i6etvd3EVvqAr5HZXeQTIqUiKhN0vnmk67ZMxP7sSUNlKr
	 QZ4HJiQ7zMkyZlspqfDxgSe9b0IvRhL9UCdc2hq6zMWtpkHYUwEnXWGN5iZrP2thkH
	 2op7eteoLJ63UbRfa7qOTcDr9R0x/IKxQPDqjIh9ikECLumoEtBT3DOJBOnEAfK2DS
	 deS13QDJD9P6g==
Date: Fri, 24 Apr 2026 18:32:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <20260424183258.602d401c@jic23-huawei>
In-Reply-To: <20260424181919.62e2e6bd@jic23-huawei>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
	<20260422165643.2148195-5-sanjayembedded@gmail.com>
	<aekjfPR7JksBESxX@ashevche-desk.local>
	<20260424181919.62e2e6bd@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 18:19:19 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 22 Apr 2026 22:37:32 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Apr 22, 2026 at 10:26:41PM +0530, Sanjay Chitroda wrote:
> >   
> > > dev_err_probe() makes error code handling simpler and handle
> > > deferred probe nicely (avoid spamming logs).    
> > 
> > This patch should go earlier than dev temporary variable one.
> > And dev needs to be introduced here.
> > 
> > ...
> >   
> > >  	ret = regulator_enable(data->vddio_reg);
> > >  	if (ret) {
> > > -		dev_err(dev, "failed to enable VDDIO regulator!\n");
> > > +		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
> > >  		goto disable_regulator_vdd;    
> > 
> > Before doing these patches, please fix the mess with the devm/non-devm ordering.
> > There shouldn't be goto after any devm calls.
> >   
> I briefly wondered what you meant here.  Key is you are referring to
> devm_request_threaded_irq() much further down.
> 
> Absolutely agree that's wrong.  Rule is devm until you stop doing devm and
> then no more devm.
> 
> Here it looks like we can take the whole thing devm but it will need
> some custom callbacks and we may run into corner cases with runtime_pm()
> messing with the supplies and devm cleanup doing so (that applies even
> without devm being involved)

Just noticed the two regulators are always controlled together.
Can probably simplify code by using bulk operators.
e.g. regulator_bulk_enable() / disable() etc.


> 
> Jonathan
> 
> 
> 
> > >  	}    
> >   
> 
> 

