Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F31477982;
	Tue, 28 Apr 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392774; cv=none; b=aXcnKkTI2ZV1aDh2gydYUH/KvGLBDgrTIP5P/nfqmzLTnMv0L7CQfcZC8s2BI7c/5iikirN5Q2i3hNA1V0vPp2VzbUDn+hwZL9Hfh5sVCWL+ALzAVTku66B9ivhYG4Zx4/z3g7Tl/ROUIq61cokitpdQ4hwE1eQ7wQcAZNqs4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392774; c=relaxed/simple;
	bh=dLlyBRwhVBEj0jKBAhAZJars3aHDIbvtpLsrCmHNhYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZxHME7VKmDRwmZZU+/anABh6rTKicgj/3F+MUG0FfNxdFmifK+23+qnpNNs7Wx+5HLRRtfOsK0F2JlgaL14Z79nWGAlayvvcyvdRlS68aDNKRQsLk7Qoudq3jYF81rc6RTCjcpx44DFWoeNtHBkTDOg7pIbZH2O3VpxnUn2RE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Ozmbby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Ozmbby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FB2C2BCAF;
	Tue, 28 Apr 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392774;
	bh=dLlyBRwhVBEj0jKBAhAZJars3aHDIbvtpLsrCmHNhYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1Ozmbbyf0/j743h/3m3NaxTXAWFbhqE9JS+WfWVgRFYauS2PW+UUnnHMJXpQB0ep
	 y1zk5uq9lMHodmpdh8msDHGI6AwOLLgRM16yMDawamvceg9dKb2uae5dH2HtLP0J6+
	 Bie2Vruld3RWyTuaqqdlKeQvMv6EH5WKZWI0n1O+oYMJzGRbVDFf5Y3PQvnYM2mPQX
	 hvylf3vbwH8KVmX7lR0qIEZSAiaWivQYuBYW6vS77Oij2V+ibi8KNDNLHrjxX09xW0
	 sPl4qeqKBK4nkG2VQMNzXs5JhmtlXDrriZD8DLomuTxnH2h/Of9a6qcWP5/eDwaYI3
	 K2jGd6hXKUpwA==
Date: Tue, 28 Apr 2026 17:12:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: max5821: fix return value check in
 powerdown sync
Message-ID: <20260428171244.5bf16bb5@jic23-huawei>
In-Reply-To: <afBoARByF0W3gS6k@ashevche-desk.local>
References: <20260427213319.25767-1-salah.triki@gmail.com>
	<afBoARByF0W3gS6k@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 10:55:45 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 27, 2026 at 10:33:19PM +0100, Salah Triki wrote:
> > The function max5821_sync_powerdown_mode() returned the result of
> > i2c_master_send() directly. If a partial transfer occurred, it would
> > be incorrectly treated as a success by the caller.
> > 
> > While the caller currently handles the positive return value of 2 as
> > success, this patch refactors the function to return 0 on full success
> > and -EIO on short writes. This ensures robust error handling for
> > incomplete transfers and improves code maintainability by using
> > sizeof(outbuf).  
> 
> Makes sense, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied and marked for stable.
