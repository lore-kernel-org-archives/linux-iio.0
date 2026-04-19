Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBC2DF13F;
	Sun, 19 Apr 2026 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617962; cv=none; b=al0d5FXiOlwrKUo5tq4K8hIAtng76Qv2b4I5WTpDBRUfPEm3xWA6usV/KL5zrlZqxLdAjQpUGBwxEc5prRvujagLomX4rxHDLm451G+PO67DLiOOIytUMsvDyBF5DjavZ9oFB+TbO/4dXeg0IP2UpnupssVj6uvJeny6FXD5N+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617962; c=relaxed/simple;
	bh=Yvf5FJhAKxknjRzVcc25iWVxZ2nDEwjgi1WjrbuJzs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4O+UF5oat0vQ9hxBwuDcDN37+JS8U1naqH39knatt9sKGAd3wxEn0jEySb7MVnWklWQiRrMYSEoEKr6Tf0ynJ3CJt8YcuuBebEZq/eVuhCMsHfVuf0gKfT1j408ySggZoi2Wa0h8IM7yjua3gczXwZozfmXQkrWMnYrDIggL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSlioebG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSlioebG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC6C2BCAF;
	Sun, 19 Apr 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617962;
	bh=Yvf5FJhAKxknjRzVcc25iWVxZ2nDEwjgi1WjrbuJzs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSlioebGHguujxNDoPydDoItERtTJSkSPE4OAR9ErMEtE2QsLnvF+E2P50w0hvSPp
	 MQdUJ8nCcC9wkKYAUi1bYT+W24orLBCHvhicmJ29SCxcXn8gMK9gmCXPvW0wAIg5os
	 2t5DhdjEpx/1pg4PO0+MlU1y3s/hT8K6PdV/WSlSSKb+dHQMLlB8H6SpRl15LNMPML
	 5DWsdEDIwygUvNdJgZUCLG4w3c83iUmFZ9kUk7YcfxU6PDlLB/Prh5NRF3Utqlysez
	 uhVnjxoYlULdmt9zCZIYlzcBE41dBufjpWVHKFfWSA4Sb+w6lQe64xfj1bI5KovOKN
	 wEJHAICPP1PEA==
Date: Sun, 19 Apr 2026 17:59:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: ad9834: clean up includes
Message-ID: <20260419175913.16ede123@jic23-huawei>
In-Reply-To: <CALoEA-yWpZa88nTRsTCVnaNFL9w8+pq53xKY7Nh+jLgEWZYTdQ@mail.gmail.com>
References: <20260416093240.1294-1-joshua.crofts1@gmail.com>
	<aeHXi8-zYZu-9NPr@ashevche-desk.local>
	<CALoEA-yhUTYzHUkOqAQ+nunUrH=DqzCzMS=hW5ZxO5M46ETa8Q@mail.gmail.com>
	<aeHgqpuSOxgqP6hK@ashevche-desk.local>
	<CALoEA-yWpZa88nTRsTCVnaNFL9w8+pq53xKY7Nh+jLgEWZYTdQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:34:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 17 Apr 2026 at 09:26, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Yes, that's why one still needs to understand more about headers in the Linux
> > kernel to do such a "simple" change.  
> 
> Yup, it's definitely a task that seems easy on the surface level (but
> isn't). Also the concept of
> kernel.h is truly a fun one.
> 
> > Oh, surprise surprise :-), thanks for pointing this out!  
> 
> No problem, surprisingly one of the things that IWYU got right.
> 
Looks fine to me.
Applied to the testing branch of iio.git

Thanks,

Jonathan
