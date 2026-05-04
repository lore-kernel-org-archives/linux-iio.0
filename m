Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C43D75D7;
	Mon,  4 May 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907282; cv=none; b=M3TBvQ/LqcH6Z1UoJl1pmDNGh50mdgAJALowU2l9YZHqe+A0M/fMEY5IFkRAgEDEyWbjg/McbvbRZdP0TDIrTFrMutxOT/+75nh+IHhxn+YP9bZrnlYbfWUpRYWhb23OrrBmdDCz4qeJbGufrvPLMBpf8EmNn8CXb/jlmptmjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907282; c=relaxed/simple;
	bh=Ei3avuqfXFwfmDpw3p3UBmpXu13t/gUTVM59K5vz5Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puYroGSmXF6c59E2F5DNFwJabpZS92ZPvQ2O1658o6ImFugS3aQV6s1REImOEPs1iFKQGDl0yZRq1KsFyRmTn3DtDSM1g7hMxQ5GTz0nKanO6379O/rRPXpw14xgcCCxVD6985l9684D4LcJlGERQbY1+8GcU2GTNdjepjOLPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FItXUNFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FItXUNFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CCCC2BCB8;
	Mon,  4 May 2026 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777907282;
	bh=Ei3avuqfXFwfmDpw3p3UBmpXu13t/gUTVM59K5vz5Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FItXUNFrriLSpZAtmuQ3kGDxkCArm/iGxQ/XyZ5P+rQLL+5cLnU56QGMY+zNh8d0D
	 M+ThPMFSMrI3d2StnHVpvN2frEIkc8qUzb6i0GhUkFVcemS+OtyCom6qgbQRKehVpK
	 Dzv3ltgf47zDRK2XaUxS37KXm1gqE1u89lV+NfBqSFK8sXZ/gnylYQB6/3g6DKVe28
	 gAn9hOQ9j2R8wMXMOgpop8BqzSZ7jUWb7OH+7Q/3QnaC5ohcs//7hfT5YoRS9xIdMR
	 TeAo/yHxed9rLBob8K6scyqiCyjdPt0Hwzd3sncsndefCQ6WPdZChIMxeRoapx+swU
	 /LCSQd+WKFJqA==
Date: Mon, 4 May 2026 16:07:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <20260504160753.42a4c2d7@jic23-huawei>
In-Reply-To: <CALoEA-yeMbbbS+h2YmJ7sr8CXMkQpDKT2=s0pU7+oh=yt045Cg@mail.gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
	<20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
	<afh-smyJoL7xRiqZ@ashevche-desk.local>
	<CALoEA-yr9B+74KdSY1iEYssvPQoSXdYjXpNFBzrdZm4RHvJ1jw@mail.gmail.com>
	<afin2x3jBmBRKsuY@ashevche-desk.local>
	<CALoEA-yeMbbbS+h2YmJ7sr8CXMkQpDKT2=s0pU7+oh=yt045Cg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 16:11:47 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 4 May 2026 at 16:06, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > Okay, this was suggested by Jonathan on your v0 version, but I guess there
> > > is no need now that there are poll and timeout parameters added in the function
> > > (or maybe the suggestions were for the parameters only and I
> > > misinterpreted them).  
> >
> > The idea is to see them on an average one page in the text editor, all of them
> > at once. As long as they are quite close to each other, the temporary variables
> > are not needed. Moreover, I found them a nit harmful in terms of readability as
> > one will need to jump over the code to see the values, while with explicit
> > numbers it's all being concentrated in a small code stanza.  
> 
> You've convinced me :)
> 
Also agree given they are so close together and we have that different
timeout nearby.

J

