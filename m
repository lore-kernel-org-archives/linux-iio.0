Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517476;
	b=hXHmcSf2qXkPmt5ViN7jqy0jNIGXuD1hKtFsG0gjTa84NFph8gaVhN5+c2/NLoWDTpJa
	 rf5CO4s4sDNLIMqjXqKS04c4InuJqW33mM8bGay3LoV5FgrvKU9F3xoJ+vRWCZDeVCpSH
	 T88hjNZGCrGpeJyKJFm/Qxm6mATFZg2CoCairFVfzU9/KTGj7EdFCjJqzam+BH05hPQc+
	 upjZ2dwSena0o++743id7JRlZHvKPvrZh0k8AUuWRuWWRba+oiuPbGcR0ko93ogodl4d/
	 PtAaM3McobJgXU9euAz67atDBC1ynGxcDvnGsETUFulcn36H0b1VFJBi/quQKXddWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517476;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OazviAqzNKBv4BIbyZNoXbEjnx4qpwJp7JHy2ITksuQ=;
	b=SLVoOH/el8/7r9+dBBiILmpEIzIUj7Xg5LpVrhxyI+6wglCulGJbvoY7bZAO+Zd/sPUZ
	 314nf+1egtCi+n7HKm3fDO+Ku8CWHXBsPto2cKSGQiFvoHLKjIiya1e6d2MKPc5jb4OVF
	 OP+APfb+UefbRXkLoCHiAx0ZC61xEuEHCcy4kBdYYks2BWEJXu9n1FFxyMdp96WYgCPuO
	 th9azxiBE+5aguoB/I2HekLxaNelFKdqgLYvifqfk63iBNJz6mwOrOgBuDs0kmpPZJbJz
	 Em261Mql9GmL22ZHh/5Zzltm2degiPd0VR5a9g8PgZVGfGbDPTfsgdWAythASSXxKlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRkPTvUy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544D606A322;
	Tue, 24 Nov 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRkPTvUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344031F000D2;
	Tue, 24 Nov 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795517474;
	bh=OazviAqzNKBv4BIbyZNoXbEjnx4qpwJp7JHy2ITksuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QRkPTvUy2n/0NHNvOueGPUuhqBxOe7VsXPEFjGfyu0Cdqs/ccrth9ACF6SgGArdD1
	 HWblfUu/7aIPvx+gpCVDTS2FkRxAyPC/FXa5ioUg//KcqETHGhwA6vhQubjqyPbH0a
	 WQSDT2b9W1nXM7F0cmSdv8NRBDfj9PHTzbZf+KxfjkopNnsSnazhCLbNr6upSVyO+b
	 NSNifXpwTpiNs1aE30FDQZYTgRmLKUbYd+mf5Xixapt1r6FTDSmdywWY1URQx6pGW5
	 ywcH1Cgrv0v8iRFtB28kvHAVhkF4Y08J8pl1mo9uH1wZp2F2uN5+ZZ+x3G5jNm6eSs
	 s8M9m4X+gS0OA==
Message-ID: <4012fef5-2d69-41e4-81ef-52f06d9313f7@kernel.org>
Date: Tue, 24 Nov 2026 11:51:11 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rupesh Majhi <zoone.rupert@gmail.com>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
 <awVq-mE1H2g01yS4@ashevche-desk.local>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <awVq-mE1H2g01yS4@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24-Nov-26 11:46, Andy Shevchenko wrote:
>> > +static const struct file_operations iio_debugfs_reg_fops = {
>> > +	.open = simple_open,
>> > +	.read = iio_debugfs_read_reg,
>> > +	.write = iio_debugfs_write_reg,
>> > +};
>> > +
>> > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
>> 
>> Static here but not in the header file. Same goes for register_debugfs().
> 
> Oh, how does it compile?
Unfortunately it doesn't :(

drivers/iio/industrialio-debugfs.c:138:13: error: static declaration of ‘iio_device_unregister_debugfs’ follows non-static declaration
  138 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/iio/industrialio-debugfs.c:20:
drivers/iio/iio_core.h:23:6: note: previous declaration of ‘iio_device_unregister_debugfs’ with type ‘void(struct iio_dev *)’
   23 | void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/industrialio-debugfs.c:145:13: error: static declaration of ‘iio_device_register_debugfs’ follows non-static declaration
  145 | static void iio_device_register_debugfs(struct iio_dev *indio_dev)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/iio_core.h:24:6: note: previous declaration of ‘iio_device_register_debugfs’ with type ‘void(struct iio_dev *)’
   24 | void iio_device_register_debugfs(struct iio_dev *indio_dev);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/industrialio-debugfs.c:145:13: warning: ‘iio_device_register_debugfs’ defined but not used [-Wunused-function]
  145 | static void iio_device_register_debugfs(struct iio_dev *indio_dev)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/industrialio-debugfs.c:138:13: warning: ‘iio_device_unregister_debugfs’ defined but not used [-Wunused-function]
  138 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:290: drivers/iio/industrialio-debugfs.o] Error 1

-- 
Kind regards,
Joshua Crofts
