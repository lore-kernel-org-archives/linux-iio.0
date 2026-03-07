Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47566305064;
	Sat,  7 Mar 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892783; cv=none; b=MEFf8N8JnIgtl275ITd/Vy5vV5hN+XpK9GBHeSZmS8jB2XPdXXq0l2mKpTSZrmuFlsYkAxYnyZdj2epHUPxd1kK1bv8GgR8omUvJ1L7SOOwkiKzRy0ajCLoDT0VEiS9RitS416HAUau/aSbbzTx0cf1VVsRisB8neAM5upw3rHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892783; c=relaxed/simple;
	bh=wJEA4iHhtTAee7wbKF059tqkKkUpu0bswMskgazNF1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcTA94ZrpmKFZRDQeLSxb0kkr9CkA/JyGGdDSNcfPEB6MfeEydpMmb6U0JD/c4VuiX1sDU74V9EGG6B/bnUQE0VS/CkK1w5eFi1UDAGb8pzdoGhtGSGdzeTwLTnyJtLcohftrOKf7/fDs0BzeCMOUEG4i+vE0WK3qkXKGP9GkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+PYiqRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+PYiqRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4C3C19422;
	Sat,  7 Mar 2026 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772892783;
	bh=wJEA4iHhtTAee7wbKF059tqkKkUpu0bswMskgazNF1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+PYiqRLS6yHrHrSQDgJFqALNYKfNjbMsyQ44KNg4c18WNk8P3+L653nffuYy9Qzs
	 lDsJfkHIOcTf9UQOvxqFrOJ4iJrbrzCoid+xR8KjDaCwAKOcPLbIL4VTqSwvlWZe5C
	 JIZniJUGNmT3KE92V2BEKKOJpfFKmnZCNFsvLH6fZlAejELhWsOFhSc8Egk5TYa0Fj
	 8+WlGqPTB5Supk2VI1SBQCB08+sshclrVnpP20bL1xp7SQ9mAvNAWcpiOCBKYcZ+J3
	 U+lU2FDP7zAzCeNH+WQK/2mIE6xOO3FbbacxZHZDEyvqvdnJaZvodlpX0QjJtKaL3o
	 /oe9cS0ZqT5dg==
Date: Sat, 7 Mar 2026 14:12:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Robert Budai
 <robert.budai@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter
 functions
Message-ID: <20260307141254.28f53278@jic23-huawei>
In-Reply-To: <aaHHYMY5hdxQYYPO@ashevche-desk.local>
References: <20260227122046.46710-1-antoniu.miclaus@analog.com>
	<aaHHYMY5hdxQYYPO@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 18:33:36 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 02:20:46PM +0200, Antoniu Miclaus wrote:
> > The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
> > other's filter functions in both read_raw and write_raw. Swap them so
> > each channel type uses its correct filter accessor.  
> 
> Hmm...
> Would it be just a naming issue? How do we know that the code is now correct?
> 

I had a dig and it goes all the way down so looks correct to me and not
a naming issue.  With the tag from Robert, I'm going to take the view
we are sure enough this is correct and apply it.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

