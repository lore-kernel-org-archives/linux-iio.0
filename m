Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF7155757;
	Sun, 22 Feb 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771776707; cv=none; b=OVOCt5R8o3MfYYcq7SwlBLngN7E1OC18v3V9GVIr3MUSYYIi1VJF9CeefdU07HnmOq9yvdrJJwzyTn/3P+e2y5mJ419uDvqzadg5h2KreqLOe30HukRUNQ0SWrbuqvNcRO7hHlvPDhIBX9s0dw0hWgyR3Y6edBtNHG0oqUCFoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771776707; c=relaxed/simple;
	bh=+U3DSArkuN2qfEZlfmqKxrOsyDYSJ/k5DqwNlHGL/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyiavGE5G28LPo6S2iMlZEv7afNcPUkpGcrWi5PxTvm0vL7dvPbseDaNUmAGMRdCKR+e2lShh+NOf5ex8QEV2u+qK5iuBUo4FlP1DvTVxLzIk/Bs9uHlDaYev9izfPcubX0qf48t/N4vcQx/f33Hx31H4X/V9QtmXHzPHATjhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWAVfSB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWAVfSB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C7FC116D0;
	Sun, 22 Feb 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771776707;
	bh=+U3DSArkuN2qfEZlfmqKxrOsyDYSJ/k5DqwNlHGL/zQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWAVfSB/kUTMOyIjxaJ7cFdym1bOh4TP1XQ4QH5b3sUp4J5lWGComUF4rppEe8zS/
	 m+iNZ+UmF4XIxNWcHPHPIkFkQoD50SQGxP7bALAPhrNNTAO4SfFYTMxZMamD9n8ewR
	 TS7DSOKGIM4pLdR7mCOoFFnOFvL2/5ew8lBCzvIPHwSzWEgnRy4OUBGulLg4kjOj0G
	 5Tht6ak7iFZv4gm8pK5N4KHxOmRVJzqLkBZ+F7OQV8FaipWR2PMDS/kOptv3mSEz/M
	 MPwOwHtMMRpbUdlg4FgfW2DpEW81MbgKzciRfEPv5udJCBKb6EjJbBJQjsi/gOkMzU
	 z8efcn/0qt7Xw==
Date: Sun, 22 Feb 2026 16:11:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: dlechner@baylibre.com, Michael.Hennerich@analog.com, andy@kernel.org,
 corbet@lwn.net, lars@metafoo.de, linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, rdunlap@infradead.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v4 3/4] iio: accel: adxl345: Implement event scaling for
 ABI compliance
Message-ID: <20260222161137.18cdebd4@jic23-huawei>
In-Reply-To: <20260221172123.57134-1-0rayn.dev@gmail.com>
References: <e2c74e7f-d851-457f-88f8-d80a8d17c51f@baylibre.com>
	<20260221172123.57134-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 17:21:23 +0000
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> I did go over the datasheet and found the hardware uses a single
> register for both tap thresholds, so I assume the VALUE was intentionally
> omitted from DOUBLETAP to avoid duplicate sysfs attributes.
> 
> I mechanically added the scale attribute without realizing this. I will
> drop BIT(IIO_EV_INFO_SCALE) for double tap and update the docs in v5.

If the underlying register applies to two different events and it's not
possible to combine them using shared_by_ (which I don't think it is here)
then we should have attributes for both of them.

The IIO ABI always allows any write to any channel property including event
thresholds to change the value of a different one, so there is never a problem
with duplication like this

thanks,

Jonathan

> 
> I'll wait a couple of days for any other feedback before sending the
> next version.

