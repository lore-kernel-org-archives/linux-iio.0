Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810917;
	b=BB4cr7tgObnCbGtyXZP57soPsRBRj89sgIos0ox1xNkr1c3Fpmd2ps/0QUUaYCWPR4je
	 O5gtj1HcDF+W18Y4HlMFb4AruWbUocO7gemoNMKSaKb0kKYoyOC9cQJs6tPrvWcdffqzv
	 zdIGResW3MjCTNlYMZtHduLRlGifd5pVLk+Y1vyqbL2UJqq67UFXP0fnMnj07XTqlgoOp
	 9oLIu0OYMtLorbscbcdKNiYN1QvZuFXssdtaLXIgXy9ZA41bXENK36D8OWvlqYHucKwVW
	 hjhAEqjEVNWjzzAM14vltZb3dI5m7mP/VZzMKqJjDQ49R8jMTkbknZe0hfqIE4x/q+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810917;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZHU20LtdB92ZHD8b04r3AkFAJLGtMIqpqC1eTLwhvdc=;
	b=w6mh8GWfxo800h1JkJ6wveFoKU1OfhSY31tF9EQZq7s5d8B+tDnoKKfacd8ysu5rXOZZ
	 mnEhDEyVhVHNWvkUCbYwVC84CQhXhkZxwOEjVSwOHVEJ7p3RpAIyWKOFDc3c8IQ9xJ8o6
	 MXRmqsKLtpbcVCxWPT8ALzGtR4cZjtm+VugrVRhXUyIez0vGPN4uxvPLEQ8ThlAHtaJtv
	 FlgnLs+tCmoFAWZ1tl8Q0m1+p96c2RbpA5DVCv7PUV9Ul0UnAe9dDENpWxYCnJ3sojTUY
	 3hk0H2Vm+bH93HdVJIxUDVpx0jNE/PtBxhdvob+h1eR0+1fZphQG4WEWYWI7MV7Hzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eilMIvcm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD81606A31A;
	Sat, 24 Oct 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eilMIvcm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904141F01825;
	Sat, 24 Oct 2026 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810917;
	bh=ZHU20LtdB92ZHD8b04r3AkFAJLGtMIqpqC1eTLwhvdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eilMIvcmeweKXBGapRsGDbcvYad+XKExeU/+8AQ4JRx9se1t3O9JQTqlJylY3Jwko
	 zMivRXaK7ev2//L5zciudd7xlGeCshmwVQFFkTAmcVjlQ+rIt7KUPnd3GLRPnvUdTL
	 26mnVdQCSUQBiBTXjohJs3YXhpG38NFsKXCVDRWtdpyp57viyDRSBhkc1WPugG+CqQ
	 aD8uSygXsUuv1oDrfxjdrMVnPu6/kEfBcRvQTtGOFSmuyl3LSaH35kBZWAsgqIydAh
	 QrwJrRSNUlu+sgeM7r+MBlBapGvIxWdq2+joeqYomAf4Ztz6aqHhRhDFfR28v81NNN
	 LWC24wZ9QuTfw==
Date: Sat, 24 Oct 2026 04:01:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, linux-iio@vger.kernel.org, Eddie
 James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Message-ID: <20261024040150.7cebbd56@jic23-hlaptop>
In-Reply-To: <20261021132409.3742735-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
	<20261019141646.49599-1-zoone.rupert@gmail.com>
	<20261021132409.3742735-1-paulius.zaleckas@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:24:09 +0300
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> On Mon, Oct 19, 2026, Rupesh Majhi wrote:
> > Tested-by: Rupesh Majhi <zoone.rupert@gmail.com>  
> 
> Thanks for testing on a real DPS310!
> 
> Paulius
> 
Applied to the testing branch of iio.git

Thanks,

Jonathan

