Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295948;
	b=UZkyF93vDTDaMvDwfYIsOk/v1yFRyH0dXiqOpMJlr9gjE/Yltf1xU0Z65iBsuG2DvlhD
	 Vq5KChkfMw3qaLYfXI+p2L4L4Dw+3WaGRz6Ndm6a2AtWNi5X9K3zU/nrygclNWMQEAVkP
	 RxIKeaMySyahMRSQTZGGsajYMa71ulAdf2YC2FL+ndWjgTKg0pgzwr5aGbDL+KJoUb3ie
	 4A/MicM0um6aQzUaRn71jC6J2dgVuA0Dq7Nx0p4+xfrh62n39KZmcsruW9NPhBGyRcsws
	 EJKGuipheF0UAhdBxDPeYcPSofm7rfDEWihLGq8m3flrKmVGAgsmmvlkhGoWsuRDu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295948;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nn4NLcCLn4UsidM4X4VaPvfR/4D6nJNXCDJVByzVWOA=;
	b=4eHb++mhKgcqEXm35tizRZTCFWFLp1UMKeEmN3SJ62TctkCtrEZ39Ucer8lWLlR5IiFp
	 gLFsR1Xpb9R8hRiagIKBeoVw84WfVHN8senb8UENeKelIt3tUq4ymKuk1f8pj05eO9s7p
	 gPKvoCiI09NtwycrFUATEe8Lw6obiguWiEW70Q/mBts1TxsVYJyuSsxaHBCr29NXoaI4K
	 Aer5bdxFqGbMhpKMr2N8ibagadnAsO8X1UqsuaE8JFnVYmSU+YCZ9Mn7/9z2S55qnjP9p
	 2ZE8T3OX2BXx9DrR6E9Lp3Cs9A0dilQvfM/mSY+IYP5dvXp2UKK+nhdsu84oYLJf/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbFJeKHn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB7606A320;
	Sat, 21 Nov 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbFJeKHn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A861F000C6;
	Sat, 21 Nov 2026 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295948;
	bh=nn4NLcCLn4UsidM4X4VaPvfR/4D6nJNXCDJVByzVWOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IbFJeKHn+82+xBNewS+Rnj7D9lnu5h6zu042G5j/tT6AoFVixsjMERdu3lH2l5Uej
	 QvKX+QZML9RR2UomvsxJAn+HlHeTeTDRjJ0A7EfzxginDH42hR6EITCgXzwnsye8zw
	 NF9W/nnISJ/qpMgzE6Uc7ZvvxSf7z1EKbzCCpyq4afVKoSC5QtnbgI0xUyq2yxpm8Y
	 YLf/T2wCrFFB9esQVS3NGdBhsI3H4yKdhkH0mC5WpOO0rzpHiM/TEz34VDepYvuQAS
	 RD27YZ2fTsIFv0Q8Ia6lsJOOTz+ZfGM8vPMtPrTdvDD5NPzV0klbsNtnvegha2RLk8
	 N5m+LWEO8H7cQ==
Date: Sat, 21 Nov 2026 21:19:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Keep the buffer index separate from the
 acquired fd
Message-ID: <20261121211902.13a9f3ed@jic23-hlaptop>
In-Reply-To: <20261120210317.184756-2-kapoorarnav43@gmail.com>
References: <20261120061903.98141-1-zhujun2@cmss.chinamobile.com>
	<20261120210317.184756-2-kapoorarnav43@gmail.com>
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

On Sat, 21 Nov 2026 02:33:17 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Fri, Nov 20, 2026 at 02:19:03PM +0800, Zhu Jun wrote:
> > IIO_BUFFER_GET_FD_IOCTL takes the buffer index as input and replaces
> > it with a file descriptor on success. On failure, cleanup can mistake
> > the unchanged index for an open fd and close a different file. Only
> > assign the returned descriptor to buf_fd after successful acquisition.  
> 
> Checked against iio_device_buffer_getfd(): on every error path it
> returns before copy_to_user(), so the argument keeps the index, and the
> error: label then closes it because buf_fd >= 0. With the default
> buffer index 0 that closes stdin, with -b 1 stdout. The patch fixes
> that, buffer_idx is already rejected when negative, and it applies to
> iio testing, builds without warnings and is checkpatch --strict clean.
> 
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>

Applied to the testing branch of iio.git. That means it is queued up
for the next merge window.

Thanks,

Jonathan
