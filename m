Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696066;
	b=S/DhWwAgbVRdXeciHQoI6CjU3X9iEstWW2OK1wdLjBaEnNdS2qOkWXyxgMBK3s9lRaNZ
	 Y2NwqnCOmMzUhDNEs6pHSLF0w919Ui4Xa6fG5shQzvpjIDDPAuFzDXytrNquXQHnzPTlP
	 n5wut4n99U9rwLhsRj/3WInDZiMUia0c+4Uhj/goskuXi5jLYYJpTVwGLmYzy+fG/MYqK
	 bsnOZ+jPibLB6KGSVmWNPkQHupEcLoRbPYtm1NG9AiI1ZlHkj/MGzZbn0mbV8zw7QE0FV
	 r4g3y8VG/EjTfJS0hWiuxzFnNhPTfFvwonpfPdAWtJbMJWN3WX1pU3BK3fnya1JYDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ns8wSVI6QgrHnhjyZ5SwkLYi/b3DsW8O/C3+sYhEyWQ=;
	b=xqBmUbJODX06l6nvOGAZctvvVRdKpuxwlkKhP2l6ioziiXsIjYwYWnHTY06ZBiL7Tmpr
	 wejJDtCC3aDRRFYlg8WvxiHUyTG3RXRs2jLfPeT9HqsO7bj8Yw9o+jBqzgk1R/+jScSmF
	 uUPl0vIBTZWZUuIx41BJkFieIwLti3utcI2QucbIKhlaUobYAdWLHT0HYISxFDzNWBqJs
	 WkwNiJnQoAnMD4pSbqgyu6Oh6qD2GNEl919SqlKT8+Rfh+655QTgrK3c/tEfmVXCo1VI+
	 9v0OxZD8LLu35tMshk+Pa5E81TDSlWJuDa8FcWDsK6DwUMVh2oxuj9TGnKqKJojlrqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlD1aLxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37723606A327
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlD1aLxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603021F000C4;
	Sat, 14 Nov 2026 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794696065;
	bh=Ns8wSVI6QgrHnhjyZ5SwkLYi/b3DsW8O/C3+sYhEyWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nlD1aLxJK45NFOqeFAiwW/j9uKkPpoCUUlcS2jQmw76oqWZwrk8GoygnN6j/TfKto
	 V+P9qbrVxemK5vibkQjb4hMgCY/rAaLLbYtVfu3uqn3AQcVfYyfu6fVcLKX9AYpIq+
	 tnNkJIL8ebsv4VkzW8HwerCIdwAipNGnukcsID7TqSZ8DLX/rEi2lH4AdJSLIZv6F2
	 tptFlcEuIBQCiPfdHawuYneArStQUmOAvERO2SLDcJCWGdOLy/nvUWZVkoWaVCfz86
	 EBQiUi2lC4GuABTUFDJJdb7XyxLVYQ2zbeUJIIMbo++X4qAIwqYL24tbFtOWQAVALX
	 ezBdb9lOhTuRA==
Date: Sat, 14 Nov 2026 22:41:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe LeVeque <joe.l@reflexrobotics.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature
 sensor disabled (ICM-42688-P)
Message-ID: <20261114224100.43387f8e@jic23-hlaptop>
In-Reply-To: <CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
References: <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
	<FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
	<CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
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


> 2. Should this go in as a fix, with a "Fixes:" tag for stable backports, or
>    as a regular change? It is larger than a typical stable fix. I'm planning
>    to base it on the IIO "togreg" branch unless you or Jonathan prefer
>    otherwise.

At this point in the cycle I'm unlikely to take a large scope fix
the fast way (they tend to risk making Linus grumpy).  Let's get this
sorted for the coming merge windows. So on togreg is good.

> 
> I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driver
> backported) and mention that in the patch.
> 
> Thanks again,
> Joe
