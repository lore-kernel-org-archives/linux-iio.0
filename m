Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168626;
	b=JOjVFBxc4Rig+E4W+IdzbCtTRu4krMZW/WNJI5rPoQQcIPRUI2BS0z3i0lH3N5S6om8L
	 5hoyOcaf3ouHf7tjg7DYFWvNtiPqXtsK7iQSnJWL+1XklG2IRpO2YRLvZoxeCF+DYW2t/
	 N/rXvjo8RNxLMZCvIUTn/8O5Qugx2++FbK7PC/Q5lVq7iRjfuejztkcyAS+oXxEPfAMtF
	 WGNHXT4WnZw7VkXY8e9gx9uNzfRKAB7sHe1q/KZckLxJ/yKtP39V5QFpSCZSOIcYSIii+
	 fyB9eNvsIoVMXlkSusAGAVxAwSs2WRShVHAItHDe3noYdiRnzYwS91e1sKWwOM/pERA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JydNdH1zyu2AJFI2LCpjNhOcKmbmLzRXo/gnywVuaC8=;
	b=KEtcFEGO2nD5pZzAjOL4VLVpe8XJNuFwnOq316RwTJmckfzkKD5Uy0WV7zbJG5VVC8xX
	 FI9HU+MYl4PNglscaaNGrWW+flwzr8/VzojzTfn3SD33QgXDd67WZpRQPYfrnjvKqalk+
	 0983aMY3Lia08qJj1rN4yudUOM+/ZrXWqouwPuMnGA/se+kU+UJQmFCwbFJ2C9bYfrPc7
	 e0C4SDKX+I2lLgBRajD7sQxh5VmAH4DyEx713fwatOJ1tpwKyRpmqbm8ja8dqd+lEakvC
	 BZWZHmJxNFVmoIWjXEfHeu3CwF6K6gR/8l/BsaJAwQFEPjGpMWiG8w5xP1AMOEBXtCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSehNNYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C251606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSehNNYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0DA1F0089F;
	Sun,  8 Nov 2026 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168625;
	bh=JydNdH1zyu2AJFI2LCpjNhOcKmbmLzRXo/gnywVuaC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fSehNNYTuHLQM+fmMNxMdmwjnRLaGWuu4gxvdL6NgLR49PLKkrVfQIED8vCQpXwJB
	 /IBAY/mLU5K5AEOPQjgD0o79+32OoSuimKIV5y0tFd8pqWWxpngeruMiEzkl7sTR8u
	 D+vL7+su3D0NsSZyVh+DR4LrgSHdWobzJoalP9YIruDmGeE89ss1rKMcClie+M7C0Q
	 PiFKYOaLpiIpsQMyZJ6hHxoRXCSqI8687YN69ajjU9S1XWesIQ8LQEPTY3FbxckgpJ
	 J7GrC9M6zGiNmku0N4YCKZ9erXBbLQ38qSyQ4OlstuyzLX5NeMmYP/4PjXk4zgn3li
	 vnWJ1UX14Gq1g==
Date: Sun, 8 Nov 2026 20:10:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 27/39] iio: humidity: hdc100x: use
 iio_push_to_buffers_with_ts() with a scan struct on stack
Message-ID: <20261108201019.559c196d@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-27-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-27-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:45 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Move the scan buffer out of struct hdc100x_data and make it local to
> hdc100x_trigger_handler(), as it has no need to persist between calls.
> i2c_master_recv() does not require a DMA safe buffer, so this is fine
> on the stack.
> 
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied.
