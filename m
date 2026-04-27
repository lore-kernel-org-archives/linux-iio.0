Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9E308F15;
	Mon, 27 Apr 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285565; cv=none; b=P0EVWGnsB2YOhEjUCDae7MY90oY7dWor6ZZP6m/lGNTC9WHzW+3/cTenFRGTGcM37DhY/pGPR3WvnyJS9z+0W0gK1alAhUClYTS8Ev96314alnog3h7jShzWuac+NVOo9XFwSK9tzFNXaIjTU3CBLIPqaSbMnogKKgsZ/1eSJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285565; c=relaxed/simple;
	bh=uw20svrOCellNynJv6AlOb+Q2kLJUIrIJrU2/InpmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr+aG1vwwAVXD4JcCPT9CSuw8ksrgCfTHQhPUaK5ieyYFawnCuUHniWe5P1T3jf+vtsKx/qjOdeddlWiQr3e+lvUds5mU7vl/fC7eo4DNNrRFXekCLYpmPIoGl8cCIMPLeQwYU6VrdCyK7turay8Yd5dxoXrT1T5Qh14XIQxMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onk6YRCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onk6YRCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE39EC19425;
	Mon, 27 Apr 2026 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285565;
	bh=uw20svrOCellNynJv6AlOb+Q2kLJUIrIJrU2/InpmdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Onk6YRCUkYbumel3gOG/f62LTeaC7xfNZHLU8KzAHqFqwwg4X9Pa7l/cY05+TIbaL
	 q+r5mddCkOgYGGOzi/ZfeDyA2LJXKuwNKIPVQsEf37cUDJ4s2tUMrv8ykRLwf4d1j6
	 xu/WkwA+XcQBF/L3emUyjxexorKqKeWRcd9UOaYXCUPoDm9G3JQiy2lMmqzqniPneD
	 RNc4hhzg5PzQBLeVQ5KbbRKbf89aXDuCX1hDW1rtsog4iP4XHn7V/t3EgCLIX3GC9p
	 0B935z3KW7wDjfBx3XoHTw0DX0WwKMQkZ7jyc1s9Gr6oOmwcQ5GY+yoh1CM8M4z26m
	 h2c4RS3CJEm/g==
Date: Mon, 27 Apr 2026 11:25:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/10] iio: dac: ad5686: remove redundant register
 definition
Message-ID: <20260427112553.6f7b598b@jic23-huawei>
In-Reply-To: <kjqs2ucnoqud3o3ilex4kostgzxhvx2xphr2akeneiwqw47q5l@veqdwbx7xzfw>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
	<20260426143211.1d0bc12e@jic23-huawei>
	<20260426143824.463af045@jic23-huawei>
	<kjqs2ucnoqud3o3ilex4kostgzxhvx2xphr2akeneiwqw47q5l@veqdwbx7xzfw>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 11:09:59 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/26 02:38PM, Jonathan Cameron wrote:
> > On Sun, 26 Apr 2026 14:32:11 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Sun, 26 Apr 2026 09:38:03 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > >   
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
> > > > and that is because they target single channel devices from the same
> > > > sub-family. There is no reason to separate them and it will make things
> > > > simpler when refactoring the chip info table.
> > > > 
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>    
> > > This one stands well on it's own, so applied to the testing branch of iio.git.
> > > 
> > > IIO is very busy at the moment, so I'm trying to pick up anything
> > > that is ready, including individual patches from larger series.
> > >   
> > Dropped again. I didn't read on far enough.  The fixes in this series
> > need to come before all this stuff so they are easier to backport.
> > 
> > So dropped 2-4 from my tree pending that reorganization.  
> 
> I am getting the fixes first. But I still see commit 2 and 3 in the
> testing branch.
> 
ah. Guess I forgot to push out.  Done now (along with rebase on rc1)

