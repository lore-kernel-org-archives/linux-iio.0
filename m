Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099873AE18C;
	Wed,  4 Mar 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627246; cv=none; b=eUfb+d2B5hYDGwz0NSwcnCAz9OxZ/vl2hVTkF4Fkq81/STytmTcxE90Gc/kJk8/u1JWCpxA0Y00Oun4kFCPpEoDQIbiWaJL8/1szdCieSuVOaAjdmltxnDD4N7rT8aPBvRQzkN6YkUFm9O5S7msdKCT18vry8//cvOcaFdFL7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627246; c=relaxed/simple;
	bh=61CUg3cJyS5Hn8hFmKDTccoIZr/dCkyxeA6tXPIlyWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlNU7rmuFw+31zfnmAM9nJx+22XVBpgbgMQnCh9Si9lTrecfk/BIb37qEMQyohhP61WzekAVF5SSwmuJOnzbRwXiLBtk46a39ujWHil6EX8LIYxT95K1Fg+3D8HBJq2Ew3CQrI0YHvQUJnkUGTbNXzoGtWzxfaPBNlfCqbt+H8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=h/y/6dpY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="h/y/6dpY"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C66EC22A32;
	Wed,  4 Mar 2026 13:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772627231;
	bh=iU++sNcuri4cVzjQpIyvjjKtBvL1WBHji7cLIsH5auQ=;
	h=Received:From:To:Subject;
	b=h/y/6dpYYWH7iDhXxVBbeQ0f0xBN1ZdRRM31skrBwF8Q4qIcfTd6d3W+PRfYsS9dC
	 iIWyRaFSSXwMz6VPo7hsI49BxbYWZ+KhdJBCXCIX3biLBNZ3Al7/8pWJgUi0Wb5YWH
	 sd7tWPCw8W1OOqo7yFUcziqRo/PAzTawawv8p2/6kr1P4P9DcpFgD3g2vgL7xvIuFq
	 GYlzLWtw4v1RtAfO3/jUd2gAcKdt/iwkAw5ei9ECyeKwlyEOKxYeN9nbjrv+RCmAl7
	 HuAqbozYkztN54YzqsF4UCBI5q12jPinFKDtz859aIRy8eNCrBAdpNWRKxFQdAfUcd
	 nu8s6TcPsjVRw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 7FDF67F9C4; Wed, 04 Mar 2026 13:27:11 +0100 (CET)
Date: Wed, 4 Mar 2026 13:27:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1119: Reinit completion before
 wait_for_completion_timeout()
Message-ID: <aaglH6vGHrfUSE9P@gaggiata.pivistrello.it>
References: <20260303-ti-ads1119-1-v2-1-3badba8737f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-ti-ads1119-1-v2-1-3badba8737f3@gmail.com>

Hello Felix,
thanks for the patch

On Tue, Mar 03, 2026 at 09:47:33PM +0800, Felix Gu wrote:
> The completion is not reinit before wait_for_completion_timeout(),
> so wait_for_completion_timeout() will return immediately after
> the first successful completion.
> 
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

