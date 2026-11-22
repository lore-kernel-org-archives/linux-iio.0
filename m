Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380294;
	b=gAfeOXQuEM8PEmma1GafLxYDKOqQdJrNxcUFl1GzMR3s3585ypGlyO3tqUWlQX2d3vaD
	 0G3hzKHpxlqi4fETX0jl/zhm+GFbEqitrtA4953kax08Xgjpb6d9MWGw+vD5qN+8SCoOF
	 bvWUoSKK2TGtr7emw3Wfzqf0a5quE/L0tjaDDnYAAfJIKYcJ6DRW3/ptoy+yU2USwJeCF
	 4OM9lHUybBJ2bM2jaW+PBpOHI1tpALH1Ch3jnXa+O5AagGU0ROBGGxiq3a5+ZHKk0qQeV
	 hbje04XiCJwZhToEW+CvqmO0bvFPHLEhnBnC50vng9OEnY1iQFE0BY9EUPw7J8zEgUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380294;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OSEHCSqjPr65IMs6cW535Ttbt4448C9+CWlVhuqRLDM=;
	b=PCjhigToDA1RkiEF0EgIOFG+vGkNn/Y2S/9nzPRFn3I4R4BL7Ratm9UyesEflj15TNha
	 RHoEYimlWhDubO+oMCqCv1o15j8O4ah6PN0JY5LXWqz8HyU+0efQeA31dUUpzq1Zk4OzS
	 hSiyVWTng1Hztwt18n01sAr0bRMKdpjq1ucDC3J8H+p1vC4MitVcdGGXVRo7OIv9rQtjU
	 PHF9BHzclveAalTxC9PUE8nXvTYbbmSAylZ/j3cU4Qm0rowHYV47jqhj0bqTkEc9+02v5
	 48QM0V772PLNcWVfLoNlgCG/MO0Fhk/EU/CVqHqR5sdR7XV1bhzxHrK6ZS7cpumjg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmtNJ42Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FE606A31A;
	Sun, 22 Nov 2026 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmtNJ42Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09921F000D2;
	Sun, 22 Nov 2026 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795380293;
	bh=OSEHCSqjPr65IMs6cW535Ttbt4448C9+CWlVhuqRLDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gmtNJ42YiPAAKGQ8Znzt2f71ltI15sHxfnt9u4r4KXqtB1E2+/Lzi6GXQPhAASckN
	 9INJTpEmekblR7jdw1e+Yztl0+WlN6s3xdcjztMExCyCvSEDEQjExzxbcYx/2YVaVL
	 k1Sri045XWQuZIiGrzooCBwPCUL2+8M/fkcHfVfcvYdxAjlY9NnKkIbFM4woWIkUmD
	 3VF1J+0RNIfTWyP2mizxIbM+/gDxh86Ts9zpmY8sWTF2bxZlU43XcUyECZAowYSOC1
	 FHDXkH9Sehp4uioxNwKCjfQ7HN5Agzbt40aSeA0fc2GT+DzvPPcR6mfgDEJL3Gfk4m
	 x+qehOXMlMYlg==
Date: Sun, 22 Nov 2026 20:44:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 0/7] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Message-ID: <20261122204447.56875aea@jic23-hlaptop>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
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

On Sat, 14 Nov 2026 14:09:52 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
> notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
> It then moves the IIO core fixed-point parser over to kstrtodec64(), so
> every IIO channel attribute written through iio_write_channel_info()
> accepts that format as well.

Andy, no huge rush on this as we have a few weeks left in the cycle.
However I'm relying on you for review of this one.

FWIW looks fine to me and I like all the confidence the tests are bringing!

Jonathan
