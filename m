Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC83E5585;
	Fri, 24 Apr 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051169; cv=none; b=mYvUjVkUfhvN40Tvu9ZuHnl5HF9RPHPdhGxlDwPvuzAhadtaDtG8FmRJRQx3ev8PlkVYM/AsvtSDcqt1bRlSGMZYfjh1pJtx6IwNdcth4zSoNPVjFtzv6NjLi/jf9qti4mOfd5z+SRmbpF8qHT50oqouLfTstc3AiRgHN+klFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051169; c=relaxed/simple;
	bh=Lelefx0d/T793B/gZwrS2Nr4n0p9FFyd6jbOw+E4AB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtnOQAvilq7pJUp6pT9Y9bQT9vbF8g0phhPiIt+zHjUWnMBbTqdEt00QKmK1qQE2zJsnAsXcynUlQPCuuqvENSldlU8YjHjap41s5KEN1KTAG1BHyOPL8sc5WMB6aPAvsL3EH98/uQrSY18+xiyEuvfjfg/3R1DG3x81OSPbok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc6nQAqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc6nQAqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C246C2BCB2;
	Fri, 24 Apr 2026 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051168;
	bh=Lelefx0d/T793B/gZwrS2Nr4n0p9FFyd6jbOw+E4AB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mc6nQAqCpiWX2SCKY/q1esh4D7vJ8KOzR9wLAUvCr57pAayMCgGj5qNnB0/VWeL5W
	 3wKKu+li3TfHFLAGUT/Id0QYOs+50sxLfWYzANDaxSGIfbYcj5+wzDjTx5+j4ncjLi
	 SFXik1RcY5sgUR3eY8s1FXZb/m7UmO6OJ0Y4dWuuCfW5I2lviY6kncj/sTUgILRHID
	 KkVV75JI+V2smOb8VGucjp6kHi3yWK8nqAh3QQ5gbpQ6UX/FsBl7SlYgel+ZeWjLc9
	 rBPHRdZJKKNH8C5KTqSKS5QhcT6gU2H4bdJ8hUsw28m5WtFosVvu8hmJRmhSARLG4z
	 SRVId+ObeoYEg==
Date: Fri, 24 Apr 2026 18:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <20260424181919.62e2e6bd@jic23-huawei>
In-Reply-To: <aekjfPR7JksBESxX@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
	<20260422165643.2148195-5-sanjayembedded@gmail.com>
	<aekjfPR7JksBESxX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 22:37:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 10:26:41PM +0530, Sanjay Chitroda wrote:
> 
> > dev_err_probe() makes error code handling simpler and handle
> > deferred probe nicely (avoid spamming logs).  
> 
> This patch should go earlier than dev temporary variable one.
> And dev needs to be introduced here.
> 
> ...
> 
> >  	ret = regulator_enable(data->vddio_reg);
> >  	if (ret) {
> > -		dev_err(dev, "failed to enable VDDIO regulator!\n");
> > +		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
> >  		goto disable_regulator_vdd;  
> 
> Before doing these patches, please fix the mess with the devm/non-devm ordering.
> There shouldn't be goto after any devm calls.
> 
I briefly wondered what you meant here.  Key is you are referring to
devm_request_threaded_irq() much further down.

Absolutely agree that's wrong.  Rule is devm until you stop doing devm and
then no more devm.

Here it looks like we can take the whole thing devm but it will need
some custom callbacks and we may run into corner cases with runtime_pm()
messing with the supplies and devm cleanup doing so (that applies even
without devm being involved)

Jonathan



> >  	}  
> 

