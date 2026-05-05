Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CF38946A
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983705; cv=none; b=kSC8zvQe/KOFaTqQATMgGWUYpLeQ4W1J65excYuA9x9s0NyORsqZ1CNiwIoLo+YGdRFpt/b/d/IhyJhAPkgHhY0ejOkmfJYK3Rsx/FfQ9NhB2gZgD4DeC6c4jVuKWYYgTUZWkyVnKahM0ElVyAozMOVNPOzUeBaSKlut+AaAjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983705; c=relaxed/simple;
	bh=7GLu1J9K9MlPGPvNrwdi4uvlH4Jtq8zWq9hi5+lOre4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITiGBsz6LUyPt3UyU6h+rcIAhEy/3VcRGZn1mqVLijx3BWw9q+mWHQHnQ2xXvVImCJNnO4eKfoTyjd4BfcV+/TiYxLi5eLE1XQ6PBu38ZMQmSHxdLisOZwc6FkrGrFiVn2fpgSCUo2jh4O7EpWvcfYzpsqRa7jQiGkWO2I0Tjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tit8ytLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tit8ytLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB9EC2BCB4;
	Tue,  5 May 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983705;
	bh=7GLu1J9K9MlPGPvNrwdi4uvlH4Jtq8zWq9hi5+lOre4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tit8ytLlIi2t3nI2QXvp5Kz8SSra4XuAgOA3342B8WinVn9iXAWZc/KXeKck9cp5B
	 UuuxHhpg/tMkCjST4s/SniaHfDdYQqw2knlLW16CN0MNipYx+nLLPsNruQ31/4+AU3
	 /xsdBTEYRcit/dZ5TzhOPqFtYIhZGA9tCPHAN6BOCP4kWpRqiIVTd44XJRzFE0aVp9
	 aLwnSoaPKOpGzAhSkRQS6Bn7EDOjSJfFHOfb6drikfYruvnhRTaJ1ta3+x0Zeh71Ux
	 mJo7VxwA0pltFwY7MKBf7qlXsbofzpyseotsGCTyTwG5KHeEajic/30xPEyvhdHnav
	 6hs3yorzvO38w==
Date: Tue, 5 May 2026 13:21:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>, nish.malpani25@gmail.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, =?UTF-8?B?Sm/Do28=?= Paulo Menezes
 Linaris <jplinaris@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <20260505132136.46cb7925@jic23-huawei>
In-Reply-To: <afmvD1EB159V498L@ashevche-desk.local>
References: <20260504190455.9841-1-guilhermeabreu200105@usp.br>
	<afmvD1EB159V498L@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 11:49:19 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 04, 2026 at 04:04:25PM -0300, Guilherme Dias wrote:
> > Use guard(mutex) to automatically release the lock on scope exit,  
> 
> Better to point that guard is kinda "operator" and hence we refer to it as
> guard()() [note double parentheses], but it's minor, just for the future.
> 
> > simplifying the error handling path and removing the need for
> > explicit unlock and goto-based cleanup.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 


Applied to the testing branch of iio.git

Thanks for the patch and thanks to all those involved in review!

Jonathan
