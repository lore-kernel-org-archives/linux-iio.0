Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091900;
	b=1lh8agX8YE3nyHmZaArMqqaSeEnip0YrQUWMGOXR8+ZRh6Hvz3Rp+yWz/KjN7GMw206H
	 d+ip7W5p61vImozK0MQC7iSHa1IjfdxcdzCWT67bSKynrh3gpYZ9olqKpvS+qnXSixK7M
	 Tv+Cz6UyWk71n6Yez6g/KsIea/P/LxGBNUV/K8N8WdgJ9huUkE4IeeqVzn2Maa87bECNK
	 3eFH2guBVWQYqiJikPz9IwkINDbFRQg1NMeTcW6fhDb5JsUCvDUfhPDg/NV1Ejk/sgbOt
	 LD86ah2FwV3w4EJyAyeJf0VNMgMjptniVi+QXTseJClYi9q6slmsL32Ga1Ghp3vDt8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xd5OB0+cy7x3sgoVmGo58lbOXWx68IYY53KsIJit3EQ=;
	b=LMZ5U6DNjbdF1+YDqGiKUTqt4/vOHi5bNCaDcQ4OhD0ujoATnkDC9IGdM0tsHVzdQUoO
	 1bU6liI/r2OMjuYgu/MLQZvz1EhQDUnipvu4I2fGQjjkvCIBPblaekP7DUm2BqCvkKRyn
	 cGPefV8c23pq5uyNx5bUod3kQUmrlNkpBRhKdERcuGtW16bVNOHctOSMDCud3RjY1LcxO
	 E/LUueoxqugz09RtNUarUsvviguiN+UVP+kPLVwyxIfT8LdBZaDLuhShbHTlTUsGrMo/x
	 6SW+P8NWVOpPJvbXB2HrsoJkbr8H/uUdonX9n9LPUfRF6EwmtwMeR7buyL/2fEuWRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRueuu7u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96229606A32C;
	Sat,  7 Nov 2026 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRueuu7u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33161F008A4;
	Sat,  7 Nov 2026 22:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091900;
	bh=Xd5OB0+cy7x3sgoVmGo58lbOXWx68IYY53KsIJit3EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YRueuu7uduNw9UbNcHrHfzN+5wzkE/aj4ceGgKFle0DawzMkmP/AjoRpZb7YriFb7
	 2D9wuKJ9UCDnfF3uTVDhCtBelGEZzO+TKAgJisiMYFzivagbTOkYWW2AnmgLDB/e5X
	 x/moqrqRUmFr4nn/rBWUq4FjIRFF8G0vCwWB5CyRyldY+DAOw/qEA1peUZYnROz2An
	 0MECLP2N1wbPhbcuxfGVPu+KwQMioJto5wvsynigw094EXC02lfArAtg5tJd/PijM8
	 s8YMZGM0hmQyJ4GTMpcR94ctE0dlPeSIsZ3NcUsW95gs2lZoyWYjbJ9rRMmFoVeGHa
	 4EvrzQwrDhPqw==
Date: Sat, 7 Nov 2026 22:51:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH v4 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak
 in trigger enable path
Message-ID: <20261107225135.04a6b1b9@jic23-hlaptop>
In-Reply-To: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
References: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
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

On Wed,  4 Nov 2026 12:00:05 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> Hi Jonathan,
> 
> Thanks for the review! This version addresses both comments on the
> trigger helpers: the dispatcher now uses an else, and the error
> return for the IRQ status read in the enable path is propagated.
> The disable path is left as is, as you concluded it was not worth
> the effort to fix.

I agree with your logic in replying to Andy (and think he probably
will as well) so I've applied this. Taking it the slow path so
applied to the testing branch of iio.git which will end up going upstream
next merge window.

Thanks,

Jonathan
