Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62007356A24;
	Sun, 22 Feb 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779030; cv=none; b=HGgQoSRJ3B8NPoWOcRZyXz96t8Zvyfv454vKfBpuNY+6ppn2ueIEnoTozywFJALD7wkNQa7Cfx39wiNPNs/jg6KBSOoM3Rwpas1sFj8ldW4xKyJjo38DdP2qmcmAYIFrUjAYGxl3fN2XSv5675mp3oewEh4gOD8V0i9p1eMRRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779030; c=relaxed/simple;
	bh=pqAIJ/V7Xjcwb+lEoIISZQ2L02xZfYOWUsi3UD86LzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guuziGBiJdAKcEOKOYjBiLc9hvsic5ZsbiF3seDZXBZIt67MqxrUigm30wZ46WkEBtO+ULzZkG57iDQ/9MU55TalqyanbPR0SpafZI0/zFkbQdSaQ2RTERiGRGK3iKV6xRbVj+XvHpCuE7PiB/ciYxfR1xccmjQQRMPqTjps5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRipilG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRipilG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA12C116D0;
	Sun, 22 Feb 2026 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771779030;
	bh=pqAIJ/V7Xjcwb+lEoIISZQ2L02xZfYOWUsi3UD86LzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRipilG2HTm5qjca65jSnxKrmiQqmfn43+03eDkWWovhWkITtdgVfpYxvSyuB9cUe
	 esJeXFJmHnZu7Mg8AIJQnTyGgu9uB8wUJ9ny5ahrUBtUc1C7lTtnztFbUCqdIW23jr
	 OOaoiVAznwdvX43iJlPEU++E9QVAUq8Bbk0Z1URwCwy8D8FPWqNisEG9+3wZ+UGZO1
	 qermmsNUZ9JVqau4u3vLdM0tpZccIaAnk5ANkPCZuV1gyalLyeOUZspXLuZq9nb8D0
	 t2ggP4mKl2gBf2NqXxVfm/mwkYlOcqUFN+K1GNeU89q5Y2XXydnJ1tY5OKgRDIhK/E
	 6ozOzQSJHYjTg==
Date: Sun, 22 Feb 2026 16:50:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7266: simplify error return
Message-ID: <20260222165021.045777af@jic23-huawei>
In-Reply-To: <aZhrBO0dkftNJ_z1@smile.fi.intel.com>
References: <20260220131847.76968-1-antoniu.miclaus@analog.com>
	<20260220131847.76968-2-antoniu.miclaus@analog.com>
	<aZhrBO0dkftNJ_z1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:09:08 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 03:18:46PM +0200, Antoniu Miclaus wrote:
> > Return PTR_ERR() directly instead of assigning it to an intermediate
> > variable first.  
> 
> Definitely!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.
> 

