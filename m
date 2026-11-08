Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099770;
	b=0lx8tgen7BXRZpU3WXKdMDfB/qIGRLgZ3rvNa0pICPkN+h5EWkSGTia3Mc3adsoZohHm
	 lL4mREPXnwyVr7QnnFYaIEE4YO8tdW7+T4nDiK+wSUw2+3BaQwkvTnKQC2RxEzAX8L/+e
	 fRkETJzaYb0P0TZxEuX0T4+6ybiFvF7uFCdUf8Sc3CM2XMqKLSt0QBzdaImA6fy0s+4Qq
	 8IoQ7rzz4mXCui/42OA7VnoT3iTfj9nNobqAPKJKWujf9VLGEYOJE/771ru0P8kNhxUtG
	 A6NinebaHTLcpvjIycH++ZKV60jb/e5XRLSi3+3ADjInfHg6LKZKz9gf3dtKj3Pwipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099770;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AxhNloA/BhuU2bSpQxDs9Yluvlf8YopYAU6+w9dcNOg=;
	b=N88oe8e8pr4glKxFaCb/leVPjeebvBlqmpgsaSuWwuZk5OB27DY/EQWVQqnJWvowyubd
	 +xUtaXZYR5qWUhq7lUER76z95N2DD04mW0tZeGpPCZTzXfuMwWduJfPphzVveO8v3cAp+
	 FkEVD/hOC1AMd0+sTw3wFdTIKdctY82QmD5OY+g1ncGgVHnIn2BlwMGve5JpwTrMPZMXB
	 HzP0YCXxSArqRzsUiF/TQBBxM1HDc2cwlgRTolVKJ9SHTZDKYBAcWkxRxbLL/RfHxcv6D
	 y6+Lje+2bel0biIBDiIEiJge2RXUlbsG6EyTHChecznY/WSQeonBy1iP+ZJiDF7V0Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEMCVeDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF2606A326;
	Sun,  8 Nov 2026 01:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEMCVeDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE01F0089F;
	Sun,  8 Nov 2026 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099770;
	bh=AxhNloA/BhuU2bSpQxDs9Yluvlf8YopYAU6+w9dcNOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NEMCVeDTzGsHkVGJ9/YmeI6lpLMANJPI6llv+RWPXTDDh/mJZvK8mgCIbyiZE0mVM
	 YfdDRqfBpHARJ6woWmnqShf/BLzIPgkwWf3R9FXJ9iyEu4gHov1UdpbEedZjqqW2n0
	 03bB9S76fMXgCWq/qSTKoQTur/YZiqNMlDoVxV8T7UdgtJqJ7OQKWaUcZJfQ8tqjDd
	 SD8rtGz/jXVUzFs84jw6wqWF+2kJKe6cS5lEkDB2hxc/nL2/D2krnpqe3X2h9S3ckS
	 JpgiH5adkGvSl1kaLD6Ec5rEW8MTBEGqRaV47ZsHDKUMiqzi+ABCM/mN9nvkZeqvyu
	 WiNmTmP4EnlcA==
Date: Sun, 8 Nov 2026 01:02:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: chemical: sgp40: Implement
 execute_self_test-command
Message-ID: <20261108010241.649992fc@jic23-hlaptop>
In-Reply-To: <20261102091258.247402-5-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102091258.247402-5-jmatko@utu.fi>
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

On Mon, 2 Nov 2026 11:12:57 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

> Add functionality for running the SGP40 sensor self-test, testing
> the heater and MOX-material.
> 
> Datasheet does not clearly state if the chip is completely unusable if
> the test fails. Because of this the driver will try to use the chip
> normally even if the self-test has failed.
> 
> If the test fails to run, the driver probe is aborted.
> 
> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
> Is it ok to fail the probe if the self-test fails? Currently the driver
> will probe succesfully even if the device is powered down, or does
> not exist at all, so failing the probe is rather significant change
> from current behaviour.

Yes, it is fine to fail. In rare cases where selftest has known
issues such as a tight bound that fails one in a hundred times
we just retry it.  If we think self test failing means broken device
then failing probe is definitely fine.

Given your comment on the lack of clarity above, it is reasonable
in this case to print a message but carry on anyway as long
as the test ran!

So to conclude, I think you have the right balance here.

thanks,

Jonathan

> +}

