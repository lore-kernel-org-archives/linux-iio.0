Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B00184524;
	Tue, 26 May 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800433; cv=none; b=NpIANTHS2N2IpOVNCsNzWTA/nKRys29ExH5peU3sdYORHYvBHzaVVgiF3Tty0V87kNO2TCkoFIRlRGlQuTLyBJaDv5AhNajtIhbiVaZYY2vSw7tA4otGqAYd4l09UelTikaZIlqJga+nYiTJixn9xsb5KNOheO1fZyEMkFTt6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800433; c=relaxed/simple;
	bh=47bb7LiyE4yyR1fIIa4xKP2mMq7RrmM0996rxatX2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWnH7/Eg7ADdEbi0EhPGcFtWPZRIWsf1TmRB/jwddOzlMYIHG5Kc4CZjygtn7glbE4p/uUEyndwrl+3GsAQPU34jNNtfIOBuhURrIRJgKWj3dYWGcJwkMUwkxuq0rWjDAiYyqIeyM0kUrRkrrKCP9torvelJ3V1opqavT14o3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSVwg6k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSVwg6k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C9D1F000E9;
	Tue, 26 May 2026 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800432;
	bh=6WmM2jyAP3Y3wSZA35c/ErcUlZK06XMNBgxdHiZ9RD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JSVwg6k3odXUU69MG9YidCYL3xmTN0M+BuwVXEwB1uBOFWUOi2UpXeH0cEL9XHX+Y
	 SB4DRhK5tN/iS5UzR+DcHkMOGpyYlLiy+B56uS7H8d4KUuU96mv807bMwZ0UyOdU4k
	 E9bXGcU1rsJndbhu/+K5QDgfkoXoozKyEntGNLj5zTcjkNPZo3KZI7kkoX8CKMvH6S
	 FmD7d5ktfBUAY3IhBPy2rub96NajMn4C/lGpEBmGHLeqcvrTdjnv2Wjo3OHHqdOWID
	 gVp/bkwudS+MW6bKoT/Afc+bGlsdQ/sBe/hbfq8CcHDGyWm1qV1b1y/OrJ6Uhm4Ten
	 Ts5GpCdsF9IMQ==
Date: Tue, 26 May 2026 14:00:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 5/8] iio: tcs3472: use devm for resource management
Message-ID: <20260526140024.3e422667@jic23-huawei>
In-Reply-To: <20260522123420.45495-6-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-6-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:34:16 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> Convert the driver to use device-managed resource allocation:
> - Add tcs3472_powerdown_action() and register it with
>   devm_add_action_or_reset() to ensure the device is powered down on
>   cleanup.
> - Replace iio_triggered_buffer_setup() with
>   devm_iio_triggered_buffer_setup().
> - Replace request_threaded_irq() with devm_request_threaded_irq().
> - Replace iio_device_register() with devm_iio_device_register().
> - Replace mutex_init() with devm_mutex_init().
> - Remove tcs3472_remove() as all cleanup is now handled by devm.
> 
> Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
> calls compact.
> 
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
