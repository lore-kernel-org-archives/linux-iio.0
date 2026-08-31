Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5529357D19;
	Mon, 31 Aug 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142373; cv=none; b=rb9IEwBeYtvvDel1v1VSgbgId0pXcPLkL8A/U2l/xsOxfqavaRxQPQwILCrf19y+KvUXrWtcYB/m/T1PSf3s/eCNRCu5LfWPYMClY8SHK5Trf9+UKGyNwk8hEIGd8unSYH+4kn/as+JDcP8lGsy6DlH+qWD/JjeUB2mHoL6rbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142373; c=relaxed/simple;
	bh=YRaXp+wetwFt+A5Kb4G9e2Q8E+L35JUlp0sMCg2Q+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVcYlUPwJgEX+taSGFpzMOhwTLDV455EE4r+24XQwt98p/C35P7ZpGVKiD7tvTDMOpGqhevhctnCrwKcaK7ILU3HK1zF1DhUgBQn3/1NMGRLKAgFDhQu+qQ2pu805Z8bJ89GsbR3rMxj30KwlfC7k3Yns7jQtLx7W/bET3kMXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuwKD9Fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuwKD9Fd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA431F000E9;
	Mon, 31 Aug 2026 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788142371;
	bh=s75XF+BPupfbYXIRccVkZ1r5qFkyaGBi/5mrleH1g8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DuwKD9FdVUMTwAkESzG4UZXU5cRlpKUB2ZHy3bjMEp+aeHzSD1WhZXR4k+HAhfl0h
	 rd7j66chVyThKOPfqxXkbSQ9O7Qon0C2NJAj3qxJW+/FCfZb+P0wgr4cG9xsyfjdAi
	 DYfPB9eDT6UNy1bPupZKpfWHGxZbGyLSNes1aRdBZ5BHjJY1eU1HPV8ib78xu+pxeS
	 ry+sOdnH5lK5ruy8pY4XVKWeAZ+cFJ/tZiVYTARno8BakQSChF4kpzxyzXLcQzDA6j
	 s6siCo8CmurfDE6gd0TFsAWMSzWutWcnJOCalGxHzmin6a/mOTFu+nML3A1p8ZKKZP
	 GtlpOMDpofR2g==
Date: Mon, 31 Aug 2026 03:12:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <20260831031245.23d6e47c@jic23-huawei>
In-Reply-To: <aov_FNNX2-TWheQc@ashevche-desk.local>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
	<8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
	<aoK4FXvkPT45RsIV@ashevche-desk.local>
	<20260822032014.3d4607dd@jic23-huawei>
	<aov_FNNX2-TWheQc@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 11:21:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Aug 22, 2026 at 03:20:14AM +0100, Jonathan Cameron wrote:
> > On Mon, 17 Aug 2026 10:28:21 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Thu, Aug 13, 2026 at 08:05:07PM -0300, Marcelo Schmitt wrote:  
> > > > LTC2338-18 is similar to LTC2378-18, differentiating from the already
> > > > supported part mainly on the embedment of an internal voltage reference and
> > > > addition of a resistor divider network connected to the input signal path.
> > > > Extend the device driver, handling the internal reference and input signal
> > > > attenuation, enabling it to also support LTC2338-18.    
> > > 
> > > LGTM now,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> > Ah. I applied the earlier version fixing up at least comments it seems.
> > (Not that I've completely forgotten doing so!)
> > 
> > Can you please check if there is anything different we can handle
> > as a follow on patch?  
> 
> Hmm... Are you asking me doing this? I would delegate this to Marcelo.
> If we forget something, I don't think it would be a big deal. I just have
> almost no time for this.
> 

Indeed not!  Sorry - should have been explicit that I meant Marcelo
as author of the series.

Jonathan

