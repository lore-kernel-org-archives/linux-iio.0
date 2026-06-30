Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623B1C84D7;
	Tue, 30 Jun 2026 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862741; cv=none; b=pegMCZJ0qE+nXVZ0EJiAHwIBekE8GyZgLTAGfm5zwi8xp/4w62OVYTobtSpa/n/PSLYqbzN4RSlemMFuVwvtidBTeyNRZX96xuzwc0hZBUFW6aHDEkeS/7lq1s6xB4x0NskUTdy0vvaBkqjjXFOJbkhhkqkOUkPJ+FHdZka9lgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862741; c=relaxed/simple;
	bh=8ftUvM+U+YwrA6FgezMIU5JIH0sshQ0tLwIJ1gWGOhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxMSdhryPmENq25mvCftKHEpYM+azD+mDb2Kb6iSB4Ma3a1F6Gq2kTj4h6dwW7YFkV2KaXNNmb6NtNjtYS8PdejXmIadHHa0YwPRRY5tAmAbzY0RdgD+crGtVGnfb6ZunNN07urrnYfmh6g9EyJrwjtWEw9fpE2OSRyfTKYtgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/mSlnvR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/mSlnvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BED91F000E9;
	Tue, 30 Jun 2026 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862740;
	bh=FQEymWMUNRG8sk5hn2KrPQ1InsJmesUG9Pbivjtz/Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i/mSlnvRLI51lq3+IdKnmLxkaSgHfFb6k43864AA0ByJMaAae3tZu74voced2ZHfB
	 rfeMtZ3ErngKoRQqnjxGSbBB7m354oT2C9n+5yM/SD71gyeogFd5ogIS2rWiprvdaD
	 DtTGTm1lY2SMWVTPCfM1inwVGbA2keBNVo0Q1Fy5Mbvs8T13rQU6vXW0UDbuU+lp3/
	 ofRdYPt1aSKFFfMkAHwsSp+HYmFHhA+dIjbc5bgDlJzJWyoHZfH0ei69aH6mtTh22M
	 eJpec/EdRDCAThUVEzszfIYEyjT9ZYglzOFCViOAhLQSFlWCmGCc+k2LaBwV00fFM8
	 PKDnbvpNmGI/Q==
Date: Wed, 1 Jul 2026 00:38:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>,
 <jorge.marques@analog.com>, <mazziesaccount@gmail.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] iio: adc: at91-sama5d2_adc: rework temp
 calibration layout handling
Message-ID: <20260701003853.2a44477c@jic23-huawei>
In-Reply-To: <20260630093603.38663-4-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
	<20260630093603.38663-4-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:05:53 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Extend support to handle different temperature calibration layouts.
> 
> Add a temperature calibration data layout structure to describe indexes
> of the factors P1, P4, P6, tag, minimum length of the packet and the
> scaling factors for P1 (mul, div) which are SoC-specific instead of the
> older non scalable id structure. This helps handle the differences in the
> same function flow and prepare the calibration data to be applied. Add
> additional condition to validate the calibration data read from the
> NVMEM cell using the TAG of the packet.

Last bit smells like an AND in a commit message.
I.e. should be in as separate patch as it is making a functional change,
whereas the rest is refactoring only.

