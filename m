Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8626F291;
	Sun, 22 Feb 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771768737; cv=none; b=ZdMhALGrvS1UxKMYts6/YXigwYygnrTNlM9DG1U60zO1m9ejCo9eljETIhAmh919g+Nm/mQQ5jYoxN0mQCKseFDk1Lk45XVQdVTYQZQEAkR9qPdFp1dAsFwDGow33pgb4KZTLiOuto8Mi+Ect6+ltiVP4UCXIu2bK/rxb6FMF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771768737; c=relaxed/simple;
	bh=g2HcNtWbc/QAGjodBwlubcmmR1PFFF4LLxUP8cEtz4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlO2wviQIRbkBdIn9gvNQcMoDctZoRo6vzKgp33SgHYMldSuikToWwKE1Hye0nlRcLfXeRnzX+XmmODH5t97o2PCbPkJHT0i2O7rqP7166td1SIK9NOF8K7szhzYRk43Fqo9fptzT+eGACKPNOR6lmrq3PUkYDaBla4BaJFN6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7VDX8lI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7VDX8lI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18D9C19424;
	Sun, 22 Feb 2026 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771768736;
	bh=g2HcNtWbc/QAGjodBwlubcmmR1PFFF4LLxUP8cEtz4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E7VDX8lIxCKeEN7/RfHDU8D3ADB/0U+uFTWKZdNm1yK22aSCxvx841c4//yZsNRaO
	 qHBV3vlBOGfBXggrHLMRD9KO46KFZSgNwGXSUJic673lvfgo5cDdvmpNJKM2Bhsrgh
	 0b2nQ/bKFK+k/2GsqvIc/vcU5h+ah4HpiLYECOa1Omb6R1Pp9Xx3YxWkC/7lO4JANe
	 gnpCBHF+qCSqyLe3IBH29K67ap7AvtixPoSdrCdUpou8VwwYMeBtS61iw/KEIOcOkK
	 RGhFHFXrVe+rtlVLbdHJ2jajJn16TVZni9UFnGxxuX6DFs4Ogs4Rkiu6rsfxBw/MQ2
	 ez5WDcFmB9pCg==
Date: Sun, 22 Feb 2026 13:58:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: bhargav <rougueprince47@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <20260222135836.3f8d7a38@jic23-huawei>
In-Reply-To: <20260222135054.2e2012aa@jic23-huawei>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
	<20260219213549.59645-1-rougueprince47@gmail.com>
	<aZgLutMih65WdesN@smile.fi.intel.com>
	<20260222135054.2e2012aa@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 13:50:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 20 Feb 2026 09:22:34 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Fri, Feb 20, 2026 at 03:05:46AM +0530, bhargav wrote:  
> > > Changes in v3:
> > > -Patch 1: updated macros to use '(x)' instead of 'x'.
> > > -Patch 2: collected reviewed-by (no code changes).
> > > -Patch 3: fixed vertical spacing and broken indentation.
> > > 
> > > These patches address several checkpatch warnings in the ad9523 driver.    
> > 
> > Do a new email thread for each new version of the series.
> > Do not send a new version more often than a couple of days.
> > (The very bare minimum is 24h.)
> >   
> 
> Series is simple enough I'm not going to wait on Michael
> giving it a quick look (as the driver maintainer).  Still
> time for more feedback though given I'll be rebasing the tree
> anyway on rc1 later this week.
> 
> Applied to the testing branch of iio.git.
Pulled again.  Just a small thing I need to check.

For sign off we need a "known identity" - see submitting patches.
Mostly that's a legal name, but if people are commonly known
by other names that's acceptable as well.

Given short nature of your SoB and that this is (I think?) your
first upstream commit I just wanted to check that bhargav is 
sufficient to meet this level.  

What counts for this varies a lot by culture or country so if
that is the right level of identification to use that that's
fine, just reply to let me know.

Thanks,

Jonathan


> 
> Thanks,
> 
> Jonathan
> 
> >   
> 

