Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9535C193
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737777; cv=none; b=O9K8PYZL+nbj/OjnxqiXsqyhlKzf/xxThLNs8mEIEFTpCE4tNMRn+jejZwEuG47tp4bpTqrR8dIPlBEBNWdgKVcpikMFH0dpk4KacuA6AuEgPiKxv1UOl/lXoUVDdNhMOtQRRadbcKIJJltOrt66T/opX4W8kKUhWCLPvai4wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737777; c=relaxed/simple;
	bh=5kdYw02t/34O+wIzpCLlt3t67Vvl0Bh4JCcLHlRfiAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ukt7ttvVSb9MdIXwWKvKRAN9nPdzkleq4yIaS9SzSmwKvagcSv1R9vvr7+lw8pbTbBpc0kC4d+e596rHyFsVcuD09DhKHliBb7ygITgIwrj0gKfGMGMTg0VCnFU8mkrwDXyX3dIRqx46ascsuiVl+0KKsQdOj1VSbAj9r1Uq5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4U4iDyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4U4iDyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8951F00A3E
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737776;
	bh=5kdYw02t/34O+wIzpCLlt3t67Vvl0Bh4JCcLHlRfiAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U4U4iDytPTYP8tnu79+Hyjmq4qGys7it3bg5D4DgncWLUB3p70UT4MPkUzaUIklYe
	 lw7r7qYk6p58rhvNVQJVVjaRuHEk1qU3Rap5s5W7MCS4OsBT7BN2keIjLCrOX4IiMU
	 0Oon1SA4F5VGgxHCyaddZh/ZhfQerIIjL8JO9Qg1iEAMDHiG9e+V+Bf0BVd1VDFEV+
	 6qDzKqa+gNMYCz4alFHZr9UFsp1dgnGrZrFUBm9AFSWrpPgi9zWJWO5VclLfF49iOF
	 n76UBvlprDHJztlKr9ePrXhHu9fu9/tTWNelx1+Skwt3kykHPkLPhEjfepzvMwLony
	 IGD7SyBFc4E3Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b01146b205so1058024e87.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:02:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp4qGHM6oKr6t3wMFtON6HdWVaUxRnlPPPhQZhCvCvZ+uRzfm+Y8tMqIVhW2smSg9oKL/accG2bHvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXvwHGPz5EoczWtX+6mFbP5Rgype6fJky3JI0OlvEULhUYz59
	cfVY92/k7w9aM/md7Yvv5j9Mijv8DMSKJ6P5gTckv2HRF3AK1vZHjzqjfkkoyJ8QXjekrMiwHIQ
	vB3U8Z4Vi2WoxdDxoOs3QM6PtHasfRic=
X-Received: by 2002:a05:6512:1310:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b45915e3e6mr1233390e87.16.1786737775389; Fri, 14 Aug 2026
 13:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814101845.301769-1-yashsuthar983@gmail.com> <20260814101845.301769-3-yashsuthar983@gmail.com>
In-Reply-To: <20260814101845.301769-3-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:02:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLmWtYLuATn6+sGUtGfSryTVphHVKKv0Vc=g-FpHvd3=9Q@mail.gmail.com>
X-Gm-Features: AcwNN1XqnmX_xZ0ngVzCIRXTcvisYH-CSPKjoYehL4Y5Yac5FQ6BAAnU2JraBTs
Message-ID: <CAD++jLmWtYLuATn6+sGUtGfSryTVphHVKKv0Vc=g-FpHvd3=9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: bmc150: use DMA-safe buffers for regmap
 bulk reads
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, grondon@gmail.com, hexlabsecurity@proton.me, 
	sakari.ailus@linux.intel.com, srinivas.pandruvada@linux.intel.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:19=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.c=
om> wrote:

> The FIFO and read_raw buffers are passed to regmap bulk/raw reads
> ,which is not DMA-safe.Moved them into struct bmc150_accel_data
> after scan, each aligned to IIO_DMA_MINALIGN.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
