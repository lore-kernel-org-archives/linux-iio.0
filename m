Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1238DC50;
	Sat, 22 Aug 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434767; cv=none; b=q+cCtocSPY96dcreny9KcwChE3FirOWSeZtuQR29OdiMzvyOzP1h7XV6Fwc6cIW5Qko2OIqe6X+mj3qLVNZrYCv8r27iG/XjRucfD8oOTPLXgkPUbqWYfqOc83Kj8MODNzB3wGqaAXJoXXuepsr7kJ52SmoU5iYCAFFwSHxRJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434767; c=relaxed/simple;
	bh=IhmaDM6g2g0c4nJjbqTZG80nCYqaUsiQRgsn3ODAnTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJG2sUz2+JDu5NqF4PPo8+GPMi2KsZ6ArDKb60abfhLePYMUZXxWo39em1VdJits9ep0GLqGkJSCtcxDffaALXfD08bixBpIryxuApazTnosWzBbvWkn4ei0cYZjXr/xXnvGgn3eFR8P679PdkRiF3ihAjCXg1NBn3wYBIBCNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISeYi8Pg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISeYi8Pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7320A1F000E9;
	Sat, 22 Aug 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787434765;
	bh=BmoMb4yjOwQT1H+1ROCgzdqFClru6A/w2ZRwYJPagLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ISeYi8Pg7mOcWKqEag0aKkqJbhTTTF9JFf2orVrbXi/ODM7fv8UBPTQtaysFE8NyQ
	 IQRqCA5f9hzxTwPSdXixucC4C75/A/TfUGOyyBzjCV+qegz09o7huNRcvho7uFRC7T
	 aJ+IJ6RVuF/I4bGTRt8XhMCmCPJEkqSWruIkLvNOUc/JGPamBZmSN9I9wA7vBqMnSY
	 tY3FVqgg7BYCzd+t/fBpeh+b4Te7FROF/GSEueGXNB0lHu2P/8/9tdWlJ32E3bG8Hx
	 vrYzrtyFJ7hHSbjxUDgPJV+U6BpiLKgFLRzL2WN3gnjWIjaleC56irXRgKCt4rsuDo
	 JQAfqpUURREPA==
Date: Sat, 22 Aug 2026 22:39:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arka Mondal <arkamondalofficial@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 venkat.prashanth2498@gmail.com, rohitsarkar5398@gmail.com,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: gyro: adis16136: fix unprotected debugfs reads
Message-ID: <20260822223922.7db1a013@jic23-huawei>
In-Reply-To: <aoAoCBgh048wLxtZ@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
	<20260814090728.965922-3-arkamondalofficial@gmail.com>
	<aoAoCBgh048wLxtZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 11:49:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 14, 2026 at 06:07:28PM +0900, Arka Mondal wrote:
> > The serial_number file operations are open coded and never call
> > debugfs_file_get(), which debugfs_create_file_unsafe() requires.
> > debugfs_remove_recursive() therefore does not wait for a read in
> > progress, and unbind frees the iio_dev underneath it.
> > 
> > Use debugfs_create_file() instead.  
> 
> Same question as per patch 1.
> But if Jonathan likes as is
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

I haven't looked into the tradeoffs fo the two possible solutions,
so would like v2 to have a cover letter and for that to state why
one was chosen over the other.

Thanks

Jonathan
