Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C926158B
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934552; cv=none; b=Uh9UMmF9vm5rQKvyocbea/ijRVCIwt5vkA7ZlkU+79ELYALZsuU0Mel6NKTAm5vk0HX4ub0WiDYkj72EAubQcUtvOKC144K2DxueYuEc5QOAsvu+Wmob0fwrs3NZxu+s0mwoV3dOwTSLF5H3NP0tpvqL5ga5SRUZVLFguBsUvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934552; c=relaxed/simple;
	bh=ID6AvTJI1rntp7uaS48ci1VkqVXb8TdUA/KgD6Y/23g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZq1igfMtsKvAOHRpSkMTZp2LTV8STsSsjQGyR0K0ExEMJyQ5iodoV3GdQW4JAyP0M/8CK09mmEMnj8JOjM6Y8v5KtqSUyBOsZCvZZLdilIWDL0y0EyeSaiXcH4VgCXAAIq4MQ0wUvBBqH+JG82Y2/E9Neh7HJ+L4eh/i3TGRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWnapfEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWnapfEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD63C19425;
	Sat, 16 May 2026 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934551;
	bh=ID6AvTJI1rntp7uaS48ci1VkqVXb8TdUA/KgD6Y/23g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sWnapfEbTF3GZ2MS8DWLt9k70GuNIxNGz8KniodbJ2KnhB8AHjLdSCuTqTeNUD/zX
	 8FFGB+SttcoSQN6WqDQ/WnL0ATbbg6accy08owaJLxc6GQXV2hg+KX7sl+y8GbI7WP
	 4cGHZLnsQC1VTnf4MUEc+4xjss1bImA+S3ZH8a8Ek7Pyt2ty/YAQ0vVwJfd9/U9MWd
	 As5zi6t8KO9oYvcKemwQjkitN5qLsb5/awUxcM/pMTqmIXOqqFCeAzT4VA0mWrStzC
	 QnKekUy64mXLWdgz2QgdPrS0UJ5i+E6mvLelYpi1TPFocXFCteuJAF1A0q3m2OtJ9W
	 1i8vxf2XeIqoQ==
Date: Sat, 16 May 2026 13:29:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 anand.ashok.dumbre@xilinx.com, andy@kernel.org, conall.ogriofa@amd.com,
 dlechner@baylibre.com, manish.narani@xilinx.com, michal.simek@amd.com,
 nuno.sa@analog.com, Jonathan.Cameron@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
Message-ID: <20260516132902.30edeaa7@jic23-huawei>
In-Reply-To: <0ae1a3d0-cc51-4d5f-997c-04d3114121ca@amd.com>
References: <20260513003503.339418-1-guilherme.bozi@usp.br>
	<0ae1a3d0-cc51-4d5f-997c-04d3114121ca@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 02:21:37 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Hi,
> 
> On 5/13/2026 1:31 AM, Guilherme Ivo Bozi wrote:
> 
> > v3 -> v4:
> > - Removed unnecessary 'event < 0' check for type e32  
> 
> Thanks for addressing the feedback.
> Tested on ZCU102 Rev1.0. Driver probes successfully with no errors.
> 
> For the series:
> Reviewed-by: Salih Erim <salih.erim@amd.com>
> Tested-by: Salih Erim <salih.erim@amd.com>
> 

Given I think the 1st patch is a defensive fix rather than one we
actually expect to ever see (and I don't want to delay the other two),
I've applied the whole series to the testing branch of iio.git.

Once I've caught up with the review backlog and the bots have finished
playing with it, I'll push that out as togreg which gets picked up for
linux-next.

Thanks,

Jonathan

> Salih
> 

