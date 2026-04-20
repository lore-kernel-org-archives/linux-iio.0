Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF73A7F41;
	Mon, 20 Apr 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708007; cv=none; b=k0X0ZbuuZyQY38Izp4AtgvqBBQEiS1mnRa7tBrVeBl8R9Uj+1Q2wjumKcYbAcbRsFaoIQ5HijIWj0qZmBQNNYeLXbIhWQbN/x3a85BUSTjcGxJo+0jWhAzfC0GJPif8L3oHzKL/eNLhS1t0XpkxpZimyiXrYjzLDEmk9YCFZTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708007; c=relaxed/simple;
	bh=r1fIjUeSxsMecxMdPKeTMgbmN3KqMTf+MAqPY/2AiHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgQuTBTRvKedYdDI11+tjk31AqgF0NKuv+J69M1SaByykhvMlc9mveSH28uGBeJddRRaxSBX9WRapTwogcDiwgiIGlqUsHf2QXyT5WPzLKQljJOwdlcBCs0atz51Ye5xPZbR4A9UZyRieObayYk1T6ZcEQcpW7qYg5R315FcJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDmrENMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDmrENMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8720CC19425;
	Mon, 20 Apr 2026 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708007;
	bh=r1fIjUeSxsMecxMdPKeTMgbmN3KqMTf+MAqPY/2AiHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDmrENMFMMPsT0h2fXOMJ7AAA8j7HcPYGmfobYZYzqeL088bTuvnxd8LyXw0xXFcR
	 yEBVUi0Hy4ZcbWMdywfmgN/l7J3IERNKu7MT7/pCDOaeI03foHSlpMWgqRzp4qRxPx
	 wT4stMkJ6SLwEP+NB+l9Nn+ifuY3laFgg6cnAhthyDoejHGoUvoGEjgCxFvCNej57X
	 i8l3qJjf7Ej8Bbt3js7wpDYjp7Qes2nOgQe4vK7fXJlZFDIoPzc+DGTJgD7QWgIJ9s
	 8+mmOdr1rzJArUWQJ4/ygsTFyKUekhxUmAEprf543MSx7BocZTT5k5n/IZsubDpaCf
	 nvAHKrzqFoB1w==
Date: Mon, 20 Apr 2026 18:59:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antony Kurniawan Soemardi <linux@smankusors.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-pm8xxx-xoadc: remove redundant
 error logs when reading values
Message-ID: <20260420185955.79031fc5@jic23-huawei>
In-Reply-To: <adQNCy14vfk0FCrn@ashevche-desk.local>
References: <20260405-pm8xxx-xoadc-label-v3-0-9fe179c283ec@smankusors.com>
	<20260405-pm8xxx-xoadc-label-v3-2-9fe179c283ec@smankusors.com>
	<adQNCy14vfk0FCrn@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 22:44:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Apr 05, 2026 at 04:52:18PM +0000, Antony Kurniawan Soemardi wrote:
> > Drop dev_err() logging for -EINVAL and -ETIMEDOUT cases and rely on
> > return values to report errors, reducing unnecessary log noise.  
> 
> ...
> 
> >  	ret = wait_for_completion_timeout(&adc->complete,
> >  					  VADC_CONV_TIME_MAX_US);
> >  	if (!ret) {
> > -		dev_err(adc->dev, "conversion timed out\n");
> >  		ret = -ETIMEDOUT;
> >  		goto unlock;
> >  	}  
> 
> In case you need a new version, the above can be replaced with a better
> alternative (assuming the ret is defined as not boolean and it is so):
> 
> 	if (!wait_for_...(...)) {
> 		ret = ...;
> 		goto ...
> 	}
> 
Given we are early in the cycle and have lots of time I would like this
change made.  It avoids the current slightly nasty meaning changes of
ret where sometimes it being 0 is good, sometimes bad.
So a v4 please with this form that Andy suggested.

Thanks,

Jonathan

