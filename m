Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CF34750A;
	Mon, 20 Apr 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709245; cv=none; b=j4lmw7g9PBP+SrprudaONIcRKTzd+NSjYI2QVFF898KrxYu1luP1nXs5ThGbNK2L3FQhvi7wb9xRYhgv7FwBtuNxIGwCaNgx1omSNsJyajqkxZcwpP1En5S8eXRka+MQ6iwWT6u1b5H6jqrv9GfD3Y/XGjdXoBWL2j549NShsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709245; c=relaxed/simple;
	bh=xyeRDtZDj0oH6E4L3jUBiadAoSK9S8jIIBhaItlh29U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS4CtfcrxvT0jH1gIacMTFqXbfaQalL1j4UCsH8V1jjCUwqsCJA552FCiHJMWjPgKv8ZZaZFcCMvL8wOvQWLg8WhQwrNvpVvnA0wFHxOmqPsf5P0sUyZQQbCBVBsSQ8gpuFD8VJsfccbui6EfuQ1t5KAXt1jn8mgfYInQHvDLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohUXXFeI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohUXXFeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69320C19425;
	Mon, 20 Apr 2026 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776709245;
	bh=xyeRDtZDj0oH6E4L3jUBiadAoSK9S8jIIBhaItlh29U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohUXXFeIvf5BQK6FTD+i2OjnMvnH68krr2J8yWztmC7VSy5igrs80SCvNf4a+43PN
	 n8u7FwHar85hMKyUeMNQBIK6PIasDIAAqLzQQFJEm9ac+6hHaSvxsRp7FR+bcivsNh
	 kJy0Vv3fEfo0J7GzZR4cYadP5yHjzZxe2TSs0p6jyRMCk9jbJAtka7XllknvBNzlEG
	 rLhOqog6bODNnvIfgwfJ7SpD2V9y+Ny5y3dZX08vampm7IOE3IJpfLMpKmfd+rNup/
	 sdvTf9MtylLB5jcElKcsSkswqlrC/foh/dJgCnIKnggV+khXxvGvLomqgmPYJR7Jyp
	 q6d5lXL0HG81w==
Date: Mon, 20 Apr 2026 19:20:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 stable <stable@kernel.org>
Subject: Re: [PATCH 1/3] iio: pressure: bmp280: fix stack leak in bmp580
 trigger handler
Message-ID: <20260420192037.2ce1a50e@jic23-huawei>
In-Reply-To: <84e57bae-358b-43f6-9455-ee6c84b576cb@baylibre.com>
References: <2026040947-overhang-fax-02d0@gregkh>
	<84e57bae-358b-43f6-9455-ee6c84b576cb@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 10:01:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/9/26 8:40 AM, Greg Kroah-Hartman wrote:
> > bmp580_trigger_handler() declares its scan buffer on the stack without
> > an initializer and then memcpy()s 3 bytes of 24-bit sensor data into
> > each 4-byte __le32 field.  The high byte of comp_temp and comp_press is
> > left uninitialized, and the channel storagebits is 32, so two bytes of
> > stack are pushed to userspace per scan.
> > 
> > This is a regression from when the buffer lived in the private data, the
> > move to a stack-local struct dropped the implicit zeroing.
> > bme280_trigger_handler() was fixed up to handle this bug, but this
> > driver was not fixed because there was no padding hole, but rather a
> > short-fill issue.
> > 
> > Fix this all by just zero-initializing the structure on the stack.
> >   
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Series applied to the fixes-togreg branch of iio.git.
I'll be rebase on rc1 once available before sending out a pull request
but in the meantime it can get some build coverage

Thanks,

Jonathan
