Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702523B62C;
	Sat, 21 Mar 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121546; cv=none; b=QsR8D/7Axk/WAPzvf/ZalyoOngpZAmqEtosBJjbzEr/l1/tN/zVDzWMayGvOjadyup5BMrE9QL7m+6JMwd3Yk7P8FlQnBAvCgIhegudJF1arbTecnToJAwp192ORf7yWrQEMi3V/mkS7dPs4D37QE55y2XiL3BuTkNiHbppEN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121546; c=relaxed/simple;
	bh=MiwxW4kltKiO7sVlyWlbR0W8T0eFv5Wria2h5qQZPwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSZxnj6Ge/PXcOycqIVie9h2mdb4M9vPMdXzw6CKtTstzuMR/I+pJHWD+BWma6OVtEMRpjP1ElTWQTAxNPafd71cJzU0Sid9uHN37OGeF0zxzZgfXHFGVw2/T5LynOdkjD/BSe6/XDSq3c32wM15HZDTsciOgml9OIdZXZCWJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzJBE8yL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzJBE8yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C0FC2BC87;
	Sat, 21 Mar 2026 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121546;
	bh=MiwxW4kltKiO7sVlyWlbR0W8T0eFv5Wria2h5qQZPwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzJBE8yLQ84UG1PXc2hslDC2OrBqi2ykMkGqlg5nF/e9tpDvByKM9G7joj/VWzzef
	 idvONrqC3FSJVnoWZkdsHU8eoahFBecplq25u3sTmebe7j+hm4aUClAKCHeiS2zpic
	 UcBI+mv7JxscQveosxZTFXuxeDLT11F+XtTQkbhf3V3tHSNNaO8Sp9zLO75V3/5Vye
	 PrCfCxlP0RyZs5Q4RDpSk+7oM8OgQt8jJimjh7coLWjgkGV8RwDRMMj7Z1yQExyCd0
	 fDpEr9xmRuCEX3ZiAmuY8P0L12SxS4ayycNJHi1xE+ggLBxhCkrtd/eE6LRyAcnMWz
	 gPigOXkD5tgjA==
Date: Sat, 21 Mar 2026 19:32:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 00/14] iio: fix spelling mistakes in comments
Message-ID: <20260321193217.3fa11fdc@jic23-huawei>
In-Reply-To: <abgbKZro-i2o3Opq@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<abgbKZro-i2o3Opq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 17:00:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 16, 2026 at 02:30:08PM +0530, Shi Hao wrote:
> > This series fixes spelling mistakes in comments across several IIO
> > subsystems to improve readability and code consistency.
> > 
> > v5:
> > 
> > - Rebased on linux-next
> > - Dropped patches already fixed upstream
> > - Added 8 additional patches to previous 6-patch series
> > - Rephrased several patches for clarity and grammar
> > - Added missing article where needed
> > - Improved commit messages for clarity
> > 
> > v4: https://lore.kernel.org/linux-iio/20260311093933.21333-1/  
> 
> This URL is wrong as well as other references here.

Oddly of this whole set only patch 10 applied with out having to fall back
to the slightly fuzzier logic patch uses compared to git am

I'm not sure what caused it but Shi Hao, see if you can save
these patches an apply them with git am. Then figure out why not?
If that works try b4 am  to pull them down and figure out what is going
wrong.

Applying by hand takes a while as I've not scripted it, so I'm keen
whatever went wrong here doesn't reoccur!

The resulting patches look fine to me on my tree.

thanks,

Jonathan

> 
> > - Fix commit message grammar and punctuation across patches
> > - Keep 'whilst' instead of 'while'
> > - Rephrase sentence in chemical driver comment
> > - Capitalize IIO in comments
> > 
> > v3: https://lore.kernel.org/linux-iio/20260309104513.40359-1
> > 
> > - Change commit subjects as per changes
> > - Capitalize proper acronyms (IRQ) and Celsius
> > - Fix short wrap in commit body
> > 
> > v2: https://lore.kernel.org/linux-iio/20260307104705.49129-1
> > 
> > - Split original patch into 6 commits
> > - Fixed commit message formatting and typos
> > - Added necessary tags in commits
> > - Added more fixes than previous  
> 

