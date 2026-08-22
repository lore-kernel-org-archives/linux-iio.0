Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C9171B1;
	Sat, 22 Aug 2026 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359370; cv=none; b=lElSDcXDy/3wSwyygPVmKrvNcTZo0Iyk1ym/1hlBS5OCfTEAWg/QWyUZBS9YKrq8S2r00Qhcc2Jl81usmUMQ+qxVxSoewC16d0GXjvyNbzFHxayawIFtwa3xJDnfZbQL+yIldNWigYvvTTknJRM+RY7Z3qp+ahXkbtuhq2P/SlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359370; c=relaxed/simple;
	bh=cB2yfiyt3nUGrn/6CUkJYYkDPmWcHK28H64t6g+xa0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grTc/ILZiCdtONeH5Ykaagf/gpJbnBSfZG7fbG+ffuSv8XW8YQaCizerOkuEzd1DkZARlHmcoinb0/So4i1DXYWkNnVJwtj21NkzoOtWWk6pN7qucNKjopcPHbQ70Gb57Sgep20CmFiwV7CTfYO6aIz0rhlWmvJTbggOBzr4Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2KyJcer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2KyJcer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40801F000E9;
	Sat, 22 Aug 2026 00:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359369;
	bh=7SoicxjxVmgP9bW3/fWqsrW7UzceM0XpjA/yty4A4qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C2KyJcero7oZJR5OLICvxBkNd5rLYQh4WZi7EPoSklDVQzcbmnXjWP+W4Bz5e+6I1
	 tvcBrEJBQ/tPA6o9OcLpVdMCP75zLbEt0+fDFCeqXbg6Isb0wlbk/9DjBp311I5s5r
	 vIFNV1CNFDINgX7zjMsRl80TV5u7SNAtP7180hwMeCTFlTm1Rezp0ZgYM75c2FtUQJ
	 AqYQHYtt1fe0vhMprEC2MLz67qn7FxSRiF0vc3E9bRmqI06zkkAiu4neAflQU3DC6Y
	 gxxk8yfIBxasi3QhoHt3fD5le8GcRenQj/M93Q8uMOZ8GI3LDBBEtYgOOlyyY3NkCK
	 C+wIs3wzDb6vQ==
Date: Sat, 22 Aug 2026 01:42:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Maxwell Doose" <maxwell@maxwelld.cc>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>, "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Marius
 Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Tomasz Duszynski" <tduszyns@gmail.com>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Message-ID: <20260822014243.2d854b50@jic23-huawei>
In-Reply-To: <20260818161115.000067a4@gmail.com>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
	<20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
	<DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
	<CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
	<DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
	<an7OSM04kiviu9xL@ashevche-desk.local>
	<CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
	<an7W8VKXrIKzl9xt@ashevche-desk.local>
	<20260817035414.496912f4@jic23-huawei>
	<DKRGHVP0FO9A.1VS4B0R21J97C@maxwelld.cc>
	<20260818161115.000067a4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:11:15 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 17 Aug 2026 14:12:56 -0500
> "Maxwell Doose" <maxwell@maxwelld.cc> wrote:
> 
> ...
> 
> > > Absolutely. One patch per driver for this and not more than 10 ish
> > > drivers in a series or out for review at a tiem.  This stuff is still quite
> > > tricky to review, even with details on why each header change below the ---
> > >
> > > Also precursor patches for any significant reordering to put them in alphabetical
> > > + block for IIO headers just to make it easier to read the patch that cleans
> > > up what is included.
> > >
> > > I've done some of these as have many others. It's worthy work but slow to
> > > do!  I'd suggest we leave it as a newbie task, but it requires more understanding
> > > than typical for one of those - so if you want to take it on (probably take
> > > a year or more to finish given review bandwidth!) then that would be most
> > > welcome.
> > >    
> > 
> > What we ought to do is start by removing all of the kernel.h inclusions
> > and then we can go into each individual driver and do IWYU on them. Not
> > sure if we want all of the IWYU stuff (including kernel.h removal)
> > rolled up into one patch per driver or if we want to split patches into
> > kernel.h removal and then IWYU (hopefully this time I can get iwyu-tool
> > setup so it won't be *as* gruelling). Or in the case of we leave it as a
> > newbie task maybe we just add it to the TODO (since this is probably one
> > of those things that happens over time when we revisit drivers).  
> 
> Well, removing kernel.h is essentially IWYU, as we have to include the actual
> used headers we were pulling in transitively. It should definitely be a task
> for newcomers, nevertheless as Jonathan says it's not exactly easy to do from
> the get go (and automating it with iwyu-tool can also be a headache). Also,
> I've had a pretty good experience with AI when it comes to verifying headers.
> 
> I'll probably send a series removing it from some sensor type subdirectory,
> just to get the ball rolling?

Definitely need to include the kernel.h removal as part of iwyu, otherwise
we may well run into random build issues.

Yes, a series - one per driver for a specific sensor type directory would be
a good starting point.  Split the bigger ones up into multiple series to
keep the numbers manageable.

Jonathan

> 

